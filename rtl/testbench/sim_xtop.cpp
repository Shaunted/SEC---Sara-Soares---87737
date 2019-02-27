#include "Vxtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
int main(int argc, char** argv, char** env) {
  Verilated::commandArgs(argc, argv);
  Verilated::traceEverOn(true);
  
  Vxtop* top = new Vxtop;
  VerilatedVcdC* tfp = new VerilatedVcdC;
  
  top->trace (tfp, 99);
  tfp->open ("Sim.vcd");
  
  //Initialize inputs
  top->clk = 1;
  top->rst = 0;
  
  //Initialize parallel interface
  top->par_addr = 0;
  top->par_we = 0;
  top->par_in = 0;

  int t = 0;

  while (!Verilated::gotFinish()) {
    if (t == 20)
      top->rst = 1;
    else 
      top->rst = 0;
    if (t == 70) {
      top->par_addr = 0;
      top->par_we = 1;
      top->par_in = 1; //must be non-zero to jump to main program
    }
    if (t == 80) {
      top->par_we = 0;
      top->par_addr = 0;
    }

    top->clk = !top->clk;
    top->eval();
    tfp->dump(t);
    
    //Clock period / 2
    t += 5;


  }




  tfp->close();
  top->final();
  delete top;
  exit(0);
}
