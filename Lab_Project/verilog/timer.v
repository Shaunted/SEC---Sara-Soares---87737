`timescale 1ns / 1ps
`include "xdefs.vh"


// 1 clock = 20ns
// 1 second = 50000000 clocks

module timer(
        input rst,
        input clk,
        //display interface
        output reg [1:0] hour1,
        output reg [3:0] hour0,
        output reg [2:0] min1,
        output reg [3:0] min0,
        //cpu interface
        input sel,
        input [3:0] data_in,
        output [3:0] data_out,
        input  address,
        input write_en
);

reg [25:0] c;
reg [5:0] r;
reg [5:0] s;
reg [3:0] m;
reg [1:0] h;

always @(posedge clk) begin
	if (rst) begin
		s <= 0;
		min0 <= 0;
		min1<= 0;
		hour0<= 0;
		hour1<= 0;
		c <= 0;
	end 
	else begin
		if(c == 50000000 - 1) begin
			c <= 0;
		end
      else begin
			c <=  c + 1;
      end
	end
	if (c == 50000000 - 1) begin
		s <= s + 1;
		if (s == 59) begin
			s <= 0;
      end
	end

	if ( s == 59) begin
		min0 <= min0 + 1;
		if ( min0 == 9) begin
			min0 <= 0;
        	min1 <= min1 + 1;
			if (min1 == 5) begin
				min1 <= 0;
			end
		end
	end

	if (min1==5 && min0==9) begin
		hour0 <= hour0 + 1;
		if ( hour0 == 9) begin
			hour0 <= 0;
			hour1 <= hour1 + 1;
			if(hour1 == 2 && hour0 == 3)begin
				hour0 <= 0;
				hour1 <= 0;
			end
		end    
	end

	if(address == MIN0)
		data_out <= min0;
	if(address == MIN1)
      	data_out <= {0,min1};
	if(address == HOUR0)
      	data_out <= hour0; 
	if(address == HOUR1)
       	data_out <= {0,0,hour1};

    if(write_en & sel) begin
        if(address == MIN0)
            min0 <= data_in;
		if(address == MIN1)
            min1 <= data_in;
		if(address == HOUR0)
            hour0 <= data_in; 
		if(address == HOUR1)
            hour1 <= data_in;
    end

end
endmodule