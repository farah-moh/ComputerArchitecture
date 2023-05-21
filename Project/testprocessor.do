vsim -gui work.processor
add wave -position insertpoint  \*
mem load -filltype value -filldata {2 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(0)
mem load -filltype value -filldata {1001100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(2)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(3)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(4)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(5)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(6)
mem load -filltype value -filldata {1010000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(144)
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
run
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/INPort 0000000000001111 0
mem load -filltype value -filldata {0000000010010000 } -fillradix binary /processor/decodeStagee/regFile/ram(1)
mem load -filltype value -filldata {0000000010010000 } -fillradix binary /processor/mem2Stagee/dataMemory/ram(0)
