module FullAdder(
    input   a,
    input   b,
    input   ci,
    output  co,
    output  s
);

wire axb;

assign axb = a^b;
assign s = axb^ci;
assign co = (a&b) | (ci&axb);

endmodule
