library ieee;
use ieee.std_logic_1164.all;

entity encoder32to5 is
port(
		output : out std_logic_vector(4 downto 0);
		input : in std_logic_vector(31 downto 0)
);
end encoder32to5;

architecture behaviour of encoder32to5 is
begin
	output <= 
	"00000" when input(0) = '1' else
	"00001" when input(1) = '1' else
	"00010" when input(2) = '1' else
	"00011" when input(3) = '1' else
	"00100" when input(4) = '1' else
	"00101" when input(5) = '1' else
	"00110" when input(6) = '1' else
	"00111" when input(7) = '1' else
	"01000" when input(8) = '1' else
	"01001" when input(9) = '1' else
	"01010" when input(10) = '1' else
	"01011" when input(11) = '1' else
	"01100" when input(12) = '1' else
	"01101" when input(13) = '1' else
	"01110" when input(14) = '1' else
	"01111" when input(15) = '1' else
	"10000" when input(16) = '1' else
	"10001" when input(17) = '1' else
	"10010" when input(18) = '1' else
	"10011" when input(19) = '1' else
	"10100" when input(20) = '1' else
	"10101" when input(21) = '1' else
	"10110" when input(22) = '1' else
	"10111" when input(23) = '1' else
	"11000" when input(24) = '1' else
	"11001" when input(25) = '1' else
	"11010" when input(26) = '1' else
	"11011" when input(27) = '1' else
	"11100" when input(28) = '1' else
	"11101" when input(29) = '1' else
	"11110" when input(30) = '1' else
	"11111"; -- when input(31) = '1';
end architecture;