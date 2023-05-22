vsim -gui work.processor
add wave -position insertpoint  \*
<<<<<<< HEAD
mem load -filltype value -filldata {100 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(0)
mem load -filltype value -filldata {20 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(1)
mem load -filltype value -filldata {1100101011011010 } -fillradix binary /processor/fetchStagee/instructions/ram(2)
mem load -filltype value -filldata {1100101001001000 } -fillradix binary /processor/fetchStagee/instructions/ram(3)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(256)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(257)
mem load -filltype value -filldata {1101001101101100 } -fillradix binary /processor/fetchStagee/instructions/ram(258)
mem load -filltype value -filldata {1100101101101100 } -fillradix binary /processor/fetchStagee/instructions/ram(259)
mem load -filltype value -filldata {1001000010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(260)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(261)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(262)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(263)
mem load -filltype value -filldata {1100100100100100 } -fillradix binary /processor/fetchStagee/instructions/ram(264)
mem load -filltype value -filldata {1100100110110110 } -fillradix binary /processor/fetchStagee/instructions/ram(32)
mem load -filltype value -filldata {1100100110110110 } -fillradix binary /processor/fetchStagee/instructions/ram(33)
mem load -filltype value -filldata {1100100110110110 } -fillradix binary /processor/fetchStagee/instructions/ram(34)
mem load -filltype value -filldata {1010100000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(35)
mem load -filltype value -filldata {1100101001001000 } -fillradix binary /processor/fetchStagee/instructions/ram(36)
=======
mem load -filltype value -filldata {2 } -fillradix hexadecimal /processor/fetchStagee/instructions/ram(0)
<<<<<<< HEAD
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(2)
mem load -filltype value -filldata {1001000010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(3)
mem load -filltype value -filldata {1100101011011010 } -fillradix binary /processor/fetchStagee/instructions/ram(144)
=======
mem load -filltype value -filldata {0000100000000000 } -fillradix binary /processor/fetchStagee/instructions/ram(2)
mem load -filltype value -filldata {1000100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(3)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(144)
>>>>>>> parent of a415baa (smal edits)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(145)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(146)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(147)
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(148)
<<<<<<< HEAD
mem load -filltype value -filldata {1100100010010010 } -fillradix binary /processor/fetchStagee/instructions/ram(149)
>>>>>>> parent of 595841c (Hot fixes + working processor kinda)
=======
>>>>>>> parent of a415baa (smal edits)
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/reset 1 0
force -freeze sim:/processor/enable 1 0
force -freeze sim:/processor/InterruptSignal 0 0
run
force -freeze sim:/processor/reset 0 0
<<<<<<< HEAD
force -freeze sim:/processor/INPort 0044 0
=======
force -freeze sim:/processor/INPort 0000000000001111 0
mem load -filltype value -filldata {0090} -fillradix hexadecimal /processor/decodeStagee/regFile/ram(1)
>>>>>>> parent of 595841c (Hot fixes + working processor kinda)
