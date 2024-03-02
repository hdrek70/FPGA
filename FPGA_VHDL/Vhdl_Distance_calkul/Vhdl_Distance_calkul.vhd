LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Vhdl_Distance_calkul is
       port
         (
            CLOCK_50       : in std_logic;
            Reset_n        : in std_logic;
            Calkul_reset_n : in std_logic;----kompenet reset (Reset counter)
            Puls           : in std_logic; --'1' ? '0'
            --Tirig          : in std_logic;
            Distance       : out std_logic_vector(8 downto 0)----lendden är 9
         );

end entity;

architecture rtl of Vhdl_Distance_calkul is

--component Counter is
--
----    generic
----    (
----       n:POSiTIVE:=10
----    );
--
--    port
--    (
--      CLOCK_50               : in std_logic;
--      reset_n                : in std_logic;
--      enable              : in std_logic;
--      Counter_output      : out std_logic_vector( 8 downto 0)
--   );


-- end component;
-- component Vhdl_Tirigger_generator is   
--    port
--         (
--            CLOCK_50       : in std_logic;
--            Trigger        : out std_logic
--         );
--  end component;
   
   signal puls_with:  unsigned(21 downto 0);--- "1111" = 15   puls_width = Bredd*tid den räknat
   signal trig_1: std_logic;
   signal caunterout: std_logic_vector(8 downto 0);
   signal counter    :  unsigned (21 downto 0);
   
   
   begin
      
            
--   inst_counter:  Counter
--       port map
--       (
--          CLOCK_50 => CLOCK_50,
--          enable =>Puls ,
--          reset_n  =>  reset_n   ,
--          Counter_output => caunterout,
--        caunterout=>Distance
--       );
      
       
--   inst_trigger: Vhdl_Tirigger_generator
--       port map
--       (
--          CLOCK_50  => CLOCK_50,
--          Trigger   => Tirig
--       
--     );

   process(reset_n,cloCK_50)
   begin
      if reset_n = '0' then
         counter<= (others=>'0');
      elsif rising_edge  (CLOCK_50 )  then
        if Calkul_reset_n='0' then
             counter<= (others=>'0');
        elsif puls='1' then
             counter<=counter +1;
         end if;
      end if;
   end process;

   Distance_calkul: process (puls)
      variable  result 		: integer := 0 ;--start värde noll
      variable  multipira	: unsigned(23 downto 0);
      begin
         if reset_n='0' then 
             distance <= (others => '0');
             result := 0 ;
          elsif rising_edge  (CLOCK_50 )  then
               if puls ='1' then
                  multipira := counter * "11";------------------------------counter(pusl_with)*20ns(50MHz)=nanosekunder
                  result  := to_integer(unsigned(multipira(23 downto 13)));  --Nanonosekunder / 58?(Sensorfördröjning/1000(ms) (())) 12 downto 0. "Fördröjning" 
               else
                  if result < 450 then  -- Sensor Max Range 450CM
                     distance<=std_logic_vector(to_unsigned(result,9));-----typ omvandling från integer till std_logic_vektör
--                     distance<=std_logic_vector(to_unsigned(result,distance'length));-----typ omvandling från integer till std_logic_vektör
               else
                     distance<= (others=>'1');----max värde ---distance<= "111111111";
                  end if;
               end if;
         end if;
   end process  ; 
         
end rtl;
