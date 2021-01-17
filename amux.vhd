LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity amux is 
	port( cin : in std_logic;
              a : in std_logic_vector (15 downto 0);
              b : in std_logic_vector (15 downto 0);
              sel : in std_logic_vector (1 downto 0);
              CmpEnable : in std_logic;
	      FlagRegister : out std_logic_vector (15 downto 0);
              f: out std_logic_vector (15 downto 0);
              cout : inout std_logic);
end entity;

Architecture a_mux OF amux IS 
	COMPONENT my_nadder IS
	GENERIC (n : integer := 16);
               	PORT   (a, b : IN std_logic_vector(n-1 DOWNTO 0);
            		 cin : IN std_logic;
            		 s : OUT std_logic_vector(n-1 DOWNTO 0);
             		 cout : OUT std_logic);	
        END COMPONENT;
        SIGNAL dtemp : std_logic_vector(15 DOWNTO 0);
        SIGNAL btemp : std_logic_vector(15 DOWNTO 0);
	SIGNAL atemp : std_logic_vector(15 DOWNTO 0);
	SIGNAL ftemp : std_logic_vector(15 DOWNTO 0);
	SIGNAL cout_temp : std_logic;
	SIGNAL zero_flag : std_logic;
	SIGNAL negative_flag : std_logic;
BEGIN    
         atemp<=b(15 downto 0) when CmpEnable='1'
         else a(15 downto 0);

         btemp<="0000000000000000" when sel (1 downto 0)="00"
	 else not b(15 downto 0) when sel (1 downto 0)&CmpEnable="100" 
         else not a(15 downto 0) when sel (1 downto 0)&CmpEnable="101" 
         else "1111111111111111" when sel (1 downto 0)="11"
         else b(15 downto 0);

         d_mux1: my_nadder port map(atemp,btemp,cin,dtemp,cout_temp);

         ftemp<="0000000000000000" when sel(1 downto 0)&cin="111"
         else btemp when CmpEnable='1'
         else dtemp;

         f(15 downto 0)<=ftemp;

	 cout<='0' when sel(1 downto 0)&cin="111"
         else cout_temp;    
         zero_flag<='1' when ftemp="0000000000000000"
         else '0';
         negative_flag<='1' when sel(1 downto 0)&cout="100"
         else '1' when sel(1 downto 0)&cin &cout="1100"
         else '0';
         FlagRegister(15 downto 0)<="0000000000000"&negative_flag&zero_flag&cout;
end Architecture;

