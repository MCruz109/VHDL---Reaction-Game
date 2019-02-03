library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity scrolling_screen is
Port ( 
    clk : in std_logic;
    counter : in std_logic_vector(3 downto 0);
    end_game : in std_logic;
    reset : in std_logic;
    scrolling_text_sec_dig1   : out  STD_LOGIC_VECTOR(3 downto 0);
    scrolling_text_sec_dig2   : out  STD_LOGIC_VECTOR(3 downto 0);
    scrolling_text_min_dig1   : out  STD_LOGIC_VECTOR(3 downto 0);
    scrolling_text_min_dig2   : out  STD_LOGIC_VECTOR(3 downto 0)
);
end scrolling_screen;


architecture Behavioral of scrolling_screen is
   signal d, q  : STD_LOGIC_VECTOR(3 downto 0);
   signal count : STD_LOGIC_VECTOR(16 downto 0);
   signal q_sec_dig2_i : std_logic_vector(1 downto 0);
   signal q_min_dig1_i : std_logic_vector(1 downto 0);
   signal q_min_dig2_i : std_logic_vector(1 downto 0);
   signal q_sec_dig1_i : std_logic_vector(1 downto 0);
   
   signal d_sec_dig1_i : std_logic_vector(1 downto 0);
   signal d_sec_dig2_i : std_logic_vector(1 downto 0);
   signal d_min_dig1_i : std_logic_vector(1 downto 0);
   signal d_min_dig2_i : std_logic_vector(1 downto 0);



   
BEGIN
   
   process(counter, clk, end_game, reset)
   begin
    if reset = '1' then 
        scrolling_text_min_dig2 <= "1111";
        scrolling_text_min_dig1 <= "1111";
        scrolling_text_sec_dig2 <= "1111";
        scrolling_text_sec_dig1 <= "1111";
    elsif rising_edge(clk) and end_game = '1' then
        if counter = "0000" then
            scrolling_text_min_dig2 <= "1110";
            scrolling_text_min_dig1 <= "1011";
            scrolling_text_sec_dig2 <= "1100";
            scrolling_text_sec_dig1 <= "1010";
            
        elsif counter = "0001" then
              scrolling_text_min_dig2 <= "1010";
              scrolling_text_min_dig1 <= "1110";
              scrolling_text_sec_dig2 <= "1011";
              scrolling_text_sec_dig1 <= "1100";
              
        elsif counter = "0010" then
            scrolling_text_min_dig2 <= "1010";
            scrolling_text_min_dig1 <= "1010";
            scrolling_text_sec_dig2 <= "1110";
            scrolling_text_sec_dig1 <= "1011";
             
        elsif counter = "0011" then
          scrolling_text_min_dig2 <= "1010";
          scrolling_text_min_dig1 <= "1010";
          scrolling_text_sec_dig2 <= "1010";
          scrolling_text_sec_dig1 <= "1110";
          
        else
            scrolling_text_min_dig2 <= "1010";
            scrolling_text_min_dig1 <= "1010";
            scrolling_text_sec_dig2 <= "1010";
            scrolling_text_sec_dig1 <= "1010";
        end if;
    end if;
   end process;
   
END Behavioral;
