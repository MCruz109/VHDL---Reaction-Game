library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Time_Scrolling_Mux is
  Port ( 
          end_game         : in STD_LOGIC; 
          switch            : in STD_LOGIC;
          
          time_digit_1    : in  STD_LOGIC_VECTOR(3 downto 0);
          time_digit_2    : in  STD_LOGIC_VECTOR(3 downto 0);
          time_digit_3    : in  STD_LOGIC_VECTOR(3 downto 0);
          time_digit_4    : in  STD_LOGIC_VECTOR(3 downto 0);
          in_value_1   : in  STD_LOGIC_VECTOR(3 downto 0);
          in_value_2   : in  STD_LOGIC_VECTOR(3 downto 0);
          in_value_3   : in  STD_LOGIC_VECTOR(3 downto 0);
          in_value_4   : in  STD_LOGIC_VECTOR(3 downto 0);
          
          out_value_1   : out  STD_LOGIC_VECTOR(3 downto 0);      
          out_value_2   : out  STD_LOGIC_VECTOR(3 downto 0);      
          out_value_3     : out  STD_LOGIC_VECTOR(3 downto 0);    
          out_value_4   : out  STD_LOGIC_VECTOR(3 downto 0)      
  );
end Time_Scrolling_Mux;

architecture Behavioral of Time_Scrolling_Mux is
       
begin

    select_process : process(end_game,switch)
    begin
        
        if end_game = '1' and switch = '0' then
            out_value_1 <=  in_value_1;
            out_value_2 <=  in_value_2;
            out_value_3 <=  in_value_3;
            out_value_4 <=  in_value_4;
       
        else 
            out_value_1 <=  time_digit_1;   
            out_value_2 <=  time_digit_2;
            out_value_3 <=  time_digit_3;
            out_value_4 <=  time_digit_4;
            
        end if;
    
    end process;

end Behavioral;
