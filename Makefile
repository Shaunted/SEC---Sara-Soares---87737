icarus: firmware
ifeq ($(test),)
	make -C simulation/icarus
else
	make -C simulation/icarus test=$(test)
endif

firmware:
ifeq ($(test),)
	make -C tests/hello_world
else
	make -C tests/$(test)
endif

fpga:

clean:
ifeq ($(test),)
	make -C tests/hello_world $@
else
	make -C tests/$(test) $@
endif
	make -C simulation/icarus $@
	make -C fpga/xilinx/14.7/picoversat $@
	@rm -f *~

.PHONY: clean firmware fpga
