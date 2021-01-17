Library ieee;
use ieee.std_logic_1164.all;

entity tri_state_buffer is 
GENERIC ( n : integer := 32);
	port( E : in std_logic;
              d : in std_logic_vector (n-1 downto 0);
              f : out std_logic_vector (n-1 downto 0));

end entity;

Architecture my_tri_state_buffer OF tri_state_buffer IS
Begin
PROCESS (E,d)
BEGIN
IF E = '0' THEN
		f <= (OTHERS=>'Z');
ELSE 
                f<=d;

END IF;
END PROCESS;
end Architecture;
