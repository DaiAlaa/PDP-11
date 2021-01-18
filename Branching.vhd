Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

ENTITY Branch IS
	PORT ( IR,Flag,PCin : In std_logic_vector (15 DOWNTO 0); PCOut : OUT std_logic_vector (15 DOWNTO 0));
END ENTITY Branch;

ARCHITECTURE F OF Branch IS
BEGIN
	
    PCOut <= std_logic_vector(signed(PCin)+signed(IR(9 DOWNTO 0))) 
            when IR(15 DOWNTO 10) = "110000"                                     --BR
            ELSE std_logic_vector(signed(PCin)+signed(IR(9 DOWNTO 0))) 
            when IR(15 DOWNTO 10) = "110001" AND Flag(1) ='1'                    --BEQ
            ELSE std_logic_vector(signed(PCin)+signed(IR(9 DOWNTO 0))) 
            when IR(15 DOWNTO 10) = "110010" AND Flag(1) ='0'                    --BNE
            ELSE std_logic_vector(signed(PCin)+signed(IR(9 DOWNTO 0))) 
            when IR(15 DOWNTO 10) = "110011" AND Flag(0) ='0'                    --BLO
            ELSE std_logic_vector(signed(PCin)+signed(IR(9 DOWNTO 0))) 
            when IR(15 DOWNTO 10) = "110100" AND (Flag(0) ='0' OR Flag(1)='1')   --BLS
            ELSE std_logic_vector(signed(PCin)+signed(IR(9 DOWNTO 0))) 
            when IR(15 DOWNTO 10) = "110001" AND Flag(0) ='1'                    --BHI
            ELSE std_logic_vector(signed(PCin)+signed(IR(9 DOWNTO 0))) 
            when IR(15 DOWNTO 10) = "110001" AND (Flag(0) ='1' OR Flag(1)='1')   --BHS
            ELSe std_logic_vector(unsigned(PCin)+1) ;


END F;