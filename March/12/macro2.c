#include "stdio.h"

int func_sum (int a, int b){
    return a+b;
}

#define macro_sum(a, b) a+b+c;
#define SIZE 11

int main() {
    char array[SIZE];
    int i = SIZE;

    loop:
        array[i-1] = i+0x63;
        i--;
        if (i > 0) 
            goto loop;
    end:

    printf("Str -> %d\n", array);
}
