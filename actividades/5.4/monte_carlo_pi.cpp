#include <iostream>
#include <pthread.h>
#include <cmath>
#include <cstdlib>
#include <ctime>
#include "utils.h"

using namespace std;

const int NUM_THREADS = 8;
const int NUM_POINTS = 100000000;

struct ThreadData {
    int num_points;
    int count_in_circle;
};

/**
 * The function checks if a given point (x,y) is inside a circle with radius 1 centered at the origin.
 * 
 * @param x A double value representing the x-coordinate of a point in a 2D plane.
 * @param y The "y" parameter in the function "is_inside_circle" represents the y-coordinate of a point
 * in a 2D plane.
 * 
 * @return The function `is_inside_circle` is returning a boolean value, which is either `true` or
 * `false`. The function checks if the point with coordinates `(x, y)` is inside or on the boundary of
 * a circle with radius 1 and centered at the origin. If the point is inside or on the boundary of the
 * circle, the function returns `true`, otherwise it returns `false`.
 */
bool is_inside_circle(double x, double y) {
    double distance_to_center = sqrt(x * x + y * y);
    return distance_to_center <= 1;
}

/**
 * This function generates random points and counts the number of points that fall inside a circle.
 * 
 * @param thread_data A void pointer to a struct containing data specific to the thread, including the
 * number of points to generate and a counter for the number of points that fall inside a circle.
 */
void* generate_random_points(void* thread_data) {
    ThreadData* data = static_cast<ThreadData*>(thread_data);
    data->count_in_circle = 0;

    for (int i = 0; i < data->num_points; i++) {
        double x = static_cast<double>(rand()) / RAND_MAX * 2 - 1;
        double y = static_cast<double>(rand()) / RAND_MAX * 2 - 1;

        if (is_inside_circle(x, y)) {
            data->count_in_circle++;
        }
    }
    pthread_exit(NULL);
}

/**
 * The function generates random points and estimates the value of pi using multiple threads.
 * 
 * @param argc The number of command line arguments passed to the program.
 * @param argv The argv parameter is an array of strings that contains the command-line arguments
 * passed to the program. The first element (argv[0]) is the name of the program itself, and the
 * following elements (argv[1], argv[2], etc.) are any additional arguments provided by the user.
 * 
 * @return The main function is returning an integer value of 0.
 */

int main(int argc, char* argv[]) {
    srand(time(0));

    int points_per_thread = NUM_POINTS / NUM_THREADS;
    pthread_t threads[NUM_THREADS];
    ThreadData thread_data[NUM_THREADS];

    start_timer();

    for (int i = 0; i < NUM_THREADS; i++) {
        thread_data[i].num_points = points_per_thread;
        pthread_create(&threads[i], NULL, generate_random_points, static_cast<void*>(&thread_data[i]));
    }

    /* This code block is iterating through each thread and joining them to the main thread. It then adds
    the number of points that fell inside the circle for each thread to the `total_in_circle` variable.
    This variable keeps track of the total number of points that fell inside the circle across all
    threads. */

    int total_in_circle = 0;
    for (int i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
        total_in_circle += thread_data[i].count_in_circle;
    }

    double pi_estimate = 4 * static_cast<double>(total_in_circle) / NUM_POINTS;
    double elapsed_time = stop_timer();

    cout << "Numero de estimado: " << total_in_circle << endl;
    cout << "Estimacion de Pi: " << pi_estimate << endl;
    cout << "Tiempo de ejecucion: " << elapsed_time << " ms" << endl;

    return 0;
}

/*

Implementacion de semaforo:

El código proporcionado utiliza un semáforo implícito en la función pthread_join. 
La función pthread_join se utiliza para esperar a que un hilo se complete antes de 
continuar con el hilo principal. Tambien se utiliza un semáforo para evitar que varios 
hilos generen el mismo número aleatorio al mismo tiempo.

En general, se pueden utilizar semáforos explícitos en situaciones en las que varios 
hilos necesitan acceder a recursos compartidos y se debe evitar que los hilos accedan 
a los recursos compartidos al mismo tiempo.

*/
