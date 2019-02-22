RTL_DIR := ../../rtl/src

#default test
test := hello_world

#
#  PICOVERSAT SIMULATION
#

all: 
	make -C $(RTL_DIR) test=$(test)
	mv $(RTL_DIR)/*.hex .
	$(RTL_DIR)/a.out

# CLEANUP, ETC
clean:
	make -C $(RTL_DIR) test=$(test) clean
	@rm -f *#
	@rm -f *~ 
	@rm -f *.vcd
	@rm -f *.hex

.phony: clean versat_sw
