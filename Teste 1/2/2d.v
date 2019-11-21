`timescale 1ns / 1ps

module test_ex1 (
                  input clk,
                  input signed [3:0] a,
                  output reg signed [11:0] c
                  );


    assign c = a*a*a;

endmodule



