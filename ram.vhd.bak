LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
GENERIC ( n : integer := 16);
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(5 DOWNTO 0);
		datain  : IN  std_logic_vector(n-1 DOWNTO 0);
		dataout : OUT std_logic_vector(n-1 DOWNTO 0));
END ENTITY ram;

ARCHITECTURE syncrama OF ram IS

	TYPE ram_type IS ARRAY(0 TO 2047) OF std_logic_vector(n-1 DOWNTO 0);
	SIGNAL ram : ram_type := (
		0     => X"000002BC",
		1     => X"000002BB",
		2     => X"000002BA",
		3     => X"000002B9",
		4     => X"000002B8",
		5     => X"000002B7",
		6     => X"000002B6",
		7     => X"000002B5",
		8     => X"000002B4",
		9     => X"000002B3",
		10     => X"000002B2",
		11     => X"000002B1",
		OTHERS => X"FFFFFFFF"
		) ;
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF we = '1' THEN
						ram(to_integer(unsigned(address))) <= datain;
					END IF;
				END IF;
		END PROCESS;
		dataout <= ram(to_integer(unsigned(address)));
END syncrama;
