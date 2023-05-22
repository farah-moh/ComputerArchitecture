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
mem load -filltype value -filldata {1100100000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(256)
mem load -filltype value -filldata {1100100000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(257)
mem load -filltype value -filldata {0101010100000000 } -fillradix binary /processor/fetchStagee/instructions/ram(258)
mem load -filltype value -filldata {09 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(259)
mem load -filltype value -filldata {1101000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(260)
mem load -filltype value -filldata {1110000110100000 } -fillradix binary /processor/fetchStagee/instructions/ram(261)
mem load -filltype value -filldata {1110011000100100 } -fillradix binary /processor/fetchStagee/instructions/ram(262)
mem load -filltype value -filldata {FF00 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(263)
mem load -filltype value -filldata {0001100010000000 } -fillradix binary /processor/fetchStagee/instructions/ram(264)
mem load -filltype value -filldata {1101101000010010 } -fillradix binary /processor/fetchStagee/instructions/ram(265)
mem load -filltype value -filldata {1111101011000100 } -fillradix binary /processor/fetchStagee/instructions/ram(266)
mem load -filltype value -filldata {0010000001001000 } -fillradix binary /processor/fetchStagee/instructions/ram(267)
mem load -filltype value -filldata {0100000000010010 } -fillradix binary /processor/fetchStagee/instructions/ram(268)
mem load -filltype value -filldata {0100101110000000 } -fillradix binary /processor/fetchStagee/instructions/ram(269)
mem load -filltype value -filldata {1111000011011110 } -fillradix binary /processor/fetchStagee/instructions/ram(270)
mem load -filltype value -filldata {1111100100011110 } -fillradix binary /processor/fetchStagee/instructions/ram(271)
mem load -filltype value -filldata {0110000001000000 } -fillradix binary /processor/fetchStagee/instructions/ram(272)
mem load -filltype value -filldata {0101101100000000 } -fillradix binary /processor/fetchStagee/instructions/ram(273)
mem load -filltype value -filldata {0110000001100110 } -fillradix binary /processor/fetchStagee/instructions/ram(274)
mem load -filltype value -filldata {1110101011100110 } -fillradix binary /processor/fetchStagee/instructions/ram(275)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(276)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(277)
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
force -freeze sim:/processor/InterruptSignal 0 0
run
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/INPort 0000000001000100 0
run 2800 ps