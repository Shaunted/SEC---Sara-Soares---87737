`timescale 1ns / 1ps

//O numero de addr é 1kbits, sendo que há 1Byte por addr. Assim sendo,
//para obter 32kB, é necessario 32kB/1kB = 32.
//O novo módulo terá de ter um address de 15 bits. 5 para escolher
//o modulo desejado e 10 para escolher o endereço dentro do modulo em si

module RAM_Eight(
    input   clk,
    input   we,
    input   data_in[7:0],
    input   address[14:0],
    output  data_out[7:0]
);


wire [7:0] data_o[31:0];

wire [7:0] data_i[31:0];

generate for(i=0; i<32; i = i+1) 
    RAM ram1(
        .clk(clk),
        .we(we),
        .address(address[9:0]),
        .data_in(data_i[i]),
        .data_out(data_o[i])
    );
    if(address[14:10] == i)begin
        data_out = data_o[i];
        data_in = data_i[i];
    end
endgenerate



