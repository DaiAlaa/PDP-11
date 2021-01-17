vsim -gui work.lab4(my_lab4)
add wave -position insertpoint  \
sim:/lab4/ClkRam
add wave -position insertpoint  \
sim:/lab4/ClkReg \
sim:/lab4/Rst \
sim:/lab4/counter_address \
sim:/lab4/dataout \
sim:/lab4/destinationEnable \
sim:/lab4/outbus \
sim:/lab4/r0 \
sim:/lab4/r1 \
sim:/lab4/r2 \
sim:/lab4/r3 \
sim:/lab4/ram \
sim:/lab4/selsource \
sim:/lab4/seldestination \
sim:/lab4/sourceEnable
force -freeze sim:/lab4/ClkReg 0 0, 1 {50 ps} -r 100
force -freeze sim:/lab4/Rst 1 0
run 100
force -freeze sim:/lab4/Rst 0 0
force -freeze sim:/lab4/sourceEnable 0 0
force -freeze sim:/lab4/destinationEnable 1 0
force -freeze sim:/lab4/seldestination 00 0
run 100
force -freeze sim:/lab4/seldestination 01 0
run 100
force -freeze sim:/lab4/sourceEnable 1 0
force -freeze sim:/lab4/destinationEnable 1 0
force -freeze sim:/lab4/seldestination 11 0
force -freeze sim:/lab4/selsource 00 0
run 100
force -freeze sim:/lab4/sourceEnable 1 0
force -freeze sim:/lab4/destinationEnable 0 0
force -freeze sim:/lab4/selsource 01 0
run 100
force -freeze sim:/lab4/sourceEnable 0 0
force -freeze sim:/lab4/destinationEnable 0 0
run 100