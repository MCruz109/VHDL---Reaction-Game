----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2018 01:23:56 PM
-- Design Name: 
-- Module Name: Display_Score - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Display_Score is
  Port (
    p1_score      : in std_logic_vector(1 downto 0);
    p2_score      : in std_logic_vector(1 downto 0);
    
    end_game      : out std_logic;
    LED_Round_p1  : out std_logic;
    LED_Round_p2  : out std_logic;
    LED_Winner_p1 : out std_logic;
    LED_Winner_p2 : out std_logic
    
   );
end Display_Score;

architecture Behavioral of Display_Score is
signal LED_Round_p1_i  : std_logic;
signal LED_Round_p2_i  : std_logic;
signal LED_Winner_p1_i : std_logic;
signal LED_Winner_p2_i : std_logic;
signal end_game_i_p1 : std_logic;
signal end_game_i_p2 : std_logic;
signal end_game_i : std_logic;
begin

p1_score_process : process(p1_score)
begin
    if p1_score = "00" then
        LED_Round_p1_i <= '0';
        LED_Winner_p1_i <= '0';
        end_game_i_p1 <= '0';
    elsif  p1_score = "01" then 
       LED_Round_p1_i <= '1';
       LED_Winner_p1_i <= '0';  
       end_game_i_p1 <= '0';
    elsif  p1_score = "10" then  
        LED_Round_p1_i <= '1';
        LED_Winner_p1_i <= '1';  
        end_game_i_p1 <= '1';
    else
        LED_Round_p1_i <= '0';
        LED_Winner_p1_i <= '0';
        end_game_i_p1 <= '0';    
    end if;
end process;

p2_score_process : process(p2_score)
begin
    if p2_score = "00" then
        LED_Round_p2_i <= '0';
        LED_Winner_p2_i <= '0';
        end_game_i_p2 <= '0';
    elsif  p2_score = "01" then 
       LED_Round_p2_i <= '1';
       LED_Winner_p2_i <= '0';  
       end_game_i_p2 <= '0';
    elsif  p2_score = "10" then  
        LED_Round_p2_i <= '1';
        LED_Winner_p2_i <= '1';  
        end_game_i_p2 <= '1';
    else
        LED_Round_p2_i <= '0';
        LED_Winner_p2_i <= '0';
        end_game_i_p2 <= '0';    
    end if;
end process;

end_game_i <= end_game_i_p1 or end_game_i_p2;
end_game      <= end_game_i     ;
LED_Round_p1  <= LED_Round_p1_i ;
LED_Round_p2  <= LED_Round_p2_i ;
LED_Winner_p1 <= LED_Winner_p1_i;
LED_Winner_p2 <= LED_Winner_p2_i;


end Behavioral;
