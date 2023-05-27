#include <iostream>
#include <pthread.h>
#include <unistd.h>
#include "utils.h"

using namespace std;

const int NUM_ESTUDIANTES = 5;
const int S = 8;  // Rebanadas de pizza
const int ITERACIONES = 3;

pthread_mutex_t pizza_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t pizza_cv = PTHREAD_COND_INITIALIZER;
int rebanadas_disponibles = S;
int pizzas_entregadas = 0;
int pizzas_maximas = ITERACIONES;

struct ThreadData {
  int id;
};

/**
 * This function simulates a student taking a slice of pizza from a shared resource while waiting for
 * more slices to become available.
 * 
 * @param arg A void pointer to the argument passed to the thread function. In this case, it is
 * expected to be a pointer to a ThreadData struct.
 */

void* estudiante(void* arg) {
  ThreadData* data = static_cast<ThreadData*>(arg);
  int id = data->id;

  while (pizzas_entregadas < pizzas_maximas) {
    pthread_mutex_lock(&pizza_mutex);

    while (rebanadas_disponibles == 0 && pizzas_entregadas < pizzas_maximas) {
      if (id == 0 && pizzas_entregadas < pizzas_maximas - 1) {
        cout << "Estudiante " << id << " llama a la pizzeria." << endl;
        pthread_cond_signal(&pizza_cv);
      }
      cout << "Estudiante " << id << " se va a dormir." << endl;
      pthread_cond_wait(&pizza_cv, &pizza_mutex);
      cout << "Estudiante " << id << " se despierta." << endl;
    }

    if (pizzas_entregadas < pizzas_maximas) {
      rebanadas_disponibles--;
      cout << "Estudiante " << id << " toma una rebanada de pizza. Quedan " << rebanadas_disponibles << " rebanadas." << endl;
    }

    pthread_mutex_unlock(&pizza_mutex);

    sleep(1); // Estudiar mientras come la pizza
  }

  pthread_exit(NULL);
}

/**
 * This function simulates a pizzeria that delivers pizzas with a certain number of slices until a
 * maximum number of pizzas is reached.
 * 
 * @param arg The parameter "arg" is not used in the code snippet provided. It is a common convention
 * to include a void pointer parameter in the function signature of a thread function, but it is not
 * necessary for this specific implementation.
 */

void* pizzeria(void* arg) {
  while (pizzas_entregadas < pizzas_maximas) {
    pthread_mutex_lock(&pizza_mutex);

    pthread_cond_wait(&pizza_cv, &pizza_mutex);
    rebanadas_disponibles = S;
    pizzas_entregadas++;
    cout << "La pizzeria entrega una pizza con " << S << " rebanadas. Pizza número: " << pizzas_entregadas << endl;

    pthread_cond_broadcast(&pizza_cv);
    pthread_mutex_unlock(&pizza_mutex);
  }

  pthread_exit(NULL);
}

/**
 * The main function creates and joins threads for a simulation of students ordering pizza from a
 * pizzeria.
 * 
 * @return The main function is returning an integer value of 0.
 */

int main() {
  pthread_t estudiantes[NUM_ESTUDIANTES];
  pthread_t pizzeria_thread;

  ThreadData thread_data[NUM_ESTUDIANTES];
  for (int i = 0; i < NUM_ESTUDIANTES; ++i) {
    thread_data[i].id = i;
  }

  start_timer();

  for (int i = 0; i < NUM_ESTUDIANTES; ++i) {
    pthread_create(&estudiantes[i], nullptr, estudiante, static_cast<void*>(&thread_data[i]));
  }

  pthread_create(&pizzeria_thread, nullptr, pizzeria, nullptr);

  for (int i = 0; i < NUM_ESTUDIANTES; ++i) {
    pthread_join(estudiantes[i], nullptr);
  }

  pthread_join(pizzeria_thread, nullptr);

  double elapsed_time = stop_timer();
  cout << "Tiempo transcurrido: " << elapsed_time << " ms" << endl;

  return 0;
}

/*

Implementacion de semaforo:

En este código se utilizan dos semáforos explícitos: un mutex y una 
variable de condición. El mutex se utiliza para controlar el acceso 
concurrente a la variable rebanadas_disponibles, que representa el número 
de rebanadas de pizza que están disponibles en un momento dado. 
La variable de condición se utiliza para sincronizar los hilos que esperan 
a que haya más rebanadas de pizza disponibles.

*/