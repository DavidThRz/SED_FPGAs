----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2021 13:52:47
-- Design Name: 
-- Module Name: divisor_frecuencia - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divisor_frecuencia is
    Port ( 
        CLK			: in std_logic;
        CLK_DIV     : out std_logic
    );
end divisor_frecuencia;

architecture Behavioral of divisor_frecuencia is
    signal count: integer := 0;
    signal aux: std_logic := '1';
begin

    process(CLK) 
	begin
    	
    	if(CLK'event and CLK = '1') then
			
	        count <=count+1;
		  	if(count = 50000 - 1 ) then   -----Poner 50 000 - 1
			    aux <= not aux;
			    count <=0;
		    end if;
        end if;
       
	end process;
	
	CLK_DIV <= aux;

end Behavioral;
