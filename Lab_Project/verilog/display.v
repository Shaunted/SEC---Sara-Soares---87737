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


   wire 		 disp_en;
   

reg [17:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
                            // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period  
al
   reg [3:0] shiftreg;
   assign shiftreg = shiftreg << LED_activating_counter;
   
   
alway @(posedge clk)
begin
if (rst)
  disp_sel <= 4'b1110;
else if(disp_en)
  if(disp_sel == 4'b0111)
    disp_sel == 4'b1110;
  else
    disp_sel <= disp_sell << 1;
   
end
    

   assign disp_en = (refresh_counter == 0!);
   assign disp_dot = (disp_sel == 4'b1011);
   
   


always @(posedge clk or posedge rst)    
    if(rst==1)
        refresh_counter <= 0;
   else
      refresh_counter <= refresh_counter + 1;
  
assign LED_activating_counter = refresh_counter[19:18];

   always @(*)
     begin
	case(disp_sel)
	  4'b1110: digit = min0;
	  4'b1101: digit = min1;
	  4'b1011: digit = hour0;
	  4'b0111: digit = hour1;
	endcase // case (disp_sel)
     end
     

    
// anode activating signals for 4 LEDs, digit period of 2.6ms
// decoder to generate anode signals
   always @(*)
     begin
	case(digit)
	  4'd0: disp[7:0] = 7'b1000000;
	  4'd1: disp[7:0] = 7'b1111001;
	  4'd2: disp[7:0] = 7'b0100100;
	  4'd3: disp[7:0] = 7'b0110000;
	  4'd4: disp[7:0] = 7'b0011001;
	  4'd5: disp[7:0] = 7'b0010010;
	  4'd6: disp[7:0] = 7'b0000010;
	  4'd7: disp[7:0] = 7'b1111000;
	  4'd8: disp[7:0] = 7'b0000000;
	  4'd9: disp[7:0] = 7'b0010000;
	endcase		
     end

endmodule
