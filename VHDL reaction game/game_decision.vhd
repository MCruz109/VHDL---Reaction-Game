-- CHECK END_GAME_I

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_decision is
  Port ( clk   : in std_logic;                                 
         en_clk    : in std_logic; --from push button          
         start_new_round : in std_logic; --not sure if we need 
         en_for_down_clk : in std_logic;     
         p1, p2 : in std_logic;
         
         SYSTEM_RESET : IN STD_LOGIC;
         --------------------------------------
         -- led for debugging
         
--         LED_STOP : OUT STD_LOGIC; --
--         LED_HOLD : OUT STD_LOGIC; --
--         LED_EN   : OUT STD_LOGIC; --
--         LED_EN_ALL : OUT STD_LOGIC;
         LED_END_GAME : OUT std_LOGIC;
         LED_SYSTEM_RESET              : OUT STD_LOGIC;
                        
         --------------------------------------
         -- led for storage
         P1_LED_WINNER_OF_ROUND : out std_logic;
         P2_LED_WINNER_OF_ROUND : out std_logic; 
         

    --     P1_ROUND_1 : OUT STD_LOGIC;
    --     P2_ROUND_1 : OUT STD_LOGIC;
    --     P1_ROUND_2 : OUT STD_LOGIC;
    --     P2_ROUND_2 : OUT STD_LOGIC;   
         P1_LED_WINNER_OF_GAME : out std_logic;
         P2_LED_WINNER_OF_GAME : out std_logic; 
         

         
         out_dig1 : out STD_LOGIC_VECTOR(3 downto 0); 
         out_dig2 : out STD_LOGIC_VECTOR(3 downto 0); 
         out_dig3 : out STD_LOGIC_VECTOR(3 downto 0); 
         out_dig4 : out STD_LOGIC_VECTOR(3 downto 0); 
                                                      
         LED_1:     out std_Logic                                       
  );
end game_decision;

architecture Behavioral of game_decision is

signal winner_i : std_logic_vector(1 downto 0);

signal stop_i : std_logic;
signal hold_i : std_logic;
--signal round_end_i : std_logic;
--signal winner_in_i : STD_LOGIC_vector( 1 downto 0);
signal end_game_i : STD_LOGIC;

signal player1_score_i  : std_logic_vector(1 downto 0);
signal player2_score_i  : std_logic_vector(1 downto 0);
Component Storage is
  Port ( 
      clk             : in STD_LOGIC;
      winner_in       : in STD_LOGIC_VECTOR (1 downto 0);
      
      player1_score   : out STD_LOGIC_VECTOR(1 downto 0);
      player2_score   : out STD_LOGIC_VECTOR(1 downto 0);
      system_reset         : in STD_LOGIC -- NEW top level switch
     -- compare_done    : out STD_LOGIC
      );
end component;

component game_timer is
    Port (   clk   : in std_logic;                                  
             en_clk    : in std_logic; --from push button               
             start_new_round : in std_logic; --not sure if we need  
             en_for_down_clk : in std_logic;
             STOP : in std_logic;
             hold : in std_logic;
             
--             LED_STOP : OUT STD_LOGIC; --
--             LED_HOLD : OUT STD_LOGIC; --
--             LED_EN   : OUT STD_LOGIC; --
--             LED_EN_ALL : OUT STD_LOGIC;
             
             out_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
             out_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
             out_dig3 : out STD_LOGIC_VECTOR(3 downto 0);
             out_dig4 : out STD_LOGIC_VECTOR(3 downto 0);
             
             LED_1:     out std_Logic                               
          );
end component;

component Decider is
    Port ( 
        p1, p2, en : in std_logic;
        stop_clk : in std_logic; 
        end_game : in std_logic; 
        start_new_round:     in std_logic;    
        SYSTEM_RESET:     in std_logic;       
        
        w : out std_logic_vector(1 downto 0);
        stop: out std_logic
    );
end component;

component ReactionTime is
 Port ( 
    --upcounter time
    clk : in std_logic;
    --Enable signal from decider
    en : in std_logic;
    reset : in std_logic;

    
    hold : out std_logic
);
end component;

component lap_register is
PORT ( 
          clk               : in STD_LOGIC;
          system_reset      : in STD_LOGIC;
          start_new_round   : in STD_LOGIC; -- pass current to prev on rising edge
          current_winner    : in  STD_LOGIC_VECTOR(1 downto 0);
          debugLED          : out std_logic;
          prev_winner       : out  STD_LOGIC_VECTOR(1 downto 0);
          Pass_Current_To_Prev_Winner : in std_logic

        );
end component;

component Display_Score is
  Port (
    p1_score      : in std_logic_vector(1 downto 0);
    p2_score      : in std_logic_vector(1 downto 0);
    
    end_game      : out std_logic;
    LED_Round_p1  : out std_logic;
    LED_Round_p2  : out std_logic;
    LED_Winner_p1 : out std_logic;
    LED_Winner_p2 : out std_logic
    
   );
end component;


begin

 Score: Display_Score
  Port Map (
    p1_score      => player1_score_i,
    p2_score      => player2_score_i,
    end_game      => end_game_i,
    LED_Round_p1  => P1_LED_WINNER_OF_ROUND, 
    LED_Round_p2  => P2_LED_WINNER_OF_ROUND,
    LED_Winner_p1 =>  P1_LED_WINNER_OF_GAME,
    LED_Winner_p2 =>  P2_LED_WINNER_OF_GAME
   );


STORE: Storage
    Port map( 
    clk            =>   clk,
    winner_in      =>   winner_i, 
    player1_score  =>    player1_score_i,
    player2_score  =>    player2_score_i,
    system_reset   =>  system_reset
    );
    


GAME_TIME: game_timer
    Port MAP (   clk            => clk,          
             en_clk             => en_clk,          
             start_new_round    => start_new_round,
             en_for_down_clk    => en_for_down_clk,
             STOP               => stop_i,
             hold               => hold_i,                   
             out_dig1           => out_dig1,
             out_dig2           => out_dig2,
             out_dig3           => out_dig3,
             out_dig4           => out_dig4,
                                
             LED_1              => LED_1           
          );

DECISION: Decider
    Port MAP( 
                p1 => P1, 
                p2 => P2, 
                en => en_clk, 
                stop_clk => hold_i, 
                end_game => end_game_i, 
                start_new_round  => start_new_round,
                SYSTEM_RESET    => SYSTEM_RESET,
                w  => winner_i,
                stop => stop_i
    );

REACT: ReactionTime 
 Port Map( 
    --upcounter time
    clk             => clk,
    --Enable signal from decider
    en              => stop_i,
    reset           => start_new_round,
    hold            => hold_i              
);

LED_SYSTEM_RESET <= SYSTEM_RESET;
LED_END_GAME <= end_game_i;

end Behavioral;
