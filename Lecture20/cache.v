`timescale 1ns / 1ps

`define N_W 3
`define NSETS_W 10

module cache(
        input clk,
        input rst,
        input en,
        input write,
        input [31:0] addr,
        input [31:0] data_in,
        output hit,
        output [31:0] data_out
);

reg [32:0] mem0[NSETS-1:0];
reg [32:0] mem1[NSETS-1:0];
reg [32:0] mem2[NSETS-1:0];
reg [32:0] mem3[NSETS-1:0];
reg [32:0] mem4[NSETS-1:0];
reg [32:0] mem5[NSETS-1:0];
reg [32:0] mem6[NSETS-1:0];
reg [32:0] mem7[NSETS-1:0];

reg [18:0] tag[NSETS-1:0];



always @(posedge clk) begin
    if(en) begin
        if(write)
            mem[addr[NSETS_W+N_W-1 : N_W]] <= data_in[];
        else
            line_out <= mem[addr[NSETS_W+N_W-1 : N_W]]
    end
end

