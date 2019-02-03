library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TEST_RANDOM_MODULE is
    Port ( 
            -- stdlogic inputs                                     
            clk   : in std_logic;                                  
            en    : in std_logic; --from push button               
            start_new_round : in std_logic; --not sure if we need  
            en_for_down : in std_logic;
            
            -- stdlogic outputs            
            CA    : out STD_LOGIC;         
            CB    : out STD_LOGIC;         
            CC    : out STD_LOGIC;         
            CD    : out STD_LOGIC;         
            CE    : out STD_LOGIC;         
            CF    : out STD_LOGIC;         
            CG    : out STD_LOGIC;         
            DP    : out STD_LOGIC;         
            AN1      : out STD_LOGIC;      
            AN2      : out STD_LOGIC;      
            AN3      : out STD_LOGIC;      
            AN4      : out STD_LOGIC       
            );
end TEST_RANDOM_MODULE;

architecture Behavioral of TEST_RANDOM_MODULE is
-----------------------------------------------------
--for random
signal set_i : std_logic;
signal out_sec_i : std_logic_vector(3 downto 0);
signal out_dig1_i, out_dig2_i,out_dig3_i,out_dig4_i : std_logic_vector(3 downto 0);


------------------------------------------------------
component lcd_display is
  PORT ( 
        -- vector inputs
        dig1    : in  STD_LOGIC_VECTOR(3 downto 0);
        dig2    : in  STD_LOGIC_VECTOR(3 downto 0);
        dig3    : in  STD_LOGIC_VECTOR(3 downto 0);
        dig4    : in  STD_LOGIC_VECTOR(3 downto 0);
        -- stdlogic inputs
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        
        -- stdlogic outputs
        CA    : out STD_LOGIC;      
        CB    : out STD_LOGIC;      
        CC    : out STD_LOGIC;      
        CD    : out STD_LOGIC;      
        CE    : out STD_LOGIC;      
        CF    : out STD_LOGIC;      
        CG    : out STD_LOGIC;      
        DP    : out STD_LOGIC;      
        AN1      : out STD_LOGIC;
        AN2      : out STD_LOGIC;
        AN3      : out STD_LOGIC;
        AN4      : out STD_LOGIC
      );
end component;

component Random_Top_Level is
    Port (  
            -- stdlogic inputs
            clk   : in std_logic;                          
            en_clk    : in std_logic; --from push button 
            start_new_round : in std_logic; --not sure if we need  
            en_for_down_clk : in std_logic;
            
            -- stdlogic outputs        
            out_dig1 : out std_logic_vector(3 downto 0);
            out_dig2 : out std_logic_vector(3 downto 0);
            out_dig3 : out std_logic_vector(3 downto 0);
            out_dig4 : out std_logic_vector(3 downto 0)     
          );
end component;

begin

RAND_MODULE: Random_Top_Level
Port Map(  
            -- stdlogic inputs
            clk             => clk,                  
            en_clk              => en,
            start_new_round => start_new_round,  
            en_for_down_clk     => en_for_down,
            
            -- stdlogic outputs        
            out_dig1 => out_dig1_i,
            out_dig2 => out_dig2_i,
            out_dig3 => out_dig3_i,
            out_dig4 => out_dig4_i    
          );

LCD: lcd_display
 PORT MAP(                                                      
       -- vector inputs                                      
       dig1  => out_dig1_i,
       dig2  => out_dig2_i,
       dig3  => out_dig3_i,
       dig4  => out_dig4_i, 
       -- stdlogic inputs                                    
       clk   => clk,                          
       reset => start_new_round,                          

       -- stdlogic outputs                                   
       CA  => CA  ,                          
       CB  => CB  ,                       
       CC  => CC  ,                       
       CD  => CD  ,                       
       CE  => CE  ,                       
       CF  => CF  ,                       
       CG  => CG  ,                       
       DP  => DP  ,                       
       AN1 => AN1 ,                       
       AN2 => AN2 ,                       
       AN3 => AN3 ,                       
       AN4 => AN4                        
     );                                                      

end Behavioral;
