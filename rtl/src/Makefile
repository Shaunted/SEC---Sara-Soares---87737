INCLUDE_DIR := ../include
TB := ../testbench/xtop_tb.v
XDEFS := $(wildcard ../$(INCLUDE_DIR)/*.vh)
HEX :=  bootrom.hex program.hex
TESTS_DIR := ../../tests

VC = iverilog
CFLAGS = -W all -I$(INCLUDE_DIR) -g2005-sv -D DEBUG

SRC = xctrl.v xprog_ram.v xprog_rom.v xregf.v xcprint.v xprog.v xtop.v $(TB)

a.out: $(SRC) $(HEX) $(XDEFS)
	$(VC) $(CFLAGS) $(SRC)

$(HEX):
	make -C $(TESTS_DIR)/$(test) $(testparams)

xdict.json: $(XDEFS) xdict.v
	$(VC) $(CFLAGS) xdict.v
	a.out

clean:
	make -C $(TESTS_DIR)/$(test) clean
	@rm -f xtop xtop.vcd *# *~ xdict xdict.txt *.hex a.out

.phony: clean
