----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:17:57 10/20/2018 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
	port (
		i_clk : in std_logic;
		i_rst : in std_logic;
		i_sr: in std_logic_vector(1 downto 0);
		o_hsync: inout std_logic;
		o_vsync: out std_logic;
		o_color : out std_logic_vector(9 downto 0);
		button : in std_logic_vector(3 downto 0)
		
	);
end main;


architecture Behavioral of main is

	COMPONENT dcm_1
	PORT(
		CLKIN_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		CLKFX_OUT : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT SG
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
	PORT(
		i_clkzero : IN std_logic;    
		o_hsync : INOUT std_logic;      
		o_vsync : OUT std_logic;
		o_color: out std_logic_vector(9 downto 0);
		button : in std_logic_vector(3 downto 0)
		);
	END COMPONENT;

signal clkzero : std_logic;
signal clkfx : std_logic;
signal hsync1, hsync2, vsync1, vsync2  : std_logic;
signal color1, color2 :std_logic_vector(9 downto 0);
 	
begin

	Inst_dcm: dcm_1 PORT MAP(
		CLKIN_IN => i_clk,
		RST_IN => i_rst,
		CLKIN_IBUFG_OUT => open,
		CLK0_OUT => clkzero,
		CLKFX_OUT => clkfx 
	);
	
	
	Inst_SG1: SG GENERIC MAP(
		h_sync_pulse => 128,
		h_back_porch => 88,
		h_visible_area => 800,
		h_front_porch => 40,
		v_sync_pulse => 4,
		v_back_porch => 23, 
		v_visible_area => 600,
		v_front_porch => 1
	)
	PORT MAP(
		i_clkzero => clkzero,
		o_hsync => hsync1,
		o_vsync => vsync1,
		o_color => color1,
		button => button
	);
	
	Inst_SG2: SG GENERIC MAP(
		h_sync_pulse => 136,
		h_back_porch => 144,
		h_visible_area => 1024,
		h_front_porch => 24,	
		v_sync_pulse => 6,
		v_back_porch => 29, 
		v_visible_area => 768,
		v_front_porch => 3
	)
	
	PORT MAP(
		i_clkzero => clkfx,
		o_hsync => hsync2,
		o_vsync => vsync2,
		o_color => color2,
		button => button
	);
	
	o_hsync <= hsync1 when(i_sr = "00") else 
					hsync2;
					
	o_vsync <= vsync1 when(i_sr = "00") else 
					vsync2;
					
	o_color <= color1 when(i_sr = "00") else 
					color2;

end Behavioral;
