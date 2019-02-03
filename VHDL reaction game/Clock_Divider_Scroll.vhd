library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Clock_Divider_Scroll is
  Port ( 
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            enable_cd   : in  STD_LOGIC;        -- once end_game is on, enable_cd will be on
            
            state_of_scroll : out STD_LOGIC_vector (3 downto 0)
                  
  );
end Clock_Divider_Scroll;

architecture Behavioral of Clock_Divider_Scroll is


signal onehertz, singlesec: STD_LOGIC; -- FOR RESETING TO ZERO 

component upcounter is                                           
   Generic ( period : integer:= 4;                               
             WIDTH  : integer:= 3                                
           );                                                    
      PORT (  clk    : in  STD_LOGIC;                            
              reset  : in  STD_LOGIC;                            
              enable : in  STD_LOGIC;                            
              zero   : out STD_LOGIC;                            
              value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)    
           );                                                    
end component;         

BEGIN                                                                                                             
                                                                                                                  
   oneHzClock: upcounter
generic map(
            period => 100_000_000, -- 100_000_000,   -- divide by 100_000_000 to divide 100 MHz down to 1 Hz 
            WIDTH  => 28 -- 28 bits are required to hold the binary value of 101111101011110000100000000
           )
PORT MAP (
            clk    => clk,
            reset  => reset,
            enable => enable_cd,
            zero   => onehertz,      -- this is a 1 Hz clock signal
            value  => open           -- Leave open since we won't display this value
         );

singleSecondsClock: upcounter
generic map(
            period => (5),   -- Counts numbers between 0 and 9 -> that's 10 values!
            WIDTH  => 4
           )
PORT MAP (
            clk    => clk,
            reset  => reset,
            enable => onehertz,
            zero   => singlesec,
            value  => state_of_scroll -- binary value of seconds we decode to drive the 7-segment display        
         );
         
                                                                                                           
                                                                                                        
                                                                                            
end Behavioral;
