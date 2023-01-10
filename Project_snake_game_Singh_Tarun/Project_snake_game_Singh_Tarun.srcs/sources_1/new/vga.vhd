library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga is
    generic(
        h_polar         : std_logic := '1';
        v_polar         : std_logic := '1';
        scr_width       : integer := 1024 ;
        scr_height      : integer := 768 ;
        h_front_porch   : integer := 24;
        h_sync_pulse    : integer := 136;
        h_back_porch    : integer := 160;
        v_front_porch   : integer := 3;
        v_sync_pulse    : integer := 6;
        v_back_porch    : integer := 29);
    port(
        clk             : in  std_logic;                           
        en              : out std_logic;                           
        h_sync, v_sync  : out std_logic;                         
        row, col        : out std_logic_vector(15 downto 0));  
end vga;

architecture main of vga is
    constant h_period : integer := scr_width  + h_front_porch + h_sync_pulse + h_back_porch;
    constant v_period : integer := scr_height + v_front_porch + v_sync_pulse + v_back_porch;
begin
    process (clk)
        variable h_count : integer range 0 to h_period - 1 := 0;
        variable v_count : integer range 0 to v_period - 1 := 0;
    begin
        if (clk'event and clk = '1') then
            -- bij een nieuwe lijn
            if (h_count = h_period - 1) then
                h_count := 0;
                if (v_count = v_period - 1) then
                    v_count := 0;
                else 
                    v_count := v_count + 1;
                end if;
            else
                h_count := h_count + 1;
            end if;

            -- Als er geen h_sync puls is
            if (h_count < scr_width + h_front_porch or h_count >= scr_width + h_front_porch + h_sync_pulse) then 
                h_sync <= not h_polar;
            else 
                h_sync <= h_polar;
            end if;

            -- Als er geen v_sync puls is
            if (v_count < scr_height + v_front_porch or v_count >= scr_height + v_front_porch + v_sync_pulse) then
                v_sync <= not v_polar;
            else 
                v_sync <= v_polar;
            end if;
            
            -- enablen bij het toonen
            if (h_count < scr_width and v_count < scr_height) then 
                en <= '1';
            else 
                en <= '0';
            end if;

            row <= std_logic_vector(to_unsigned(v_count, row'length));
            col <= std_logic_vector(to_unsigned(h_count, col'length));
        end if;
    end process;
end main;