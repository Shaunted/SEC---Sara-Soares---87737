`timescale 1ns / 1ps

module RCM(
    input [1:0] a,
    input [1:0] b,
    output [3:0] s
);

assign s[0] =  a[0]*b[0];
wire    c;
wire    ci;
assign  ci = 0;

FullAdder halfadder0(
    .a(a[1]&b[0]),
    .b(a[0]&b[1]),
    .ci(ci),
    .co(c),
    .s(s[1])
);

FullAdder halfadder1(
    .a(a[1]&b[1]),
    .b(c),
    .ci(ci),
    .co(s[3]),
    .s(s[2])
);

endmodule