add wave -position insertpoint sim:/processor/*
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/rst 1 0
force -freeze sim:/processor/enable 1 0
force -freeze sim:/processor/enable 1 0
force -freeze sim:/processor/enableFetchReg 1 0
force -freeze sim:/processor/enableDecodeReg 1 0
force -freeze sim:/processor/enableWriteBack 1 0
run
force -freeze sim:/processor/rst 0 0
mem load -filltype value -filldata {1000010000010000 } -fillradix binary /processor/Instruction/ram(0)
mem load -filltype value -filldata {1000100000100000 } -fillradix binary /processor/Instruction/ram(1)
mem load -filltype value -filldata {1000110000110000 } -fillradix binary /processor/Instruction/ram(2)
mem load -filltype value -filldata {0100000000000000 } -fillradix binary /processor/Instruction/ram(3)
mem load -filltype value -filldata {0000010000010000 } -fillradix binary /processor/Instruction/ram(3)
run
run
run
run
run
run