Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE IEEE.numeric_std.all;
entity lab4 is 
GENERIC ( n : integer := 32);
	port( 
	      sourceEnable  : IN std_logic;
	      destinationEnable  : IN std_logic;
              dataout : OUT std_logic_vector(n-1 DOWNTO 0);
	      ClkReg : IN std_logic;
              Rst : IN std_logic;
              selSource : in std_logic_vector (1 downto 0);
	      seldestination : in std_logic_vector (1 downto 0);
	      r0 : out std_logic_vector (n-1 downto 0);
 	      r1 : out std_logic_vector (n-1 downto 0);
              r2 : out std_logic_vector (n-1 downto 0);
              r3 : out std_logic_vector (n-1 downto 0);
              outbus : inout std_logic_vector (n-1 downto 0));

end entity;

Architecture my_lab4 OF lab4 IS
	COMPONENT lab3 IS
	  	 GENERIC ( n : integer := 32);
	    	 port( sourceEnable : in std_logic;
              		destinationEnable : in std_logic;
	      		Clk : IN std_logic;
             	        Rst : IN std_logic;
            		seldestination : in std_logic_vector (1 downto 0);
	      		selsource : in std_logic_vector (1 downto 0);
	      		r0 : out std_logic_vector (n-1 downto 0);
 	      		r1 : out std_logic_vector (n-1 downto 0);
              		r2 : out std_logic_vector (n-1 downto 0);
              		r3 : out std_logic_vector (n-1 downto 0);
              		outbus : inout std_logic_vector (n-1 downto 0));
	END COMPONENT;
	COMPONENT decoder IS
                  PORT( E: in std_logic;sel: in std_logic_vector (1 downto 0);f : OUT std_logic_vector (3 downto 0));
         END COMPONENT;
         COMPONENT my_nDFF IS
	 GENERIC ( n : integer := 32);
		PORT( E,Clk,Rst : IN std_logic;
		   d : IN std_logic_vector(n-1 DOWNTO 0);
		   q : OUT std_logic_vector(n-1 DOWNTO 0));
	 END COMPONENT;
	COMPONENT tri_state_buffer IS
                  PORT( E: in std_logic;d: in std_logic_vector (n-1 downto 0);f : OUT std_logic_vector (n-1 downto 0));
         END COMPONENT;
	 TYPE ram_type IS ARRAY(0 TO 15) OF std_logic_vector(n-1 DOWNTO 0);
	 SIGNAL ram : ram_type:=(
	 "00000000000000000000001010111100", "00000000000000000000001010111011",
         "00000000000000000000001010111010", "00000000000000000000001010111001",
         "00000000000000000000001010111000", "00000000000000000000001010110111",
         "00000000000000000000001010110110", "00000000000000000000001010110101",
         "00000000000000000000001010110100", "00000000000000000000001010110011",
         "00000000000000000000001010110010", "00000000000000000000000000000000",
         "00000000000000000000000000000000", "00000000000000000000000000000000",
         "00000000000000000000000000000000", "00000000000000000000000000000000"
	 ) ;
	 SIGNAL counter_address : std_logic_vector(3 DOWNTO 0);
         signal notSourceEnable: std_logic;
	 signal ramOut: std_logic_vector (n-1 downto 0);
	 signal temp: std_logic_vector (n-1 downto 0);
	 signal R00: std_logic_vector (n-1 downto 0);
	 signal R11: std_logic_vector (n-1 downto 0);
	 signal R22: std_logic_vector (n-1 downto 0);
	 signal R33: std_logic_vector (n-1 downto 0);
         signal fdestination: std_logic_vector (3 downto 0);
	 signal fsource: std_logic_vector (3 downto 0);
	 signal REram: std_logic;
	 signal clkRam: std_logic;
Begin
	 clkRam<= not clkReg;
         readWriteToReg: lab3 PORT MAP(sourceEnable,destinationEnable,ClkReg,Rst,seldestination,selsource,r00,r11,
	 r22,r33,temp);
	 r0<=r00; r1<=r11; r2<=r22; r3<=r33;
	 PROCESS(ClkRam) IS
			BEGIN
				IF rising_edge(ClkRam) THEN  
					IF destinationEnable = '0'  THEN
						ram(to_integer(unsigned(counter_address))) <= outbus;
					END IF;
				END IF;
	 END PROCESS;
	 PROCESS (ClkRam,RST)
	 BEGIN
		IF RST = '1' THEN
               		 counter_address<="1010";
		ELSIF rising_edge(ClkRam) THEN 
               		 counter_address<=counter_address-1;
		END IF;
	 END PROCESS;
	 ramOut <= ram(to_integer(unsigned(counter_address)));
         dataout<= ramOut;
         notSourceEnable<=not sourceEnable;
	 readFromRam: tri_state_buffer port map(notSourceEnable,ramOut,temp); 
	 outbus<=temp;
END Architecture;