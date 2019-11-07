`include "xdefs.vh"
`timescale 1ns / 1ps

module xaddr_decoder_LED (
	             // address and global select signal
	              input [`ADDR_W-2:0] addr,

                output reg led_sel

                     );

if(addr == {{`ADDR_W-2{1'b0}},768})


endmodule
