-- This file needs editing by students
-- CHANGE ENABLE BACK
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity up_clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           stop     : in  STD_LOGIC;
           hold     : in  STD_LOGIC;
           
           
           
           sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
           );
end up_clock_divider;

architecture Behavioral of up_clock_divider is
-- Signals:
signal hundredhertz : STD_LOGIC;
signal onehertz, tensseconds, onesminutes, singlesec : STD_LOGIC; -- FOR RESETING TO ZERO
signal singleSeconds, singleMinutes : STD_LOGIC_VECTOR(3 downto 0); -- SENDS SIGNAL TO LCD
signal tenSeconds, tensMinutes : STD_LOGIC_VECTOR(3 downto 0); -- SENDS SIGNAL TO LCD
signal hold_fastest : std_logic; -- enable and stop
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
               period => 100_000, -- 100_000_000,   -- divide by 100_000_000 to divide 100 MHz down to 1 Hz 
               WIDTH  => 28 -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => hold_fastest,
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
               value  => singleSeconds -- binary value of seconds we decode to drive the 7-segment display        
            );
   
-- Students fill in the VHDL code between these two lines
-- The missing code is instantiations of upcounter (like above) as needed.
-- Take a hint from the clock_divider entity description's port map.
--==============================================
    tenSecondsClock: upcounter
    generic map(
               period => (9),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
    PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => singlesec,
               zero   => tensseconds,
               value  => tenSeconds -- binary value of seconds we decode to drive the 7-segment display        
            );
            
    singleMinutesClock: upcounter
               generic map(
                           period => (9),   -- Counts numbers between 0 and 9 -> that's 10 values!
                           WIDTH  => 4
                          )
               PORT MAP (
                           clk    => clk,
                           reset  => reset,
                           enable => tensseconds,
                           zero   => onesminutes,
                           value  => singleMinutes -- binary value of seconds we decode to drive the 7-segment display        
                        ); 
                        
    TenMinutesClock: upcounter
                generic map(
                            period => (9),   -- Counts numbers between 0 and 9 -> that's 10 values!
                            WIDTH  => 4
                            )
               PORT MAP (
                             clk    => clk,
                             reset  => reset,
                             enable => onesminutes,
                             zero   => open,
                             value  => tensMinutes -- binary value of seconds we decode to drive the 7-segment display        
                              );
                             
--============================================== 
   
   -- Connect internal signals to outputs
   sec_dig1 <= singleSeconds;
   
-- Students fill in the VHDL code between these two lines
-- The missing code is internal signal conections to outputs as needed, following the pattern of the previous statement.
-- Take a hint from the signal declarartions below architecture.
-- ==============================================
    sec_dig2 <= tenSeconds;
    min_dig1 <= singleMinutes;
    min_dig2 <= tensMinutes;
    hold_fastest <= enable and (not stop) and (not hold);
-- ============================================== 
   
END Behavioral;
   