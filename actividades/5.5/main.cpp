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

void CrossBridge(Direction direction) {
    if (direction == NORTH_TO_SOUTH) {
        std::cout << "Un vehículo está cruzando el puente de Norte a Sur." << std::endl;
    } else {
        std::cout << "Un vehículo está cruzando el puente de Sur a Norte." << std::endl;
    }
    usleep(1000000);
}

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

void *OneVehicle(void *arg) {
    Direction direction = static_cast<Direction>(reinterpret_cast<intptr_t>(arg));
    ArriveBridge(direction);
    CrossBridge(direction);
    ExitBridge(direction);
    return nullptr;
}

int main() {
    srand(time(0));
    pthread_t vehicles[NUM_VEHICLES];

    for (int i = 0; i < NUM_VEHICLES; i++) {
        Direction direction = static_cast<Direction>(rand() % 2);
        pthread_create(&vehicles[i], NULL, OneVehicle, reinterpret_cast<void *>(static_cast<intptr_t>(direction)));
        usleep(500000);
    }

    for (int i = 0; i < NUM_VEHICLES; i++) {
        pthread_join(vehicles[i], NULL);
    }

    pthread_mutex_destroy(&bridge_mutex);
    pthread_cond_destroy(&north_cv);
    pthread_cond_destroy(&south_cv);

    return 0;
}
