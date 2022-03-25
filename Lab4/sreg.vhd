library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Bidir_shift_reg is port
(
	CLK	: in std_logic := '0';
	RESET	: in std_logic := '0';
	CLK_EN : in std_logic := '0';
	LEFT0_RIGHT1 : in std_logic := '0';
	REG_BITS : out std_logic_vector(7 downto 0)
	);
	end Entity;

	ARCHITECTURE one OF Bidir_shift_reg IS
	
	Signal sreg: std_logic_vector(7 downto 0);
	
	BEGIN
	
	process (CLK, RESET) is
	begin
		if (RESET = '1') then
		sreg <= "00000000";
		elsif (rising_edge(CLK) AND (CLK_EN = '1')) then
			if (LEFT0_RIGHT1 = '1') then
				sreg (7 downto 0) <= '1' & sreg(7 downto 1); --right shift, concatenating a 1 in front
		elsif (LEFT0_RIGHT1 = '0') then
			sreg (7 downto 0) <= sreg(6 downto 0) & '0'; --left shift, concatenating a 0 0 to the end
		end if;
	end if;
	REG_BITS <= sreg;
end process;

END one;
			