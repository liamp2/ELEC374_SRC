library ieee;
use ieee.std_logic_1164.all;


entity MDMux is
port(
	BusMuxOut : in std_logic_vector(31 downto 0);
	Mdatain   : in std_logic_vector(31 downto 0);
	sel 		 : in std_logic;
	output 	 : out std_logic_vector(31 downto 0)
	
);
end entity;

architecture behaviour of MDMux is
begin
output <= BusMuxOut when sel = '0' else
			 Mdatain; -- when sel = "1"
end architecture;