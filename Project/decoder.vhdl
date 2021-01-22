
Library ieee;
use ieee.std_logic_1164.all;

USE IEEE.numeric_std.all;
entity decoder is 
GENERIC ( n : integer := 2);
	port( E : in std_logic;
              sel : in std_logic_vector (n-1 downto 0);
              f : out std_logic_vector (2**n-1 downto 0));

end entity;

Architecture my_decoder OF decoder IS
Begin
PROCESS (E,sel)
BEGIN
IF E = '0' THEN
		f <= (OTHERS=>'0');
		
ELSE 
		F <= (others => '0');
		F(to_integer(unsigned(sel))) <= '1';
END IF;
END PROCESS;


end Architecture;


