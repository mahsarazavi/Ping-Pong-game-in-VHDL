----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:47:35 10/27/2018 
-- Design Name: 
-- Module Name:    color - Behavioral 
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

entity color is
generic (
		x0 : integer := 500;
		y0 : integer := 500; 
		x1 : integer := 1000;
		y1 : integer := 500;
		x2 : integer := 200;
		y2 : integer := 300;
		dy : integer := 10;
		dx : integer := 10;
		dx1: integer := 30;
		dy1: integer := 100;
		dx2: integer := 30;
		dy2: integer := 100;
		xd : integer := 2;
		yd : integer := 2;
		xd1: integer := 0;
		yd1: integer := 1;
		xd2: integer := 0;
		yd2: integer := 1;

		rx : integer := 800;
		ry : integer := 600;
		
		color: std_logic_vector(9 downto 0) := "1111111111";
		color1: std_logic_vector(9 downto 0) := "1110000000";
		color2: std_logic_vector(9 downto 0) := "0000000111";

		h_sync_pulse : integer := 128;
		h_back_porch : integer := 88; 
		h_visible_area : integer := 800;
		h_front_porch : integer := 40;
		
		v_sync_pulse : integer := 4;
		v_back_porch : integer := 23; 
		v_visible_area : integer := 600;
		v_front_porch : integer := 1
		
	);
port (
		xc : in integer;
		yc: in integer;
		vsync: in std_logic;
		o_color: out std_logic_vector(9 downto 0);
		button : in std_logic_vector(3 downto 0)
	);
end color;

architecture Behavioral of color is
signal x : integer := x0;
signal y : integer := y0;
signal x_1: integer := h_visible_area + h_back_porch + h_sync_pulse - dx1;
signal y_1: integer := y1;
signal x_2: integer := x2;
signal y_2: integer := y2;
signal d : integer := 1;
signal d2 : integer := 1;
signal x_racketRed, x_racketBlue, x_ball, y_racketRed, y_racketBlue, y_ball : integer;

begin
p1 : process(xc, yc , x , y)	
	begin	
		if ( xc > x) and( xc < x+dx ) and ( yc < y+dy ) and ( yc > y ) then
				o_color <= color;

				elsif(( xc > x_1) and( xc < x_1+dx1 ) and ( yc < y_1+dy1 ) and ( yc > y_1 )) then
				o_color <= color2;

				elsif(( xc > x_2) and( xc < x_2+dx2 ) and ( yc < y_2+dy2 ) and ( yc > y_2 )) then
				o_color <= color1;
				
				else 	o_color <= "0000000000";
			end if;
	end process;


--	
p2: process(vsync)
	begin
		if ( falling_edge(vsync) ) then 
			x <= x + d;
			y <= y + d2;
			
			if (x + dx > h_visible_area + h_back_porch + h_sync_pulse  ) then
					d <= -xd;
				end if;

			if (x < h_back_porch + h_sync_pulse) then
					d <= xd;
				end if;
				
			if (y + dy > v_visible_area + v_back_porch + v_sync_pulse ) then
					d2 <= -yd;
				end if;

			if (y < v_back_porch + v_sync_pulse ) then
					d2 <= yd;
				end if;
				
			if( button(0) = '0')then
				if( y_1 > 0 ) then
				y_1 <= y_1 - 5;
				end if;
			end if;
			
			if( button(1) = '0')then
				if ( y_1 + 100 < v_visible_area + v_back_porch + v_sync_pulse )then
				y_1 <= y_1 + 5;
				end if;
			end if;
			
			if( button(2) = '0')then
				if( y_2 > 0 ) then
				y_2 <= y_2 - 5;
				end if;
			end if;
			
			if( button(3) = '0')then
				if(y_2 + 100 < v_visible_area + v_back_porch + v_sync_pulse )then
				y_2 <= y_2 + 5;
				end if;
			end if;
	end if;
	
	
	end process;
end Behavioral;

