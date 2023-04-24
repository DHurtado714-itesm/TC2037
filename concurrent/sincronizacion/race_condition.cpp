#include <iostream>
#include <iomanip>
#include <pthread.h>

using namespace std;

int count = 0;

void* increment (void* param){
  for (int i = 0; i < 30; i++){
    cout << "increment - before count = " << count << endl;
    count++;
    cout << "after count = " << count << endl;
  }
  pthread_exit(0);
}

void* decrement (void* param){
  for (int i = 0; i < 30; i++){
    cout << "decrement - before count = " << count << endl;
    count--;
    cout << "after count = " << count << endl;
  }
  pthread_exit(0);
}

int main(int argc, char* argv[]){
  pthread_t tids[2];

  pthread_create(&tids[0], NULL, increment, NULL);
  pthread_create(&tids[1], NULL, decrement, NULL);

  pthread_join(tids[0], NULL);
  pthread_join(tids[1], NULL);

  return 0;

}

// Comando en la terminal para compilar -> g++ -o app main.cpp -lpthread
// comando de la terminal para correr -> ./app