#include "stdio.h"

int func_sum (int a, int b){
    return a+b;
}

#define macro_sum(a, b) \
    a+b+c; \

int main() {
    int c = 10;
    int rf = func_sum(1,2);
    int rm = 1,2+c; //macro_sum(1,2);

    printf("Sum using function -> %d\n", rf);
    printf("Sum using macro -> %d\n", rm);
}