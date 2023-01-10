library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity snake_game is
    port (
        -- klok
        clk_100mhz : in std_logic;
        
        -- het beeld op de monitor 
        vga_hs : out std_logic;
        vga_vs : out std_logic;
        vga_r : out std_logic_vector(3 downto 0);
        vga_g : out std_logic_vector(3 downto 0);
        vga_b : out std_logic_vector(3 downto 0);
        reset: in  std_logic;
        
        -- besturing met knoppen
        button: in  std_logic_vector(4 downto 0);
        
        -- toetsenboard
        clr : in STD_LOGIC;
        ps2d : in STD_LOGIC;
        ps2c : in STD_LOGIC);
        
end snake_game;

architecture Behavioral of snake_game is
--------------------------------------------------------------------------------------------------------
component beeld_en_rgb is       -- in deze component zit de logica voor het spel en de waardes voor de rgb  
    port(
        -- spel logica bij het besturen van de slang
        clk_60hz            : in  std_logic;
        direction           : in  std_logic_vector(1 downto 0);
        stop                : in  std_logic;
        reset               : in  std_logic;
        -- generatie van de rgb 
        clk_108mhz          : in  std_logic;
        en                  : in  std_logic;
        row, col            : in  std_logic_vector(15 downto 0);
        rout, gout, bout    : out std_logic_vector(3 downto 0));
end component;
--------------------------------------------------------------------------------------------------------
component vga is            -- deze component zorgt voor de synchronisatie van de vga en het teken van de slang en het eten 
port ( 
        clk: in  std_logic;                                 -- virtuele klok gemaakt door cloking wizard
        en: out std_logic;                                  -- enablen van de display
        h_sync, v_sync: out std_logic;                      -- horizontale en vericale synchronisatie
        row, col: out std_logic_vector(15 downto 0));       -- rij en kolom van de pixel die weergegeven moeten worden
end component vga;
--------------------------------------------------------------------------------------------------------
component clk_wiz_0         -- deze deel werd gemaakt door clocking wizard
    port(
      clk_out1          : out    std_logic;
      reset             : in     std_logic;
      locked            : out    std_logic;
      clk_in1           : in     std_logic);
end component;
--------------------------------------------------------------------------------------------------------
component besturing is      -- deze deel wordt gebruikt de om knoppen van de toetsenboard en van de fpga in te lezen
    port(
        clk_60hz    : in std_logic;
        button      : in std_logic_vector(4 downto 0);
        stop        : out std_logic;
        direction   : out std_logic_vector(1 downto 0);
        toetsWaarde : in std_logic_vector(7 downto 0));
end component;
--------------------------------------------------------------------------------------------------------
component top_PS2_CR is     -- deze commpent wordt gebruikt om de toetsenboard te synchroniseren
    Port ( clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           ps2c : in STD_LOGIC;
           ps2d : in STD_LOGIC;
           toets: out STD_LOGIC_VECTOR (7 downto 0));
end component;
--------------------------------------------------------------------------------------------------------

-- Signalen voor vga
signal vga_en: std_logic;                                   -- vga_en wordt ook gebruikt bij beeld_en_vga
signal vga_row, vga_col: std_logic_vector(15 downto 0);     -- vga_row, vga_col wordt ook gebruikt bij beeld_en_vga

-- signalen voor clk_wiz_0
signal clk_108mhz: std_logic;                               -- clk_108mhz wordt ook gebruikt bij beeld_en_vga

-- signalen voor beeld_en_rgb
signal clk_60hz: std_logic;
signal joypad_direction: std_logic_vector(1 downto 0);      -- joypad_direction wordt ook gebruikt bij besturing
signal joypad_stop: std_logic;                              -- joypad_stop wordt ook gebruikt bij besturing

-- signalen voor besturing
signal toetsWaarde: std_logic_vector(7 downto 0);           -- wordt gebruikt bij besturing
begin

-- verbinden van alle poorten van de componenten

C1: vga port map (clk =>clk_108mhz, en => vga_en, h_sync => vga_hs, v_sync => vga_vs, row => vga_row, col => vga_col );
C2: clk_wiz_0 port map (clk_out1 => clk_108mhz, reset => reset, locked => open, clk_in1 => clk_100mhz);
C3: beeld_en_rgb port map (clk_60hz => clk_60hz, direction => joypad_direction, stop => joypad_stop, reset => reset, clk_108mhz => clk_108mhz,en => vga_en, row => vga_row, col => vga_col,rout => vga_r, gout => vga_g,bout => vga_b); --debug_led => led,
C4: besturing port map (clk_60hz => clk_60hz, button => button, stop => joypad_stop, direction => joypad_direction,toetsWaarde => toetsWaarde);
C5: top_PS2_CR port map (clk => clk_100mhz, clr => clr, ps2c => ps2c, ps2d => ps2d, toets => toetsWaarde);

-- maken van 60hz klok
use_clk_60hz:
    process(clk_108mhz)
        --counter reverts in 108 / 0.9 = 120hz
        constant counter_max    : integer := 900000;

        variable counter        : integer range 0 to counter_max - 1 := 0;
        variable clk_60hz_future: std_logic := '0';
    begin 
        if (rising_edge(clk_108mhz)) then 
            if (counter = counter_max - 1) then
                counter := 0;
                clk_60hz_future := not clk_60hz_future;
            else
                counter := counter + 1;
            end if;
        end if;
        clk_60hz <= clk_60hz_future;
    end process;
    
end Behavioral;

