project open D:/3rdYear/ComputerArch/Lab2
vsim work.finalmux(f_mux)
add wave -position insertpoint  \
sim:/finalmux/cin \
sim:/finalmux/a \
sim:/finalmux/b \
sim:/finalmux/s \
sim:/finalmux/f \
sim:/finalmux/cout
sim:/finalmux/CmpEnable
sim:/finalmux/FlagRegister

force -freeze sim:/finalmux/CmpEnable 0 0
#ADD-SUB
force -freeze sim:/finalmux/s 0000 0
force -freeze sim:/finalmux/Cin 0 0
force -freeze sim:/finalmux/a 16'h0F0F 0
force -freeze sim:/finalmux/b 0000000000000001 0
run 200
force -freeze sim:/finalmux/sel 0001 0
run 200
force -freeze sim:/finalmux/A 1111111111111111 0
run 200
force -freeze sim:/finalmux/s 0010 0
run 200
force -freeze sim:/finalmux/s 0011 0
run 200
force -freeze sim:/finalmux/A 16'h0F0E 0
force -freeze sim:/finalmux/s 0000 0
force -freeze sim:/finalmux/Cin 1 0
run 200
force -freeze sim:/finalmux/A 16'hFFFF 0
force -freeze sim:/finalmux/s 0001 0
run 200
force -freeze sim:/finalmux/s 0010 0
force -freeze sim:/finalmux/A 16'h0F0F 0
run 200
force -freeze sim:/finalmux/s 0011 0
run 200

#AND
force -freeze sim:/finalmux/Cin 0 0
force -freeze sim:/finalmux/Cin 0 0
force -freeze sim:/finalmux/A 16'h0F0F 0
force -freeze sim:/finalmux/B 16'h000A 0
force -freeze sim:/finalmux/s 0100 0
run 200
#OR
force -freeze sim:/finalmux/s 0101 0
run 200
#XOR
force -freeze sim:/finalmux/s 0110 0
run 200
#NOT
force -freeze sim:/finalmux/s 0111 0
run 200
#shift right
force -freeze sim:/finalmux/s 1000 0
run 200
#rotate right
force -freeze sim:/finalmux/s 1001 0
run 200
#zero
force -freeze sim:/finalmux/s 1111 0
run 200
#rotate right with carry
force -freeze sim:/finalmux/s 1010 0
force -freeze sim:/finalmux/Cin 0 0
run 200
force -freeze sim:/finalmux/Cin 1 0
run 200
#shift left
force -freeze sim:/finalmux/s 1100 0
run 200


force -freeze sim:/finalmux/A 16'hF0F0 0
#rotate left
force -freeze sim:/finalmux/s 1101 0
run 200

#rotate with carry
force -freeze sim:/finalmux/s 1110 0
force -freeze sim:/finalmux/Cin 0 0
run 200
force -freeze sim:/finalmux/Cin 1 0
run 200

#rotate right arithmetic
force -freeze sim:/finalmux/s 1011 0
run 200
force -freeze sim:/finalmux/s 0000 0
force -freeze sim:/finalmux/Cin 0 0
force -freeze sim:/finalmux/A 16'h0F0F 0
force -freeze sim:/finalmux/B 0000000000000001 0
force -freeze sim:/finalmux/s 0010 0
run 200