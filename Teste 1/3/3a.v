`timescale 1ns / 1ps

module 3a (
                  input clk,
                  input [3:0] x,
                  input x_valid,
                  output reg [11:0] y,
                  output y_valid
                  );

reg [3:0] x1;
reg [3:0] x2;
reg [3:0] x3;

assign y_valid = x_valid;

always @(posedge clk) begin
        x1 <= x;
        x2 <= x1;
        x3 <= x2;
        y = (x<<1)+ x1+ x2+ x3;
end


endmodule


