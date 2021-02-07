----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2021 20:41:03
-- Design Name: 
-- Module Name: divisor_frecuencia_tb - Behavioral
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

entity divisor_frecuencia_tb is
    --Port ();
end divisor_frecuencia_tb;

architecture Behavioral of divisor_frecuencia_tb is
    signal CLK, CLK_DIV : std_logic;

    component divisor_frecuencia is 
        port (
            CLK			: in std_logic;
            CLK_DIV     : out std_logic
        );
    end component;

    constant CLK_PERIOD : time := 1 sec/100000000 ; -- Clock period
    
begin
    uut : divisor_frecuencia
    port map(
        CLK       => CLK,
        CLK_DIV   => CLK_DIV
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
        wait for 3 ms;
        assert false
        	report "[SUCCESS]: simulation finished."
            severity failure; 
    end process;

end Behavioral;
