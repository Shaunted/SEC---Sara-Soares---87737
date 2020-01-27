`timescale 1ns / 1ps
`include "xdefs.vh"


module xtop (
	   input                clk,
	   input                rst,
      input        [1:0] button,
      output        [6:0] disp_num,
      output         [3:0] disp_sel,
      output         disp_dot,
      output               trap

`ifndef NO_EXT
	     // external parallel interface
	     , output [`ADDR_W-2:0] par_addr,
	     input [`DATA_W-1:0]  par_in,
        output               par_re, 
	     output [`DATA_W-1:0] par_out,
	     output               par_we
`endif
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
   wire [`DATA_W-1:0] 		  data_to_rd;
   wire [`DATA_W-1:0] 		  data_to_wr;

   
   // ADDRESS DECODER
   wire                           mem_sel;
   wire [`DATA_W-1:0] 		  mem_data_to_rd;
   
   wire				  regf_sel;
   wire [`DATA_W-1:0] 		  regf_data_to_rd;

   
   // TIMER TO DISPLAY WIRING
   wire [1:0] hour1;
   wire [3:0] hour0,min0;
   wire [2:0] min1;

   //BUTTON AND TIMER SELECTS + DATA
   wire timer_sel, button_sel;
   wire [5:0] timer_data_to_rd;
   wire [1:0] button_data_to_rd;
   


`ifdef DEBUG
   reg 				  cprt_sel;
`endif

`ifndef NO_EXT
   wire                           ext_sel;
   wire [`DATA_W-1:0]             ext_data_to_rd = par_in;
 
   //External interface
   assign par_addr = data_addr[`ADDR_W-2:0];
   assign par_re = ext_sel & ~data_we;
   assign par_out = data_to_wr;
   assign par_we = ext_sel & data_we;
`endif
   
   
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
		     .mem_sel(data_sel),
		     .mem_we (data_we), 
		     .mem_addr(data_addr),
		     .mem_data_from(data_to_rd), 
		     .mem_data_to(data_to_wr)
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


   // REGISTER FILE
   xregf regf (
	       .clk(clk),
	       .sel(regf_sel),
	       .we(data_we),
	       .addr(data_addr[`REGF_ADDR_W-1:0]),
	       .data_in(data_to_wr),
	       .data_out(regf_data_to_rd)
	       );

   // INTERNAL ADDRESS DECODER

   xaddr_decoder addr_decoder (
	                       // input select and address
                               .sel(data_sel),
	                            .addr(data_addr),
                               
                               //memory 
	                            .mem_sel(mem_sel),
                               .mem_data_to_rd(mem_data_to_rd),

                               //registers
	                            .regf_sel(regf_sel),
                               .regf_data_to_rd(regf_data_to_rd),

                              // Buttons
                              .button_data_to_rd(button),
                              .button_sel(button_sel),

                              // Timer
                              .timer_data_to_rd(timer_data_to_rd),
                              .timer_sel(timer_sel),

`ifdef DEBUG
                               //debug char printer
	                       .cprt_sel(cprt_sel),
`endif

`ifndef NO_EXT
                               //external
                               .ext_sel(ext_sel),
                               .ext_data_to_rd(ext_data_to_rd),
`endif

                               //trap
                               .trap_sel(trap),
                               
                               //data output 
                               .data_to_rd(data_to_rd)
                               );
   
   //
   //
   // USER MODULES INSERTED BELOW
   timer timer1(
      .rst(rst),
      .clk(clk),

      //display interface
      .hour1(hour1),
      .hour0(hour0),
      .min1(min1),
      .min0(min0),

      //cpu interface
      .sel(timer_sel),
      //.data_in(data_to_wr),
      //.data_out(timer_data_to_rd),
      //.address(data_addr),
      .write_en(data_we)
   );

   display disp1(
      .rst(rst),
      .clk(clk),

      // Display inputs
      .hour1(hour1),
      .hour0(hour0),
      .min1(min1),
      .min0(min0),

      // Display outputs
      .disp_num(disp_num),
      .disp_sel(disp_sel),
      .disp_dot(disp_dot)
   );



   //
   //



`ifdef DEBUG
   xcprint cprint (
		   .clk(clk),
		   .sel(cprt_sel & data_we),
		   .data_in(data_to_wr[7:0])
		   );
`endif
   
endmodule
