module CLA_top(
    input   [3:0] a,
    input   [3:0] b,
    input   ci,
    output  co,
    output  [3:0] s

);

wire [2:0] cout;
wire [6:0]  p;
wire [6:0]  g;
assign co = g[6] | (p[6]&ci);

FullAdder full0(
    .a(a[0]),
    .b(b[0]),
    .ci(ci),
    .p(p[0]),
    .g(g[0]),
    .s(s[0])

);

FullAdder full1(
    .a(a[1]),
    .b(b[1]),
    .ci(cout[0]),
    .p(p[1]),
    .g(g[1]),
    .s(s[1])

);

FullAdder full2(
    .a(a[2]),
    .b(b[2]),
    .ci(cout[1]),
    .p(p[2]),
    .g(g[2]),
    .s(s[2])

);

FullAdder full3(
    .a(a[3]),
    .b(b[3]),
    .ci(cout[2]),
    .p(p[3]),
    .g(g[3]),
    .s(s[3])

);


CLA_node nodeB0(
    .p(p[1:0]),
    .g(g[1:0]),
    .ci(ci),
    .co(cout[0]),
    .P(p[4]),
    .G(g[4])
);

CLA_node nodeB1(
    .p(p[3:2]),
    .g(g[3:2]),
    .ci(cout[1]),
    .co(cout[2]),
    .P(p[5]),
    .G(g[5])
);

CLA_node nodeB2(
    .p(p[5:4]),
    .g(g[5:4]),
    .ci(ci),
    .co(cout[1]),
    .P(p[6]),
    .G(g[6])
);