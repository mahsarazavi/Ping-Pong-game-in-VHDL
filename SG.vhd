----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:53 10/20/2018 
-- Design Name: 
-- Module Name:    SG - Behavioral 
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

entity SG is
	generic (
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
		i_clkzero : in std_logic;
		o_hsync: inout std_logic;
		o_vsync: out std_logic;
		o_color: out std_logic_vector(9 downto 0);
		button : in std_logic_vector(3 downto 0)

	);
end SG;

architecture Behavioral of SG is

	COMPONENT HC
		generic (
		sync_pulse : integer := 128;
		back_porch : integer := 88; 
		visible_area : integer := 800;
		front_porch : integer := 40
	);
	PORT(
		i_clkzero : IN std_logic;          
		o_hsync : OUT std_logic;
		xc : OUT integer
		);
	END COMPONENT;
		
	COMPONENT VC
	generic (
		sync_pulse : integer := 4;
		back_porch : integer := 23; 
		visible_area : integer := 600;
		front_porch : integer := 1
	);
	PORT(
		i_hsync : IN std_logic;          
		o_vsync : OUT std_logic;
		yc : OUT integer
		);
	END COMPONENT;
	
	COMPONENT color
	generic (
		x0 : integer := 500;
		y0 : integer := 500; 
		x1 : integer := 1000; --red 
		y1 : integer := 500;
		x2 : integer := 200;
		y2 : integer := 300;
		dy : integer := 10; --  ball
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
	PORT(
		xc : IN Integer;
		yc : IN integer;
		vsync : IN std_logic;
		
		o_color : OUT std_logic_vector(9 downto 0);
		button : in std_logic_vector(3 downto 0)
		);
	END COMPONENT;



signal xc ,yc : integer;
signal vsync : std_logic;
signal o_color1, o_color2, o_color3 : std_logic_vector(9 downto 0);

begin

	Inst_HC: HC GENERIC MAP(
		sync_pulse => h_sync_pulse,
		back_porch => h_back_porch ,
		visible_area => h_visible_area,
		front_porch => h_front_porch
	)
	PORT MAP(
		i_clkzero => i_clkzero,
		o_hsync => o_hsync,
		xc => xc
	);

	Inst_VC: VC GENERIC MAP(
		sync_pulse => v_sync_pulse,
		back_porch => v_back_porch ,
		visible_area => v_visible_area,
		front_porch => v_front_porch
	)
	PORT MAP(
		i_hsync => o_hsync,
		o_vsync => vsync,
		yc => yc
	);
	
	Inst_color: color 
	GENERIC MAP(
		x0 => 500,
		y0 => 500, 
		x1 => 600,
		y1 => 500,
		x2 => 200,
		y2 => 300,
		dy => 10,
		dx => 10,
		dx1=> 30,
		dy1=> 100,
		dx2=> 30,
		dy2=> 100,
		xd => 2,
		yd => 2,
		xd1 => 0,
		yd1 => 1,
		xd2 => 0,
		yd2 => 1,

		rx => h_visible_area,
		ry => v_visible_area,
		
		color => "1111111111",
		color1 => "1110000000",
		color2=> "0000000111",

		h_sync_pulse => h_sync_pulse,
		h_back_porch => h_back_porch, 
		h_visible_area => h_visible_area,
		h_front_porch => h_front_porch,
		
		v_sync_pulse => v_sync_pulse,
		v_back_porch => v_back_porch, 
		v_visible_area => v_visible_area,
		v_front_porch => v_front_porch
	)PORT MAP(
		xc => xc,
		yc => yc,
		vsync => vsync,
	o_color => o_color,
	button => button
	
	);
	--o_vsync <= vsync;


--
--	Inst_color2: color 
--	GENERIC MAP(
--		x0 => 300,
--		y0 => 500 ,
--		dx => 30,
--		dy => 100,
--		yd => 1,
--		xd => 0,
--		rx => h_visible_area,
--		ry => v_visible_area,
--		color => "1110000000",
--		h_sync_pulse => h_sync_pulse,
--		h_back_porch => h_back_porch, 
--		h_visible_area => h_visible_area,
--		h_front_porch => h_front_porch,
--		
--		v_sync_pulse => v_sync_pulse,
--		v_back_porch => v_back_porch, 
--		v_visible_area => v_visible_area,
--		v_front_porch => v_front_porch
--	)PORT MAP(
--		xc => xc,
--		yc => yc,
--		vsync => vsync,
--		o_color => o_color2,
--		button => button
--	);
--	o_vsync <= vsync;
----	o_color <= (o_color1 or o_color2);
--
--
--	Inst_color3: color 
--	GENERIC MAP(
--		x0 => 200,
--		y0 => 300 ,
--		dx => 30,
--		dy => 100,
--		yd => 1,
--		xd => 0,
--		rx => h_visible_area,
--		ry => v_visible_area,
--		color => "0000000111",
--		h_sync_pulse => h_sync_pulse,
--		h_back_porch => h_back_porch, 
--		h_visible_area => h_visible_area,
--		h_front_porch => h_front_porch,
--		
--		v_sync_pulse => v_sync_pulse,
--		v_back_porch => v_back_porch, 
--		v_visible_area => v_visible_area,
--		v_front_porch => v_front_porch
--	)PORT MAP(
--		xc => xc,
--		yc => yc,
--		vsync => vsync,
--		o_color => o_color3,
--		button => button
--	);
	o_vsync <= vsync;
--	o_color <= (o_color1 or o_color2 or o_color3);

end Behavioral;

	
