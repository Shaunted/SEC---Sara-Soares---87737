//
// picoVersat system definitions
//

// DATA WIDTH
`define DATA_W 32 // bits

// ADDRESS WIDTH
`define ADDR_W 11 //10

// MODULE SELECT ADDR WIDTH
`define SEL_ADDR_W 3

// REGISTER FILE ADDRESS WIDTH


// DEBUG: USE PRINTER AND GENERATE VCD FILE
//`define DEBUG

//
// MEMORY MAP
//

`define MEM_BASE 0 //instruction and data memory
`define MEM_ADDR_W 10 //1024 positions //9 //512 positions (2kB)

`define REGF_BASE 1024  //512 //
`define REGF_ADDR_W 4 //2**4 = 16 registers

`define BUTTON_BASE 1500 //530 // 
`define BUTTON_ADDR_W 0 // only need 1 register for 3 bits 

//`define DISPLAY_BASE 768 //
//`define DISPLAY_ADDR_W 0 // Only need 1 register for 12 bits

`define TIMER_BASE 1600 //770 // 
`define MIN0 1600
`define MIN1 1601
`define HOUR0 1602
`define HOUR1 1603
`define TIMER_ADDR_W 2 // Need 4 addresses

`define CPRT_BASE 2000 //1000
`define CPRT_ADDR_W 0

`define TRAP_BASE 2047 //1023


// Instruction width 
`define INSTR_W 32

// Instruction fields
`define OPCODESZ 4
`define IMM_W 28

`define DELAY_SLOTS 1

// Instruction codes

// arithmetic
`define addi 0
`define add 1
`define sub 2
//logic
`define shft 3
`define and 4
`define xor 5

// load / store
`define ldi 6
`define ldih 7
`define rdw 8
`define wrw 9
`define rdwb 10
`define wrwb 11

// branch
`define beqi 12
`define beq 13
`define bneqi 14
`define bneq 15
