------------- Quartus Prime VHDL Template
-- Binary Counter

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity counter is

--   generic
--   (
--      n:POSiTIVE:=10
--   );

   port
   (
      CLOCK_50               : in std_logic;
      reset_n                : in std_logic;
      enable              : in std_logic;
      Counter_output      : out std_logic_vector(8 downto 0)
   );

end entity;

architecture rtl of counter is
signal count :std_logic_vector(9 downto 0);
--signal reset1,reset2  :std_logic;
begin 

   
   process (CLOCK_50,reset_n)
      
   begin
			if (reset_n='0') then

				count<=(others=>'0');

         elsif rising_edge (CLOCK_50) then      
         if (enable= '1')  then
            count <= count + 1;

         end if;
      end if;
end process;
      -- Output the current count
			Counter_output<= count;
   

end rtl;
