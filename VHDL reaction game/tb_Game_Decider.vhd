library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity game_decision_tb is
end;

architecture bench of game_decision_tb is

  component game_decision
    Port ( clk   : in std_logic;                                 
           en_clk    : in std_logic;
           start_new_round : in std_logic;
           en_for_down_clk : in std_logic;     
           p1, p2 : in std_logic;
           SYSTEM_RESET : IN STD_LOGIC;
           LED_END_GAME : OUT std_LOGIC;
           LED_SYSTEM_RESET              : OUT STD_LOGIC;
           P1_LED_WINNER_OF_ROUND : out std_logic;
           P2_LED_WINNER_OF_ROUND : out std_logic;
           P1_LED_WINNER_OF_GAME : out std_logic;
           P2_LED_WINNER_OF_GAME : out std_logic; 
           out_dig1 : out STD_LOGIC_VECTOR(3 downto 0); 
           out_dig2 : out STD_LOGIC_VECTOR(3 downto 0); 
           out_dig3 : out STD_LOGIC_VECTOR(3 downto 0); 
           out_dig4 : out STD_LOGIC_VECTOR(3 downto 0); 
           LED_1:     out std_Logic                                       
    );
  end component;

  signal clk: std_logic;
  signal en_clk: std_logic;
  signal start_new_round: std_logic;
  signal en_for_down_clk: std_logic;
  signal p1, p2: std_logic;
  signal SYSTEM_RESET: STD_LOGIC;
  signal LED_END_GAME: std_LOGIC;
  signal LED_SYSTEM_RESET: STD_LOGIC;
  signal P1_LED_WINNER_OF_ROUND: std_logic;
  signal P2_LED_WINNER_OF_ROUND: std_logic;
  signal P1_LED_WINNER_OF_GAME: std_logic;
  signal P2_LED_WINNER_OF_GAME: std_logic;
  signal out_dig1: STD_LOGIC_VECTOR(3 downto 0);
  signal out_dig2: STD_LOGIC_VECTOR(3 downto 0);
  signal out_dig3: STD_LOGIC_VECTOR(3 downto 0);
  signal out_dig4: STD_LOGIC_VECTOR(3 downto 0);
  signal LED_1: std_Logic ;

   constant clk_period : time := 4 ns;

begin

   clk_process :process
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process;
 

  uut: game_decision port map ( clk                    => clk,
                                en_clk                 => en_clk,
                                start_new_round        => start_new_round,
                                en_for_down_clk        => en_for_down_clk,
                                p1                     => p1,
                                p2                     => p2,
                                SYSTEM_RESET           => SYSTEM_RESET,
                                LED_END_GAME           => LED_END_GAME,
                                LED_SYSTEM_RESET       => LED_SYSTEM_RESET,
                                P1_LED_WINNER_OF_ROUND => P1_LED_WINNER_OF_ROUND,
                                P2_LED_WINNER_OF_ROUND => P2_LED_WINNER_OF_ROUND,
                                P1_LED_WINNER_OF_GAME  => P1_LED_WINNER_OF_GAME,
                                P2_LED_WINNER_OF_GAME  => P2_LED_WINNER_OF_GAME,
                                out_dig1               => out_dig1,
                                out_dig2               => out_dig2,
                                out_dig3               => out_dig3,
                                out_dig4               => out_dig4,
                                LED_1                  => LED_1 );

  stimulus: process
  begin
  
    P2 <= '0';
    P1 <= '0';
  
    -- Put initialisation code here
    system_reset <= '1';
    wait for 10 ns;
    
    system_reset <= '0';
    en_clk <= '1';
    en_for_down_clk <= '1';
    wait for 10 ns;
    
    start_new_round <= '1';
    wait for 10 ns;
    
    start_new_round <= '0';
    wait for 100 ns;
    
    
    P1 <= '1';
    wait for 10 ns;
    P1 <= '0';
    
    
    start_new_round <= '1';
    wait for 10 ns;
    
    start_new_round <= '0';
    wait for 100 ns;
    
    P1 <= '1';
        wait for 10 ns;
        P1 <= '0';
    
    -- Put test bench stimulus code here

    wait;
  end process;


end;