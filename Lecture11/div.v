`timescale 1ns / 1ps

module signed_div(
    input rst,
    input start,
    input [3:0] d,
    input [3:0] D,
    input clk,
    output [3:0] qout
);

wire [3:0] D1;
reg [3:0] r, d1, q;
reg [7:0] RD;


always@(posedge clk)
    if(rst) begin
        d1<= 4'd0;
    end
    else if(start) begin
        d1<= d;
    end

always@*
    if(D1>=d1) begin
        r = D1-d1;
        q = 1;
    end
    else begin
        r = D1;
        q = 0;
    end

always@(posedge clk)
    if(rst)
        RD<= 8'd0;
    else if(start) begin
        RD<={4'd0,D};
    end
    else begin
        RD <= {r,RD[2:0],q};
    end

assign qout = RD[3:0];

endmodule

module signed_div_tb ();

   reg clk, rst;
   reg signed [3:0] a;
   reg signed [3:0] b;
   wire signed [3:0] c;
   reg         start;
   
   signed_div div0 (
                       .clk(clk),
                       .rst(rst),
                       .d(a), 
                       .D(b),
                       .qout(c),
                       .start(start)
                     );   

   initial begin

      $dumpfile("dump.vcd");
      $dumpvars;
      
      rst = 1;
      clk = 1;
      start = 0;

      a= 4'd10;
      b = 4'd2;

      @(posedge clk) #1 rst=0;

      #5 @(posedge clk) #1 start=1;
      @(posedge clk) #1 start=0;

      @(posedge done) $display("%d", c);
      
      @(posedge clk) $finish;
   end
   
   always #10 clk = ~clk;
 
endmodule
    


