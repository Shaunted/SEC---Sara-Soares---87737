`timescale 1ns / 1ps

module add_shft_mul (
                     input         clk,
                     input         rst,
                     
                     input signed [7:0]   a, 
                     input signed [15:0]   b,
                     output reg signed [15:0] c,
                     input         start,
                     output        done
                     );

   reg [3:0]                     counter;


   assign done = (counter == 4'd8);

   always@(posedge clk)
     if(rst)
       counter <= 4'd8;
     else if (start)
       counter <= 4'd0;
     else if (counter != 4'd8)
       counter <= counter + 1'b1;
   
    
     always@(posedge clk)
     if(rst)
        c <= 16'd0;
     else if(counter != 4'd7) begin 
        c <= (c>>>1) + (b[counter]? a<<7: 16'd0);
     end
     else if(counter == 4'd7) begin
     c <= c  - (b[counter]? a<<7: 16'd0);
     c <= c>>>1;
     end
endmodule


module add_shft_mul_tb ();

   reg clk, rst;
   reg signed [7:0] a;
   reg signed [15:0] b;
   wire signed [15:0] c;
   reg         start;
   wire        done;
   
   add_shft_mul mult0 (
                       .clk(clk),
                       .rst(rst),
                     
                       .a(a), 
                       .b(b),
                       .c(c),
                       .start(start),
                       .done(done)
                     );   

   initial begin

      $dumpfile("dump.vcd");
      $dumpvars;
      
      rst = 1;
      clk = 1;
      start = 0;

      a= 10;
      b = -2;

      @(posedge clk) #1 rst=0;

      #5 @(posedge clk) #1 start=1;
      @(posedge clk) #1 start=0;

      @(posedge done) $display("%d", c);
      
      @(posedge clk) $finish;
   end
   
   always #10 clk = ~clk;
 
endmodule
