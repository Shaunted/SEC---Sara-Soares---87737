# PATHS
VA := ../../tools/assembler/va

all: bootrom.hex program.hex

# assemble bootrom
bootrom.hex: bootrom.va xdict.json
	$(VA) -b < bootrom.va

# assemble program
program.hex: program.va xdict.json
	$(VA) < program.va

clean:
	@rm -f xdict.json *# *~ rom.v

.phony: all clean
