SRC_DIR := ../../rtl/src
INCLUDE_DIR := ../../rtl/include
XDEFS := $(wildcard $(INCLUDE_DIR)/*.vh)
HEX :=  bootrom.hex program.hex
TESTS_DIR := ../../tests

VC = iverilog
CFLAGS = -W all -I$(INCLUDE_DIR) -g2005-sv -D DEBUG

SRC = $(wildcard $(SRC_DIR)/*.v)
TB = ../../rtl/testbench/xtop_tb.v
XDICT = ../../tools/xdictgen

#default test
test := hello_world

#
#  PICOVERSAT SIMULATION
#

all: a.out

a.out: $(SRC) $(HEX) $(XDEFS)
	$(VC) $(CFLAGS) $(SRC) $(TB)
	./a.out

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
	@rm -f xtop
	@rm -f *.out
	@rm -f xdict
	@rm -f xdict.json	

.phony: all clean
