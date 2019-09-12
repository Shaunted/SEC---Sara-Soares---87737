`timescale 1ns / 1ps
module xaddr_decoder (
	             // address and global select signal
	              input [`SEL_ADDR_W-1:0] addr,
                      input                   sel,
             
                      // ports

                      //memory
	              output reg              mem_sel,
                      input [31:0]            mem_data_to_rd,

	              output reg              regf_sel,
                      input [31:0]            regf_data_to_rd,

`ifdef DEBUG	
	              output reg              cprt_sel,

`endif
                      output reg              ext_sel,
                      input [31:0]            ext_data_to_rd,
                      
                      output reg              trap_sel,

                      //read port
                      output reg [31:0]       data_to_rd
                     );


   //select module
   always @ * begin
      mem_sel = 1'b0;
      regf_sel = 1'b0;
`ifdef DEBUG
      cprt_sel = 1'b0;
`endif
      ext_sel = 1'b0;
      trap_sel = 1'b0;
      
      case (addr)
        `MEM_BASE>>(`ADDR_W-`SEL_ADDR_W): mem_sel = sel;
        `REGF_BASE>>(`ADDR_W-`SEL_ADDR_W): regf_sel = sel;
`ifdef DEBUG
        `CPRT_BASE>>(`ADDR_W-`SEL_ADDR_W): cprt_sel = sel;
 `endif
        `EXT_BASE >>(`ADDR_W-`SEL_ADDR_W): ext_sel = sel;
        default: trap_sel = sel;
      endcase
   end

   //select data to read
   always @ * begin
      data_to_rd = `DATA_W'd0;

      if(mem_sel)
        data_to_rd = mem_data_to_rd;
      else if(regf_sel)
        data_to_rd = regf_data_to_rd;
      else if(ext_sel)
        data_to_rd = ext_data_to_rd;
   end

endmodule
