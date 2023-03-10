library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_PS2_CR is
    Port ( clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           ps2c : in STD_LOGIC;
           ps2d : in STD_LOGIC;
           toets: out STD_LOGIC_VECTOR (7 downto 0));
end top_PS2_CR;

architecture Behavioral of top_PS2_CR is

component PS2 is
    Generic(clk_freq: INTEGER := 100_000_000); --system clock frequency in Hz 
    Port ( clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           ps2d : in STD_LOGIC;
           ps2c : in STD_LOGIC;
           ps2_new : out STD_LOGIC;
           ps2_out : out STD_LOGIC_VECTOR (7 downto 0));
end component PS2;

component PS2_CR is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           valid : in STD_LOGIC;
           toets: out STD_LOGIC_VECTOR (7 downto 0));
end component PS2_CR;

signal ps2_out: STD_LOGIC_VECTOR (7 downto 0);
signal ps2_new : STD_LOGIC;

begin
U1: PS2 
    Port map ( clk => clk,
           clr => clr,
           ps2d => ps2d,
           ps2c => ps2c,
           ps2_new => ps2_new,
           ps2_out => ps2_out);

U2: PS2_CR
    Port map ( clk => clk,
           rst => clr,
           data => ps2_out,
           valid => ps2_new,
           toets => toets);

end Behavioral;
