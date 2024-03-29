Library ieee;
use ieee.std_logic_1164.all;
ENTITY my_nDFF IS
GENERIC ( n : integer := 32);
PORT( E,Clk,Rst : IN std_logic;
		   d : IN std_logic_vector(n-1 DOWNTO 0);
		   q : OUT std_logic_vector(n-1 DOWNTO 0));
END my_nDFF;

ARCHITECTURE a_my_nDFF OF my_nDFF IS
BEGIN
PROCESS (E,Clk,Rst)
BEGIN
IF Rst = '1' THEN
		q <= (OTHERS=>'0');
ELSIF rising_edge(Clk) and E='1' THEN
		q <= d;
END IF;
END PROCESS;
END a_my_nDFF;