vsim -gui work.processor
add wave -position insertpoint  *
mem load -filltype value -filldata {100 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(0)
mem load -filltype value -filldata {20 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(1)
mem load -filltype value -filldata {0101100010000000 } -fillradix binary /processor/fetchStagee/instructions/ram(256)
mem load -filltype value -filldata {1001000010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(257)
mem load -filltype value -filldata {1100100110110110 } -fillradix binary /processor/fetchStagee/instructions/ram(32)
mem load -filltype value -filldata {1100100110110110 } -fillradix binary /processor/fetchStagee/instructions/ram(33)
mem load -filltype value -filldata {1100100110110110 } -fillradix binary /processor/fetchStagee/instructions/ram(34)
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
force -freeze sim:/processor/InterruptSignal 0 0
run
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/INPort 0000000000001111 0
mem load -filltype value -filldata {0090} -fillradix hexadecimal /processor/decodeStagee/regFile/ram(1)
mem load -filltype value -filldata {0003} -fillradix hexadecimal /processor/decodeStagee/regFile/ram(0)
mem load -filltype value -filldata {0020 } -fillradix hexadecimal /processor/mem2Stagee/dataMemory/ram(3)