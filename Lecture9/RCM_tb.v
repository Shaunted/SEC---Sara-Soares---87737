`timescale 1ns / 1ps

module RCM_tb;

   reg     [1:0] a;
   reg     [1:0] b;
   wire    [3:0] s;


   RCM uut (
         .a    (a),
         .b		(b),
         .s	   (s)
         );

 
   
   initial begin
      $dumpfile("RCM.vcd");
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