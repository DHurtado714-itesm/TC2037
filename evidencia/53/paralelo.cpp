#include <pthread.h>
#include <queue>
#include <string>
#include <cstring>
#include <iostream>

#define NUM_THREADS 4
#define MAX_QUEUE_SIZE 10

std::queue<ThreadData*> jobs;
pthread_mutex_t queue_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t condition_var = PTHREAD_COND_INITIALIZER;

// Definimos una estructura para pasar los datos a cada hilo.
struct ThreadData {
    std::string input_file_name;
    std::string output_file_name;
};

void* processFile(void* arg) {
    ThreadData* data = (ThreadData*)arg;
    csharp_to_html(data->input_file_name, data->output_file_name);
    delete data;
    return NULL;
}

void* worker(void* arg) {
    while (true) {
        pthread_mutex_lock(&queue_mutex);
        while (jobs.empty()) {
            pthread_cond_wait(&condition_var, &queue_mutex);
        }
        ThreadData* data = jobs.front();
        jobs.pop();
        pthread_mutex_unlock(&queue_mutex);

        processFile(data);
    }
    return NULL;
}

int main() {
    struct stat st = {0};
    if (stat("./output", &st) == -1) {
        mkdir("./output");
    }

    pthread_t threads[NUM_THREADS];

    for(int i = 0; i < NUM_THREADS; ++i) {
        pthread_create(&threads[i], NULL, worker, NULL);
    }

    DIR* dirp = opendir("./csharp_examples");
    struct dirent * dp;
    while ((dp = readdir(dirp)) != NULL) {
        std::string filename = dp->d_name;
        if (filename.length() >= 3 && filename.substr(filename.length() - 3) == ".cs") {
            ThreadData* data = new ThreadData;
            data->input_file_name = "./csharp_examples/" + filename;
            data->output_file_name = "./output/" + filename + ".html";

            pthread_mutex_lock(&queue_mutex);
            while (jobs.size() > MAX_QUEUE_SIZE) {
                pthread_mutex_unlock(&queue_mutex);
                sched_yield();
                pthread_mutex_lock(&queue_mutex);
            }
            jobs.push(data);
            pthread_cond_signal(&condition_var);
            pthread_mutex_unlock(&queue_mutex);
        }
    }
    closedir(dirp);
    
    return 0;
}
