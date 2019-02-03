library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity visual_start is
    Port ( enable : in STD_LOGIC;
           reset  : in STD_LOGIC;
           LED : out STD_LOGIC);
end visual_start;

architecture Behavioral of visual_start is

signal enable_i, start_i,LED_i: STD_LOGIC;

begin

    start : process(enable, reset)
    
    begin
    
        if (reset = '1') then
            LED_i <= '0';
        
        elsif (enable = '1') then 
            LED_i <= '1';
            
        else
            LED_i <= '0';
       
        end if;
        
    end process;
    
LED <= LED_i;

end Behavioral;
