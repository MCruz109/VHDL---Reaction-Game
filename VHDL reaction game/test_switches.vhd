library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_switches is
    Port (      i01     : in STD_LOGIC;
                i02     : in STD_LOGIC;
                i03     : in STD_LOGIC;
                i04     : in STD_LOGIC;
                i05     : in STD_LOGIC;
                i06     : in STD_LOGIC;
                i07     : in STD_LOGIC;
                i08     : in STD_LOGIC;
                i09     : in STD_LOGIC;
                i10     : in STD_LOGIC;
                i11     : in STD_LOGIC;
                i12     : in STD_LOGIC;
                i13     : in STD_LOGIC;
                i14     : in STD_LOGIC;
                i15     : in STD_LOGIC;
                i16     : in STD_LOGIC;
                
                out01     : out STD_LOGIC;
                out02     : out STD_LOGIC;
                out03     : out STD_LOGIC;
                out04     : out STD_LOGIC;
                out05     : out STD_LOGIC;
                out06     : out STD_LOGIC;
                out07     : out STD_LOGIC;
                out08     : out STD_LOGIC;
                out09     : out STD_LOGIC;
                out10     : out STD_LOGIC;
                out11     : out STD_LOGIC;
                out12     : out STD_LOGIC;
                out13     : out STD_LOGIC;
                out14     : out STD_LOGIC;
                out15     : out STD_LOGIC;
                out16     : out STD_LOGIC                
                );
                
end test_switches;

architecture Behavioral of test_switches is

begin
    start: process ( i01,
                     i02,
                     i03,
                     i04,
                     i05,
                     i06,
                     i07,
                     i08,
                     i09,
                     i10,
                     i11,
                     i12,
                     i13,
                     i14,
                     i15,
                     i16)
                     
    begin
        if (i01 = '1') then
            out01 <= '1';
        elsif (i02 = '1') then
            out02 <= '1';
        elsif (i03 = '1') then   
            out03 <= '1';
        else 
            out01 <= '0';
            out02 <= '0';
            out03 <= '0';
            out04 <= '0';
            out05 <= '0';
            out06 <= '0';
            out07 <= '0';
            out08 <= '0';
            out09 <= '0';
            out10 <= '0';
            out11 <= '0';
            out12 <= '0';
            out13 <= '0';
            out14 <= '0';
            out15 <= '0';
            out16 <= '0';
        end if;
    end process;

-- connect to LED

end Behavioral;
