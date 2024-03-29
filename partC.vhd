
Library ieee;
use ieee.std_logic_1164.all;

entity cmux is 
	port( Cin : in std_logic;
              A : in std_logic_vector (15 downto 0);
              sel : in std_logic_vector (1 downto 0);
              F : out std_logic_vector (15 downto 0);
              Cout : inout std_logic;
	      FlagRegister : out std_logic_vector (15 downto 0));
end entity;

Architecture c_mux OF cmux IS
	SIGNAL ftemp : std_logic_vector(15 DOWNTO 0);
	SIGNAL zero_flag : std_logic;
Begin 
        ftemp<='0'&A(15 downto 1) when sel="00"
   	else A(0)&A(15 downto 1) when sel= "01"
    	else Cin &A(15 downto 1)when sel= "10"
   	else A(15)&A(15 downto 1) ;
	Cout<=A(0);

        
        F(15 downto 0)<=ftemp;
	zero_flag<='1' when ftemp="0000000000000000"
        else '0';
        FlagRegister(15 downto 0)<="0000000000000"&'0'&zero_flag&Cout;

end Architecture;

