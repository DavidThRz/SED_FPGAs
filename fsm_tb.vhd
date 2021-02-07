----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2021 20:59:37
-- Design Name: 
-- Module Name: fsm_tb - Behavioral
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

entity fsm_tb is
    --Port ();
end fsm_tb;

architecture Behavioral of fsm_tb is
    signal RESET           : std_logic;
    signal B_LARGO         : std_logic;
    signal B_CORTO         : std_logic;
    signal S_ON	      :   std_logic;		--Swicth para encendido
    signal S_LECHE	  :   std_logic;		--Swicht leche
    signal S_AZUCAR   :   std_logic;		--Swicht azucar
        
    signal CLK        : std_logic;		--Señal del reloj
    signal LIGHT      : std_logic_vector(0 TO 3); --Leds
    signal segment_u  : std_logic_vector(6 downto 0);
    signal segment_d  : std_logic_vector(6 downto 0);

    component fsm is 
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
    end component;

    constant CLK_PERIOD : time := 1 sec/1000 ; -- Clock period
    
begin
    uut : fsm
    port map(
            RESET     =>RESET,
        	B_LARGO   =>B_LARGO,
        	B_CORTO   =>B_CORTO,
        	S_ON	  =>S_ON,
        	S_LECHE   =>S_LECHE,
        	S_AZUCAR  =>S_AZUCAR,
        	CLK       =>CLK,
        	LIGHT     =>LIGHT,
        	segment_u =>segment_u,
        	segment_d =>segment_d
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
    
        wait for 0.1 sec;
        RESET <= '1';
        wait for 0.1 sec;
        S_ON  <= '1';
        
        wait for 0.1 sec;
        B_CORTO <= '1';
        
        wait for 11 sec;
        assert false
        	report "[SUCCESS]: simulation finished."
            severity failure; 
    end process;

end Behavioral;

