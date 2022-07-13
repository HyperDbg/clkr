LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

-- A 128x8 single-port RAM in VHDL
ENTITY RAM IS
	PORT (
		RAM_ADDR : IN std_logic_vector(6 DOWNTO 0); -- Address to write/read RAM
		RAM_DATA_IN : IN std_logic_vector(7 DOWNTO 0); -- Data to write into RAM
		RAM_WR : IN std_logic; -- Write enable
		RAM_CLOCK : IN std_logic; -- clock input for RAM
		RAM_DATA_OUT : OUT std_logic_vector(7 DOWNTO 0) -- Data output of RAM
	);
END RAM;

ARCHITECTURE Behavioral OF RAM IS

	-- define the new type for the 128x8 RAM
	TYPE RAM_ARRAY IS ARRAY (0 TO 127) OF std_logic_vector (7 DOWNTO 0);

	-- initial values in the RAM
	SIGNAL RAM : RAM_ARRAY := (
		x"55", x"66", x"77", x"67", -- 0x00:
		x"99", x"00", x"00", x"11", -- 0x04:
		x"00", x"00", x"00", x"00", -- 0x08:
		x"00", x"00", x"00", x"00", -- 0x0C:
		x"00", x"00", x"00", x"00", -- 0x10:
		x"00", x"00", x"00", x"00", -- 0x14:
		x"00", x"00", x"00", x"00", -- 0x18:
		x"00", x"00", x"00", x"00", -- 0x1C:
		x"00", x"00", x"00", x"00", -- 0x20:
		x"00", x"00", x"00", x"00", -- 0x24:
		x"00", x"00", x"00", x"00", -- 0x28:
		x"00", x"00", x"00", x"00", -- 0x2C:
		x"00", x"00", x"00", x"00", -- 0x30:
		x"00", x"00", x"00", x"00", -- 0x34:
		x"00", x"00", x"00", x"00", -- 0x38:
		x"00", x"00", x"00", x"00", -- 0x3C:
		x"00", x"00", x"00", x"00", -- 0x40:
		x"00", x"00", x"00", x"00", -- 0x44:
		x"00", x"00", x"00", x"00", -- 0x48:
		x"00", x"00", x"00", x"00", -- 0x4C:
		x"00", x"00", x"00", x"00", -- 0x50:
		x"00", x"00", x"00", x"00", -- 0x54:
		x"00", x"00", x"00", x"00", -- 0x58:
		x"00", x"00", x"00", x"00", -- 0x5C:
		x"00", x"00", x"00", x"00", 
		x"00", x"00", x"00", x"00", 
		x"00", x"00", x"00", x"00", 
		x"00", x"00", x"00", x"00", 
		x"00", x"00", x"00", x"00", 
		x"00", x"00", x"00", x"00", 
		x"00", x"00", x"00", x"00", 
		x"00", x"00", x"00", x"00"
	);
BEGIN

	PROCESS (RAM_CLOCK)
	BEGIN
		IF (rising_edge(RAM_CLOCK)) THEN
			IF (RAM_WR = '1') THEN -- when write enable = 1,
				-- write input data into RAM at the provided address
				RAM(to_integer(unsigned(RAM_ADDR))) <= RAM_DATA_IN;

				-- The index of the RAM array type needs to be integer so
				-- converts RAM_ADDR from std_logic_vector -> Unsigned -> Interger using numeric_std library
			END IF;
		END IF;
	END PROCESS;
	
	-- Data to be read out
	RAM_DATA_OUT <= RAM(to_integer(unsigned(RAM_ADDR)));
	
END Behavioral;