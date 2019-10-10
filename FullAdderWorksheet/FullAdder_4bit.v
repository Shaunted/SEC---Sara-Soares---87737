module FullAdder4bit(
    input   [3:0] a,
    input   [3:0] b,
    input   ci,
    output  co,
    output  [3:0] s
);

wire [4:0] cout;
assign cout[0] = ci;
assign co = cout[4];

genvar i;

generate for(i=0; i<4; i = i+1) 
    FullAdder full1(
        .bita(a[0]),
        .bitb(b[0]),
        .ci(cout[i]),
        .co(cout[i+1]),
        .s(s[i])
    );
endgenerate
endmodule
/*
wire [2:0] cout;


full_adder full1(
        .bita(a[0]),
        .bitb(b[0]),
        .ci(ci),
        .co(cout[0]),
        .s(s[0])
);

full_adder full2(
        .bita(a[1]),
        .bitb(b[1]),
        .ci(cout[0]),
        .co(cout[1]),
        .s(s[1])
);

full_adder full3(
        .bita(a[2]),
        .bitb(b[2]),
        .ci(cout[1]),
        .co(cout[2]),
        .s(s[2])
);

full_adder full4(
        .bita(a[3]),
        .bitb(b[3]),
        .ci(cout[2]),
        .co(co),
        .s(s[3])
);



endmodule*/
