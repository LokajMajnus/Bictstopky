library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity timer is Port ( clk:in std_logic; ms_1 : out std_logic; ms_10 : out std_logic; s_05 : out std_logic; s_1 : out std_logic);
end timer;

architecture Behavioral of timer is
signal count_1 : STD_LOGIC_VECTOR(17 downto 0) := (others =>'0');
signal count_2 : STD_LOGIC_VECTOR(3 downto 0) := (others =>'0');
signal count_3 : STD_LOGIC_VECTOR(5 downto 0) := (others =>'0');
signal tik_1kHz : STD_LOGIC := '0';
signal tik_100Hz : STD_LOGIC := '0';
signal tik_2Hz : STD_LOGIC := '0';
signal tik_1Hz : STD_LOGIC := '0';
begin

kHz1:process (clk)
begin
	if clk='1' and clk'event then
	count_1 <= count_1 +1;
	
		if count_1 = "011110100001001000" then
		count_1 <= (others => '0');
		tik_1kHz <= '1';
		else
		tik_1kHz <= '0';
		end if;
		
	   ms_1 <= tik_1kHz;
		
end if;
end process;

ms10:process(clk)
begin
	if clk='1' and clk'event then
	if tik_1kHz = '1' then
	count_2 <= count_2 + 1;
	if count_2 = "1010" then
	count_2 <= (others => '0');
	tik_100Hz <= '1';
	end if;
	else
	tik_100Hz <= '0';
	end if;
	ms_10 <= tik_100Hz;
	end if;
end process;

Hz2:process(clk)
begin
	if clk='1' and clk'event then 
	if tik_100Hz = '1' then
	count_3 <= count_3 + 1;
	if count_3 = "110001" then
	count_3 <= (others => '0');
	tik_2Hz <= '1';
	end if;
	else
	tik_2Hz <= '0';
	end if;
	s_05 <= tik_2Hz;
	end if;
end process;

Hz1:process(clk)
	begin
	if clk'event and clk='1' then
	if tik_2Hz = '1' then
	tik_1Hz <= not tik_1Hz;
	end if;
	s_1 <= tik_1Hz;
end if;
end process;
end Behavioral;



