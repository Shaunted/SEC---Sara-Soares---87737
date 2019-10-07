
`timescale 1ns / 1ps

module adder_tb;
   wire [7:0] a;
   wire [7:0] b;
   wire [7:0] data_out;
   
   
   // Instantiate the Unit Under Test (UUT)
   adder AdderN #(.N(8)) uut (
      .a(a),
      .b(b),
      .data_out(data_out)
		);

   initial begin
      a = 1b'4;
      b = 1b'5;
   end

endmodule

