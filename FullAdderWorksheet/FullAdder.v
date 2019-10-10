module FullAdder(
    input   bita,
    input   bitb,
    input   ci,
    output  co,
    output  s
);

wire axb;

assign axb = bita^bitb;
assign s = axb^ci;
assign co = (bita&bitb) | (ci&axb);

endmodule
