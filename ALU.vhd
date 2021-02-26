library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
library work;

entity ALU is
port(
	Ain : in std_logic_vector(31 downto 0);
	Bin : in std_logic_vector(31 downto 0);
	
	andS : in std_logic;
	orS : in std_logic;
	notS : in std_logic;
	addS : in std_logic;
	subS : in std_logic;
	shrS : in std_logic;
	shraS : in std_logic;
	shlS : in std_logic;
	shcS : in std_logic;
	negS : in std_logic;
	

	Cout : out std_logic_vector(63 downto 0)
);
end entity ALU;

architecture behavioural of ALU is

-- define components needed for ALU
component rca32_add is
	port(
		A, B : in std_logic_vector(31 downto 0);
		result : out std_logic_vector(31 downto 0)
		);
end component rca32_add;

component neg is
	port(
		A : in std_logic_vector(31 downto 0);
		output : out std_logic_vector(31 downto 0)
	);
end component;

component sub is
port(
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		output : out std_logic_vector(63 downto 0)
	);
end component;

-- define internal signals
signal add_result : std_logic_vector(31 downto 0);
signal sub_result : std_logic_vector(63 downto 0);
signal neg_result : std_logic_vector(31 downto 0);
-- map components
begin
addition : rca32_add
	port map(
		A => Ain,
		B => Bin,
		result => add_result
	);

negate : neg
	port map(
		A => Ain,
		output => neg_result
	);

subtract : sub 
	port map(
		A => Ain, 
		B => Bin, 
		output => sub_result
	);

ALU: process(Ain, Bin, andS, orS, notS, addS, subS, shrS, shraS, shlS, shcS, negS, 
				 add_result, sub_result, neg_result) is
begin
	if (andS = '1') then 
		Cout(63 downto 32) <= (others => '0');
		Cout(31 downto 0) <= Ain and Bin;
		
	elsif(orS ='1') then
		Cout(63 downto 32) <= (others => '0');
		Cout(31 downto 0) <= Ain or Bin;
		
	elsif(notS = '1') then
		Cout(63 downto 32) <= (others => '0');
		Cout(31 downto 0) <= not Ain;
		
	elsif(addS = '1') then
		Cout(63 downto 32) <= (others => '0');
		Cout(31 downto 0) <= add_result;
		
	elsif(subS = '1') then
		--Cout(63 downto 32) <= (others => '0');
		--Cout(31 downto 0) <= sub_result;
		Cout <= sub_result;
	elsif(negS = '1') then
		Cout(63 downto 32) <= (others => '1');
		Cout(31 downto 0) <= neg_result;
		
	else
		Cout <= (others => '0');

	end if;
end process;
end architecture;