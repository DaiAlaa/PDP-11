Library ieee;
use ieee.std_logic_1164.all;

entity finalmux is 
	port( Cin : in std_logic;
              CmpEnable : in std_logic;
              A : in std_logic_vector (15 downto 0);
              B : in std_logic_vector (15 downto 0);
              S : in std_logic_vector (3 downto 0);
              F : out std_logic_vector (15 downto 0);
              FlagRegister : out std_logic_vector (15 downto 0);
              Cout : inout std_logic);
end entity;

Architecture f_mux OF finalmux IS 
	COMPONENT bmux IS
                  PORT( a,b : in std_logic_vector (15 downto 0);sel : IN std_logic_vector (1 downto 0);
			f : OUT std_logic_vector (15 downto 0);
			FlagRegister : out std_logic_vector (15 downto 0));
			
        END COMPONENT;

        COMPONENT cmux IS
                  PORT( a : in std_logic_vector (15 downto 0); cin: in std_logic; 
                        cout: inout std_logic;  f : OUT std_logic_vector (15 downto 0);
			sel : IN std_logic_vector (1 downto 0);
			FlagRegister : out std_logic_vector (15 downto 0));
        END COMPONENT;

	COMPONENT dmux IS
                  PORT( a : in std_logic_vector (15 downto 0); cin: in std_logic; 
			cout: inout std_logic;  f : OUT std_logic_vector (15 downto 0);
			sel : IN std_logic_vector (1 downto 0);
			FlagRegister : out std_logic_vector (15 downto 0));
         END COMPONENT;

         COMPONENT amux IS
                  PORT( a,b : in std_logic_vector (15 downto 0); cin: in std_logic; 
                        cout: inout std_logic;  f : OUT std_logic_vector (15 downto 0);
			sel : IN std_logic_vector (1 downto 0);
			CmpEnable : in std_logic;
			FlagRegister : out std_logic_vector (15 downto 0));
         END COMPONENT;

         SIGNAL atemp : std_logic_vector(15 DOWNTO 0);
         SIGNAL btemp : std_logic_vector(15 DOWNTO 0);
         SIGNAL ctemp : std_logic_vector(15 DOWNTO 0);
         SIGNAL dtemp : std_logic_vector(15 DOWNTO 0);

	 SIGNAL aflag : std_logic_vector(15 DOWNTO 0);
         SIGNAL bflag : std_logic_vector(15 DOWNTO 0);
         SIGNAL cflag : std_logic_vector(15 DOWNTO 0);
         SIGNAL dflag : std_logic_vector(15 DOWNTO 0);

         SIGNAL ccout : std_logic;
         SIGNAL dcout: std_logic;
         SIGNAL acout: std_logic;
BEGIN
         b_mux1: bmux port map(a,b,s(1 downto 0),btemp,bflag);
         c_mux1: cmux port map(a,cin,ccout,ctemp,s(1 downto 0),cflag);
         d_mux1: dmux port map(a,cin,dcout,dtemp,s(1 downto 0),dflag);
	 a_mux1: amux port map(a,b,cin,acout,atemp,s(1 downto 0),CmpEnable,aflag);


	 FlagRegister<=bflag when s(3 downto 2)="01"
         else cflag when s(3 downto 2)="10"
	 else dflag when s(3 downto 2)="11"
         else aflag;
         f<=btemp when s(3 downto 2)="01"
         else ctemp when s(3 downto 2)="10"
	 else dtemp when s(3 downto 2)="11"
         else atemp;
         cout<=ccout when s(3 downto 2)="10"
         else dcout when s(3 downto 2)="11"
         else acout when s(3 downto 2)="00"
	 else '0';
end Architecture;