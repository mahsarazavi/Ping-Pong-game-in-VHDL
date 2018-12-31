----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:44:48 10/20/2018 
-- Design Name: 
-- Module Name:    M2 - Behavioral 
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

entity VC is

	generic (
		sync_pulse : integer := 4;
		back_porch : integer := 23; 
		visible_area : integer := 600;
		front_porch : integer := 1
	);
	port (
		i_hsync : in std_logic;
		o_vsync: out std_logic;
		yc: out integer
	);
end VC;

architecture Behavioral of VC  is

signal counter:integer range 0 to sync_pulse + back_porch + visible_area + front_porch+ 20 :=0;

begin

	yc <=counter;
	p1 : process(i_hsync)
	begin
		if(rising_edge(i_hsync))then
				counter <= counter + 1;
				if (counter = sync_pulse + back_porch + visible_area + front_porch -1) then
					counter <= 1;
				end if;
				
				if(counter < sync_pulse) then
					o_vsync <= '0';
				end if;
				
				if(counter >= sync_pulse) then 
					o_vsync <= '1';
				end if;
				
		end if ;
	end process;

end Behavioral;

