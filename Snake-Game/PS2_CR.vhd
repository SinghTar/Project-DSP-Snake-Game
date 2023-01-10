library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 


entity PS2_CR is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           valid : in STD_LOGIC;
           toets: out STD_LOGIC_VECTOR (7 downto 0));

end PS2_CR;

architecture Behavioral of PS2_CR is
signal prev_valid, flag: std_logic;
signal keyWaarde: STD_LOGIC_VECTOR (7 downto 0);


begin
process (clk, rst) begin 
    if rst = '1' then 
        keyWaarde <= data;
        
    elsif rising_edge (clk)then 
        prev_valid <= valid;  
        if (prev_valid = '1' and valid = '0' and flag = '0') then
            keyWaarde <= data;   
        elsif (prev_valid = '1' and valid = '0' and flag = '1') then -- if flag is set, ignore the next button 
            keyWaarde <= data;
         end if;         
    end if;    
end process; 

toets <= keyWaarde;

end Behavioral;
