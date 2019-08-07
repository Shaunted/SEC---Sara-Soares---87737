#default test
test := hello_world

#RTL 
INCLUDE_DIR := ../../rtl/include
XDEFS := $(wildcard $(INCLUDE_DIR)/*.vh)
SRC_DIR := ../../rtl/src
SRC := $(wildcard $(SRC_DIR)/*.v) 
TB := ../../rtl/testbench/xtop_tb.v

#assembly
XDICT = xdict.json
TESTS_DIR := ../../tests
VA := $(TESTS_DIR)/$(test)/program.va
HEX :=  program.hex

VC = iverilog
CFLAGS = -W all -I$(INCLUDE_DIR) -g2005-sv -D DEBUG

#
#  PICOVERSAT SIMULATION
#

all: a.out

a.out: $(SRC) $(HEX) $(XDEFS) $(TB)
	$(VC) $(CFLAGS) $(SRC) $(TB)
	./a.out

# Create dictionary and .hex files
$(HEX): $(XDEFS) $(VA)
	../../tools/xdictgen $(INCLUDE_DIR)
	mv xdict.json $(TESTS_DIR)/$(test)
	make -C $(TESTS_DIR)/$(test)
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
