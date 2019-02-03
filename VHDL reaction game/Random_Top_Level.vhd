library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Random_Top_Level is
    Port (  
            -- stdlogic inputs
            clk   : in std_logic;                          
            en_clk    : in std_logic; --from push button 
            start_new_round : in std_logic; --not sure if we need  
            en_for_down_clk : in std_logic; --enables the countdown timer
            
            -- stdlogic outputs        
            out_dig1 : out std_logic_vector(3 downto 0);
            out_dig2 : out std_logic_vector(3 downto 0);
            out_dig3 : out std_logic_vector(3 downto 0);
            out_dig4 : out std_logic_vector(3 downto 0)     
          );
end Random_Top_Level;

architecture Behavioral of Random_Top_Level is
--- signals
------------------------------------------------------
--for random
signal set_i : std_logic;
signal out_sec_i : std_logic_vector(3 downto 0);
signal out_dig1_i, out_dig2_i,out_dig3_i,out_dig4_i : std_logic_vector(3 downto 0);

-- components
------------------------------------------------------
component down_clock_divider is
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
end component;

component RandomNumber is
 Port ( 
   clk          : in std_logic;
   en_clk    : in std_logic; --from push button
   new_random        : in std_logic; --not sure if we need
   
              
   set          : out STD_LOGIC; --sets countdown value on rising edge
   out_sec      : out std_logic_vector(3 downto 0)
);
end component;

BEGIN 

    RAND: RandomNumber
    PORT MAP (      clk         => clk,
                    en_clk   => en_clk ,
                    new_random      => start_new_round,
                                
                    set         => set_i,
                    out_sec     => out_sec_i
                    );

    DOWN_CD : down_clock_divider
    PORT MAP (      clk       => clk,
                    reset     => '0',--start_new_round,
                    enable    => en_for_down_clk,
                    SET       => set_i,
                    i_dig1    => out_sec_i,
                    i_dig2    => out_sec_i,
                    i_dig3    => out_sec_i,
                    i_dig4    => out_sec_i,
                    sec_dig1  => out_dig1_i,
                    sec_dig2  => out_dig2_i,
                    min_dig1  => out_dig3_i,
                    min_dig2  => out_dig4_i
                    );
---------------------------------------------------
-- connect internals
    out_dig1 <= out_dig1_i;
    out_dig2 <= out_dig2_i;
    out_dig3 <= out_dig3_i;
    out_dig4 <= out_dig4_i; 

end Behavioral;
