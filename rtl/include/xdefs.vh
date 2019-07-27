//
// picoVersat system definitions
//

// DATA WIDTH
`define DATA_W 32 // bits

// ADDRESS WIDTH
`define ADDR_W 15

// MODULE SELECT ADDR WIDTH
`define SEL_ADDR_W 2

// DEBUG: USE PRINTER AND GENERATE VCD FILE
//`define DEBUG

//
// VERSAT MEMORY MAP
//
`define MEM_BASE `ADDR_W'h0000
`define REGF_BASE `ADDR_W'h2000
`define CPRT_BASE `ADDR_W'h4000 
`define TRAP_BASE `ADDR_W'h6000 
