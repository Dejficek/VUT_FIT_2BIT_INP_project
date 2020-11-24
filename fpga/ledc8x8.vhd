-- Autor reseni: SEM DOPLNTE VASE, JMENO, PRIJMENI A LOGIN

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ledc8x8 is
port (
		ROW : out std_logic_vector (0 to 7);
		LED : out std_logic_vector (0 to 7);
		RESET : in std_logic;
		SMCLK : in std_logic

);
end ledc8x8;

architecture main of ledc8x8 is
signal leds: std_logic_vector (0 to 7) := (others => '0');
signal rows: std_logic_vector (0 to 7) := "10000000";
signal my_clk: std_logic := '0';
signal my_clk_counter: std_logic_vector (0 to 11) := (others => '0');
signal cnt: std_logic_vector (0 to 22) := (others => '0');
signal state: std_logic_vector (0 to 1) := "01";


    -- Sem doplnte definice vnitrnich signalu.

begin

	my_clk_gen: process(SMCLK, RESET)
		begin
			if RESET = '1' then
				my_clk_counter <= (others => '0');
			elsif SMCLK'event and SMCLK = '1' then
				my_clk_counter <= my_clk_counter + 1;
				if my_clk_counter = "111000010000" then
					my_clk <= '1';
					my_clk_counter <= (others => '0');
				else
					my_clk <= '0';
				end if;
			end if;
		end process my_clk_gen;
		
	counter: process(SMCLK, RESET)
		begin
			if RESET = '1' then
				cnt <= (others => '0');
			elsif SMCLK'event and SMCLK = '1' then
				cnt <= cnt + 1;
				if cnt = "01110000100000000000000" and state = "01" then
					state <= "10";
				elsif cnt = "11100001000000000000000" and state = "10" then
					state <= "11";
				end if;
			end if;
		end process counter;
		
		
	rows_changer: process(SMCLK, RESET, my_clk)
		begin
			if RESET = '1' then
				rows <= "10000000";
			elsif SMCLK'event and SMCLK = '1' then
				if my_clk = '1' then
					rows <= rows(7) & rows(0 to 6);
				end if;
			end if;
		end process rows_changer;
		
	leds_activate: process(rows, state)
		begin
			if state = "00" or state = "10" then
				case rows is
					when "10000000" => leds <= "11111111";
					when "01000000" => leds <= "11111111";
					when "00100000" => leds <= "11111111";
					when "00010000" => leds <= "11111111";
					when "00001000" => leds <= "11111111";
					when "00000100" => leds <= "11111111";
					when "00000010" => leds <= "11111111";
					when "00000001" => leds <= "11111111";
					when others => leds <= (others => '1');
				end case;
			
			elsif state = "01" or state = "11" then
				case rows is
					when "10000000" => leds <= "00011111";
					when "01000000" => leds <= "01101111";
					when "00100000" => leds <= "01101111";
					when "00010000" => leds <= "01100001";
					when "00001000" => leds <= "00010110";
					when "00000100" => leds <= "11110001";
					when "00000010" => leds <= "11110110";
					when "00000001" => leds <= "11110110";
					when others => leds <= (others => '1');
				end case;
			end if;
			
		end process leds_activate;
	
	
    -- Sem doplnte popis obvodu. Doporuceni: pouzivejte zakladni obvodove prvky
    -- (multiplexory, registry, dekodery,...), jejich funkce popisujte pomoci
    -- procesu VHDL a propojeni techto prvku, tj. komunikaci mezi procesy,
    -- realizujte pomoci vnitrnich signalu deklarovanych vyse.

    -- DODRZUJTE ZASADY PSANI SYNTETIZOVATELNEHO VHDL KODU OBVODOVYCH PRVKU,
    -- JEZ JSOU PROBIRANY ZEJMENA NA UVODNICH CVICENI INP A SHRNUTY NA WEBU:
    -- http://merlin.fit.vutbr.cz/FITkit/docs/navody/synth_templates.html.

    -- Nezapomente take doplnit mapovani signalu rozhrani na piny FPGA
    -- v souboru ledc8x8.ucf.
	 
	 ROW <= rows;
	 LED <= leds;

end main;




-- ISID: 75579
