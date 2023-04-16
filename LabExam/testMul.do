vsim -gui work.multi
add wave -position insertpoint sim:/multi/*
force -freeze sim:/multi/rst 1 0
force -freeze sim:/multi/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/multi/en 1 0
force -freeze sim:/multi/A 101 0
force -freeze sim:/multi/B 100 0
run
force -freeze sim:/multi/rst 0 0
run
run
run
run
