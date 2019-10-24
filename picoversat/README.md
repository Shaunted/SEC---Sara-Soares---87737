# README #

### Description ###

* picoVersat is a 32-bit data 16-instruction controller
* Version 0.1

### Dependences ###

* Install Python (tested in 2.7)
* Install Icarus Verilog (download a stable version from http://iverilog.icarus.com)
* Install Xilinx ISE 14.[2-7] (download a stable version from https://www.xilinx.com)

### Environment setup for Xilinx ISE###
```
    source $ISE_DS/settings64.sh
```
If you need a license aand you are in the IST network or VPN do
```
    export LM_LICENSE_FILE=2100@delta.ist.utl.pt
```

### Simulate ###
```
    make icarus  [test=test_dir_name]
```

### Compile FPGA using ISE###
```
    make fpga  [test=test_dir_name]
```

### Assemble your program only###
```
    make firmware [test=test_dir_name]
```

### Cleanup files###
```
    make clean
```
