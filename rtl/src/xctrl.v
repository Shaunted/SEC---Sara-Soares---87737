`timescale 1ns / 1ps

`include "xdefs.vh"
`include "xctrldefs.vh"
`include "xprogdefs.vh"

module xctrl (
	      input                    clk,
	      input                    rst,
	      
	      // instruction memory interface
	      output reg [`ADDR_W-2:0] pc,
	      input [`INSTR_W-1:0]     instruction,
	      
	      // data memory interface 
	      output reg               data_mem_sel,
	      output reg               data_mem_we,
	      output reg [`ADDR_W-1:0] data_mem_addr,
	      input [`DATA_W-1:0]      data_from_mem,
	      output [`DATA_W-1:0]     data_to_mem
	      );
   
   // Instruction fields
   wire [`OPCODESZ-1 :0] 		  opcode;
   wire signed [`DATA_W-1:0] 		  imm;

   //operand 
   reg [`DATA_W-1:0] 			  operand;
   
   //register A (accumulator)   
   reg [`DATA_W-1:0] 			  regA;

   // register B
   reg [`DATA_W-1:0] 			  regB;

   //register C
   reg [`DATA_W-1:0] 			  regC;
 				  
   //alu
   reg [`DATA_W:0]                        alu_result;
   reg                                    alu_carry;
   reg                                    alu_overflow;
   reg                                    alu_negative;
   

   //
   // DATA BUS
   //
       
   // data bus write value assignment
   assign data_to_mem = regA;
   
   //address computation 
   always @ * begin
      if(opcode == `RDWB || opcode == `WRWB)
        data_mem_addr = regB[`ADDR_W-1:0];
      else
        data_mem_addr = imm[`ADDR_W-1:0];
   end

   assign data_mem_we = store_mem_ops;
   assign data_mem_sel = mem_ops | alu_mem_ops;
   
   // instruction unpacking
   assign opcode  = instruction[`INSTR_W-1 -: `OPCODESZ];

   // useful instruction groups
   wire                                   load_imm_ops = (opcode == `LDI || opcode == `LDIH);
   wire                                   load_mem_ops = (opcode == `RDW || opcode == `RDWB);
   wire                                   load_ops = load_imm_ops | load_mem_ops;

   wire                                   store_mem_ops = (opcode == `WRW || opcode == `WRWB);
   wire                                   mem_ops = store_mem_ops | load_mem_ops;                                  
   
   wire                                   alu_imm_ops = (opcode == `ADDI || opcode == `SHFT);
   wire                                   alu_mem_ops  = (opcode == `ADD || opcode == `SUB);
   wire                                   alu_arith_ops  = (opcode == `ADDI || alu_mem_ops);
   wire                                   alu_logic_ops  = (opcode == `AND ||opcode == `XOR);
   
   wire                                   alu_ops  = alu_imm_ops | alu_mem_ops | alu_logic_ops;

   wire                                   imm_ops = load_imm_ops | alu_imm_ops;
   
   
   //immediate computation
   assign imm  = (opcode == `LDIH)?                 
                 {instruction[`DATA_W/2-1:0], regA[`DATA_W/2-1:0]} :
                 { { (`DATA_W-`IMM_W) {instruction[`IMM_W-1]} }, instruction[`IMM_W-1:0]};


   // operand selection 
   always @ * begin
      if (data_mem_addr == `RB) begin
         operand = regB;
      end else if (data_mem_addr == `RC)
        if(opcode == `SUB)
	  operand = -regC;
        else
	  operand = regC;
      else if (imm_ops)
        operand = imm;
      else
        if(opcode == `SUB)
          operand = -data_from_mem;
        else
          operand = data_from_mem;
   end
   

   // program counter 
   always @(posedge clk, posedge rst) begin
      if(rst)
        pc  = 0;
      else if (opcode == `BEQI || opcode == `BNEQI)
	pc = imm[`ADDR_W-1:0];
      else if (opcode == `BEQ || opcode == `BNEQ)
	pc = regB[`ADDR_W-1:0];
      else
        pc = pc + 1'b1;
   end


   //
   // REGISTERS
   //
   
   // register A
   always @(posedge clk, posedge rst) begin
      if(rst)
        regA <= 0;
      else
        if (load_ops)
	  regA <= operand;
        else if(alu_ops)
	  regA <= alu_result;
   end

   // register B (data memory pointer)
   always @(posedge clk, posedge rst)
     if(rst)
       regB <= 0;
     else if (data_mem_addr == `RB && data_mem_we) 
       regB <= regA;
   
   // register C (processor flags)
   always @(posedge clk, posedge rst)
      if(rst)
        regC <= 0;
      else if (alu_ops)
        regC <= {alu_negative, alu_overflow, alu_carry} | 0;
      
   //
   // ALU
   //
      
   wire [`DATA_W-1:0] adder_res_1 = regA[`DATA_W-2:0] + operand[`DATA_W-2:0];
   wire [`DATA_W:0]   adder_res_2 = regA + operand;
   
   wire carry_n_1 = adder_res_1[`DATA_W-1];
   wire carry_n = adder_res_2[`DATA_W];

   wire [`DATA_W-1:0] and_res = regA & operand;
   wire [`DATA_W-1:0] xor_res = regA ^ operand;

   //alu operation
   always @* begin
      if(alu_arith_ops) begin
         alu_result = adder_res_2;
         alu_carry = carry_n;
         alu_overflow = carry_n ^ carry_n_1;
         alu_negative = adder_res_2[`DATA_W-1];
      end else if(opcode == `SHFT)
        if(operand[`DATA_W-1]) begin //left shift by 1
           alu_result = regA << 1;
           alu_carry = regA[`DATA_W-1];
           alu_overflow = regA[`DATA_W-1] ^ regA[`DATA_W-2];
           alu_negative = regA[`DATA_W-2];
        end else begin //arithmetic right shift by 1
           alu_result = {regA[`DATA_W-1], regA[`DATA_W-1:1]};
           alu_carry = 0;
           alu_overflow = 0;
           alu_negative = regA[`DATA_W-1];
        end
      else if(opcode == `AND) begin
         alu_result = and_res;
         alu_carry = 0;
         alu_negative = and_res[`DATA_W-1];
         alu_overflow = 0;
      end
      else if(opcode == `XOR) begin
         alu_result = xor_res;
         alu_carry = 0;
         alu_negative = xor_res[`DATA_W-1];
         alu_overflow = 0;
      end
      
   end
   
   
endmodule
