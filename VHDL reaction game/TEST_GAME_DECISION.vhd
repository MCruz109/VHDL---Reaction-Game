library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TEST_GAME_DECISION is
    Port (   clk   : in std_logic;                                 
     en_clk    : in std_logic; --from push button          
     start_new_round : in std_logic; --not sure if we need 
     en_for_down_clk : in std_logic; 
     P1    : in std_logic;
     P2    : in std_logic;
     SYSTEM_RESET : in std_logic   ;
     SWITCH_FOR_TIME : in std_logic;                
     --------------------------------------
     P1_LED_WINNER_OF_ROUND : out std_logic;
     P2_LED_WINNER_OF_ROUND : out std_logic;
     
     P1_LED_WINNER_OF_GAME : out std_logic;
     P2_LED_WINNER_OF_GAME : out std_logic;
     
     Pass_Current_To_Prev_Winner : in std_logic;
     
      debugLED : out std_logic;    
     ---------------------------------------
     -- DEBUGGING
--     LED_STOP : OUT STD_LOGIC; --
--     LED_HOLD : OUT STD_LOGIC; --
--     LED_EN   : OUT STD_LOGIC; --
--     LED_EN_ALL : OUT STD_LOGIC;
     LED_END_GAME : OUT std_LOGIC;
     LED_SYSTEM_RESET              : OUT STD_LOGIC;
     
     LED_1:     out std_Logic;
     
     -- stdlogic outputs       
     CA    : out STD_LOGIC;    
     CB    : out STD_LOGIC;    
     CC    : out STD_LOGIC;    
     CD    : out STD_LOGIC;    
     CE    : out STD_LOGIC;    
     CF    : out STD_LOGIC;    
     CG    : out STD_LOGIC;    
     DP    : out STD_LOGIC;    
     AN1      : out STD_LOGIC; 
     AN2      : out STD_LOGIC; 
     AN3      : out STD_LOGIC; 
     AN4      : out STD_LOGIC  
     );   
end TEST_GAME_DECISION;

architecture Behavioral of TEST_GAME_DECISION is

signal out_dig1_i, out_dig2_i,out_dig3_i,out_dig4_i : std_logic_vector(3 downto 0);
signal state_of_scroll_i : std_logic_vector(3 downto 0);
signal time_dig1_i, time_dig2_i, time_dig3_i, time_dig4_i: std_logic_vector(3 downto 0);
signal scroll_value1_i, scroll_value2_i,scroll_value3_i,scroll_value4_i : std_logic_vector(3 downto 0);
signal enable_to_shift_i: std_logic;
signal end_game_i: std_logic;

component game_decision is
  Port ( clk                : in std_logic;                                 
         en_clk             : in std_logic; --from push button          
         start_new_round    : in std_logic; --not sure if we need 
         en_for_down_clk    : in std_logic;     
         p1, p2             : in std_logic;
         SYSTEM_RESET : IN STD_LOGIC;
         
         P1_LED_WINNER_OF_ROUND : out std_logic;
         P2_LED_WINNER_OF_ROUND : out std_logic;
         
         P1_LED_WINNER_OF_GAME : out std_logic; 
         P2_LED_WINNER_OF_GAME : out std_logic; 
         
         

         
--         LED_STOP : OUT STD_LOGIC; --
--         LED_HOLD : OUT STD_LOGIC; --
--         LED_EN   : OUT STD_LOGIC; --
--         LED_EN_ALL : OUT STD_LOGIC;
         LED_END_GAME : OUT std_LOGIC;
         LED_SYSTEM_RESET              : OUT STD_LOGIC;
         
         out_dig1 : out STD_LOGIC_VECTOR(3 downto 0); 
         out_dig2 : out STD_LOGIC_VECTOR(3 downto 0); 
         out_dig3 : out STD_LOGIC_VECTOR(3 downto 0); 
         out_dig4 : out STD_LOGIC_VECTOR(3 downto 0); 
                                            
         LED_1:     out std_Logic                                       
  );
end component;

component lcd_display is
  PORT ( 
        -- vector inputs
        dig1    : in  STD_LOGIC_VECTOR(3 downto 0);
        dig2    : in  STD_LOGIC_VECTOR(3 downto 0);
        dig3    : in  STD_LOGIC_VECTOR(3 downto 0);
        dig4    : in  STD_LOGIC_VECTOR(3 downto 0);
        -- stdlogic inputs
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        
        -- stdlogic outputs
        CA    : out STD_LOGIC;      
        CB    : out STD_LOGIC;      
        CC    : out STD_LOGIC;      
        CD    : out STD_LOGIC;      
        CE    : out STD_LOGIC;      
        CF    : out STD_LOGIC;      
        CG    : out STD_LOGIC;      
        DP    : out STD_LOGIC;      
        AN1      : out STD_LOGIC;
        AN2      : out STD_LOGIC;
        AN3      : out STD_LOGIC;
        AN4      : out STD_LOGIC
      );
end component;

component Clock_Divider_Scroll is
  Port ( 
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            enable_cd   : in  STD_LOGIC;        -- once end_game is on, enable_cd will be on
            
            state_of_scroll : out std_logic_vector(3 downto 0)
               
  );
end component;

component scrolling_screen is
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
end component;

component Time_Scrolling_Mux is
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
end component;

begin

CD_Scoll: Clock_Divider_Scroll 
  Port Map ( 
            clk         => clk,
            reset       => SYSTEM_RESET,
            enable_cd   => end_game_i,
            
            state_of_scroll => state_of_scroll_i
          
  );

Scroll_logic: scrolling_screen
Port Map ( 
    clk                      => clk,
    counter                  => state_of_scroll_i,
    end_game                 => end_game_i,
    reset                    => SYSTEM_RESET,
    scrolling_text_sec_dig1  => scroll_value1_i,
    scrolling_text_sec_dig2  => scroll_value2_i,
    scrolling_text_min_dig1  => scroll_value3_i,
    scrolling_text_min_dig2  => scroll_value4_i
);

SCROLL_MUX: Time_Scrolling_Mux
  Port Map (
          end_game      => end_game_i,
          switch        => SWITCH_FOR_TIME,              
          time_digit_1  => time_dig1_i,
          time_digit_2  => time_dig2_i,
          time_digit_3  => time_dig3_i,
          time_digit_4  => time_dig4_i,
          in_value_1    => scroll_value1_i,
          in_value_2    => scroll_value2_i,
          in_value_3    => scroll_value3_i,
          in_value_4    => scroll_value4_i,
                        
          out_value_1   => out_dig1_i,
          out_value_2   => out_dig2_i,
          out_value_3   => out_dig3_i,
          out_value_4   => out_dig4_i
  );


GAME_DEC: game_decision 
  Port MAP( clk                => clk,          
         en_clk             => en_clk,      
         start_new_round    => start_new_round,
         en_for_down_clk    => en_for_down_clk,
         p1                 => P1,
         p2                 => P2,
         
         SYSTEM_RESET => SYSTEM_RESET,         
                                                
         P1_LED_WINNER_OF_ROUND => P1_LED_WINNER_OF_ROUND,
         P2_LED_WINNER_OF_ROUND => P2_LED_WINNER_OF_ROUND,
                                                
         P1_LED_WINNER_OF_GAME => P1_LED_WINNER_OF_GAME, 
         P2_LED_WINNER_OF_GAME => P2_LED_WINNER_OF_GAME, 
         

         
--         LED_STOP => LED_STOP,
--         LED_HOLD => LED_HOLD,
--         LED_EN   => LED_EN  ,
--         LED_EN_ALL => LED_EN_ALL,
         LED_END_GAME => end_game_i,
         LED_SYSTEM_RESET              => LED_SYSTEM_RESET,
         
         out_dig1           => time_dig1_i,
         out_dig2           => time_dig2_i,
         out_dig3           => time_dig3_i,
         out_dig4           => time_dig4_i,                                           
         LED_1              => LED_1                                
  );

LCD: lcd_display
  PORT MAP( 
        -- vector inputs
        dig1    => out_dig1_i,
        dig2    => out_dig2_i,
        dig3    => out_dig3_i,
        dig4    => out_dig4_i,
        -- stdlogic inputs
        clk         => clk,
        reset       => start_new_round,
        
        -- stdlogic outputs
        CA    => CA  ,   
        CB    => CB  ,   
        CC    => CC  ,   
        CD    => CD  ,   
        CE    => CE  ,   
        CF    => CF  ,   
        CG    => CG  ,   
        DP    => DP  ,   
        AN1   => AN1 ,
        AN2   => AN2 ,
        AN3   => AN3 ,
        AN4   => AN4 
      );


LED_END_GAME <= end_game_i;

end Behavioral;
