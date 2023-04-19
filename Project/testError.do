vsim -gui work.processor
add wave -position insertpoint sim:/processor/*
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
run
force -freeze sim:/processor/reset 0 0
mem load -filltype value -filldata {1101000010010000 } -fillradix binary /processor/fetchStagee/instructions/ram(0)
