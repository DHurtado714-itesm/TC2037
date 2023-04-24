#include <iostream>
#include <iomanip>

using namespace std;

int main (int argc, char* argv[]){
  for (int i = 0; i < argc; i++){
    cout << "argv[" << i << "] = " << argv[i] << "\n";
    }

    return 0;
}


// Comando en la terminal para compilar -> g++ -o app main.cpp
// comando de la terminal para correr -> ./app ../../concurrent/*.cpp