RTL_DIR := ../../rtl
VA_DIR := ../../tools/assembler
TESTS_DIR := ../../tests
INCLUDE_DIR := $(RTL_DIR)/include

VC := iverilog
CFLAGS := -W all -I$(INCLUDE_DIR)  -g2005-sv

VHEADERS := $(shell find $(INCLUDE_DIR) -name '*.vh')
SRC := $(shell find $(RTL_DIR)/src -name '*.v')

ifeq ($(CMDGOALS),)
CMDGOALS := xtop
endif

# testbench
TB := $(RTL_DIR)/testbench/$(CMDGOALS)_tb.v

# dictionary of symbols
DICT := $(RTL_DIR)/src/xdict.v

#default test
test := hello_world

#
#  VERSAT MAIN SIMULATION
#

all: $(SRC) $(VHEADERS) $(TB) versat_sw
	$(VC) $(CFLAGS) -D DEBUG $(SRC) $(TB) -s $@_tb
	./a.out



#
#  VERSAT SOFTWARE
#

versat_sw: FORCE xdict.json
	make -C $(TESTS_DIR)/$(test) $(testparams)
	cp $(TESTS_DIR)/$(test)/*.hex ./

#
#  DICTIONARY
#

xdict.json: $(DICT) $(VHEADERS)
	$(VC) $(CFLAGS) $(DICT)
	./a.out
	cp xdict.json $(TESTS_DIR)/$(test)/

# CLEANUP, ETC
clean:
	make -C $(TESTS_DIR)/$(test) clean
	@rm -f *#
	@rm -f xdict.json
	@rm -f *.hex
	@rm -f *~ 
	@rm -f *.vcd
	@rm -f a.out

FORCE: 

.phony: clean FORCE versat_sw
