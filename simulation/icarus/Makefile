#default test
test := hello_world

#rtl files
INCLUDE_DIR := ../../rtl/include
SRC_DIR := ../../rtl/src

XDEFS := $(wildcard $(INCLUDE_DIR)/*.vh)
SRC := $(wildcard $(SRC_DIR)/*.v) 
TB := ../../rtl/testbench/xtop_tb.v

#assembly programs
TESTS_DIR := ../../tests
HEX :=  program.hex

#icarus verilog
VC = iverilog
CFLAGS = -W all -I$(INCLUDE_DIR) -g2005-sv -D DEBUG

all: a.out
	./a.out

a.out: $(SRC) $(HEX) $(XDEFS) $(TB)
	$(VC) $(CFLAGS) $(SRC) $(TB)

# copy .hex file
$(HEX):
ifeq ($(wildcard $(TESTS_DIR)/$(test)/*.hex),)
	$(error Please assemble the program first: cd picoversat/tests/your_test; make)
else
	cp $(TESTS_DIR)/$(test)/*.hex .
endif

clean: 	
	@rm -f *#
	@rm -f *~ 
	@rm -f *.vcd
	@rm -f *.hex
	@rm -f xtop
	@rm -f *.out

.PHONY: all clean
