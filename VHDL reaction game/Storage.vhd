library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity Storage is
  Port ( 
        clk             : in STD_LOGIC;
        winner_in       : in STD_LOGIC_VECTOR (1 downto 0);
        system_reset    : in STD_LOGIC; -- NEW top level switch
        
        player1_score   : out STD_LOGIC_VECTOR(1 downto 0);
        player2_score   : out STD_LOGIC_VECTOR(1 downto 0)
       -- compare_done    : out STD_LOGIC
        );
end Storage;

architecture Behavioral of Storage is

  component upcounter is
     Generic ( period : integer:= 4;
               WIDTH  : integer:= 2
             );
        PORT (  clk    : in  STD_LOGIC;
                reset  : in  STD_LOGIC;
                enable : in  STD_LOGIC;
                zero   : out STD_LOGIC;
                value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
             );
  end component; 

signal reset : STD_LOGIC;
signal player1_scorei, player2_scorei : STD_LOGIC_VECTOR(1 downto 0);
signal D1, Q1, D2, Q2 : STD_LOGIC;
signal player1_score_en, player2_score_en : STD_LOGIC;

begin

player1_score_increment :process(clk, reset, D1) 
         begin
           if (reset = '1') then
               Q1 <='0';
           else 
              if (rising_edge(clk))then 
               Q1 <= D1;
              end if;
           end if;
         end process;  
            
        D1<= not winner_in(1);
        player1_score_en <= D1 and not Q1;
 
 player2_score_increment :process(clk, reset, D2) 
                 begin
                   if (reset = '1') then
                       Q2 <='0';
                   else 
                      if (rising_edge(clk))then 
                       Q2 <= D2;
                      end if;
                   end if;
                 end process;  
                    
                D2<= not winner_in(0);
                player2_score_en <= D2 and not Q2;
        
    player1_scoreXD: upcounter
        generic map(
                    period => (3),   -- divide by 100_000_000 to divide 100 MHz down to 1 Hz (scaled down to 100 Hz)
                    WIDTH  => 2             -- 28 bits are required to hold the binary value of 101111101011110000100000000
                   )
        PORT MAP (
                    clk    => clk,
                    reset  => reset,
                    enable => player1_score_en,
                    zero   => open, -- this is a 1 Hz clock signal
                    value  => player1_scorei  -- Leave open since we won't display this value
                 );     
        
        
       player2_scoreXD: upcounter
              generic map(
                          period => (3),   -- divide by 100_000_000 to divide 100 MHz down to 1 Hz (scaled down to 100 Hz)
                          WIDTH  => 2             -- 28 bits are required to hold the binary value of 101111101011110000100000000
                         )
              PORT MAP (
                          clk    => clk,
                          reset  => reset,
                          enable => player2_score_en,
                          zero   => open, -- this is a 1 Hz clock signal
                          value  => player2_scorei  -- Leave open since we won't display this value
                       );  
        
        
        

  process (winner_in, system_reset)
     begin
        if (system_reset = '1') then
--            player1_scorei <= "00";
--            player2_scorei <= "00";
            reset <= '1'; 
        elsif system_reset = '0' then
            reset <= '0';        
        end if;
     end process;
     
player1_score <= player1_scorei;
player2_score <= player2_scorei;
end Behavioral;
