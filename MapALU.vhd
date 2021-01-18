Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

ENTITY MapALU IS
	PORT (  F: In std_logic_vector (4 DOWNTO 0); Carry,CMP : OUT std_logic ; S : OUT std_logic_vector (3 DOWNTO 0));
END ENTITY MapALU;

ARCHITECTURE mapALU OF MapALU IS
BEGIN
	
    S <= "0000" when F = "00000"   
    ELSE "0001" when F = "00001"
    ELSE "0010" when F = "00010"                                 
    ELSE "0011" when F = "00011"                                 
    ELSE "0000" when F = "00100"                                 
    ELSE "0001" when F = "00101"                                 
    ELSE "0010" when F = "00110"                                 
    ELSE "0011" when F = "00111"                                 
    ELSE "0100" when F = "01000"                                 
    ELSE "0101" when F = "01001"                                 
    ELSE "0110" when F = "01010"                                 
    ELSE "0111" when F = "01011"                                 
    ELSE "1000" when F = "01100"                                 
    ELSE "1001" when F = "01101"                                 
    ELSE "1010" when F = "01110"                                 
    ELSE "1011" when F = "01111"
    ELSE "1100" when F = "10000"                                 
    ELSE "1101" when F = "10001"
    ELSE "1110" when F = "10010"
    ELSE "1111" when F = "10011"
    ELSE "0100" when F = "10100"                                 
    ELSE "0101" when F = "10101"  
    ELSE "0010" when F = "10110" ;

    CMP <= '1' when F ="10101"
    ELSE '0';

    Carry <= '0' when F = "00000"   
    ELSE '0' when F = "00001"
    ELSE '0' when F = "00010"                                 
    ELSE '0' when F = "00011"                                 
    ELSE '1' when F = "00100"                                 
    ELSE '1' when F = "00101"                                 
    ELSE '1' when F = "00110"                                 
    ELSE '1' when F = "00111"                                 
    ELSE '0' when F = "01000"                                 
    ELSE '0' when F = "01001"                                 
    ELSE '0' when F = "01010"                                 
    ELSE '0' when F = "01011"                                 
    ELSE '0' when F = "01100"                                 
    ELSE '0' when F = "01101"                                 
    ELSE '0' when F = "01110"                                 
    ELSE '0' when F = "01111"
    ELSE '0' when F = "10000"                                 
    ELSE '0' when F = "10001"
    ELSE '0' when F = "10010"
    ELSE '0' when F = "10011"
    ELSE '1' when F = "10100"                                 
    ELSE '1' when F = "10101"  
    ELSE '0' when F = "10110" ;

                                   
END mapALU;