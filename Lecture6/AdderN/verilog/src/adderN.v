`timescale 1ns/1ps

module AdderN
#(parameter N=32)
(
  input 	  [N-1:0] a,
  input     [N-1:0] b,
  output    [N-1:0] data_out
);


assign data_out = a + b;


endmodule
