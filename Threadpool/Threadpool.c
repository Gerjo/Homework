#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <assert.h>

// Used for deadlines, -1 indicates one does not care when it runs.
#define DONTCARE -1

struct Task;

// Inspired by epoll:
typedef union {
    int integer;
    void* ptr;
} TaskData;

typedef struct {
    TaskData data;
    time_t addedTime;
    time_t deadline;
    int isRunning;

    void (*runnable) (TaskData);

    struct Task* next;
    struct Task* prev;
} Task;

typedef struct {
    int workerCount;
    pthread_t workers[30]; // Hardcoded length *sigh*
    pthread_mutex_t popMutex;
    pthread_mutex_t pushMutex;

    Task* chainHead; // pop here

    pthread_t scheduler;
    pthread_cond_t emptyCond;
} ThreadPool;

Task* popTaskWait(ThreadPool* pool) {

    // No popping while popping: (adding is fine)
    pthread_mutex_lock(&pool->popMutex);

    if(pool->chainHead == NULL) {
        pthread_cond_wait(&pool->emptyCond, &pool->popMutex);
        
    }

    assert(pool->chainHead != NULL);

    // Ok something just became available. First make
    // sure no one is adding more tasks:
    pthread_mutex_lock(&pool->pushMutex);

    Task* task = pool->chainHead;

    if(task->next == NULL) {
        pool->chainHead = NULL;
    } else {
        pool->chainHead = task->next;
    }

    task->next = NULL;
    task->prev = NULL;

    // Release locks, any one can add or pop tasks again:
    pthread_mutex_unlock(&pool->pushMutex);
    pthread_mutex_unlock(&pool->popMutex);

    return task;
}

void* singlerun(void* voidTask) {
    Task* task = (Task*) voidTask;
    task->isRunning = 1;
    task->runnable(task->data);
}

void* scheduler(void* voidPool) {
    ThreadPool* pool = (ThreadPool*) voidPool;
    int i;

    while(1) {
        time_t now = time(NULL);

        // TODO: is this really the best approach? Seems rather blocking...
        pthread_mutex_lock(&pool->pushMutex);
        pthread_mutex_lock(&pool->popMutex);

        
        Task* tmp = pool->chainHead;
        while(tmp != NULL) {
            //printf("cjeck \n");
            if(!tmp->isRunning && tmp->deadline != DONTCARE) {
                time_t delta = now - tmp->addedTime;
                if(delta >= tmp->deadline) {
                    printf("Running task after exceeding a %d of %d seconds deadline. \n", delta, tmp->deadline);

                    // This is the first item:
                    if(tmp == pool->chainHead) {
                        pool->chainHead = tmp->next;
                        
                        if(tmp->next != NULL) {
                            pool->chainHead->prev = NULL;
                        }
                    } else {
                        Task* parent = tmp->prev;
                        Task* child  = tmp->next;
                        parent->next = child;

                        // We may not have one to begin with: (this was the last in the linked list)
                        if(child != NULL) {
                            child->prev  = parent;
                        }
                    }

                    pthread_t id;
                    pthread_create(&id, NULL, singlerun, (void*)tmp);

                }
            }

            tmp = tmp->next;
        }

        pthread_mutex_unlock(&pool->pushMutex);
        pthread_mutex_unlock(&pool->popMutex);

        usleep(1000000);
    }

    assert(0 == 1);
}



void* worker(void* voidPool) {
    ThreadPool* pool = (ThreadPool*) voidPool;

    while(1) {
        singlerun((void*) popTaskWait(pool));
    }

    assert(0 == 1);
}

void addTask(ThreadPool* pool, Task* task) {
    task->next      = NULL;
    task->prev      = NULL;
    task->isRunning = 0;
    task->addedTime = time(NULL);

    pthread_mutex_lock(&pool->pushMutex);
    
    if(pool->chainHead == NULL) {

        pool->chainHead = task;
    } else {
        Task* tmp = pool->chainHead;

        while(tmp->next != NULL) {
            tmp = tmp->next;
        }

        tmp->next  = task;
        task->prev = tmp;
    }


    pthread_cond_signal(&pool->emptyCond);
    pthread_mutex_unlock(&pool->pushMutex);
}

ThreadPool* createPool(const int numWorkers) {
    int i;
    ThreadPool* pool    = malloc(sizeof(ThreadPool));
    pool->workerCount   = 0;
    pool->scheduler     = 0;
    pool->chainHead     = NULL;

    pthread_mutex_init(&pool->popMutex,  NULL);
    pthread_mutex_init(&pool->pushMutex, NULL);
    pthread_cond_init(&pool->emptyCond,  NULL);

    pthread_create(&pool->scheduler, NULL, &scheduler, (void*)pool);

    for(i = 0; i < numWorkers; ++i) {
        pthread_create(&pool->workers[pool->workerCount++], NULL, &worker, (void*)pool);
    }

    printf("Created a threadpool with %i workers. \n", numWorkers);

    return pool;
}

void joinThreadPool(ThreadPool* pool) {
    int i;

    for(i = 0; i < pool->workerCount; ++i) {
        pthread_join(pool->workers[i], NULL);
    }
}

void starve(TaskData data) {
    printf("Starting really long task. \n");
    sleep(10);
    printf("Finished really long task. \n");
}

void echoTest(TaskData data) {
    printf("Running a really quick task... \n");
}

int main(int argc, char** argv) {
    int i;
    ThreadPool* pool = createPool(5); // Intentionally ignoring the CORE * 2 + 1 rule.

    Task task2[10];

    for(i = 0; i < 10; ++i) {
        task2[i].deadline = DONTCARE;
        task2[i].runnable = &starve;
        addTask(pool, &task2[i]);
    }

    Task task[2];
    for(i = 0; i < 2; ++i) {
        task[i].deadline = 4; // in seconds.
        task[i].runnable = &echoTest;
        addTask(pool, &task[i]);
    }

    joinThreadPool(pool);

    free(pool);

    return 0;
}

