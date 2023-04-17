vsim -gui work.controlunit_tb
add wave -position end  sim:/controlunit_tb/instructionTest
add wave -position end  sim:/controlunit_tb/testregWrite
add wave -position end  sim:/controlunit_tb/testmemRead
add wave -position end  sim:/controlunit_tb/testmemWrite
add wave -position end  sim:/controlunit_tb/testmemToReg
add wave -position end  sim:/controlunit_tb/testinPort
add wave -position end  sim:/controlunit_tb/testoutPort
add wave -position end  sim:/controlunit_tb/testsetC
add wave -position end  sim:/controlunit_tb/testclrC
add wave -position end  sim:/controlunit_tb/testspInc
add wave -position end  sim:/controlunit_tb/testspDec
run -all