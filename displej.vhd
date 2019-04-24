library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity displej is
	Port (clk : in STD_LOGIC;
	      data0 : in STD_LOGIC_VECTOR (3 downto 0); 
	      data1 : in STD_LOGIC_VECTOR (3 downto 0); 
	      data2 : in STD_LOGIC_VECTOR (3 downto 0); 
	      data3 : in STD_LOGIC_VECTOR (3 downto 0); 
	      dp0 : in STD_LOGIC; 
	      dp1 : in STD_LOGIC; 
	      dp2 : in STD_LOGIC; 
	      dp3 : in STD_LOGIC; 
	      timer : in STD_LOGIC; 
	      disp_digit_o : out STD_LOGIC_VECTOR (3 downto 0); 
	      disp_sseg_o : out STD_LOGIC_VECTOR (7 downto 0));

end displej;

architecture Behavioral of displej is
signal mux : STD_LOGIC_VECTOR (1 downto 0) := "00"; 
signal data : STD_LOGIC_VECTOR (3 downto 0) := "0000"; 
signal dp : std_logic := '1';

begin

process (clk)
begin
	if clk='1' and clk'event then
	if timer ='1' then
	mux <= mux + 1;
	end if;

	case mux is
	when "00" =>
		data<=data0;
		disp_digit_o <= "1110";
		dp <= dp0;
	when "01" =>
		data<=data1;
		disp_digit_o <= "1101";
		dp <= dp1;
	when "10" => 
		data <= data2;
		disp_digit_o <= "1011";
		dp <= dp2;
	when "11" =>
		data<=data3;
      disp_digit_o <= "0111";
		dp <= dp3;
	when others =>
		disp_digit_o <= "1111";
	end case;

case data is
	when "0000" => disp_sseg_o <= dp & "1000000";--0
	when "0001" => disp_sseg_o <= dp & "1111001";--1
	when "0010" => disp_sseg_o <= dp & "0100100";--2
	when "0011" => disp_sseg_o <= dp & "0110000";--3
	when "0100" => disp_sseg_o <= dp & "0011001";--4
	when "0101" => disp_sseg_o <= dp & "0010010";--5
	when "0110" => disp_sseg_o <= dp & "0000010";--6
	when "0111" => disp_sseg_o <= dp & "1111000";--7
	when "1000" => disp_sseg_o <= dp & "0000000";--8
	when "1001" => disp_sseg_o <= dp & "0010000";--9
	when others => disp_sseg_o <= "11111111";
end case;
end if;
end process;
end Behavioral;
