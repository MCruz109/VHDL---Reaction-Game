----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2018 01:35:47 PM
-- Design Name: 
-- Module Name: sw_lap_mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sw_lap_mux is
PORT ( 
          lap_time         : in STD_LOGIC; --add to file signal definition thing
          m_seconds        : out  STD_LOGIC_VECTOR(3 downto 0);
          m_tens_seconds   : out  STD_LOGIC_VECTOR(3 downto 0);
          m_minutes        : out  STD_LOGIC_VECTOR(3 downto 0);
          m_tens_minutes   : out  STD_LOGIC_VECTOR(3 downto 0);
          seconds          : in  STD_LOGIC_VECTOR(3 downto 0);
          tens_seconds     : in  STD_LOGIC_VECTOR(3 downto 0);
          minutes          : in  STD_LOGIC_VECTOR(3 downto 0);
          tens_minutes     : in  STD_LOGIC_VECTOR(3 downto 0);
          l_seconds        : in  STD_LOGIC_VECTOR(3 downto 0);
          l_tens_seconds   : in  STD_LOGIC_VECTOR(3 downto 0);
          l_minutes        : in  STD_LOGIC_VECTOR(3 downto 0);
          l_tens_minutes   : in  STD_LOGIC_VECTOR(3 downto 0)
        );
end sw_lap_mux;



architecture Behavioral of sw_lap_mux is

signal selector : std_logic;



begin

    sw_process : process(selector)
    begin
        if selector = '1' then 
            m_seconds <= l_seconds;
            m_tens_seconds <= l_tens_seconds;
            m_minutes <= l_minutes;
            m_tens_minutes <= l_tens_minutes;
        
        else
            m_seconds <= seconds;
            m_tens_seconds <= tens_seconds;
            m_minutes <= minutes;
            m_tens_minutes <= tens_minutes;
        end if;
        
    end process;

selector <= lap_time;

end Behavioral;
