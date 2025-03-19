#include <stdio.h>

main(){
    int n = 10;
    int result = 0;
    result = div2(n);
}

div2(int a){
    if(a < 2) return 0;
    if(a = 2) return 1;
    return (1 + div2(a - 2));
}