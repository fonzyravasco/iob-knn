#include "interconnect.h"
#include "iob_knn.h"
#include "KNNsw_reg.h"

//base address
static int base;

void knn_reset(){
  IO_SET(base, KNN_RESET, 1);
  IO_SET(base, KNN_RESET, 0);
}

void knn_start(){
  IO_SET(base, KNN_ENABLE, 1);
}

void knn_stop(){
  IO_SET(base, KNN_ENABLE, 0);
}

void knn_init(int base_address){
  base = base_address;
  knn_reset();
}

unsigned int knn_gen_inputs(short x1, short x2, short y1, short y2){

  IO_SET(base, KNN_x1sw, x1);
  IO_SET(base, KNN_x2sw, x2);
  IO_SET(base, KNN_y1sw, y1);
  IO_SET(base, KNN_y2sw, y2);

  return IO_GET(base,KNN_zsw);
}
