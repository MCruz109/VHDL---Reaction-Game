library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decider is
    Port ( 
        p1, p2, en : in std_logic;
        stop_clk : in std_logic;
        end_game : in std_logic;
        start_new_round:     in std_logic;
        SYSTEM_RESET:     in std_logic;
        
        w : out std_logic_vector(1 downto 0);
        stop: out std_logic
    );
end Decider;

architecture Behavioral of Decider is

signal enable_decider: std_logic;
signal stop_i : std_logic;
signal reset_stop_i: STD_LOGIC;
signal hold_winner_value: STD_LOGIC_VECTOR(1 downto 0);
signal hold_winner_value_in: STD_LOGIC_VECTOR(1 downto 0);
begin

process(p1, p2, stop_i, reset_stop_i, enable_decider, hold_winner_value, hold_winner_value_in)
begin
    if reset_stop_i = '1' then
    stop_i <= '0';
    hold_winner_value <= "11";
    hold_winner_value_in <= "11";

      
    elsif enable_decider = '1' then
        if p1 = '1' then
            hold_winner_value_in <= "01";
            hold_winner_value <= "01";
            --w <= "01";
            stop_i <= '1';
        elsif p2 = '1' then
            hold_winner_value_in <= "10";
            hold_winner_value <= "10";
            
            --w <= "10";
            stop_i <= '1';
        else
            stop_i <= '0';
            hold_winner_value_in <= "11";    
            hold_winner_value <= "11"; 
            --w    <= "11";
        end if;    
    
    elsif stop_i = '1' then
        if hold_winner_value_in = "01" then
            hold_winner_value <= "01";
            hold_winner_value_in <= "01"; 
            stop_i <= '1';
        
        elsif hold_winner_value_in = "10" then
            hold_winner_value_in <= "10";
            hold_winner_value <= "10";
            stop_i <= '1';            
        
--        else 
--            hold_winner_value <= "11";
--            stop_i <= '1';
            
     -- make sure winner is held
        end if;
    else
         stop_i <= '0'; 
         hold_winner_value    <= "11";
         hold_winner_value_in <= "11";
         
    end if;
end process;


w <= hold_winner_value;
reset_stop_i <= start_new_round or SYSTEM_RESET;
stop <= stop_i;
enable_decider <= en and (not stop_clk) and (not end_game);

end Behavioral;