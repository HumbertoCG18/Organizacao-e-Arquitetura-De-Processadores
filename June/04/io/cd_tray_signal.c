#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <stdbool.h>

volatile bool tray_open = false;

void toggle_tray() {
    const char *cmd = tray_open ? "eject -t" : "eject";
    system(cmd);
    tray_open = !tray_open;
    printf("[SINAL] Gaveta %s\n", tray_open ? "aberta" : "fechada");
}

void handle_sigusr1(int sig) {
    toggle_tray();
}

int main() {
    printf("Modo: SINAL\n");
    printf("PID: %d\n", getpid());
    printf("Use `kill -USR1 %d` para alternar a gaveta do CD/DVD.\n", getpid());

    signal(SIGUSR1, handle_sigusr1);

    while (1) {
        pause();
    }

    return 0;
}