----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2018 01:06:42 PM
-- Design Name: 
-- Module Name: lap_register - Behavioral
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

entity lap_register is
PORT ( 
          clk        : in STD_LOGIC;
          reset      : in STD_LOGIC;
          lap_time   : in STD_LOGIC; --add to file signal definition thing
          l_seconds   : out  STD_LOGIC_VECTOR(3 downto 0);
          l_tens_seconds   : out STD_LOGIC_VECTOR(3 downto 0);
          l_minutes   : out  STD_LOGIC_VECTOR(3 downto 0);
          l_tens_minutes   : out  STD_LOGIC_VECTOR(3 downto 0);
          seconds   : in  STD_LOGIC_VECTOR(3 downto 0);
          tens_seconds   : in  STD_LOGIC_VECTOR(3 downto 0);
          minutes   : in  STD_LOGIC_VECTOR(3 downto 0);
          tens_minutes   : in  STD_LOGIC_VECTOR(3 downto 0)
        );
end lap_register;

architecture Behavioral of lap_register is
    signal load : std_logic;
    signal Q    : std_logic;
    signal D    : std_logic;
begin

laptime: process(lap_time, clk, reset)
begin
    if reset = '1' then
        Q <= '0';   
    elsif rising_edge(clk) then
    
        Q <= D;
   
    end if;
     
end process;

load <= lap_time and (not Q);
D <= lap_time;

sw_mux: process (load)
begin
    if load = '1' then
        l_seconds <= seconds;
        l_tens_seconds <= tens_seconds;
        l_minutes <= minutes;
        l_tens_minutes <= tens_minutes;               
    end if;
end process;

end Behavioral;
