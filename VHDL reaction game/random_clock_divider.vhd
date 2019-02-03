-- This file needs editing by students

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity random_clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;

           sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0)
           );
end random_clock_divider;

architecture Behavioral of random_clock_divider is
-- Signals:
signal hundredhertz : STD_LOGIC;
signal onehertz,  singlesec : STD_LOGIC; -- FOR RESETING TO ZERO
signal singleSeconds : STD_LOGIC_VECTOR(3 downto 0); -- SENDS SIGNAL TO LCD
-- Components declarations
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
               period => 10,   -- divide by 100_000_000 to divide 100 MHz down to 1 Hz 
               WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable,
               zero   => onehertz,      -- this is a 1 Hz clock signal
               value  => open           -- Leave open since we won't display this value
            );
   
   singleSecondsClock: upcounter
   generic map(
               period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => onehertz,
               zero   => singlesec,
               value  => sec_dig1 -- binary value of seconds we decode to drive the 7-segment display        
            );
   
   -- Connect internal signals to outputs
--   sec_dig1 <= singleSeconds;

END Behavioral;