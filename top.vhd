----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2019 04:08:07 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
  Port (TXD,clk : in std_logic;
        btn: in std_logic_vector(1 downto 0);
        CTS: out std_logic;
        RTS: out std_logic;
        RXD: out std_logic );
end top;


architecture Behavioral of top is
component debounce is
port(btn,clk: in std_logic;
        dbnc: out std_logic);
        
        end component;
        
component clock_div is
  port(  clk  : in std_logic;        -- 125 Mhz clock
       
        
        div : out std_logic        -- 2 Hz clock

    );     
    
    end component;
    
component sender
 Port (reset, clk,  clk_enable, btn,ready: in std_logic;
        send: out std_logic;
        char: out std_logic_vector(7 downto 0));
end component;

component uart
 port (

    clk, en, send, rx, rst      : in std_logic;
    charSend                    : in std_logic_vector (7 downto 0);
    tx, newChar                   : out std_logic;
    ready                       :inout std_logic;
    charRec                     : out std_logic_vector (7 downto 0)

);

end component;        
            
    signal dbnc1,dbnc2,clk_div,rdy,send1,newchar: std_logic;
    signal char1,charrec: std_logic_vector(7 downto 0);
    
    
begin
d1: debounce
port map(
        btn=>btn(0),
        clk=>clk,
        dbnc=>dbnc1);
        
d2: debounce
        port map(
        btn=>btn(1),
        clk=>clk,
        dbnc=>dbnc2);
        
c1: clock_div     
    port map(
        clk=>clk,
        div=>clk_div);

s1: sender
    port map(
    reset=>dbnc1,
     clk=>clk,
     clk_enable=>clk_div,
      btn=>dbnc2,
      ready=>rdy,
        send=>send1,
        char=>char1);
        
u1: uart
    port map(
             clk=>clk,
              en=>clk_div,
              send=>send1,
              rx=>TXD,
              rst=>dbnc1,
              charSend=>char1,
              ready=>rdy,
              tx=>RXD,
             newchar=>newchar,
             charrec=>charrec
            
              );
newchar<='0';
charrec<= (others=>'0');              
CTS<='0';
RTS<='0';              
        
            
        
       

end Behavioral;
