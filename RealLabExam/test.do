vsim -gui work.controller
add wave -position insertpoint sim:/controller/*
force -freeze sim:/controller/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/controller/Rst 1 0
run
force -freeze sim:/controller/Rst 0 0
force -freeze sim:/controller/Valid 1 0
force -freeze sim:/controller/Choice 101 0
run
force -freeze sim:/controller/Valid 0 0
run
force -freeze sim:/controller/Valid 1 0
force -freeze sim:/controller/Choice 100 0
run
force -freeze sim:/controller/Valid 0 0
run
run
force -freeze sim:/controller/Valid 1 0
force -freeze sim:/controller/Choice 010 0
run
force -freeze sim:/controller/Valid 0 0
run