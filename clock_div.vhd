--library ieee;
--    use ieee.std_logic_1164.all;
--    use ieee.numeric_std.all;

--entity clock_div is
--    port(

--        clk  : in std_logic;        -- 125 Mhz clock
       
        
--        div : out std_logic        -- 2 Hz clock

--    );
--end clock_div;

--architecture behavior of clock_div is

--    signal counter : std_logic_vector(26 downto 0) := (others => '0');

--begin

--    process(clk)
--    begin
    
--        if rising_edge(clk) then
        
          
                
            
            
--                -- count one full led period (1 Hz)
                
--                if (unsigned(counter) < 1086) then
--                    counter <= std_logic_vector(unsigned(counter) + 1);
                    
--                else
--                    counter <= (others => '0');
                    
--                end if;
                
--                -- turn the led on for half of the period (50% duty cycle)
--                -- when sw0 is high
                
--                if (unsigned(counter) < 542) then
--                    div <= '1';
                    
--                else
--                    div <= '0';
                    
--                end if;
            
        
            
--        end if;
    
--    end process;
    
--end behavior;


-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 08:45:13 PM
-- Design Name: 
-- Module Name: clockdivider - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div is
    Port (div : out STD_LOGIC;
          clk : in STD_LOGIC);
end clock_div;

architecture Behavioral of clock_div is
signal counter : std_logic_vector(26 downto 0);
begin

process (clk)
begin
    if rising_edge(clk) then         
        if (unsigned(counter) < 124999999/115200) then
            counter <= std_logic_vector(unsigned(counter) + 1);
            div <= '0'; 
        else
             counter <= (others => '0');
             div<= '1';
        end if;
    end if;
end process;


end Behavioral;