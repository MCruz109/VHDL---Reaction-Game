-- This file needs editing by students

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity down_clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           SET      : in STD_LOGIC;
           i_dig1   : in STD_LOGIC_VECTOR(3 downto 0);
           i_dig2   : in STD_LOGIC_VECTOR(3 downto 0);
           i_dig3   : in STD_LOGIC_VECTOR(3 downto 0);
           i_dig4   : in STD_LOGIC_VECTOR(3 downto 0);
           sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
           );
end down_clock_divider;

architecture Behavioral of down_clock_divider is
-- Signals:
signal hundredhertz : STD_LOGIC;
signal onehertz, tensseconds, onesminutes, singlesec : STD_LOGIC; -- FOR RESETING TO ZERO
signal singleSeconds, singleMinutes : STD_LOGIC_VECTOR(3 downto 0); -- SENDS SIGNAL TO LCD
signal tenSeconds, tensMinutes : STD_LOGIC_VECTOR(3 downto 0); -- SENDS SIGNAL TO LCD
-- Components declarations
component downcounter is
   Generic ( period : integer:= 4;
             WIDTH  : integer:= 28
           );
      PORT (  clk    : in  STD_LOGIC;
              reset  : in  STD_LOGIC;
              enable : in  STD_LOGIC;
              zero   : out STD_LOGIC;
              value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
              init   : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
              SET    : in STD_LOGIC
           );
end component;

component downcounter0 is
  Generic ( period: integer:= 4;       
            WIDTH  : integer:= 3
		  );
    PORT ( clk    : in  STD_LOGIC;
           reset  : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           zero   : out STD_LOGIC;
           value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
         );
end component;


BEGIN
   
   oneHzClock: downcounter0
   generic map(
               period =>  100_000,   -- divide by 100_000_000 to divide 100 MHz down to 1 Hz 
               WIDTH  => 28 -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable,
               zero   => onehertz,      -- this is a 1 Hz clock signal
               value  => open        -- Leave open since we won't display this value
            );
   
   singleSecondsClock: downcounter
   generic map(
               period => (9),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               set => set,
               enable => onehertz,
               zero   => singlesec,
               value  => singleSeconds, -- binary value of seconds we decode to drive the 7-segment display 
               init   => i_dig1       
            );
   
-- Students fill in the VHDL code between these two lines
-- The missing code is instantiations of upcounter (like above) as needed.
-- Take a hint from the clock_divider entity description's port map.
--==============================================
    tenSecondsClock: downcounter
    generic map(
               period => (9),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
    PORT MAP (
               clk    => clk,
               reset  => reset,
               set => set,
               enable => singlesec,
               zero   => tensseconds,
               value  => tenSeconds, -- binary value of seconds we decode to drive the 7-segment display  
               init   => i_dig2      
            );
            
    singleMinutesClock: downcounter
               generic map(
                           period => (9),   -- Counts numbers between 0 and 9 -> that's 10 values!
                           WIDTH  => 4
                          )
               PORT MAP (
                           clk    => clk,
                           reset  => reset,
                           set => set,
                           enable => tensseconds,
                           zero   => onesminutes,
                           value  => singleMinutes, -- binary value of seconds we decode to drive the 7-segment display  
                           init   => i_dig3    
                        ); 
                        
    TenMinutesClock: downcounter
                generic map(
                            period => (9),   -- Counts numbers between 0 and 9 -> that's 10 values!
                            WIDTH  => 4
                            )
               PORT MAP (
                             clk    => clk,
                             reset  => reset,
                             set => set,
                             enable => onesminutes,
                             zero   => open,
                             value  => tensMinutes, -- binary value of seconds we decode to drive the 7-segment display    
                             init   => i_dig4    
                              );
     
                             
--============================================== 
   
   -- Connect internal signals to outputs
    sec_dig1 <= singleSeconds;
    sec_dig2 <= tenSeconds;
    min_dig1 <= singleMinutes;
    min_dig2 <= tensMinutes;
    
-- ============================================== 
   
END Behavioral;
