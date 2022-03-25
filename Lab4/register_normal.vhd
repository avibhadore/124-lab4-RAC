LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY register_normal IS
PORT
	(
		clk 			: IN std_logic := '0';
		capture 		: IN std_logic := '0';
		reset			: IN std_logic := '0';
		input_data 	: IN std_logic_vector(3 downto 0);
		reg_bits 	: OUT std_logic_vector(3 downto 0);
	);
	
ARCHITECTURE register_architecture OF normal_register IS
BEGIN

signal reg_container : UNSIGNED(3 downto 0);

process (clk, reset) is
begin
	
	if (reset = '1') then
		reg_container <= "0000";
		
	elsif (rising_edge(clk) AND capture = '1') then
		reg_container <= input_data;

	end if;

	reg_bits <= std_logic_vector(reg_container);

END PROCESS;

END;
