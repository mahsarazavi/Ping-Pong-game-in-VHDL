----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:43:46 10/20/2018 
-- Design Name: 
-- Module Name:    M1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HC is
	generic (
		sync_pulse : integer := 128;
		back_porch : integer := 88; 
		visible_area : integer := 800;
		front_porch : integer := 40
	);
	port (
		i_clkzero : in std_logic;
		o_hsync: out std_logic;
		xc: out integer
	);
end HC;

architecture Behavioral of HC is

signal counter:integer range 0 to sync_pulse + back_porch + visible_area + front_porch + 20 :=0;
	
begin
	
	xc <= counter;
	p1 : process(i_clkzero)
	begin
		if(rising_edge(i_clkzero))then
				counter <= counter + 1;
				if (counter = sync_pulse + back_porch + visible_area + front_porch -1) then
					counter <= 1;
				end if;
				
				if(counter < sync_pulse) then
					o_hsync <= '0';
				end if;
				
				if(counter >= sync_pulse) then 
					o_hsync <= '1';
				end if;
				
		end if ;
	end process;
	
end Behavioral;

