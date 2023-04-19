vsim -gui work.processor
add wave -position insertpoint  \*
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
force -freeze sim:/processor/INPort 0001111111111111 0
run
force -freeze sim:/processor/reset 0 0
mem load -filltype value -filldata {0001100010000000 } -fillradix binary /processor/fetchStagee/instructions/ram(0)
mem load -filltype value -filldata {0001100100000000 } -fillradix binary /processor/fetchStagee/instructions/ram(1)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(2)
mem load -filltype value -filldata {0000000000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(3)
mem load -filltype value -filldata {0010000000010000 } -fillradix binary /processor/fetchStagee/instructions/ram(4)
mem load -filltype value -filldata {0010000000100000 } -fillradix binary /processor/fetchStagee/instructions/ram(5)

