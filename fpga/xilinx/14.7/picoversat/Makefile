#assembly programs
TESTS_DIR := ../../../../tests
#default test
test := hello_world

#rtl files

synth: firmware
	mkdir xst
	mkdir xst/projnav.tmp
	xst -ifn "./xtop.xst" -ofn "./xtop.syr" 
	ngdbuild -dd _ngo -nt timestamp -uc xtop.ucf -p xc3s100e-cp132-4 xtop.ngc xtop.ngd  
	map -p xc3s100e-cp132-4 -cm area -ir off -pr off -c 100 -o xtop_map.ncd xtop.ngd xtop.pcf 
	par -w -ol high -t 1 xtop_map.ncd xtop.ncd xtop.pcf 
	bitgen -f xtop.ut xtop.ncd

firmware:
	make -C $(TESTS_DIR)/$(test)
	cp $(TESTS_DIR)/$(test)/*.hex .

clean:
	@rm -rf iseconfig _xmsgs *~ *.html *.ncd *.syr *.par *.xml *.cmd_log *.ngc *.ngr *.stx *.xrpt program.hex
	@rm -rf xst xtop.bgn xtop.drc xtop_map.ngm xtop_pad.txt xtop.twr
	@rm -rf _ngo webtalk.log xtop.bit xtop.lso xtop.ngd xtop.pcf xtop.twx xtop.xpi
	@rm -rf xlnx_auto_0_xdb xtop_bitgen.xwbt xtop_map.map xtop.pad 
	@rm -rf xtop.bld xtop_map.mrp xtop_pad.csv xtop.ptwx xtop.unroutes

.PHONY: all clean firmware
