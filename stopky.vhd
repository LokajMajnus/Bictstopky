library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity stopky is
	Port ( clk : in STD_LOGIC;
		btn : in STD_LOGIC_VECTOR (3 downto 0);
		disp_digit_o : out STD_LOGIC_VECTOR (3 downto 0);
		disp_sseg_o : out STD_LOGIC_VECTOR (7 downto 0));
end stopky;
architecture Behavioral of stopky is 

component displej
	port ( clk : in STD_LOGIC;
		data0 : in STD_LOGIC_VECTOR ( 3 downto 0);
		data1 : in STD_LOGIC_VECTOR ( 3 downto 0);
		data2 : in STD_LOGIC_VECTOR ( 3 downto 0);
		data3 : in STD_LOGIC_VECTOR ( 3 downto 0);
		dp0 : in STD_LOGIC;
		dp1 : in STD_LOGIC;
		dp2 : in STD_LOGIC;
		dp3 : in STD_LOGIC;
		timer : in STD_LOGIC;
		disp_digit_o : out STD_LOGIC_VECTOR ( 3 downto 0);
		disp_sseg_o : out STD_LOGIC_VECTOR ( 7 downto 0)); 
end component;

component timer
	port ( clk : in STD_LOGIC;
		ms_1 : out STD_LOGIC;
		ms_10 : out STD_LOGIC;
		s_05 : out STD_LOGIC;
		s_1 : out STD_LOGIC);
end component;

component time_core 
	port ( clk : in STD_LOGIC;
		timer : in STD_LOGIC;
		bl : in STD_LOGIC;
		btn : in STD_LOGIC_VECTOR (3 downto 0);
		sec_001 : out STD_LOGIC_VECTOR (3 downto 0);
		sec_01 : out STD_LOGIC_VECTOR (3 downto 0);
		sec_1 : out STD_LOGIC_VECTOR (3 downto 0);
		sec_10 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal data0 : STD_LOGIC_VECTOR (3 downto 0);
signal data1 : STD_LOGIC_VECTOR (3 downto 0);
signal data2 : STD_LOGIC_VECTOR (3 downto 0);
signal data3 : STD_LOGIC_VECTOR (3 downto 0);
signal dp0 : STD_LOGIC := '1';
signal dp1 : STD_LOGIC := '1';
signal dp2 : STD_LOGIC := '0';
signal dp3 : STD_LOGIC := '1';
signal clk_en : STD_LOGIC;
signal ms_1 : STD_LOGIC;
signal ms_10 : STD_LOGIC;
signal s_05 : STD_LOGIC;
signal s_1 : STD_LOGIC;
begin

displej_0:displej
	port map (	clk => clk,
			data0 => data0,
			data1 => data1,
			data2 => data2,
			data3 => data3,
			dp0 => dp0,
			dp1 => dp1,
			dp2 => dp2,
			dp3 => dp3,
			timer => ms_1,
			disp_digit_o => disp_digit_o,
			disp_sseg_o => disp_sseg_o);

timer_0:timer
	port map ( clk => clk,
			ms_1 => ms_1,
			ms_10 => ms_10,
			s_1 => s_1);

time_core_0:time_core
	port map (clk => clk,
			timer => ms_10,
			bl => s_1,
			btn => btn,
			sec_001 => data0,
			sec_01 => data1,
			sec_1 => data2,
			sec_10 => data3);
end behavioral;