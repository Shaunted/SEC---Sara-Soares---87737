`timescale 1ns/1ps

module counter ( //Counter module with clock, reset, enable and 2bit output register.
  input 	   clk,
  input 	   rst,
  input 	   en,
  output reg [1:0] data_out
);

   
   always @ (posedge clk) begin // Counter until 10 with enable and reset button.
      if (rst == 1'b1) begin
	      data_out <= 2'b0;
      end
      else if (en == 1'b1 ) begin	 
	       if(data_out != 2'b11)
	         data_out <= data_out+1'b1;
         end
      end

endmodule
