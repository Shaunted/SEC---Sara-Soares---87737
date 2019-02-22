# PATHS
VA := ../../tools/assembler/va
RTL_DIR := ../../rtl/src

all: bootrom.hex program.hex

# build symbol dictionary
xdict.json: 
	make -C $(RTL_DIR) xdict.json
	mv $(RTL_DIR)/xdict.json .

# assemble bootrom
bootrom.hex: bootrom.va xdict.json
	$(VA) -b < bootrom.va
	mv $@ $(RTL_DIR)

# assemble program
program.hex: program.va xdict.json
	$(VA) < program.va
	mv $@ $(RTL_DIR)

clean:
	@rm -f xdict.json *# *~ rom.v

.phony: all clean
