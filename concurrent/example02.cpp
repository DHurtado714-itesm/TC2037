#include <iostream>
#include <cstdlib>
#include <iomanip>
#include <pthread.h>
#include <utils.h>

using namespace std;

const int SIZE = 100000000;
const int THREADS = 4;

void add_vectors(int *c, int *a, int *b, int size) {
  for (int i = 0; i < size; i++){
    c[i] = a[i] + b[i];
  }
}