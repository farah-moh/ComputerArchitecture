vsim -gui work.processor
add wave -position insertpoint  \
sim:/processor/clk \
sim:/processor/reset \
sim:/processor/enable
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
run
force -freeze sim:/processor/reset 0 0
mem load -filltype value -filldata {1100101011010000 } -fillradix binary /processor/fetchStagee/instructions/ram(0)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(1)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(2)
mem load -filltype value -filldata {1100101011010000 } -fillradix binary /processor/fetchStagee/instructions/ram(3)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(4)
mem load -filltype value -filldata {0110000000100010 } -fillradix binary /processor/fetchStagee/instructions/ram(5)
mem load -filltype value -filldata {0110000001000110 } -fillradix binary /processor/fetchStagee/instructions/ram(6)
mem load -filltype value -filldata {0110000001010100 } -fillradix binary /processor/fetchStagee/instructions/ram(7)
mem load -filltype value -filldata {1100100100010000 } -fillradix binary /processor/fetchStagee/instructions/ram(8)
mem load -filltype value -filldata {0101100000010000 } -fillradix binary /processor/fetchStagee/instructions/ram(9)
mem load -filltype value -filldata {0101101110110000 } -fillradix binary /processor/fetchStagee/instructions/ram(10)
mem load -filltype value -filldata {1111000010101100 } -fillradix binary /processor/fetchStagee/instructions/ram(11)
mem load -filltype value -filldata {1100100010010000 } -fillradix binary /processor/fetchStagee/instructions/ram(12)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(13)
mem load -filltype value -filldata {1111001010111000 } -fillradix binary /processor/fetchStagee/instructions/ram(14)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(15)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(16)
run
run
run
run
run
