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
   
   `SIGNAL(neighbour_data, `DATA_W*4) 
   `SIGNAL(dist_target, `DATA_W)
   `SIGNAL(output_data, `DATA_W*4)
  
    
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
     
      @(posedge clk) #1
      
      neighbour_data[`DATA_W-1:0] = 32'b00000000000000000000000000000001;
      neighbour_data[2*`DATA_W-1:`DATA_W] =32'b00000000000000000000000000000010;
      neighbour_data[3*`DATA_W-1:2*`DATA_W] =32'b00000000000000000000000000000100;
      neighbour_data[4*`DATA_W-1:3*`DATA_W] =32'b00000000000000000000000000001000;
      dist_target =32'b00000000000000000000000000000011;
   
      #1
      if(output_data[`DATA_W-1:0] == 1) 
        $display("Test passed");
      else
        $display("Test failed: expecting knn value 1 but got %d", output_data[`DATA_W-1:0]);
        
       if(output_data[2*`DATA_W-1:`DATA_W] == 2) 
        $display("Test passed");
      else
        $display("Test failed: expecting knn value 2 but got %d", output_data[2*`DATA_W-1:`DATA_W]);
        
       if(output_data[3*`DATA_W-1:2*`DATA_W] == 3) 
        $display("Test passed");
      else
        $display("Test failed: expecting knn value 3 but got %d", output_data[3*`DATA_W-1:2*`DATA_W]);
      
      if(output_data[4*`DATA_W-1:3*`DATA_W] == 4) 
        $display("Test passed");
      else
        $display("Test failed: expecting knn value 4 but got %d", output_data[4*`DATA_W-1:3*`DATA_W]);
      
     
     $display("Tests failed because no Control finite state machine was added (registers keep writing the same value. So sad."); 
      
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
   
    knn_list list0
    (
     .neighbour_data(neighbour_data),
     .clk(clk),
     .rst(rst),
     .dist_target(dist_target),
     .list_out(output_data)
	);


endmodule
