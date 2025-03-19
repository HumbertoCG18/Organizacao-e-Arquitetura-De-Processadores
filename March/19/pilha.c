#include <stdio.h>


main(){
		int var_a=0x00AA0000;
		int var_b=0x0000BB00;
		int var_c=0x000000CC;
		int var_x=0;

	var_x = soma3(var_a,var_b,var_c);
    }

    int soma3(int x, int y, int z){
      return(soma(z,soma(x,y)));
    }

    int soma(int x1, int x2){
      return(x1+x2);
    }