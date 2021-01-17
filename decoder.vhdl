
Library ieee;
use ieee.std_logic_1164.all;

entity decoder is 
	port( E : in std_logic;
              sel : in std_logic_vector (1 downto 0);
              f : out std_logic_vector (3 downto 0));

end entity;

Architecture my_decoder OF decoder IS
Begin
PROCESS (E,sel)
BEGIN
IF E = '0' THEN
		f <= (OTHERS=>'0');
ELSIF sel="00" THEN
		f <= "0001";
ELSIF sel="01" THEN
                f <= "0010";
ELSIF sel="10" THEN
                f <= "0100";
ELSE
                f <= "1000";
END IF;
END PROCESS;


end Architecture;


