`timescale 1ns / 1ps

module RAM(
    input   clk,
    input   we,
    input   data_in[7:0],
    input   address[9:0],
    output  data_out[7:0]
);


reg [7:0]    ram[2**10-1:0];


initial begin
    $readmemh("ram.hex", ram, 0, 2**10-1)
end

always@(posedge clk)begin
    if(we) begin
        ram[address] <= data_in;
    end
    data_out <= ram[address];
end

endmodule
