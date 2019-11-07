`timescale 1ns / 1ps

module ROM(
        input   [3:0] A,
        output reg [5:0] D
);

reg [5:0] rom [9:0];

initial begin
    $readmemb("Rom.txt", rom,0,9);
end

always@(A) begin
    D = rom[A];
end

endmodule


module ROM_tb();

reg [3:0] A;
wire [5:0] D;

ROM rom1(
    .A(A),
    .D(D)
);

initial begin

      $dumpfile("dump.vcd");
      $dumpvars;

      for(A = 0 ; A < 10; A = A + 1) begin
        #100;
      end

   end

endmodule