library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lcd_display is
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
end lcd_display;

architecture Behavioral of lcd_display is
--SIGNALS--------------------------------------------------
signal in_DP, out_DP : STD_LOGIC;
signal an_i : STD_LOGIC_VECTOR(3 downto 0);
signal digit_to_display : STD_LOGIC_VECTOR(3 downto 0);
signal sec_dig1_i, sec_dig2_i, min_dig1_i, min_dig2_i, digit_select_i : STD_LOGIC_VECTOR(3 downto 0);
signal CA_i, CB_i, CC_i, CD_i, CE_i, CF_i, CG_i : STD_LOGIC;


--COMPONENTS------------------------------------------------

component digit_multiplexor is
  PORT ( 
          sec_dig1   : in  STD_LOGIC_VECTOR(3 downto 0);
          sec_dig2   : in  STD_LOGIC_VECTOR(3 downto 0);
          min_dig1   : in  STD_LOGIC_VECTOR(3 downto 0);
          min_dig2   : in  STD_LOGIC_VECTOR(3 downto 0);
          selector   : in  STD_LOGIC_VECTOR(3 downto 0);
          time_digit : out STD_LOGIC_VECTOR(3 downto 0)
        );
end component;

component seven_segment_decoder is
    PORT ( CA    : out STD_LOGIC;
           CB    : out STD_LOGIC;
           CC    : out STD_LOGIC;
           CD    : out STD_LOGIC;
           CE    : out STD_LOGIC;
           CF    : out STD_LOGIC;
           CG    : out STD_LOGIC;
           DP    : out STD_LOGIC;
           dp_in : in  STD_LOGIC;
           data  : in  STD_LOGIC_VECTOR (3 downto 0)
         );
 end component;
         
component seven_segment_digit_selector is
    PORT ( clk          : in  STD_LOGIC;
           digit_select : out STD_LOGIC_VECTOR (3 downto 0);
           an_outputs   : out STD_LOGIC_VECTOR (3 downto 0);
           reset        : in  STD_LOGIC
         );                
          
end component;


BEGIN

    -- Instantiate COMPONENTS
    
DIGIT_MUX : digit_multiplexor
    PORT MAP( 
              sec_dig1   => dig1,  
              sec_dig2   => dig2, 
              min_dig1   => dig3,  
              min_dig2   => dig4,  
              selector   => digit_select_i,  
              time_digit => digit_to_display
              );
              
SELECTOR : seven_segment_digit_selector
     PORT MAP( clk          => clk,
               digit_select => digit_select_i, 
               an_outputs   => an_i,
               reset        => reset
             );

DECODER : seven_segment_decoder
           PORT MAP (
                      CA    => CA_i,
                      CB    => CB_i,
                      CC    => CC_i,
                      CD    => CD_i,
                      CE    => CE_i,
                      CF    => CF_i,
                      CG    => CG_i,
                      DP    => out_DP,
                      dp_in => in_DP,
                      data  => digit_to_display
                    );
                    
-- Connect internal signals to outputs here:
                 
                 
                 DP <= out_dp;
                 CA <= CA_i;
                 CB <= CB_i;
                 CC <= CC_i;
                 CD <= CD_i;
                 CE <= CE_i;
                 CF <= CF_i;
                 CG <= CG_i;
                 
                 in_dp <= an_i(3); -- have the decimal point light up in the third digit of the 7-segment display (i.e. minutes digit)
               
                 AN1 <= an_i(0); -- seconds digit
                 AN2 <= an_i(1); -- tens of seconds digit
                 AN3 <= an_i(2); -- minutes digit
                 AN4 <= an_i(3); -- tens of minutes digit       

end Behavioral;