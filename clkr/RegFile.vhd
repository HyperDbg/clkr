LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_file IS
	PORT (
		outA : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
		outB : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
		input : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		writeEnable : IN STD_LOGIC;
		regASel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		regBSel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		writeRegSel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		clk : IN STD_LOGIC
	);
END register_file;

ARCHITECTURE behavioral OF register_file IS
	TYPE registerFile IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR(63 DOWNTO 0);
	SIGNAL registers : registerFile;
BEGIN

	regFile : PROCESS (clk) IS
	BEGIN
		IF rising_edge(clk) THEN
			-- Read A and B before bypass
			outA <= registers(to_integer(unsigned(regASel)));
			outB <= registers(to_integer(unsigned(regBSel)));
			-- Write and bypass
			IF writeEnable = '1' THEN
				registers(to_integer(unsigned(writeRegSel))) <= input; -- Write
				IF regASel = writeRegSel THEN -- Bypass for read A
					outA <= input;
				END IF;
				IF regBSel = writeRegSel THEN -- Bypass for read B
					outB <= input;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END behavioral;