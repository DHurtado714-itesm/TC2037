#include <iostream>
#include <iomanip>
#include <pthread.h>

using namespace std;

const int CELLS = 10;

pthread_cond_t spaces = PTHREAD_COND_INITIALIZER;
pthread_cond_t items = PTHREAD_COND_INITIALIZER;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

typedef struct{
  int data[CELLS];
  int front = 0, rear = 0, count = 0;
} Queue;

void put (Queue &q, int value){
  q.data[q.rear] = value;
  q.rear = (q.rear + 1) % CELLS;
  q.count++;
}

int get(Queue &q){
  int result = q.data[q.front];
  q.front = (q.front + 1) % CELLS;
  q.count--;
}

void* producer(void *param){
  pthread_mutex_lock(&mutex);
  if (q.count == CELLS){
    pthread_cond_wait(&spaces, &mutex);
  }
  //put elements
  pthread_cond_signal(&items);
  pthread_mutex_unlock(&mutex);

  pthread_exit(0);
}