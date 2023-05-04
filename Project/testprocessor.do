vsim -gui work.processor
add wave -position insertpoint  \*
mem load -filltype value -filldata {2 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(0)
mem load -filltype value -filldata {0001100010000000 } -fillradix binary /processor/fetchStagee/instructions/ram(2)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(3)
mem load -filltype value -filldata {0001100100000000 } -fillradix binary /processor/fetchStagee/instructions/ram(4)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(5)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(6)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(7)
mem load -filltype value -filldata {0110000000010010 } -fillradix binary /processor/fetchStagee/instructions/ram(8)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(9)
mem load -filltype value -filldata {1111100100100010 } -fillradix binary /processor/fetchStagee/instructions/ram(10)
mem load -filltype value -filldata {0101100110010000 } -fillradix binary /processor/fetchStagee/instructions/ram(11)
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
run
force -freeze sim:/processor/INPort 0001 0
force -freeze sim:/processor/reset 0 0
run
force -freeze sim:/processor/INPort 0002 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
