----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2021 21:14:35
-- Design Name: 
-- Module Name: disp_ref_tb - Behavioral
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

entity disp_ref_tb is
--  Port ( );
end disp_ref_tb;

architecture Behavioral of disp_ref_tb is
    signal CLK			: std_logic;                     --Reloj de entrada
    signal ce 			: std_logic;                     --Hay que mostrar o no
    signal segment_u    : std_logic_vector(6 downto 0);  --Segmento unidades
    signal segment_d    : std_logic_vector(6 downto 0);  --Segmento decenas
    signal disp_num 	: std_logic_vector(6 downto 0); --Numero a mostrar en el display
    signal disp_selec   : std_logic_vector(7 downto 0);  --Selección del display

    component disp_ref is 
	port(
    	CLK			: in std_logic;                     --Reloj de entrada
        ce 			: in std_logic;                     --Hay que mostrar o no
        segment_u   : in std_logic_vector(6 downto 0);  --Segmento unidades
        segment_d   : in std_logic_vector(6 downto 0);  --Segmento decenas
        disp_num 	: out std_logic_vector(6 downto 0); --Numero a mostrar en el display
        disp_selec  : out std_logic_vector(7 downto 0)  --Selección del display
    );
    end component;

    constant CLK_PERIOD : time := 1 sec/1000 ; -- Clock period
    
begin
    uut : disp_ref
    port map(
            CLK       => CLK,
            ce        => ce,
            segment_u =>segment_u,
        	segment_d =>segment_d,
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
    
        wait for 0.1 sec;
        ce <= '1';
        wait for 0.1 sec;
        segment_u <= "1001111";
        segment_d <= "0000001";
        
        wait for 1 sec;
        assert false
        	report "[SUCCESS]: simulation finished."
            severity failure; 
    end process;

end Behavioral;
