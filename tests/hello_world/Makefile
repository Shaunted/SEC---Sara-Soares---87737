# PATHS
VA := ../../tools/assembler/va
INCLUDE_DIR := ../../rtl/include

all: program.hex

# assemble program
program.hex: program.va xdict.json
	$(VA) program.va program.hex

xdict.json: ../../rtl/include/xdefs.vh
	../../tools/xdictgen $(INCLUDE_DIR)


clean:
	@rm -f xdict.json *# *~ program.hex

.PHONY: all clean
