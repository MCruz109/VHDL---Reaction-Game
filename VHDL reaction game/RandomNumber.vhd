library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RandomNumber is
 Port ( 
   clk : in std_logic;
   en_clk : in std_logic; --Starts clock
   new_random : std_logic; --Outputs a new random on rising edge
   --new_round : in std_logic; --not sure if we need
              
   set : out STD_LOGIC; --sets countdown value on rising edge, may not need
   out_sec : out std_logic_vector(3 downto 0)
);
end RandomNumber;

architecture Behavioral of RandomNumber is

signal sec_dig1_i : STD_LOGIC_VECTOR(3 downto 0);

--Rising edge circuit signals
signal rising_new_random_edge : std_logic; 
signal Q    : std_logic;
signal D    : std_logic;


component random_clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0)   
         );
end component;

begin   
   DIVIDER : random_clock_divider
   PORT MAP( 
             clk   => clk,
             sec_dig1   => sec_dig1_i,
             enable =>  en_clk,
             reset => '0'
           );  
           
    process(rising_new_random_edge)
    begin
        if rising_new_random_edge = '1' then
            
            out_sec <= '0' & sec_dig1_i(2) & sec_dig1_i(1) & '1';
            set <= '1';
        else
            
            set <= '0';
        end if;
    end process; 
    
    process( clk, new_random) --Make rising_new_random_edge 1 on rising new_random edge
    begin
       -- if new_round = '1' then
         --   Q <= '0';   
        if rising_edge(clk) then
            Q <= D;
        end if;
         
    end process;
    
rising_new_random_edge <= new_random and (not Q);
D <= new_random; 
       
end Behavioral;
