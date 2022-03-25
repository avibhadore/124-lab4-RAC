library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- clk input is the LogicalStep 50MHz clock input
entity Clock_Source is

	port
	(
		SIM_FLAG					: in boolean;
		clk_input				: in std_logic; 
		clock_out				: out std_logic
	);

end entity;

architecture rtl of Clock_Source is

signal clk_2hz 			: std_logic;
signal sim_clock			: std_logic;
signal digital_counter 	: std_logic_vector(23 downto 0);


begin

-- clk_divider process generates a 2Hz Clck from the 50 Mhz clk

clk_divider: process (clk_input)
	variable   counter	:  unsigned(23 downto 0);
	
	begin
-- Synchronously update counter
		if (rising_edge(clk_input))  then
				 counter :=  counter + 1;
		end if;
		digital_counter <= std_logic_vector(counter);		

	end process;
	
clk_2hz <= digital_counter(23);

clk_mux: process (SIM_FLAG)
	begin
		if (SIM_FLAG)  then
				 clock_out<=  clk_input; 		-- non-divided clock used for simulations
		else
				 clock_out<=  clk_2hz; 	-- 2Hz clock used for LogicalStep Board downloads
		end if;
	end process;


end rtl;


