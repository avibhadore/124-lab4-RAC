library ieee;
use ieee.std_logic_1164.all;

ENTITY compx4 IS PORT(
	input0, input1 		: IN std_logic_vector(3 downto 0);
	AGTB, AEQB, ALTB		: OUT std_logic
	);
	
END compx4;
	
ARCHITECTURE logic69 OF compx4 IS



COMPONENT compx1 PORT(
	in0, in1 	: IN std_logic;
	gt, eq, lt  : OUT std_logic
	);
END COMPONENT;


signal A0, A1, A2, A3, B0, B1, B2, B3 : std_logic;
signal A0_LT_B0, A1_LT_B1, A2_LT_B2, A3_LT_B3, A0_EQ_B0, A1_EQ_B1, A2_EQ_B2, A3_EQ_B3, A0_GT_B0, A1_GT_B1, A2_GT_B2, A3_GT_B3 : std_logic;

BEGIN

A0 <= input0(0);
A1 <= input0(1);
A2 <= input0(2);
A3 <= input0(3);
B0 <= input1(0);
B1 <= input1(1);
B2 <= input1(2);
B3 <= input1(3);

inst0 : compx1 PORT MAP(A0, B0, A0_GT_B0, A0_EQ_B0, A0_LT_B0);
inst1 : compx1 PORT MAP(A1, B1, A1_GT_B1, A1_EQ_B1, A1_LT_B1);
inst2 : compx1 PORT MAP(A2, B2, A2_GT_B2, A2_EQ_B2, A2_LT_B2);
inst3 : compx1 PORT MAP(A3, B3, A3_GT_B3, A3_EQ_B3, A3_LT_B3);


AGTB <= A3_GT_B3 OR (A3_EQ_B3 AND A2_GT_B2) OR (A3_EQ_B3 AND A2_EQ_B2 AND A1_GT_B1) OR (A3_EQ_B3 AND A2_EQ_B2 AND A1_EQ_B1 AND A0_GT_B0);
AEQB <= A0_EQ_B0 AND A1_EQ_B1 AND A2_EQ_B2 AND A3_EQ_B3;
ALTB <= A3_LT_B3 OR (A3_EQ_B3 AND A2_LT_B2) OR  (A3_EQ_B3 AND A2_EQ_B2 AND A1_LT_B1) OR (A3_EQ_B3 AND A2_EQ_B2 AND A1_EQ_B1 AND A0_LT_B0);


END logic69;