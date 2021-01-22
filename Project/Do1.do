vsim -gui work.pdp_11
# vsim -gui work.pdp_11 
# Start time: 08:36:42 on Jan 19,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.pdp_11(my_pdp_11)
# Loading ieee.numeric_std(body)
# Loading work.decoder(my_decoder)
# Loading work.my_ndff(a_my_ndff)
# Loading work.tri_state_buffer(my_tri_state_buffer)
# Loading work.ram(syncrama)
# Loading work.rom(syncroma)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.pla(pla)
# Loading work.mapalu(mapalu)
# Loading work.finalmux(f_mux)
# Loading work.bmux(b_mux)
# Loading work.amux(a_mux)
# Loading work.my_nadder(a_my_nadder)
# Loading work.my_adder(a_my_adder)
# Loading work.cmux(c_mux)
# Loading work.dmux(d_mux)
add wave -position insertpoint  \
sim:/pdp_11/Clk \
sim:/pdp_11/Rst \
sim:/pdp_11/outbus \
sim:/pdp_11/R0 \
sim:/pdp_11/R1 \
sim:/pdp_11/R2 \
sim:/pdp_11/R3 \
sim:/pdp_11/R4 \
sim:/pdp_11/R5 \
sim:/pdp_11/R6 \
sim:/pdp_11/R7 \
sim:/pdp_11/MAR \
sim:/pdp_11/MDR \
sim:/pdp_11/Z \
sim:/pdp_11/Y \
sim:/pdp_11/temp \
sim:/pdp_11/flag \
sim:/pdp_11/IR \
sim:/pdp_11/uPC \
sim:/pdp_11/control_word
mem load -i Ram4.mem /pdp_11/my_ram/ram
force -freeze sim:/pdp_11/Clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/pdp_11/Rst 1 0
run
force -freeze sim:/pdp_11/Rst 0 0
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