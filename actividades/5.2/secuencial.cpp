#include <iostream>
#include <cmath>
#include <ctime>

bool esPrimo(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= std::sqrt(n); i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int main() {
    int limite = 5000000;
    long long suma = 0;
    std::clock_t inicio = std::clock();

    for (int i = 2; i < limite; i++) {
        if (esPrimo(i)) {
            suma += i;
        }
    }

    std::clock_t fin = std::clock();
    double tiempo_secuencial = double(fin - inicio) / CLOCKS_PER_SEC;

    std::cout << "Suma de primos: " << suma << std::endl;
    std::cout << "Tiempo secuencial: " << tiempo_secuencial << " segundos" << std::endl;

    return 0;
}
