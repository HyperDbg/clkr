LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;

LIBRARY STD;

USE STD.TEXTIO.ALL;

ENTITY RAM_INIT IS
	PORT (
		CLK : IN STD_LOGIC;
		PERFORM_INIT : IN STD_LOGIC
	);
END RAM_INIT;

ARCHITECTURE Behavioral OF RAM_INIT IS

	FILE FIN : TEXT OPEN READ_MODE IS "input.dat";

BEGIN

	PROCESS (CLK)
		VARIABLE RD_LINE : LINE;
		VARIABLE HEX : STD_LOGIC_VECTOR(3 DOWNTO 0);
	BEGIN
		IF PERFORM_INIT = '1' THEN
			WHILE NOT ENDFILE(FIN) LOOP
				readline(FIN, RD_LINE);
				hread(RD_LINE, HEX);
			END LOOP;
		END IF;
	END PROCESS;

END Behavioral;