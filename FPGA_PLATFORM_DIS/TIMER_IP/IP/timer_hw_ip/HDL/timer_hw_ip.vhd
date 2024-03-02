-------- Quartus Prime VHDL Template
-- Signed Adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer_hw_ip is
  port 

    (
      clk     : in  std_logic;
      rst_n   : in  std_logic;
      ----det signaler  ska kopla till avalon bussen
      cs_n    : in  std_logic;                      ---chip sellektion
      write_n : in  std_logic;
      read_n  : in  std_logic;
      addr    : in  std_logic_vector(1 downto 0);
      din     : in  std_logic_vector(31 downto 0);  ---cpu 32 bitar
      dout    : out std_logic_vector(31 downto 0)  ---output
      );


end entity;

architecture rtl of timer_hw_ip is
component timer is
  port (
    clk          : in  std_logic;
    rst_n        : in  std_logic;  ---det noll st lle timer
    i_ctrl_reg   : in  std_logic_vector(1 downto 0);  ---star bitan ska r kna upp
                                                   ---stop bien ska inte r kna upp
    o_timer_data : out std_logic_vector(31 downto 0)  ---timer data skriv ut 32 bit
    );
end component;

signal s_ctrl_reg:std_logic_vector(1 downto 0);
signal data_reg: std_logic_vector(31 downto 0);                                  
begin
---------------------------------------------------------------------------
---avalonbus control
---------------------------------------------------------------------------
----write
	process (clk, rst_n) is
	  begin  ---process
		 if rst_n = '0' then                 ----asynkron reset(acktive)
			s_ctrl_reg <= (others => '0');
		 elsif rising_edge(clk) then        --- rising cloclk edige
			if cs_n = '0' and write_n = '0' and read_n = '1' and addr = "01" then
			  s_ctrl_reg <= din(31 downto 30);              ---kontrol register
			 end if;
			end if;
			
	  end process;
      ----read
     process(cs_n, read_n, addr,write_n, data_reg) is

      begin  ----process
        if cs_n = '0' and write_n = '1' and read_n = '0' and addr="00" then
          dout <= data_reg;
        else
          dout <= (others => '0');      ---'x'
        end if;
      end process;
---------------------------------------------------------------------------
----timer component instanser
-------------------------------------------------------------------------------
  timer_oi:timer
    port map
	 (
    clk          =>clk,
    rst_n        => rst_n,
    i_ctrl_reg   => s_ctrl_reg,
    o_timer_data =>data_reg
    );
 
  
  
  
 end rtl;