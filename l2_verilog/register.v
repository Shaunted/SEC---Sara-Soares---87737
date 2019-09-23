`timescale 1ns/1ps

module register ( //input and outputs of 32 bit register.
  input		    clk,
  input             en,
  input    [31:0] data_in,   
  output reg [31:0] data_out    
);


always @ (posedge clk) //as long as enable is 1, output equals input.
   if (en == 1'd1) 
     data_out <= data_in;

endmodule
