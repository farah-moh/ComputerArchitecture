vsim -gui work.processor
add wave -position insertpoint  *
mem load -filltype value -filldata {100 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(0)
mem load -filltype value -filldata {20 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(1)
mem load -filltype value -filldata {0000100000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(256)
mem load -filltype value -filldata {0101100010000000 } -fillradix binary /processor/fetchStagee/instructions/ram(257)
mem load -filltype value -filldata {1000100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(258)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(336)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(337)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(338)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(339)
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
force -freeze sim:/processor/InterruptSignal 0 0
run
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/INPort 0000000000001111 0
mem load -filltype value -filldata {0003} -fillradix hexadecimal /processor/decodeStagee/regFile/ram(0)
mem load -filltype value -filldata {0150 } -fillradix hexadecimal /processor/mem2Stagee/dataMemory/ram(3)