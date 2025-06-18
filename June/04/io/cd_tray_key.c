#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdbool.h>
#include <termios.h>
#include <fcntl.h>
#include <sys/select.h>

volatile bool tray_open = false;

void toggle_tray() {
    const char *cmd = tray_open ? "eject -t" : "eject";
    system(cmd);
    tray_open = !tray_open;
    printf("[TECLA] Gaveta %s\n", tray_open ? "aberta" : "fechada");
}

void enable_raw_mode() {
    struct termios t;
    tcgetattr(STDIN_FILENO, &t);
    t.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &t);
    fcntl(STDIN_FILENO, F_SETFL, O_NONBLOCK);
}

int main() {
    printf("Modo: TECLA\n");
    printf("Pressione [Enter] ou [Espaço] para alternar a gaveta.\n");
    printf("Pressione 'q' para sair.\n");

    enable_raw_mode();

    while (1) {
        fd_set fds;
        FD_ZERO(&fds);
        FD_SET(STDIN_FILENO, &fds);

        struct timeval timeout = {1, 0};
        int ret = select(STDIN_FILENO + 1, &fds, NULL, NULL, &timeout);

        if (ret > 0 && FD_ISSET(STDIN_FILENO, &fds)) {
            char c;
            if (read(STDIN_FILENO, &c, 1) > 0) {
                if (c == '\n' || c == ' ') {
                    toggle_tray();
                }
                if (c == 'q') {
                    printf("\nEncerrando...\n");
                    break;
                }
            }
        }
    }

    return 0;
}