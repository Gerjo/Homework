#include <cstdlib>
#include <iostream>
#include <sys/stat.h>
#include <sys/select.h>
#include <sys/time.h>
#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string>
#include <vector>

using namespace std;

string readLine(int fd);

int main(int argc, char** argv) {
    const char* name;

    cout << argc << endl;

    if(argc == 2) {
        name = argv[1];
    } else {
        cout << "No filename given." << endl;
        return 1;
    }

    if(mkfifo(name, S_IRWXU) < 0) {
        cout << "fifo probably already exists, or no write permission." << endl;
        //return 0;
    }


    int fdWrite = open(name, O_WRONLY); // O_NONBLOCK
    if(fdWrite < 0) {
        cout << "unable to open file for reading." << endl;
    } else {
        cout << "open for write:)" << endl;
    }

    int fdRead = open(name, O_RDONLY);
    if(fdRead < 0) {
        cout << "unable to open file for writing." << endl;
    } else {
        cout << "open for read :)" << endl;
    }

    vector<string> writeBuffer;

    while(1) {
        struct timeval tv = {5, 0};
        //tv.tv_sec  = 1;
        //tv.tv_usec = 0;

        fd_set rfds;
        fd_set wfds;
        FD_ZERO(&rfds);
        FD_ZERO(&wfds);
        FD_SET(fdWrite, &wfds);
        FD_SET(fdRead,  &rfds);
        FD_SET(0,       &rfds);
    
        if(select(FD_SETSIZE, &rfds, &wfds, NULL, &tv) < 0) {
            cout << "Select function call failed. " << endl;
            return 0;
        }

        // Read from client, print to stdout:
        if (FD_ISSET(fdRead, &rfds)) {
            cout << readLine(fdRead);
        }

        // Read from stdin, send to client.
        if (FD_ISSET(0, &rfds)) {
            writeBuffer.push_back(readLine(0));
        }

        // Send the buffer to the client:
        if (FD_ISSET(fdWrite, &wfds) && writeBuffer.size() > 0) {
            vector<string>::iterator itString;

            for(itString = writeBuffer.begin(); itString != writeBuffer.end(); ++itString) {
                write(fdWrite, (*itString).c_str(), (*itString).length());
            }

            writeBuffer.clear();
        }
    }

    unlink(name);
    return cin.get();
}

string readLine(int fd) {
    char in;
    string buffer;

    // Read till the end, or a newline.
    while(read(fd, &in, 1) > 0) {
        buffer.push_back(in);

        if(in == '\n') {
            break;
        }
    }

    return buffer;
}
