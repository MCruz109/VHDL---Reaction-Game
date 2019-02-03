-- was working but changed output of LED
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TEST_UPCOUNTER is
    Port ( clk      : in  STD_LOGIC;       
           reset    : in  STD_LOGIC;       
           enable   : in  STD_LOGIC;       
           stop     : in  STD_LOGIC;       
           hold     : in  STD_LOGIC;       
    
         LED_STOP   : OUT STD_LOGIC; --  
           LED_HOLD   : OUT STD_LOGIC; --  
         LED_EN     : OUT STD_LOGIC; --  
         LED_EN_ALL : OUT STD_LOGIC;    
           
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
end TEST_UPCOUNTER;

architecture Behavioral of TEST_UPCOUNTER is

signal dig1_i, dig2_i, dig3_i, dig4_i : STD_LOGIC_vector(3 downto 0);

component up_clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           stop     : in  STD_LOGIC;
           hold     : in  STD_LOGIC;
           
        LED_STOP   : OUT STD_LOGIC; --  
          LED_HOLD   : OUT STD_LOGIC; --
        LED_EN     : OUT STD_LOGIC; --
        LED_EN_ALL : OUT STD_LOGIC;
           
           sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
           );
end component;

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


begin

UP_CLK: up_clock_divider
    PORT MAP (  clk      => clk    ,
                reset    => reset  ,
                enable   => enable ,
                stop     => stop   ,
                hold     => hold   ,
           
              LED_STOP     => LED_STOP   ,
                LED_HOLD     => LED_HOLD   ,
              LED_EN       => LED_EN     ,
              LED_EN_ALL   => LED_EN_ALL ,
           
           sec_dig1 => dig1_i,
           sec_dig2 => dig2_i,
           min_dig1 => dig3_i,
           min_dig2 => dig4_i
           );


LCD: lcd_display 
  PORT MAP ( 
        -- vector inputs
        dig1  =>  dig1_i,
        dig2  =>  dig2_i,
        dig3  =>  dig3_i,
        dig4  =>  dig4_i, 
        -- stdlogic inputs
        clk   => clk,
        reset => reset,
        
        -- stdlogic outputs
        CA  =>  CA , 
        CB  =>  CB , 
        CC  =>  CC , 
        CD  =>  CD , 
        CE  =>  CE , 
        CF  =>  CF , 
        CG  =>  CG , 
        DP  =>  DP , 
        AN1 =>  AN1,
        AN2 =>  AN2,
        AN3 =>  AN3,
        AN4 =>  AN4
      );


end Behavioral;
