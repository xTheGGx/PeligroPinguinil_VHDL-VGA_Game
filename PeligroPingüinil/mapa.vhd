library ieee;
use ieee.std_logic_1164.all;

entity mapa is
port (in_clk: in std_logic;
		VGA_clk: out std_logic;
		r,g,b: out std_logic_vector (2 downto 0);
		horiz_s,vert_s: out std_logic;
		dipsw: in std_logic_vector (2 downto 0));
end entity mapa;

architecture behavioral of mapa is
signal pix_clock: std_logic;
signal pantalla: std_logic;
signal col: integer;
signal fila: integer;
signal idk: std_logic;

begin

VGA_clk<=pix_clock;

u1: entity work.Gen25MHz (behavior) port map (in_clk, pix_clock);
u2: entity work.vga_controller (behavior) port map (pix_clock, '1', horiz_s, vert_s, pantalla, col, fila);
u3: entity work.hw_image_generator (behavior) port map (pantalla, fila, col, r, g, b,dipsw,idk);
u4: entity work.relojlento (arq) port map (in_clk, idk);
end architecture behavioral;