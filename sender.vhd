----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2019 02:08:40 PM
-- Design Name: 
-- Module Name: sender - Behavioral
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

entity sender is
 Port (reset, clk,  clk_enable, btn,ready: in std_logic;
        send: out std_logic;
        char: out std_logic_vector(7 downto 0));
        
end sender;

architecture Behavioral of sender is

type mynetid is array (0 to 5) of std_logic_vector(7 downto 0);

--signal netid:mynetid :=(x"6d", x"73", x"32", x"38", x"30",x"38");
signal netid:mynetid :=(b"01101101", b"01110011", b"00110010", b"00111000", b"00110000",b"00111000");

signal count : integer range 0 to 6 := 0;  -- 6 Bits Total
--signal count : STD_LOGIC_VECTOR(2 downto 0) := "000";

type state is (idle,busyA,busyB,busyC);
signal curr: state:=idle;

begin

process(clk)
    begin
        if rising_edge(clk) then
        
            if clk_enable='1' then
                if reset='1' then
                    curr<=idle;
                    count<=0;
                    char<= x"00";
                    send<='0';
                end if;

                
                          
                          case curr is
                            when busyA=>
                            curr<=busyB;
                            
                            when busyB=>
                            send<='0';
                            curr<=busyC;
                            
                            when busyC=>
                            if ready ='1' and btn='0' then
                                curr<=idle;
                              end if;
                              
                            when idle=>
                            if ready='1' then
                                 if btn='1' then
                                     if count<6 then
                                        send<='1';
                                        char<=netid(count);
                                        count<=count+1;
                                        curr<=busyA;
                                        elsif (count) = 6 then
                                            curr<=idle;
                                            count<=0;
                        
                                     end if;
                              end if;                                              
                      end if;   
                          
                                
                          end case;                                
                          
                   
      end if ;
end if;                              
                        
                                             
 end process;                   
        
end Behavioral;


