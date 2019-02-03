library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Storage_tb is
end;

architecture bench of Storage_tb is

  component Storage
      Port ( 
      system_reset              : in std_logic;
      round_end                 : in std_logic;
      winner_in                     : in std_logic_vector(1 downto 0);
      clk                        : in STD_LOGIC; 
      p1_winner_of_round_out        : out std_logic;
      p2_winner_of_round_out        : out std_logic;
      end_game                      : out std_logic;
      LED_SYSTEM_RESET              : OUT STD_LOGIC;
      p1_winner_of_game_out         : out std_logic;
      p2_winner_of_game_out         : out std_logic
      );
  end component;

  signal system_reset: std_logic;
  signal round_end: std_logic;
  signal winner_in: std_logic_vector(1 downto 0);
  signal clk: STD_LOGIC;
  signal p1_winner_of_round_out: std_logic;
  signal p2_winner_of_round_out: std_logic;
  signal end_game: std_logic;
  signal LED_SYSTEM_RESET: STD_LOGIC;
  signal p1_winner_of_game_out: std_logic;
  signal p2_winner_of_game_out: std_logic ;

begin

  uut: Storage port map ( system_reset           => system_reset,
                          round_end              => round_end,
                          winner_in              => winner_in,
                          clk                    => clk,
                          p1_winner_of_round_out => p1_winner_of_round_out,
                          p2_winner_of_round_out => p2_winner_of_round_out,
                          end_game               => end_game,
                          LED_SYSTEM_RESET       => LED_SYSTEM_RESET,
                          p1_winner_of_game_out  => p1_winner_of_game_out,
                          p2_winner_of_game_out  => p2_winner_of_game_out );

  stimulus: process
  begin
    wait for 10 ns;
    -- Put initialisation code here
    system_reset            <= '1';
    round_end               <= '0';
    winner_in               <= "11";
   
   -- Put test bench stimulus code here
    wait for 10 ns;
    system_reset <= '0';
    
    wait for 10 ns;
    
    round_end    <= '1';
    winner_in    <= "01";
    
    wait for 10 ns; 
    round_end <= '0';
    
    wait for 10 ns;
    round_end <= '1';
    winner_in <= "10";
    
    wait for 10 ns;
    round_end <= '0';
    
    wait for 10 ns;                
    round_end <= '1'; 
    winner_in <= "01";
    
    wait for 10 ns;
    round_end <= '0';
    
    wait for 10 ns;                
    round_end <= '1'; 
    winner_in <= "01";
    
    wait for 10 ns;
    round_end <= '0';
    
    
    wait;
  end process;


end;