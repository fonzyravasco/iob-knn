`timescale 1ns/1ps
`include "iob_lib.vh"
`include "interconnect.vh"

module knn_tb;

   localparam PER=10;
   
   `CLOCK(clk, PER)
   `RESET(rst, 7, 10)

   `SIGNAL(KNN_ENABLE, 1)
   `SIGNAL(KNN_SAMPLE, 1)
   
   `SIGNAL(x1, `DATA_W/2)
   `SIGNAL(x2, `DATA_W/2)
   `SIGNAL(y1, `DATA_W/2)
   `SIGNAL(y2, `DATA_W/2)
   
   //`SIGNAL_OUT(KNN_VALUE, `DATA_W)   
   `SIGNAL_OUT(z, `DATA_W)
   
   initial begin
`ifdef VCD
      $dumpfile("knn.vcd");
      $dumpvars();
`endif
      KNN_ENABLE = 0;
      KNN_SAMPLE = 0;

      @(posedge rst);
      @(negedge rst);
      @(posedge clk) #1 KNN_ENABLE = 1;
      @(posedge clk) #1 KNN_SAMPLE = 1;
      @(posedge clk) #1 KNN_SAMPLE = 0;

      //uncomment to fail the test 
      //@(posedge clk) #1;
      
      @(posedge clk) #1 
       //en=1; 
      x1=1; 
      x2=4;
      y1=8; 
      y2=3;
      #1
      //z=KNN_VALUE;
      $display("Coordenates x1: %d  x2: %d  y1: %d  y2: %d Distance %d",x1, x2, y1, y2,z);

      if( z == 34) 
        $display("Test passed");
      else
        $display("Test failed: expecting knn value 34 but got %d", z);
      
      @(posedge clk) #1 
       //en=1; 
      x1=3; 
      x2=15;
      y1=20; 
      y2=50;
      #1
      //z=KNN_VALUE;
      $display("Coordenates x1: %d  x2: %d  y1: %d  y2: %d Distance %d",x1, x2, y1, y2,z);

      if( z == 1044) 
        $display("Test passed");
      else
        $display("Test failed: expecting knn value 34 but got %d", z);
        
        @(posedge clk) #1 
       //en=1; 
      x1=132; 
      x2=33;
      y1=640; 
      y2=12;
      #1
      //z=KNN_VALUE;
      $display("Coordenates x1: %d  x2: %d  y1: %d  y2: %d Distance %d",x1, x2, y1, y2,z);

      if( z == 404185) 
        $display("Test passed");
      else
        $display("Test failed: expecting knn value 34 but got %d", z);
      
      
      
      $finish;
   end
   
   //instantiate knn core
  knn_core knn0
     (
      .KNN_ENABLE(KNN_ENABLE),
      .clk(clk),
      .rst(rst),
      .x1(x1),
      .x2(x2),
      .y1(y1),
      .y2(y2),
      .z(z)
      );
    

endmodule
