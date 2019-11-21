`timescale 1ns / 1ps

module 3a (
                  input clk,
                  input [3:0] x,
                  input x_valid,
                  output reg [5:0] y,
                  output y_valid,
                  input rst
                  );

reg [3:0] x1;
reg [3:0] x2;
reg [3:0] x3;

assign y_valid = x_valid;

always @(posedge clk) begin
        if(rst) begin
                x <= 0;
        end
        else begin
        x1 <= x;
        x2 <= x1;
        x3 <= x2;
        y = (x<<1)+ x1+ x2+ x3;
        end
end

endmodule



module 3a();

reg clk,rst;
reg signed [3:0] a;
wire signed [5:0] c;

test_ex1 tb(
    .clk(clk),
    .a(a),
    .c(c),
    .rst(rst)
);

    initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    rst = 1;
    clk = 1;  
    a = 4'b1111;
    #40
    rst = 0;
    #400;
    a = 4'b0101;
    #400;
    $finish;
   end

   always #10 clk = ~clk;

endmodule



