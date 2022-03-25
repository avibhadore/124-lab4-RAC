library ieee;
use ieee.std_logic_1164.all;

ENTITY compx1 is PORT(
	in0, in1 	: IN std_logic;
	gt, eq, lt  : OUT std_logic
	);

end compx1;

ARCHITECTURE logic_compx1 OF compx1 IS
BEGIN

eq <= in0 XNOR in1;
gt <= in0 AND (NOT in1);
lt <= (NOT in0) AND in1;

END ARCHITECTURE logic_compx1;

