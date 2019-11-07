#assembly programs
TESTS_DIR := ../../tests
#default test
test := hello_world

#rtl files
INCLUDE_DIR := ../../rtl/include
SRC_DIR := ../../rtl/src

XDEFS := $(wildcard $(INCLUDE_DIR)/*.vh)
SRC := $(wildcard $(SRC_DIR)/*.v) 
TB := ../../rtl/testbench/xtop_tb.v


#icarus verilog
VC = iverilog
CFLAGS = -W all -I$(INCLUDE_DIR) -g2005-sv -D DEBUG

all: a.out
	./a.out

a.out: $(SRC) firmware $(XDEFS) $(TB)
	$(VC) $(CFLAGS) $(SRC) $(TB)

firmware:
	make -C $(TESTS_DIR)/$(test)
	cp $(TESTS_DIR)/$(test)/*.hex .

clean: 	
	@rm -f *#
	@rm -f *~ 
	@rm -f *.vcd
	@rm -f *.hex
	@rm -f xtop
	@rm -f *.out

.PHONY: all clean firmware
