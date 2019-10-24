`timescale 1ns / 1ps
`include "xdefs.vh"

module xledprint (
		input 	    clk,
		input				rst,
		input 	    sel,
		input				data_in,
		output	reg		led
		);

 always @(posedge clk)
	if(rst)
		led <= 1'b0;
  else if(sel)
    led <=data_in;

endmodule
