Library ieee;
use ieee.std_logic_1164.all;

entity lab3 is 
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

end entity;

Architecture my_lab3 OF lab3 IS

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
	 signal temp: std_logic_vector (n-1 downto 0);
	 signal R00: std_logic_vector (n-1 downto 0);
	 signal R11: std_logic_vector (n-1 downto 0);
	 signal R22: std_logic_vector (n-1 downto 0);
	 signal R33: std_logic_vector (n-1 downto 0);
         signal fsource: std_logic_vector (3 downto 0);
	 signal fdestination: std_logic_vector (3 downto 0);
Begin
	 destination_decoder: decoder port map(destinationEnable,SELdestination,fdestination);      
	 reg0: my_nDFF port map(fdestination(0),Clk,Rst,outbus,r00);
	 reg1: my_nDFF port map(fdestination(1),Clk,Rst,outbus,r11);
	 reg2: my_nDFF port map(fdestination(2),Clk,Rst,outbus,r22);
	 reg3: my_nDFF port map(fdestination(3),Clk,Rst,outbus,r33);
         r0<=r00; r1<=r11; r2<=r22; r3<=r33;
	 source_decoder: decoder port map(sourceEnable,SELsource,fsource);
	 tri0: tri_state_buffer port map(fsource(0),r00,temp);
	 tri1: tri_state_buffer port map(fsource(1),r11,temp);
	 tri2: tri_state_buffer port map(fsource(2),r22,temp);
	 tri3: tri_state_buffer port map(fsource(3),r33,temp);
	 outbus<=temp WHEN sourceEnable='1'
         ELSE (OTHERS=>'Z');
END Architecture;
