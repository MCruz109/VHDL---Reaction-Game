library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity start_round is
    Port ( dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           dig3 : in STD_LOGIC_VECTOR (3 downto 0);
           dig4 : in STD_LOGIC_VECTOR (3 downto 0);
--           dig_out1 : out STD_LOGIC_VECTOR (3 downto 0);
--           dig_out2 : out STD_LOGIC_VECTOR (3 downto 0);
--           dig_out3 : out STD_LOGIC_VECTOR (3 downto 0);
--           dig_out4 : out STD_LOGIC_VECTOR (3 downto 0);
           
           E : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in STD_LOGIC;
           send_start : out STD_LOGIC);
end start_round;

architecture Behavioral of start_round is

signal check1, check2, check3, check4 : STD_LOGIC_VECTOR(3 downto 0);
signal stop : std_logic;
signal comb : std_logic;


begin

    sw_process : process(clk, check1, check2, check3, check4, reset)
    
    begin
    if rising_edge(clk) then  
        if reset = '1' then
            stop                <= '0';
--            dig_out1        <= "0000";
--            dig_out2        <= "0000";
--            dig_out3        <= "0000";
--            dig_out4        <= "0000";
      
        elsif check1 = "0000" and check2 = "0000" and check3 = "0000" and check4 = "0000" then
            if E = '1' then
--            dig_out1        <= "1110";
--            dig_out2        <= "1110";
--            dig_out3        <= "1110";
--            dig_out4        <= "1110";
            stop <= '1';
            end if;
            
        elsif stop = '1' then
--            dig_out1        <= "1110";
--            dig_out2        <= "1110";
--            dig_out3        <= "1110";
--            dig_out4        <= "1110";
            stop            <= '1';          
        else
--            dig_out1        <= dig1;
--            dig_out2        <= dig2;
--            dig_out3        <= dig3;
--            dig_out4        <= dig4;
            stop            <= '0';
        end if;
   end if;     
    end process;

-- INPUTS
check1 <= dig1;
check2 <= dig2;
check3 <= dig3;
check4 <= dig4;

send_start <= stop;

end Behavioral;
