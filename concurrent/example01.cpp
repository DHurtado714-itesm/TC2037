#include <iostream>
#include <cstdlib>
#include <unistd.h>
#include <iomanip>
// #include <pthread.h>
#include <utils.h>


using namespace std;



const int SIZE = 100000000;
const int THREADS = 4;

#define N 10
#define MAXIMUM 10

double sum (int *arr, int size) {
  double acum = 0;
  for (int i = 0; i < size; i++){
    acum += arr[i];
  }
  return acum;
}

typedef struct {
  int *arr;
  int size;
  double result;
} Block;

void* task(void *param) {
  Block *b;
  double acum;

  b = (Block *) param;
  acum = 0;
  for (int i = b->start; i < b->end; i++){
    acum += b->arr[i];
  }
  b->result = acum;
}


int main (int argc, char* argv[]) {
  int *arr;
  double ms, result;

  pthread_t tids[THREADS];
  Block blocks[THREADS];

  arr = new int[SIZE];
  fill_array(arr, SIZE);

  ms = 0;

  for (int i = 0; i < N; i++){
    start_timer();
    result = sum(arr, SIZE);
    ms += stop_timer();
  }


  cout << "result = " << fixed << setprecision(0) << result << endl;
  cout << "avg time = " << fixed << setprecision(5) << (ms / N) << " ms.\n";
  
  delete [] arr;

  return 0; 
}