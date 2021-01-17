vsim -gui work.lab3(my_lab3)
add wave -position insertpoint  \
sim:/lab3/Clk \
sim:/lab3/sourceEnable \
sim:/lab3/destinationEnable \
sim:/lab3/outbus \
sim:/lab3/r0 \
sim:/lab3/r1 \
sim:/lab3/r2 \
sim:/lab3/r3 \
sim:/lab3/selsource 
add wave -position insertpoint  \
sim:/lab3/seldestination
force -freeze sim:/lab3/Rst 1 0
force -freeze sim:/lab3/Clk 0 0, 1 {50 ps} -r 100 
force -freeze sim:/lab3/outbus 32'H00AA 0
run  
force -freeze sim:/lab3/Rst 0 0
force -freeze sim:/lab3/seldestination 00 0
force -freeze sim:/lab3/destinationEnable 1 0

run  
force -freeze sim:/lab3/seldestination 01 0
force -freeze sim:/lab3/outbus 32'H00BB 0
run  
force -freeze sim:/lab3/seldestination 10 0
force -freeze sim:/lab3/outbus 32'H00CC 0
run  
force -freeze sim:/lab3/seldestination 11 0
force -freeze sim:/lab3/outbus 32'H00DD 0
run  
#R0->R1
noforce sim:/lab3/outbus
force -freeze sim:/lab3/sourceEnable 1 0
force -freeze sim:/lab3/selsource 00 0
force -freeze sim:/lab3/destinationEnable 1 0
force -freeze sim:/lab3/seldestination 01 0
run  
#R2->R0
force -freeze sim:/lab3/sourceEnable 1 0
force -freeze sim:/lab3/selsource 10 0
force -freeze sim:/lab3/destinationEnable 1 0
force -freeze sim:/lab3/seldestination 00 0
run  
#R3->R0
force -freeze sim:/lab3/sourceEnable 1 0
force -freeze sim:/lab3/selsource 11 0
force -freeze sim:/lab3/destinationEnable 1 0
force -freeze sim:/lab3/seldestination 00 0
run  