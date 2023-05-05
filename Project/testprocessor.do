vsim -gui work.processor
add wave -position insertpoint  \*
mem load -filltype value -filldata {2 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(0)
mem load -filltype value -filldata {1001000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(2)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(91)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(92)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(93)
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
run
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/INPort FFFF 0
mem load -filltype value -filldata 0090 -fillradix hexadecimal /processor/decodeStagee/regFile/ram(0)


