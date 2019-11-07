SRC_DIR := ../../rtl/src
INCLUDE_DIR := ../../rtl/include
XDEFS := $(wildcard $(INCLUDE_DIR)/*.vh)
HEX :=  bootrom.hex program.hex
TESTS_DIR := ../../tests

VC = verilator
CFLAGS = -Wall --cc -Wno-UNUSED --trace -DDEBUG[=1]

SRC = $(wildcard $(SRC_DIR)/*.v)
TB = ../../rtl/testbench/sim_xtop.cpp
XDICT = ../../tools/xdictgen $(INCLUDE_DIR)

#default test
test := hello_world

#
#  PICOVERSAT SIMULATION
#

all: a.out

a.out: $(SRC) $(HEX) $(XDEFS)
	$(VC) $(CFLAGS) $(SRC) -I$(INCLUDE_DIR) --exe $(TB) --top-module xtop --Mdir xtop_dir
	make -C xtop_dir -j -f Vxtop.mk Vxtop
	xtop_dir/Vxtop

# Create dictionary and .hex files
$(HEX):$(XDEFS) $(XDICT)
	$(XDICT)
	mv xdict.json $(TESTS_DIR)/$(test)
	make -C $(TESTS_DIR)/$(test) $(testparams)
	mv $(TESTS_DIR)/$(test)/*.hex .

# CLEANUP, ETC
clean: 	
	make -C $(TESTS_DIR)/$(test) clean
	@rm -f *#
	@rm -f *~ 
	@rm -f *.vcd
	@rm -f *.hex
	@rm -rf xtop_dir
	@rm -f *.out
	@rm -f xdict
	@rm -f xdict.json	

.phony: all clean
