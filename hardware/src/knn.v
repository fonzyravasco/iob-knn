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

//module Compare and Select

module knn_comp_sel
   #(
    parameter DATA_W = 32
    )
   ( 
    `INPUT(dist_target, DATA_W),
    `INPUT(clk,1),
    `INPUT(rst,1),
    `INPUT(write_enable_previous, 1),
    `INPUT(previous_data, DATA_W),
    `OUTPUT(data_out, DATA_W),
    `OUTPUT(write_enable_out, 1)    
    );
    
    `SIGNAL(write_enable,1)
    `SIGNAL(REG_OUT, DATA_W)
    `SIGNAL(content, DATA_W)
    
    
    `COMB begin
		if(dist_target < REG_OUT) write_enable = 1'b1; //Comparador para saber se escreve no registo
		else write_enable = 1'b0;
		
		//MUX
		if(write_enable_previous == 0) content = dist_target;
		else content = previous_data; //content é o que entra dentro do registo (register in)
		
	  end
	  
    `REG_ARE(clk, rst, '1, write_enable, REG_OUT, content)
    `SIGNAL2OUT( write_enable_out, write_enable)
    `SIGNAL2OUT(data_out,REG_OUT)
endmodule



module knn_list
   #(
    parameter DATA_W = 32,
    parameter NUMBER_VIZI = 10
    )
    (
   `INPUT(neighbour_data, NUMBER_VIZI*(DATA_W)),
   `INPUT(clk, 1),
   `INPUT(rst,1),
   `INPUT(dist_target, DATA_W),
   `OUTPUT(data_out, DATA_W)
   );

	`SIGNAL(write_enable_list, NUMBER_VIZI)
	    
    knn_comp_sel comp_sel0
    (
     .dist_target(dist_target), // distância a ser avaliada
     .clk(clk),
     .rst(rst),
     .write_enable_previous(1'b0),
     .previous_data(neighbour_data[DATA_W-1:0]),
     .data_out(neighbour_data[DATA_W-1:0]),
     .write_enable_out(write_enable_list[0])
 
    );
    
    //Criar vários knn_comp_sel's para os seguintes
    genvar j;
    generate
	 for(j=1 ; j<NUMBER_VIZI ; j=j+1) begin
		
	knn_comp_sel comp_sel
    (
     .dist_target(dist_target), // distância a ser avaliada
     .clk(clk),
     .rst(rst),
     .write_enable_previous(write_enable_list[j-1]),
     .previous_data(neighbour_data[(DATA_W)*j-1:(DATA_W*(j-1))]),
     .data_out(neighbour_data[(DATA_W)*(j+1)-1:(DATA_W*j)]),
     .write_enable_out(write_enable_list[j])
    );
    end		
    endgenerate


endmodule
