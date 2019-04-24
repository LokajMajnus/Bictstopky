library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity time_core is
	Port( clk : in std_logic;
	timer : in std_logic;
	bl : in std_logic;
	btn : in std_logic_vector(3 downto 0);
	sec_001 : out std_logic_vector(3 downto 0);
	sec_01 : out std_logic_vector(3 downto 0);
	sec_1 : out std_logic_vector(3 downto 0);
	sec_10 : out std_logic_vector(3 downto 0));
end time_core;

architecture Behavioral of time_core is
signal count_sec_001 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal count_sec_01 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal count_sec_1 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal count_sec_10 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal run : STD_LOGIC := '0';

begin 
com:process (clk)
begin 
if clk='1' and clk'event then
if count_sec_001 = "1001" and count_sec_01 = "1001"
and count_sec_1 = "1001" and count_sec_10 = "1001" then 
run <= '0';
if bl = '0' then
sec_001 <= (others => '1');
sec_01 <= (others => '1');
sec_1 <= (others => '1');
sec_10 <= (others => '1');
else
sec_001 <= count_sec_001;
sec_01 <= count_sec_01;
sec_1 <= count_sec_1;
sec_10 <= count_sec_10;
end if;
else
sec_001 <= count_sec_001;
sec_01 <= count_sec_01;
sec_1 <= count_sec_1;
sec_10 <= count_sec_10;
end if;

if btn(1) = '1' then
run<='1';
end if;
if btn(2)= '1' then 
run<= '0';
end if;
end if;
end process;

cnt:process (clk,btn(0), btn(1), count_sec_001, count_sec_01, count_sec_1, count_sec_10)
begin

if btn(0) = '1' or (count_sec_001 = "1001" and count_sec_01 = "1001" 
and count_sec_1 = "1001" and count_sec_10 = "1001"
and btn (1) ='1') then
count_sec_001 <= (others => '0');
count_sec_01 <= (others => '0');
count_sec_1 <= (others => '0');
count_sec_10 <= (others => '0');
elsif clk='1' and clk'event then
if timer = '1' and  run = '1' then 
count_sec_001 <= count_sec_001 + 1;
if count_sec_001 = "1001" then
count_sec_001 <= (others => '0');
count_sec_01 <= count_sec_01 + 1;
if count_sec_01 <= "1001" then 
count_sec_01 <= (others => '0');
count_sec_1 <= count_sec_1 +1;
if count_sec_1 = "1001" then
count_sec_1 <= (others => '0');
count_sec_10 <= count_sec_10 + 1;
end if;
end if;
end if;
end if;
end if;
end process;
end Behavioral;