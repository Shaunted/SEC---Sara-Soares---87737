module CLA_node(
    input   [1:0] p,
    input   [1:0] g,
    input   ci,
    output  co,
    output  P,
    output  G
);

assign co = g[0] | (p[0]&co);
assign P = p[1]&p[0];
assign G = g[1] | (p[1]&g[0]);

endmodule