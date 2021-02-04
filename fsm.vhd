
library IEEE;
use IEEE.std_logic_1164.all;

entity fsm is
    port (
        RESET      : in  std_logic;		--Boton para reset LOW LVL
        
        B_LARGO    : in  std_logic;		--Boton cafe largo
        B_CORTO    : in  std_logic;		--Boton cafe corto
        
        S_ON	   : in  std_logic;		--Swicth para encendido
        S_LECHE	   : in  std_logic;		--Swicht leche
        S_AZUCAR   : in  std_logic;		--Swicht azucar
        
        CLK        : in  std_logic;		--Señal del reloj
        LIGHT      : out std_logic_vector(0 TO 3); --Leds
        segment_u  : out std_logic_vector(6 downto 0);
        segment_d  : out std_logic_vector(6 downto 0)
    );
end fsm;

architecture behavioral of fsm is

	--//------------ESTADOS DEL SISTEMA---------------
	--S0:= estado de cafetera apagada
    --S1:= estado de reposo
    --S2:= Cafe Corto
    --S3:= Cafe Largo
    
    --Variables para los estados
    type STATES is (S0, S1, S2, S3);   
    signal current_state	: STATES;		--Estado actual
    signal next_state		: STATES;		--Estado siguiente
    signal con_leche   	 	: std_logic;    --0 sin leche 1 con leche
    signal con_azucar   	: std_logic;	--0 sin azucar 1 con leche
    
    --Flags para tipos de cafe
--    signal flag_largo : std_logic;
--    signal flag_corto : std_logic;
    
    --variables para divisor
    --signal clk_divisor      : std_logic;    --1 segundo de ciclo
	--signal aux              : std_logic:='0'; 
    --signal count            : integer:=0;
    
    --contador
    signal contador		    : integer:=0;
    signal flag_fin         :std_logic;
begin


	--divisor de frecuencia
    
  --  process(CLK,) 
	--begin
    	
    	--if(RESET = '1') the
    	
    --	if(CLK'event and CLK = '1') then
    --    	if(current_state = S2 or current_state = S3) then
			
	--			count <=count+1;
	--			if(count = 50000 - 1 ) then   -----Poner 50 - 1
	--			aux <= not aux;
		--			count <=0;

	--			end if;
      --      elsif((current_state=S2 or current_state=S3) and current_state'event) then
      --  		count<= 0;
     --       	aux<= '0';
      --    		clk_divisor<='0';
        		
	--		end if;
     ---   clk_divisor<=aux;
   --     end if;
	--end process;
    
	--//-------CONTADOR DE LOS DOS TIPOS DE CAFE---------------
 --   contador_process: process (next_state,clk_divisor,flag_corto,flag_largo)
 --   begin
 --   	if(next_state = S1) then
 --       	contador <= 0;
 --       end if;
 --       if( flag_corto'event and flag_corto ='1') then
 --       	contador<=10;
 --       elsif( flag_largo'event and flag_largo ='1') then
 --       	contador<=20;
 --       end if;
 --   	if  (clk_divisor'event and clk_divisor ='0') then
 --      	if (current_state = S2 or current_state = S3) then
 --           	
 --           	contador<=contador-1;
 --               
 --           end if;
 --       end if;    	
 --   end process;


	--//-------FUNCIONAMIENTO DEL RESET EN EL SISTEMA----------
    reset_process : process (RESET,CLK)	 
    begin
        if (RESET = '0') then				 --Reset por nivel bajo
            current_state <= S1;
        elsif (CLK'event and CLK = '1') then
            current_state <= next_state;
        end if;          
    end process;
    
	--//-------TRANSCION DE LOS ESTADOS DE LA CAFETERA---------
    next_state_process : process (B_CORTO,B_LARGO,S_ON,current_state,CLK)
    begin  
        
        next_state <= current_state;  	 --Iguala el estado siguiente al actual
        if(  current_state=S0) then
                if S_ON = '1' then
                    next_state <= S1;
                end if; 
                
        elsif current_state=S1 then
            	
            	contador<=3;
 --               flag_largo<='0';
 --               flag_corto<='0';
           	    --Implementacion para añadir leche
            	if S_LECHE = '0' then
                	con_leche <= '0';
                else 
                	con_leche <= '1';
                end if;
                --Implementacion para añadir leche
            	if S_AZUCAR = '0' then
                	con_azucar <= '0';
                else 
                	con_azucar <= '1';
                end if;  
                --Implementacion cambios de estado      
                if B_CORTO = '1' then
 --               	flag_corto <= '1';
                    contador <= 10000;
                    next_state <= S2;
                elsif B_LARGO = '1' then
 --               	flag_largo <= '1';
                    contador <= 20000;
                    next_state <= S3;
                end if;
                
            elsif (current_state=S2 or current_state=S3 ) then
               if (CLK'event and CLK = '1') then
                    contador <= contador -1;            
                    if contador<0 then
                	   next_state <= S1;
                    end if;
                end if;
            else
                next_state <= S0;	--vuelta al estado de reposo
        end if;
        
        -- Apagar la maquina
        if (S_ON = '0') then
        	next_state <= S0;
        end if;
        
    end process;
    
    
    
    
    --//-------GESTION DE LAS SALIDA ASOCIADAS AL ESTADO-----------------
    salidas_process: process (current_state)
    begin
        LIGHT <= (OTHERS => '0');
        
        case current_state is       
        when S1 =>
            LIGHT(0) <= '1';
        when S2 =>
            LIGHT(0) <= '1';
        	LIGHT(1) <= '1';
            
            --Implementacion del caso con leche o sin leche
        	if con_leche = '1' then
            	LIGHT(2) <= '1';
            end if;
            
            --Implementacion del caso con leche o sin leche
        	if con_azucar = '1' then
            	LIGHT(3) <= '1';
            end if;
         when S3 =>
            LIGHT(0) <= '1';
        	LIGHT(1) <= '1';
            
            --Implementacion del caso con leche o sin leche
        	if con_leche = '1' then
            	LIGHT(2) <= '1';
            end if;
            
            --Implementacion del caso con leche o sin leche
        	if con_azucar = '1' then
            	LIGHT(3) <= '1';
            end if;    
        when others =>
            LIGHT <= (OTHERS => '0');
        end case;
    end process;
    
    --//-------SALIDAS DE LOS DISPLAYS-----------------
    display_process: process (contador)
    begin
    
        case (contador/1000 mod 10) is
        when 0 => 
            segment_u <= "0000001";
        when 1 => 
            segment_u <= "1001111";
        when 2 => 
            segment_u <= "0010010";
        when 3 => 
            segment_u <= "0000110";
        when 4 => 
            segment_u <= "1001100";
        when 5 => 
            segment_u <= "0100100";
        when 6 => 
            segment_u <= "0100000";
        when 7 => 
            segment_u <= "0001111";
        when 8 => 
            segment_u <= "0000000";
        when 9 => 
            segment_u <= "0000100";
        when others =>
            segment_u <= "1111110";
        end case;
        
        case (contador/10000) is
        when 0 => 
            segment_d <= "0000001";
        when 1 => 
            segment_d <= "1001111";
        when 2 => 
            segment_d <= "0010010";
        when 3 => 
            segment_d <= "0000110";
        when 4 => 
            segment_d <= "1001100";
        when 5 => 
            segment_d <= "0100100";
        when 6 => 
            segment_d <= "0100000";
        when 7 => 
            segment_d <= "0001111";
        when 8 => 
            segment_d <= "0000000";
        when 9 => 
            segment_d <= "0000100";
        when others =>
            segment_d <= "1111110";
        end case;
                    
    end process;
end behavioral;
