# PATHS
VA_DIR := ../../tools/assembler

all: bootrom.hex program.hex
	make -C ../../rtl xtop

# build symbol dictionary
xdict.json: 
	make -C ../../rtl xdict
	cp ../../rtl/xdict.txt .

# compile bootrom
bootrom.hex: bootrom.va xdict.txt
	$(VA_DIR)/va -b < $(test).va


# compile 
program.hex: program.va xdict.txt
	../../tools/va < program.va
	cp $@ ../../rtl
	cp $@ ../../rtl 

clean:
	make -C ../../rtl clean
	@rm -f  xdict.txt *# *~ *.hex rom.v


.phony: all clean
