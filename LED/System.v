`timescale 1ns / 1ps
`include "xdefs.vh"

module system(
    input clk,
    input rst,
    output reg led
);

wire par;
wire sel;

xaddr_decoder decoder(
    .ext_sel(sel)

);

xtop picoversat(
    .clk(clk),
    .rst(rst),
    .par_out({{`DATA_W-1{1'b0}},par})

);

xledprint led(
    .clk(clk),
    .rst(rst),
    .sel(sel),
    .data_in(par),
    .led(led)

);

endmodule
