# PATHS
VA := ../../tools/assembler/va

all: program.hex

# assemble program
program.hex: program.va xdict.json
	$(VA) program.va program.hex

clean:
	@rm -f xdict.json *# *~ rom.v

.phony: all clean
