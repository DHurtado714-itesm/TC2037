#include <iostream>
#include <cmath>
#include <ctime>
#include <pthread.h>
#include <vector>

struct PrimosThread {
    int id;
    int inicio;
    int fin;
    long long suma;
};

bool esPrimo(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= std::sqrt(n); i++) {
        if (n % i == 0) return false;
    }
    return true;
}

void* sumaPrimos(void* arg) {
    PrimosThread* datos = static_cast<PrimosThread*>(arg);
    datos->suma = 0;

    for (int i = datos->inicio; i < datos->fin; i++) {
        if (esPrimo(i)) {
            datos->suma += i;
        }
    }

    return nullptr;
}

int main(int argc, char* argv[3]) {
    int limite = 5000000;
    int num_threads = 4;
    std::vector<PrimosThread> datos(num_threads);
    std::vector<pthread_t> threads(num_threads);

    std::clock_t inicio_paralelo = std::clock();

    int rango = limite / num_threads;
    for (int i = 0; i < num_threads; i++) {
        datos[i].id = i;
        datos[i].inicio = i * rango + 2;
        datos[i].fin = (i + 1) * rango + 2;
        pthread_create(&threads[i], nullptr, sumaPrimos, &datos[i]);
    }

    long long suma_paralela = 0;
    for (int i = 0; i < num_threads; i++) {
        pthread_join(threads[i], nullptr);
        suma_paralela += datos[i].suma;
    }

    std::clock_t fin_paralelo = std::clock();
    double tiempo_paralelo = double(fin_paralelo - inicio_paralelo) / CLOCKS_PER_SEC;

    std::cout << "Suma de primos (paralela): " << suma_paralela << std::endl;
    std::cout << "Tiempo paralelo: " << tiempo_paralelo << " segundos" << std::endl;

    return 0;
}
