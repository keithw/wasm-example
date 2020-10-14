#include <stdio.h>
#include <stdlib.h>

#define WASM_RT_MODULE_PREFIX fixpoint_

#include "add_in_wasm.h"

int main( int argc, char *argv[] )
{
  int a, b;

  if ( argc < 1 ) {
    abort();
  }
  
  if ( argc < 2 ) {
    fprintf( stderr, "Usage: %s A B\n", argv[ 0 ] );
    return 1;
  }

  a = atoi( argv[ 1 ] );
  b = atoi( argv[ 2 ] );

  fixpoint_init();
  
  printf( "The sum of %d and %d is: %d\n", a, b, fixpoint_Z_addZ_iii( a, b ) );

  return 0;
}
