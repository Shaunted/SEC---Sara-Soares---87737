`timescale 1ns / 1ps
module xaddr_decoder (
	             // address
	             input [`SEL_ADDR_W-1:0] addr,
                     input                   sel,
             
             // read ports
                     input [31:0]            regf_data_to_rd,
                     input [31:0]            prog_data_to_rd,

             // module select
	             output reg              mem_sel,
	             output reg              regf_sel,
`ifdef DEBUG	
	             output reg              cprt_sel,
`endif
                     output reg              trap,
                     output reg [31:0]        data_to_rd
                     );

   
   always @ * begin
      mem_sel = 1'b0;
      regf_sel = 1'b0;
`ifdef DEBUG
      cprt_sel = 1'b0;
`endif
      data_to_rd = `DATA_W'd0;

      mem_sel = 0;
      regf_sel = 0;
      cprt_sel = 0;
      trap = 0;
      
      if(sel)  
      case (addr)
        0: begin 
           mem_sel = sel;
           data_to_rd = prog_data_to_rd;
        end
        `REGF_BASE>>(`ADDR_W-`SEL_ADDR_W): begin
	   regf_sel = sel;
           data_to_rd = regf_data_to_rd;
        end
`ifdef DEBUG
        `CPRT_BASE>>(`ADDR_W-`SEL_ADDR_W): cprt_sel = sel;
 `endif

        `TRAP_BASE>>(`ADDR_W-`SEL_ADDR_W): trap = sel;

`ifdef DEBUG	
        default:
          $display("Warning: unmapped controller issued data address %x at time %f", addr, $time);
`endif
      endcase
   end

endmodule
