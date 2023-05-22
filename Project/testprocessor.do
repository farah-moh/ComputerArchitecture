vsim -gui work.processor
add wave -position insertpoint sim:/processor/reset
add wave -position insertpoint sim:/processor/clk
add wave -position insertpoint sim:/processor/PC_IF
add wave -position insertpoint sim:/processor/decodeStagee/regFile/ram
add wave -position insertpoint sim:/processor/flags_EX
add wave -position insertpoint sim:/processor/InPort
add wave -position insertpoint sim:/processor/OutPort
add wave -position insertpoint sim:/processor/InterruptSignal
mem load -filltype value -filldata {100 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(0)
mem load -filltype value -filldata {20 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(1)
mem load -filltype value -filldata {0000100000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(256)
mem load -filltype value -filldata {0101010010000000 } -fillradix binary /processor/fetchStagee/instructions/ram(257)
mem load -filltype value -filldata {0F0F } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(258)
mem load -filltype value -filldata {0101010110000000 } -fillradix binary /processor/fetchStagee/instructions/ram(259)
mem load -filltype value -filldata {80 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(260)
mem load -filltype value -filldata {1100000100010010 } -fillradix binary /processor/fetchStagee/instructions/ram(261)
mem load -filltype value -filldata {1000100110110110 } -fillradix binary /processor/fetchStagee/instructions/ram(262)
mem load -filltype value -filldata {0010000000110110 } -fillradix binary /processor/fetchStagee/instructions/ram(263)
mem load -filltype value -filldata {0101010110000000 } -fillradix binary /processor/fetchStagee/instructions/ram(128)
mem load -filltype value -filldata {150 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(129)
mem load -filltype value -filldata {1000100110110110 } -fillradix binary /processor/fetchStagee/instructions/ram(130)
mem load -filltype value -filldata {0101011000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(131)
mem load -filltype value -filldata {08 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(132)
mem load -filltype value -filldata {1111001010111000 } -fillradix binary /processor/fetchStagee/instructions/ram(133)
mem load -filltype value -filldata {1000001001001000 } -fillradix binary /processor/fetchStagee/instructions/ram(134)
mem load -filltype value -filldata {1100101001001000 } -fillradix binary /processor/fetchStagee/instructions/ram(135)
mem load -filltype value -filldata {0100000000110110 } -fillradix binary /processor/fetchStagee/instructions/ram(8)
mem load -filltype value -filldata {0100101010000000 } -fillradix binary /processor/fetchStagee/instructions/ram(9)
mem load -filltype value -filldata {1001001011011010 } -fillradix binary /processor/fetchStagee/instructions/ram(10)
mem load -filltype value -filldata {1100101011011010 } -fillradix binary /processor/fetchStagee/instructions/ram(11)
mem load -filltype value -filldata {0000100000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(336)
mem load -filltype value -filldata {0101010010000000 } -fillradix binary /processor/fetchStagee/instructions/ram(337)
mem load -filltype value -filldata {200 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(338)
mem load -filltype value -filldata {1001100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(339)
mem load -filltype value -filldata {1100000010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(340)
mem load -filltype value -filldata {0010000000010010 } -fillradix binary /processor/fetchStagee/instructions/ram(341)
mem load -filltype value -filldata {0101010010000000 } -fillradix binary /processor/fetchStagee/instructions/ram(512)
mem load -filltype value -filldata {400 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(513)
mem load -filltype value -filldata {1010000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(514)
mem load -filltype value -filldata {0001000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(515)
mem load -filltype value -filldata {0010000000010010 } -fillradix binary /processor/fetchStagee/instructions/ram(516)
mem load -filltype value -filldata {0001000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(32)
mem load -filltype value -filldata {0101011110000000 } -fillradix binary /processor/fetchStagee/instructions/ram(33)
mem load -filltype value -filldata {300 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(34)
mem load -filltype value -filldata {0010000001111110 } -fillradix binary /processor/fetchStagee/instructions/ram(35)
mem load -filltype value -filldata {1010100000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(36)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(37)
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
force -freeze sim:/processor/InterruptSignal 0 0
run
force -freeze sim:/processor/reset 0 0
run
force -freeze sim:/processor/InterruptSignal 1 0
run
force -freeze sim:/processor/InterruptSignal 0 0
#run 2500 ps
#run
#run
#run
#run
#run
#run
#run
#run
#run
#
#
#run
#run
#run
#run
#run
#force -freeze sim:/processor/InterruptSignal 1 0
#run
#force -freeze sim:/processor/InterruptSignal 0 0
#run 2400 ps
#run