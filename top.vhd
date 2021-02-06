library IEEE;
use IEEE.std_logic_1164.all;

entity top is
    PORT (-- code : IN std_logic_vector(3 DOWNTO 0);
        RESET      : in  std_logic;				--Boton para reset LOW LVL
        
        B_LARGO    : in  std_logic;				--Boton cafe largo
        B_CORTO    : in  std_logic;				--Boton cafe corto
        
        S_ON	   : in  std_logic;				--Swicth para encendido
        S_LECHE	   : in  std_logic;				--Swicht leche
        S_AZUCAR   : in  std_logic;				--Swicht azucar
        
        CLK         : in  std_logic;				--Señal del reloj
        LIGHT       : out std_logic_vector(0 TO 3); 		--Leds
        disp_num 	: out std_logic_vector(6 downto 0);	--numero a mostrar en el instante
        disp_selec  : out std_logic_vector(7 downto 0)		--display de cifras a activar
    );
end top;


architecture Behavioral of top is

    signal boton_sinc_corto: std_logic;
    signal boton_edge_corto: std_logic;
    signal boton_sinc_largo: std_logic;
    signal boton_edge_largo: std_logic;
    signal segment_unid:std_logic_vector(6 downto 0);
    signal segment_dec: std_logic_vector(6 downto 0);
    signal CLK_DIV    : std_logic;
   
    component SYNCHRNZR
        port (
            CLK      : in std_logic;
            ASYNC_IN : in  std_logic;
            SYNC_OUT : out std_logic
        );
    end component;

    component EDGEDTCTR
        port (
            CLK     : in  std_logic;
            SYNC_IN : in  std_logic;
            EDGE    : out std_logic
    );
    end component;

    component fsm
        port (
        RESET      : in  std_logic;		--Boton para reset LOW 
        B_LARGO    : in  std_logic;		--Boton cafe largo
        B_CORTO    : in  std_logic;		--Boton cafe corto
        S_ON	   : in  std_logic;		
        S_LECHE	   : in  std_logic;		--Swicht leche
        S_AZUCAR   : in  std_logic;		--Swicht azucar
       	CLK        : in  std_logic;		--Señal del reloj
        LIGHT      : out std_logic_vector(0 TO 3); --Leds
        segment_u  : out std_logic_vector(6 downto 0);
        segment_d  : out std_logic_vector(6 downto 0)
    );
    end component;

	component disp_ref is
    	port(
    		CLK			: in std_logic;
        	ce 			: in std_logic;
        	segment_u   : in std_logic_vector(6 downto 0);
        	segment_d   : in std_logic_vector(6 downto 0);
        	disp_num 	: out std_logic_vector(6 downto 0);
        	disp_selec  : out std_logic_vector(7 downto 0)
    	);
	end component;

    component divisor_frecuencia is
        port(
            CLK			: in std_logic;
            CLK_DIV     : out std_logic
        );
    end component;

    begin
        Inst_SYNCHRNZR_CORTO: SYNCHRNZR port map(
            CLK      => CLK_DIV,
            ASYNC_IN => B_CORTO,
            SYNC_OUT => boton_sinc_corto
        );
        
        Inst_SYNCHRNZR_LARGO: SYNCHRNZR port map(
            CLK      => CLK_DIV,
            ASYNC_IN => B_LARGO,
            SYNC_OUT => boton_sinc_largo
        );

        Inst_EDGEDTCTR_CORTO: EDGEDTCTR port map(
            CLK     => CLK_DIV,
            SYNC_IN => boton_sinc_corto,
            EDGE    => boton_edge_corto
        );
        Inst_EDGEDTCTR_LARGO: EDGEDTCTR port map(
            CLK     => CLK_DIV,
            SYNC_IN => boton_sinc_largo,
            EDGE    => boton_edge_largo
        );

        Inst_fsm: fsm port map(
            RESET     =>RESET,
        	B_LARGO   =>B_LARGO,
        	B_CORTO   =>B_CORTO,
        	S_ON	  =>S_ON,
        	S_LECHE   =>S_LECHE,
        	S_AZUCAR  =>S_AZUCAR,
        	CLK       =>CLK_DIV,
        	LIGHT     =>LIGHT,
        	segment_u =>segment_unid,
        	segment_d =>segment_dec
        );
        
        Inst_DISP_REF: disp_ref port map(
            CLK     => CLK_DIV,
            ce => S_ON,
            segment_u =>segment_unid,
        	segment_d =>segment_dec,
            disp_num  =>disp_num,
            disp_selec=>disp_selec
        );
        
        Inst_DIV_FREC: divisor_frecuencia port map(
            CLK     => CLK,
            CLK_DIV => CLK_DIV
        );
                
 end Behavioral;
