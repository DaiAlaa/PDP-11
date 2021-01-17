Library ieee;
use ieee.std_logic_1164.all;

entity bmux is 
	port( A : in std_logic_vector (15 downto 0);
              B : in std_logic_vector (15 downto 0);
              sel : in std_logic_vector(1 downto 0);
              F : out std_logic_vector (15 downto 0);
	      FlagRegister : out std_logic_vector (15 downto 0));
end entity;

Architecture b_mux OF bmux IS
	SIGNAL ftemp : std_logic_vector(15 DOWNTO 0);
	SIGNAL zero_flag : std_logic;
Begin
	ftemp <= (A AND B) when sel ="00"
   	else (A OR B) when sel= "01"
    	else (A XOR B) when sel= "10"
   	else (NOT A) ;

	F(15 downto 0)<=ftemp;
	zero_flag<='1' when ftemp="0000000000000000"
        else '0';
        FlagRegister(15 downto 0)<="0000000000000"&'0'&zero_flag&'0';
end Architecture;