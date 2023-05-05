vsim -gui work.processor
add wave -position insertpoint  \*
mem load -filltype value -filldata {2 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(0)
mem load -filltype value -filldata {1101000010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(2)
mem load -filltype value -filldata {1000100000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(3)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(144)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(145)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(146)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(147)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(148)
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
run
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/INPort 0000000000001111 0
mem load -filltype value -filldata {0090} -fillradix hexadecimal /processor/decodeStagee/regFile/ram(0)


