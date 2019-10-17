RCM: FullAdder.v RCM.v RCM_tb.v
	iverilog -o RCM FullAdder.v RCM.v RCM_tb.v
	./RCM

clean: 
	rm -f RCM *~ *.vcd

.PHONY: clean all
