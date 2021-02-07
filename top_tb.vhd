
library IEEE;
use IEEE.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is
signal RESET,B_LARGO,B_CORTO,S_ON,S_LECHE,S_AZUCAR,CLK:std_logic;
signal LIGHT :std_logic_vector(0 to 3);
signal disp_num 	: std_logic_vector(6 downto 0);
signal disp_selec   : std_logic_vector(7 downto 0);


component top is
  PORT (-- code : IN std_logic_vector(3 DOWNTO 0);
        RESET      : in  std_logic;		--Boton para reset LOW LVL
        
        B_LARGO    : in  std_logic;		--Boton cafe largo
        B_CORTO    : in  std_logic;		--Boton cafe corto
        
        S_ON	   : in  std_logic;		--Swicth para encendido
        S_LECHE	   : in  std_logic;		--Swicht leche
        S_AZUCAR   : in  std_logic;		--Swicht azucar
        
        CLK        : in  std_logic;		--Señal del reloj
        LIGHT      : out std_logic_vector(0 TO 3); --Leds
        disp_num   : out std_logic_vector(6 downto 0);
        disp_selec : out std_logic_vector(7 downto 0)

    );
end component;

constant CLK_PERIOD : time := 1 sec/100000000 ; -- Clock period
begin
    uut : top
    port map(
        RESET     =>RESET,
        B_LARGO   =>B_LARGO,
        B_CORTO   =>B_CORTO,
        S_ON	  =>S_ON,
        S_LECHE   =>S_LECHE,
        S_AZUCAR  =>S_AZUCAR,
        CLK       =>CLK,
        LIGHT     =>LIGHT,
        disp_num  =>disp_num,
        disp_selec=>disp_selec
    );

	clkgen: process
    begin
        CLK <= '0';
        wait for 0.5 *CLK_PERIOD;
        CLK <= '1';
        wait for 0.5 *CLK_PERIOD;
    end process;
    
    
    tester: process
    begin	
    	RESET <= '0', '1' after 0.1 sec;
    	S_ON <= '0', '1' after 0.15 sec;
  
        wait for 0.2 sec;
        
        --hacer un cafe largo con azucar
        S_LECHE<='0';
        S_AZUCAR<='1';
        wait for 0.1 sec;
        B_LARGO<='1';
        wait for 1 sec;
        B_LARGO<='0';
        wait for 25 sec;
        
        --hacer un cafe corto con leche
        
        S_LECHE<='1';
        S_AZUCAR<='0';
        wait for 0.25 sec;
        B_CORTO<='1';
        wait for 1 sec;
        B_CORTO<='0';
        wait for 15 sec;
        
        --reset en mitad de cafe corto
        
        S_LECHE<='1';
        S_AZUCAR<='0';
        wait for 0.25 sec;
        B_CORTO<='1';
        wait for 1 sec;
        B_CORTO<='0';
        wait for 5 sec;
        
        RESET <= '0';
        wait for 1 sec;
        RESET <= '1';
        wait for 5 sec;
        
        -- pulsar boton cuando esta en reset
        
        RESET <= '0';
        wait for 0.25 sec;
        B_CORTO<='1';
        wait for 1 sec;
        B_CORTO<='0';
        wait for 5 sec;
        RESET <= '1';
        
        --pulsar tecaldo cuando esta apagado
        S_ON <= '0';
        wait for 5 sec;
        B_CORTO<='1';
        wait for 1 sec;
        B_CORTO<='0';
        wait for 1 sec;
        RESET <= '0';
        wait for 1 sec;
        RESET <= '1';
        wait for 1 sec;
        
        wait for 0.25 * CLK_PERIOD;
        assert false
        	report "[SUCCESS]: simulation finished."
            severity failure;        
    end process;
    
end Behavioral;