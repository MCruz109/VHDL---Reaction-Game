library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_timer is
    Port (   clk   : in std_logic;                                  
             en_clk    : in std_logic; --from push button               
             start_new_round : in std_logic; --not sure if we need  
             en_for_down_clk : in std_logic;
             STOP: in std_logic;
             hold: in std_logic;
             
--             LED_STOP : OUT STD_LOGIC; --
--             LED_HOLD : OUT STD_LOGIC; --
--             LED_EN   : OUT STD_LOGIC; --
--             LED_EN_ALL : OUT STD_LOGIC;
             
             out_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
             out_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
             out_dig3 : out STD_LOGIC_VECTOR(3 downto 0);
             out_dig4 : out STD_LOGIC_VECTOR(3 downto 0);
             
             LED_1:     out std_Logic                               
          );
end game_timer;



architecture Behavioral of game_timer is

signal send_start_i : std_logic;
signal dig1_i, dig2_i,dig3_i,dig4_i : std_logic_vector(3 downto 0);

component Random_Top_Level is
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
end component;

component start_round is
    Port ( dig1 : in STD_LOGIC_VECTOR (3 downto 0);
           dig2 : in STD_LOGIC_VECTOR (3 downto 0);
           dig3 : in STD_LOGIC_VECTOR (3 downto 0);
           dig4 : in STD_LOGIC_VECTOR (3 downto 0);
--           dig_out1 : out STD_LOGIC_VECTOR (3 downto 0);
--           dig_out2 : out STD_LOGIC_VECTOR (3 downto 0);
--           dig_out3 : out STD_LOGIC_VECTOR (3 downto 0);
--           dig_out4 : out STD_LOGIC_VECTOR (3 downto 0);
           
           E : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in STD_LOGIC;
           send_start : out STD_LOGIC);
end component;

component up_clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           stop     : in  STD_LOGIC;
           hold     : in  STD_LOGIC;
           
--           LED_STOP : OUT STD_LOGIC; --
--           LED_HOLD : OUT STD_LOGIC; --
--           LED_EN   : OUT STD_LOGIC; --
--           LED_EN_ALL : OUT STD_LOGIC;

           sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
           );
end component;

component visual_start is
    Port ( enable : in STD_LOGIC;
           reset  : in STD_LOGIC;
           LED : out STD_LOGIC);
end component;

begin

RAND_MOD: Random_Top_Level
    Port Map(                                                                 
            -- stdlogic inputs                                             
            clk             => clk,           
            en_clk          => en_clk,      
            start_new_round => start_new_round,
            en_for_down_clk => en_for_down_clk,
                                                                           
            -- stdlogic outputs                                            
            out_dig1 => dig1_i,                  
            out_dig2 => dig2_i,                  
            out_dig3 => dig3_i,                   
            out_dig4 => dig4_i                  
          );                                                               

START_MOD: start_round                               
    Port Map (  dig1 =>  dig1_i,      
                dig2 =>  dig2_i,      
                dig3 =>  dig3_i,      
                dig4 =>  dig4_i,       
--           dig_out1 : out STD_LOGIC_VECTOR (3 downto 0);
--           dig_out2 : out STD_LOGIC_VECTOR (3 downto 0);
--           dig_out3 : out STD_LOGIC_VECTOR (3 downto 0);
--           dig_out4 : out STD_LOGIC_VECTOR (3 downto 0);
                                                          
                E           => en_clk,                             
                reset       => start_new_round,                        
                clk         => clk,   
                                       
                send_start  => send_start_i
                
                );                   
                                         
UP_MOD: up_clock_divider
    PORT MAP ( clk      => clk,
           reset        => start_new_round,
           enable       => send_start_i,
           stop         => STOP,
           hold         => hold,
           
--           LED_STOP => LED_STOP,
--           LED_HOLD => LED_HOLD,
--           LED_EN   => LED_EN  ,
--           LED_EN_ALL => LED_EN_ALL,

           sec_dig1     => out_dig1,
           sec_dig2     => out_dig2,
           min_dig1     => out_dig3,
           min_dig2     => out_dig4
           );

LED_ON: visual_start
    Port Map (  enable  => send_start_i,
                reset   => start_new_round,
                LED     => LED_1
                );

end Behavioral;
