`timescale 1ns/1ps
`include "iob_lib.vh"

module knn_core
  #(
    parameter DATA_W = 32
    )
   (
    `INPUT(KNN_ENABLE, 1),
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(x1, DATA_W/2),
    `INPUT(x2, DATA_W/2),
    `INPUT(y1, DATA_W/2),
    `INPUT(y2, DATA_W/2),
    `OUTPUT(z, DATA_W)
    );

   `SIGNAL(dist_int, DATA_W) //internal y
   `SIGNAL_SIGNED(distx, DATA_W/2) //internal y
   `SIGNAL_SIGNED(disty, DATA_W/2) //internal y
   `SIGNAL2OUT(z, dist_int) //connect internal y to output

   `COMB begin
     distx=x1-x2;
     disty=y1-y2;
     dist_int=distx*distx+disty*disty;
   end


endmodule
