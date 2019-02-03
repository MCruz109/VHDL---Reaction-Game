library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ReactionTime is
 Port ( 
    --upcounter time
    clk         : in std_logic;

    --Enable signal from decider
    en : in std_logic;
    reset: in std_logic;
    
   -- winner: in std_logic_vector(1 downto 0);
    
    hold            : out std_logic
);

end ReactionTime;

architecture Behavioral of ReactionTime is

--signal sec_i         : std_logic_vector(3 downto 0);
--signal tenth_sec_i   : std_logic_vector(3 downto 0);
--signal mill_i       : std_logic_vector(3 downto 0);--winner, wait for 2 
--signal tenth_mill_i  :  std_logic_vector(3 downto 0);--winning time, wait for 2
signal en_i : std_logic;

begin

--overall score
start : process(clk, en, reset, en_i)
begin
if rising_edge(clk) then
--Write time on rising en edge and holds
        if reset = '1' then
        en_i <= '0';
           
        elsif en = '1' then                            
        en_i         <= '1';
        
        elsif en_i = '1' then
        en_i        <= '1';
    
        else
        en_i        <= '0';
        
    end if;
end if;
end process;

 hold           <= en_i        ;

end Behavioral;
