`timescale 1ns / 1ps
module xaddr_decoder (
	             // address
	              input [`SEL_ADDR_W-1:0] addr,
                      input                   sel,
             
                      // module select
	              output reg              mem_sel,
	              output reg              regf_sel,
`ifdef DEBUG	
	              output reg              cprt_sel,
`endif
                      output reg              trap_sel,

                      // read ports
                      input [31:0]            regf_data_to_rd,
                      input [31:0]            mem_data_to_rd,
                      input [31:0]            regB_data_to_rd,
                      input [31:0]            regC_data_to_rd,
                      input [31:0]            mem_data_to_rd,
                      
                      //write port
                      output reg [31:0]       data_to_rd
                     );


   //select module
   always @ * begin
      mem_sel = 1'b0;
      regf_sel = 1'b0;
`ifdef DEBUG
      cprt_sel = 1'b0;
`endif
      mem_sel = 0;
      regf_sel = 0;
      cprt_sel = 0;
      trap_sel = 0;
      regB_sel = 0;
      regC_sel = 0;

      case (addr)
        0: mem_sel = sel;
        `REGF_BASE>>(`ADDR_W-`SEL_ADDR_W): regf_sel = sel;
`ifdef DEBUG
        `CPRT_BASE>>(`ADDR_W-`SEL_ADDR_W): cprt_sel = sel;
 `endif
        `TRAP >> (`ADDR_W-`SEL_ADDR_W): trap_sel = sel;
 `ifdef DEBUG	
        default: $display("Warning: unmapped controller issued data address %x at time %f", addr, $time);
 `endif
      `RB >> (`ADDR_W-`SEL_ADDR_W): regB_sel = sel;
      `RC >> (`ADDR_W-`SEL_ADDR_W): regC_sel = sel;
      endcase
   end

   //select data to read
   always @ * begin
      data_to_rd = `DATA_W'd0;

      if(mem_sel)
        data_to_rd = mem_data_to_rd;
      else if(regf_sel)
        data_to_rd = regf_data_to_rd;
      else if(regB_sel)
        data_to_rd = regB_data_to_rd;
      else if(regC_sel)
        data_to_rd = regC_data_to_rd;
   end

endmodule
