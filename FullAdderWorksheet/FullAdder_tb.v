`timescale 1ns / 1ps

module FullAdder_tb;

   reg     [3:0] a;
   reg     [3:0] b;
   wire    [3:0] s;
   reg     ci;
   wire    co;

   FullAdder4bit uut (
         .a    (a),
         .b		(b),
         .ci	(ci),
         .co	(co),
         .s	   (s)
         );

 
   
   initial begin
      $dumpfile("FullAdder_4bit.vcd");
      $dumpvars();
      
      a = 5;
      b = 2;

      #10

      a = 2;
      b = 2;

      #10
      $finish;

   end
   
   

endmodule

