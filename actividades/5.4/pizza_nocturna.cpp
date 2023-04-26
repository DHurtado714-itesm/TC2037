#include <iostream>
#include <pthread.h>
#include <cmath>
#include <cstdlib>
#include <ctime>
#include "utils.h"

using namespace std;

const int MAX_SLICES_PER_PIZZA = 8;
const int MAX_STUDENTS = 20;

int slicesPerPizza;
int remainingSlices;
bool pizzaAvailable;
pthread_mutex_t mutexPizza;
pthread_cond_t condPizza;
pthread_t studentThreads[MAX_STUDENTS];

void *studentFunction(void *idPtr) {
    int id = *((int *) idPtr);
    int numSlices = 0;

    while (true) {
        // Get a slice of pizza
        pthread_mutex_lock(&mutexPizza);

        while (!pizzaAvailable) {
            pthread_cond_wait(&condPizza, &mutexPizza);
        }

        if (remainingSlices > 0) {
            numSlices++;
            remainingSlices--;

            if (remainingSlices == 0) {
                pizzaAvailable = false;
                pthread_cond_signal(&condPizza);
            }

            pthread_mutex_unlock(&mutexPizza);

            // Study while eating the pizza
            cout << "Student " << id << " is eating a slice of pizza. Remaining slices: " << remainingSlices << endl;
            this_thread::sleep_for(chrono::milliseconds(rand() % 1000));
            cout << "Student " << id << " has finished eating a slice of pizza." << endl;
        } else {
            pthread_mutex_unlock(&mutexPizza);

            // Go to sleep until a pizza is available
            cout << "Student " << id << " is going to sleep because there is no pizza left." << endl;
            break;
        }
    }

    // Request pizza delivery if needed
    if (pizzaAvailable == false) {
        cout << "Student " << id << " is requesting a pizza delivery." << endl;

        pthread_mutex_lock(&mutexPizza);
        remainingSlices = slicesPerPizza;
        pizzaAvailable = true;
        pthread_cond_broadcast(&condPizza);
        pthread_mutex_unlock(&mutexPizza);

        cout << "Student " << id << " has received a new pizza." << endl;
    }

    pthread_exit(NULL);
}

int main(int argc, char *argv[]) {
    int numStudents;

    if (argc != 3) {
        cerr << "Usage: " << argv[0] << " numStudents slicesPerPizza" << endl;
        return -1;
    }

    numStudents = atoi(argv[1]);
    slicesPerPizza = atoi(argv[2]);

    if (slicesPerPizza > MAX_SLICES_PER_PIZZA) {
        cerr << "Maximum slices per pizza is " << MAX_SLICES_PER_PIZZA << "." << endl;
        return -1;
    }

    if (numStudents > MAX_STUDENTS) {
        cerr << "Maximum number of students is " << MAX_STUDENTS << "." << endl;
        return -1;
    }

    srand(time(NULL));
    remainingSlices = slicesPerPizza;
    pizzaAvailable = true;
    pthread_mutex_init(&mutexPizza, NULL);
    pthread_cond_init(&condPizza, NULL);

    int studentIds[numStudents];
    for (int i = 0; i < numStudents; i++) {
        studentIds[i] = i + 1;
        pthread_create(&studentThreads[i], NULL, studentFunction, (void *) &studentIds[i]);
    }

    for (int i = 0; i < numStudents; i++) {
        pthread_join(studentThreads[i], NULL);
    }

    pthread_mutex_destroy(&mutexPizza);
    pthread_cond_destroy(&condPizza);

    return 0;
}