library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divisor_frecuencia is
    Port ( 
        CLK			: in std_logic;	--clock de entrada
        CLK_DIV     		: out std_logic	--clock de salida
    );
end divisor_frecuencia;

architecture Behavioral of divisor_frecuencia is
    signal count: integer := 0;		--contador iniciado a 0
    signal aux: std_logic := '1';	--senal auxiliar iniicado a 1
begin

    process(CLK) 
	begin
    	
    	if(CLK'event and CLK = '1') then
			
	        count <=count+1;
		  	if(count = 50000 - 1 ) then   -----Poner 50 000 - 1 para aumentar el periodo 100 mil veces
			    aux <= not aux;
			    count <=0;
		    end if;
        end if;
       
	end process;
	
	CLK_DIV <= aux;

end Behavioral;
