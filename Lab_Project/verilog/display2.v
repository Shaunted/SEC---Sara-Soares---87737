`timescale 1ns / 1ps

module display(
	input 		 clk,
   input 		 rst,
	input [1:0] 	 hour1,
	input [3:0] 	 hour0,
	input [2:0] 	 min1,
	input [3:0] 	 min0,
   output reg [6:0] disp_num,
	output reg [3:0] disp_sel,
	output 		 disp_dot
);


//-------teste disp------
	/*wire [1:0] 	 hour1;
		wire [3:0] 	 hour0;
		wire [2:0] 	 min1;
		wire [3:0] 	 min0;
		
		assign hour1 = 2;
		assign hour0 = 1;
		assign min1 = 3;
		assign min0 = 5;*/
//-----------------------


   wire 		 disp_en;

reg [17:0] refresh_counter;


	reg [3:0] digit;
	
   
always @(posedge clk) begin
	if (rst)
		disp_sel <= 4'b0111;
	else if(disp_en) begin
		if(disp_sel == 4'b0111)
			disp_sel <= 4'b1110;
		else begin
			disp_sel[3:1] <= disp_sel[2:0];
			disp_sel[0] <= 1'b1;
		end
	end
end 

   assign disp_en = (refresh_counter == 0);
	assign disp_dot = ~(disp_sel == 4'b1101);

		
   
   


always @(posedge clk, posedge rst)  begin   
	if(rst) begin
		refresh_counter <= 0;
	end		  
   else begin
		refresh_counter <= refresh_counter + 1;	
	end
end


   always @(*)begin
		case(disp_sel)
			4'b0111: digit = min0;
			4'b1011: digit = min1;
			4'b1101: digit = hour0;
			4'b1110: digit = hour1;
			default: digit = min0;
		endcase // case (disp_sel)
	end
     

    
// anode activating signals for 4 LEDs, digit period of 2.6ms
// decoder to generate anode signals
   always @(*)
     begin
	case(digit)
	  4'd0: disp_num[6:0] = 7'b1000000;
	  4'd1: disp_num[6:0] = 7'b1111001;
	  4'd2: disp_num[6:0] = 7'b0100100;
	  4'd3: disp_num[6:0] = 7'b0110000;
	  4'd4: disp_num[6:0] = 7'b0011001;
	  4'd5: disp_num[6:0] = 7'b0010010;
	  4'd6: disp_num[6:0] = 7'b0000010;
	  4'd7: disp_num[6:0] = 7'b1111000;
	  4'd8: disp_num[6:0] = 7'b0000000;
	  4'd9: disp_num[6:0] = 7'b0010000;
	  default: disp_num[6:0] = 7'b1000001;
	endcase		
     end



endmodule

/*
module display_tb ();

   reg clk, rst;
   reg  [1:0] hour1;
   reg  [2:0] min1;
   reg  [3:0] hour0, min0;
   wire	disp_dot;
   wire	[6:0] disp_num;
   wire	[3:0] disp_sel;
   
   display disp0 (
                       .clk(clk),
                       .rst(rst),
                       .hour0(hour0), 
                       .hour1(hour1),
					   .min0(min0),
					   .min1(min1),
    				   .disp_num(disp_num),
					   .disp_sel(disp_sel),
				       .disp_dot(disp_dot)
                     );   

   initial begin

      $dumpfile("dump.vcd");
      $dumpvars;
      
      rst = 1;
      clk = 1;

      hour0 = 4'd4;
      hour1 = 2'd2;
	  min0 = 4'd1;
	  min1 = 3'd3;


      @(posedge clk) #1 rst=0;

		#100000
      
      @(posedge clk) $finish;
   end
   
   always #10 clk = ~clk;
 
endmodule
*/


