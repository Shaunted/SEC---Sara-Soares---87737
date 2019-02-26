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
  while (!Verilated::gotFinish()) { top->eval();
  }
  tfp->close();
  top->final();
  delete top;
  exit(0);
}
