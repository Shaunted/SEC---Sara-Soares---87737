`timescale 1ns / 1ps

`include "xdefs.vh"
`include "xctrldefs.vh"
`include "xprogdefs.vh"
`include "xregfdefs.vh"


module xtop (
	     input                    clk,
	     input                    rst,
             output reg               trap,

	     // native interface
	     input [`REGF_ADDR_W-1:0] par_addr,
	     input                    par_we,
	     input [`DATA_W-1:0]      par_in,
	     output [`DATA_W-1:0]     par_out
	     );

   //
   //
   // CONNECTION WIRES
   //
   //
   
   // INSTRUCTION MEMORY INTERFACE
   wire [`INSTR_W-1:0] 		  instruction;
   wire [`ADDR_W-2:0]             pc;

   // DATA BUS
   wire 			  data_sel;
   wire 			  data_we;
   wire [`ADDR_W-1:0] 		  data_addr;
   reg [`DATA_W-1:0] 		  data_to_rd;
   wire [`DATA_W-1:0] 		  data_to_wr;

   
   // SIGNALS FROM PERIPHERALS
   reg 				  mem_sel;
   wire [`DATA_W-1:0] 		  mem_data_to_rd;
   
   reg 				  regf_sel;
   wire [`DATA_W-1:0] 		  regf_data_to_rd;

   
`ifdef DEBUG
   reg 				  cprt_sel;
`endif
   
   
   //
   //
   // FIXED SUBMODULES
   //
   //
   
   //
   // CONTROLLER MODULE
   //
   xctrl controller (
		     .clk(clk), 
		     .rst(rst),
		     
		     // Program memory interface
		     .pc(pc),
		     .instruction(instruction),
		     
		     // mem data bus
		     .data_mem_sel(data_sel),
		     .data_mem_we (data_we), 
		     .data_mem_addr(data_addr),
		     .data_from_mem(data_to_rd), 
		     .data_to_mem(data_to_wr)
		     );

   // HOST-CONTROLLER SHARED REGISTER FILE
   xregf regf (
	       .clk(clk),
	       
	       //host interface (external)
	       .ext_we(par_we),
	       .ext_addr(par_addr),
	       .ext_data_in(par_in),
	       .ext_data_out(par_out),
			
	       //versat interface (internal)
	       .int_sel(regf_sel),
	       .int_we(data_we),
	       .int_addr(data_addr[`REGF_ADDR_W-1:0]),
	       .int_data_in(data_to_wr),
	       .int_data_out(regf_data_to_rd)
	       );

   // MEMORY MODULE
   xram ram (
	       .clk(clk),

	       // instruction interface
	       .pc(pc),
       	       .instruction(instruction),

	       //data interface 
	       .data_sel(mem_sel),
	       .data_we(data_we),
	       .data_addr(data_addr[`ADDR_W-2 : 0]),
	       .data_in(data_to_wr),
	       .data_out(mem_data_to_rd)
	       );


   // ADDRESS DECODER

   wire                           trap_sel;
   
   xaddr_decoder addr_decoder (
	                       // address
	                       .addr(data_addr[`ADDR_W-1 -: `SEL_ADDR_W]),
                               .sel(data_sel),
                               
                               // read ports
                               .regf_data_to_rd(regf_data_to_rd),
                               .mem_data_to_rd(mem_data_to_rd),
                               
                               // module select
	                       .mem_sel(mem_sel),
	                       .regf_sel(regf_sel),
`ifdef DEBUG	
	                       .cprt_sel(cprt_sel),
`endif
                               .data_to_rd(data_to_rd),
                               .trap_sel(trap_sel)
                               );
   

   always @(posedge clk, posedge rst)
     if(rst)
       trap <= 0;
     else if (trap_sel & data_we)
       trap <= 1;
   
   //
   //
   // USER MODULES INSERTED BELOW
   //
   //
   
`ifdef DEBUG
   xcprint cprint (
		   .clk(clk),
		   .sel(cprt_sel),
		   .data_in(data_to_wr[7:0])
		   );
`endif
   
endmodule
