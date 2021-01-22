Library ieee;
use ieee.std_logic_1164.all;

entity bmux is 
	port( A : in std_logic_vector (15 downto 0);
              B : in std_logic_vector (15 downto 0);
              sel : in std_logic_vector(1 downto 0);
              F : out std_logic_vector (15 downto 0);
	      FlagRegister : out std_logic_vector (15 downto 0);
	      cin: IN std_logic);
end entity;

Architecture b_mux OF bmux IS
	
         COMPONENT amux IS
                  PORT( a,b : in std_logic_vector (15 downto 0); cin: in std_logic; 
                        cout: inout std_logic;  f : OUT std_logic_vector (15 downto 0);
			sel : IN std_logic_vector (1 downto 0);
			CmpEnable : in std_logic;
			FlagRegister : out std_logic_vector (15 downto 0));
         END COMPONENT;
		 
	SIGNAL ftemp : std_logic_vector(15 DOWNTO 0);
	SIGNAL zero_flag : std_logic;

	SIGNAL aflag : std_logic_vector(15 DOWNTO 0);
	SIGNAL partAtemp : std_logic_vector(15 DOWNTO 0);
	SIGNAL coutPartA : std_logic;	
	SIGNAL selPartA : std_logic_vector(1 DOWNTO 0);	
	SIGNAL cinPartA : std_logic;	
Begin
	cinPartA<='1' when sel(1 downto 0)&cin ="001"
        else '0';
	selPartA<="00" when sel(1 downto 0)&cin ="001" else "11";
	a_mux1: amux port map(B,A,cinPartA,coutPartA, partAtemp,selPartA,'0',aflag);


	ftemp <= partAtemp when sel(1 downto 0)&cin ="001" or sel(1 downto 0)&cin ="011"
        else (A AND B) when sel ="00"
   	else (A OR B) when sel= "01"
    	else (A XOR B) when sel= "10"
   	else (NOT A);
	
	F(15 downto 0)<=ftemp;
	zero_flag<='1' when ftemp="0000000000000000"
        else '0';
        FlagRegister(15 downto 0)<=aflag when sel(1 downto 0)&cin ="001" or sel(1 downto 0)&cin ="011"
        else "0000000000000"&'0'&zero_flag&'0';
end Architecture;