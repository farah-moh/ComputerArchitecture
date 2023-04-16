force -freeze sim:/gcd/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/gcd/rst 0 0
run
force -freeze sim:/gcd/A 00000062 0
force -freeze sim:/gcd/B 00000038 0
run
run
run
run
run
force -freeze sim:/gcd/B FFFFFFFF 0
force -freeze sim:/gcd/A FFFFFFFF 0
force -freeze sim:/gcd/rst 1 0
run
force -freeze sim:/gcd/rst 0 0
run
run
force -freeze sim:/gcd/B 12B87CA0 0
force -freeze sim:/gcd/A 00798F20 0
force -freeze sim:/gcd/rst 1 0
run
force -freeze sim:/gcd/rst 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/gcd/B 00000009 0
force -freeze sim:/gcd/A 00000000 0
force -freeze sim:/gcd/rst 1 0
run
force -freeze sim:/gcd/rst 0 0