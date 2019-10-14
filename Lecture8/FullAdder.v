module FullAdder(
    input   a,
    input   b,
    input   ci,
    output  p,
    output  g,
    output  s
);


assign p = a^b;
assign s = p^ci;
assign g = (a&b);

endmodule
