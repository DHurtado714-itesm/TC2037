#include <iostream>
#include <pthread.h>
#include <unistd.h>
#include "utils.h"

const int MAX_BRIDGE_CAPACITY = 3;
const int NUM_VEHICLES = 10;

pthread_mutex_t bridge_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t north_cv = PTHREAD_COND_INITIALIZER;
pthread_cond_t south_cv = PTHREAD_COND_INITIALIZER;

int north_waiting = 0;
int south_waiting = 0;
int on_bridge = 0;

enum Direction {
    NORTH_TO_SOUTH,
    SOUTH_TO_NORTH
};

/**
 * This function allows threads representing vehicles to arrive at a bridge and wait until it is safe
 * to cross in their direction.
 * 
 * @param direction The direction parameter is an enum type that specifies the direction in which the
 * thread wants to cross the bridge. It can be either NORTH_TO_SOUTH or SOUTH_TO_NORTH.
 */
void ArriveBridge(Direction direction) {
    pthread_mutex_lock(&bridge_mutex);
    if (direction == NORTH_TO_SOUTH) {
        north_waiting++;
        while (south_waiting > 0 || on_bridge >= MAX_BRIDGE_CAPACITY) {
            pthread_cond_wait(&north_cv, &bridge_mutex);
        }
        north_waiting--;
    } else {
        south_waiting++;
        while (north_waiting > 0 || on_bridge >= MAX_BRIDGE_CAPACITY) {
            pthread_cond_wait(&south_cv, &bridge_mutex);
        }
        south_waiting--;
    }
    on_bridge++;
    pthread_mutex_unlock(&bridge_mutex);
}

/**
 * The function outputs a message indicating the direction of a vehicle crossing a bridge and waits for
 * one second.
 * 
 * @param direction The direction parameter is an enumeration type variable that represents the
 * direction in which a vehicle is crossing a bridge. It can have two possible values: NORTH_TO_SOUTH
 * or SOUTH_TO_NORTH.
 */
void CrossBridge(Direction direction) {
    if (direction == NORTH_TO_SOUTH) {
        std::cout << "Un vehiculo esta cruzando el puente de Norte a Sur." << std::endl;
    } else {
        std::cout << "Un vehiculo esta cruzando el puente de Sur a Norte." << std::endl;
    }
    sleep(1);
}

/**
 * The function signals the appropriate condition variable and decrements the number of cars on the
 * bridge.
 * 
 * @param direction The direction parameter is an enum type that specifies the direction of travel on
 * the bridge. It can have two possible values: NORTH_TO_SOUTH or SOUTH_TO_NORTH.
 */
void ExitBridge(Direction direction) {
    pthread_mutex_lock(&bridge_mutex);
    on_bridge--;
    if (direction == NORTH_TO_SOUTH) {
        pthread_cond_signal(&south_cv);
    } else {
        pthread_cond_signal(&north_cv);
    }
    pthread_mutex_unlock(&bridge_mutex);
}

/**
 * The function takes a direction argument, calls three other functions related to crossing a bridge,
 * and returns a null pointer.
 * 
 * @param arg The parameter "arg" is a void pointer that is passed as an argument to the function
 * "OneVehicle". It is then cast to an intptr_t type and then to a Direction type using static_cast and
 * reinterpret_cast respectively. The Direction type represents the direction in which the vehicle is
 * traveling (either North
 * 
 * @return a `nullptr`.
 */
void *OneVehicle(void *arg) {
    Direction direction = static_cast<Direction>(reinterpret_cast<intptr_t>(arg));
    ArriveBridge(direction);
    CrossBridge(direction);
    ExitBridge(direction);
    return nullptr;
}

/**
 * The main function creates and joins threads for a number of vehicles, each with a random direction,
 * and then destroys mutexes and condition variables.
 * 
 * @return The main function is returning an integer value of 0.
 */
int main() {
    srand(time(0));
    pthread_t vehicles[NUM_VEHICLES];

    for (int i = 0; i < NUM_VEHICLES; i++) {
        Direction direction = static_cast<Direction>(rand() % 2);
        pthread_create(&vehicles[i], NULL, OneVehicle, reinterpret_cast<void *>(static_cast<intptr_t>(direction)));
        sleep(1);
    }

    for (int i = 0; i < NUM_VEHICLES; i++) {
        pthread_join(vehicles[i], NULL);
    }

    pthread_mutex_destroy(&bridge_mutex);
    pthread_cond_destroy(&north_cv);
    pthread_cond_destroy(&south_cv);

    return 0;
}
