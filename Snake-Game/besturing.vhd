library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity besturing is
    port(
        clk_60hz    : in std_logic;
        button      : in std_logic_vector(4 downto 0);
        stop        : out std_logic;
        direction   : out std_logic_vector(1 downto 0);
        toetsWaarde : in std_logic_vector(7 downto 0));
end entity;

architecture main of besturing is
begin
    process(clk_60hz)
        -- variablen voor knoppen
        variable old_button : std_logic_vector(4 downto 0) := (others => '0');
        variable stop_next : std_logic := '0';
        variable direction_next : std_logic_vector(1 downto 0) := (others => '0');
    begin
        if (rising_edge(clk_60hz)) then
            if ((old_button(0) = '0' and button(0) = '1') OR toetsWaarde = X"1D") then
                direction_next := "00";         -- knop boven en toets A
            end if;
            if ((old_button(1) = '0' and button(1) = '1') OR toetsWaarde = X"23") then
                direction_next := "01";         -- knop rechs en toets D
            end if;
            if ((old_button(2) = '0' and button(2) = '1') OR toetsWaarde = X"1A") then
                direction_next := "10";         -- knop beneden en toets W
            end if;
            if ((old_button(3) = '0' and button(3) = '1') OR toetsWaarde = X"1C" ) then
                direction_next := "11";         -- knop links en toets Q
            end if;
            if ((old_button(4) = '0' and button(4) = '1') OR toetsWaarde = X"29") then
                stop_next := not stop_next;     -- knop stop en toets spatie
            end if;
            old_button := button;
        end if;
        stop <= stop_next;
        direction <= direction_next;
    end process;
end architecture;
