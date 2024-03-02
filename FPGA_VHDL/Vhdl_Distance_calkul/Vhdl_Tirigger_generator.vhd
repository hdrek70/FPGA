-------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Vhdl_Tirigger_generator is
       port
         (
            CLOCK_50       : in std_logic;
            reset_n       : in std_logic;
            Trigger        : out std_logic; -- Send echo
            rst_cnt        : out std_logic);---reset counter

end entity;

architecture rtl of Vhdl_Tirigger_generator is

 
	signal resetCaunter :std_logic;
	signal outputCaunter: std_logic_vector(23 downto 0);
	
	begin
	
		process(reset_n,cloCK_50)
		begin
			if reset_n = '0' then
				outputCaunter<= (others=>'0');
			elsif rising_edge  (CLOCK_50 )  then
			  if resetCaunter='0' then
					 outputCaunter<= (others=>'0');
			  else
					 outputCaunter<=outputCaunter +1;
				end if;
			end if;
		end process;
		
		
		process(CLOCK_50, reset_n)
		constant ms250        :std_logic_vector(23 downto 0):="101111101000001111000010";
		constant ms250And100us:std_logic_vector(23 downto 0):="101111101100111011111010";
		begin
					if reset_n='0' then
						resetCaunter<='0';
						Trigger<='0';
					elsif rising_edge(cloCK_50) then
						if(outputCaunter>ms250 and outputCaunter < ms250And100us) then
							trigger <='1';
						else
							trigger <='0';
						end if;
					end if;
			 end process;
end rtl;	 

	 

 