CLA_top: FullAdder.v CLA_node.v CLA_top.v CLA_top_tb.v
	iverilog -o CLA_top FullAdder.v CLA_node.v CLA_top.v CLA_top_tb.v
	./CLA_top

clean: 
	rm -f CLA_top *~ *.vcd

.PHONY: clean all
