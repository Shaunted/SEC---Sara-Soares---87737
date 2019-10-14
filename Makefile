HEX := simulation/icarus/program.hex

icarus: $(HEX)
ifeq ($(test),)
	make -C simulation/icarus
else
	make -C simulation/icarus test=$(test)
endif

$(HEX):
ifeq ($(test),)
	make -C tests/hello_world
else
	make -C tests/$(test)
endif


clean:
ifeq ($(test),)
	make -C tests/hello_world $@
else
	make -C tests/$(test) $@
endif
	make -C simulation/icarus $@
	@rm -f *~

.PHONY: clean
