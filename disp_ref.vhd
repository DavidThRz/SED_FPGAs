library IEEE;
use IEEE.std_logic_1164.all;

entity disp_ref is
	port(
    	CLK			: in std_logic;                 --Reloj de entrada
        ce 			: in std_logic;                 --Hay que mostrar o no
        segment_u   : in std_logic_vector(6 downto 0);  	--Segmento unidades
        segment_d   : in std_logic_vector(6 downto 0);  	--Segmento decenas
        disp_num 	: out std_logic_vector(6 downto 0); 	--Numero a mostrar en el display
        disp_selec  : out std_logic_vector(7 downto 0)  	--Selección del display
    );
end disp_ref;

architecture behavioral of disp_ref is

   	signal count            : integer := 0; 	--contador iniciado a 0
	signal clk_divisor      : std_logic;    	--1 segundo de ciclo
	signal aux              : std_logic := '1'; 	--signal auxiliar iniciado a nivel alto

	begin

    		process(CLK) 
			begin
    				if(CLK'event and CLK = '1') then
			
	        			count <=count+1;
		  			if(count = 2 - 1) then  --Poner la division, en este caso 2, unidad y decenas.
			    		aux <= not aux;	--Alterar la senal
			    		count <=0;		--resetear la senial
		    			end if;
        			end if;
       
		end process;
    
	
    	process(ce,segment_u,segment_d,clk_divisor)	--alternar la salida dependiendo del numero a mostrar
   	begin
    	if ce ='0' then
        	disp_selec<="11111111";
        elsif clk_divisor = '1' then
        	disp_num<=segment_u;
          	disp_selec<="11111110";
        elsif clk_divisor = '0' then
        	disp_num<=segment_d;
          	disp_selec<="11111101";
        end if;
    end process;
    
    clk_divisor <= aux;					--asignar la senal auxiliar al clk deseado
    
end behavioral;
