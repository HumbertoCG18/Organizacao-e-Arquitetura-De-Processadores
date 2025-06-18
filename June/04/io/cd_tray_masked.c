#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <stdbool.h>
#include <string.h>

volatile bool tray_open = false;
volatile sig_atomic_t signal_received = 0;

void toggle_tray() {
    const char *cmd = tray_open ? "eject -t" : "eject";
    system(cmd);
    tray_open = !tray_open;
    printf("[SINAL COM MÁSCARA] Gaveta %s\n", tray_open ? "aberta" : "fechada");
}

void handle_sigusr1(int sig) {
    signal_received = 1;
}

int main() {
    printf("Modo: SINAL com MÁSCARA\n");
    printf("PID: %d\n", getpid());
    printf("Use `kill -USR1 %d` para alternar a gaveta do CD/DVD.\n", getpid());

    struct sigaction sa;
    sigemptyset(&sa.sa_mask);
    sa.sa_handler = handle_sigusr1;
    sa.sa_flags = 0;
    sigaction(SIGUSR1, &sa, NULL);

    sigset_t mask, oldmask;
    sigemptyset(&mask);
    sigaddset(&mask, SIGUSR1);

    while (1) {
        // Bloqueia temporariamente SIGUSR1
        sigprocmask(SIG_BLOCK, &mask, &oldmask);

        if (signal_received) {
            toggle_tray();
            signal_received = 0;
        }

        // Espera por sinal com máscara desbloqueada
        printf("Aguardando sinal com máscara restaurada...\n");
        sigsuspend(&oldmask);

        // Após retorno do sigsuspend, o sinal já foi tratado
    }

    return 0;
}