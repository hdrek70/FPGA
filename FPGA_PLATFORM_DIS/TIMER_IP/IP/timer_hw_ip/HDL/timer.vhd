---
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is
  port (
    clk          : in  std_logic;
    rst_n        : in  std_logic;  ---det noll ställe timer
    i_ctrl_reg   : in  std_logic_vector(1 downto 0);  ---star bitan ska räkna upp
                                                   ---stop bien ska inte räkna upp
    o_timer_data : out std_logic_vector(31 downto 0)  ---timer data skriv ut 32 bit
    );

end entity timer;

architecture rtl of timer is
signal s_timer_cnt : unsigned(31 downto 0);  ---timer counter signal 32 bit ---std_logic-vector<-unsign>--integer


begin  ----architecture rtl
  process (clk, rst_n) is
  begin  ---proces
    ---asynkron reset(acktiva low)
	 
	 if rst_n = '0' then  
      s_timer_cnt <= (others => '0');
    elsif clk' event and clk = '1' then
		
		case i_ctrl_reg is
          ---timer start---varje clk syc räknar upp ett steg                 
			  
			  when"10"=>  
					s_timer_cnt <= s_timer_cnt+1;  
			  ----timer stop ---timer gör ingenting
			  when"00"=>
				s_timer_cnt <= s_timer_cnt;
				 ---timer reset
				when"01"=>
					s_timer_cnt <= (others => '0');  ---noll steller timer
				when others =>
					s_timer_cnt <= s_timer_cnt;

		 end case;
    end if;
    end process;

    o_timer_data <= std_logic_vector(s_timer_cnt);  ---typ omvandling countur till-timer data ut


end architecture rtl;
