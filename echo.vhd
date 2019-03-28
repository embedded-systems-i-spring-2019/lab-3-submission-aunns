----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2019 05:40:41 PM
-- Design Name: 
-- Module Name: echo - Behavioral
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

entity echo is
 Port (clk,clk_enable,ready,newchar : in std_logic;
        charin: in std_logic_vector(7 downto 0);
            send: out std_logic;
            charout: out std_logic_vector(7 downto 0) );
end echo;

architecture Behavioral of echo is
type state is (idle,busyA,busyB,busyC);
signal curr: state:=idle;


begin
process (clk)
    begin
        case curr is
            when idle=>
               if rising_edge (clk) and clk_enable='1' then
                     if newchar='1' then
                        send<='1';
                        charout<=charin;
                        curr<=busyA;
                        end if;
               end if;    
               
            when busyA=>
                curr<=busyB;
                
            when busyB=>
                send<='0';
                curr<=busyC;
                  
                    
            when busyC=>
            if ready='1' then 
            curr<=idle;
            else
            curr<=busyC;            
            end if;
end case;
end process;
end Behavioral;
