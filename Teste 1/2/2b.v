`timescale 1ns / 1ps

module test_ex1 (
                  input clk,
                  input signed [3:0] a,
                  output reg signed [11:0] c
                  );

   reg [7:0]                  y;

   always @(posedge clk) begin 
        y <= a[2:0]*a[2:0];
        c  <= y*a[2:0];
        if (a[3])
        c <= -c;

   end

endmodule

module test_ex1_tb();

reg clk,rst;
reg signed [3:0] a;
wire signed [11:0] c;

test_ex1 tb(
    .clk(clk),
    .a(a),
    .c(c)
);

    initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    rst = 1;
    clk = 1;  
    a = 2;
    #40
    rst = 0;
    #400;
    a = -(10'd2);
    #400;
    $finish;
   end

   always #10 clk = ~clk;

endmodule


