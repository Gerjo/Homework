#include <cstdlib>
#include <pthread.h>
#include <iostream>
#include "Semphore.h"
#include <assert.h>

using namespace std;

Semaphore* tableMutex;
Semaphore* waiting;

int table;
int inQueue;
bool doPrint = true;


void guest(void *) {
    assert(table <= 5);

    tableMutex->wait();
    if(table == 5) {
        if(doPrint) printf("[Sitting: %i/5, waiting: %02d] Table full, queuing for empty table. \n", table, inQueue);
        inQueue++;

        tableMutex->signal();
        waiting->wait();
        tableMutex->wait();
        
    } else {
        ++table;
    }
   
    
    tableMutex->signal();


    if(doPrint) printf("[Sitting: %i/5, waiting: %02d] Someone took a seat. Nomnomnomnom. \n", table, inQueue);
    assert(table <= 5);

    // Nomnomnom

    tableMutex->wait();
    --table;
    if(doPrint) printf("[Sitting: %i/5, waiting: %02d] Someone finished their meal! \n", table, inQueue);
    if(table <= 0) {
        if(doPrint) printf("[Sitting: %i/5, waiting: %02d] Table empty, signalling up to 5 people. \n", table, inQueue);

        // Table is empty, signal 5 guests.
        for(int i = 0; i < 5; ++i) {
            waiting->signal();
        }

        table   += min(5, inQueue);
        inQueue  = max(0, inQueue -= 5);
    }

    assert(table <= 5);

    tableMutex->signal();
}


int main(int argc, char** argv) {
    tableMutex = new Semaphore(1);
    waiting    = new Semaphore(0);
    
    table   = 0; // Table is empty.
    inQueue = 0; // Queue is empty.

    // Summon some guests:
    for(int i = 0; i < 20; ++i) {
        pthread_t _threadIndex;
        pthread_create(&_threadIndex, 0, (void *(*) (void *))&guest, NULL);
    }

    return cin.get();
}
