--*****************************************************************************
-- CENTRO UNIVERSITARIO FEI
-- Sistemas Digitais II  -  Projeto 1  - 2o Semestre de 2024
-- Prof. Dr. Valter F. Avelino - 07/2024
-- Componente VHDL: Decodificador Hexadecimal / 7 Segmentos => DEC_HEX.vhd
-- Rev. 0
-- Especificacoes: Entradas: Q[3..0]
-- 				    Saidas:   D[6..0]
-- Esse codigo eh um exemplo de descricao VHDL de um decodificador de codigos
-- hexadecimais em codigo para ativacao de display de 7 segmentos da disciplina
-- de Laboratorio de Sistemas Digitais II do Centro Universitario FEI.
--****************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DEC_SIM IS 			  			-- declaracao da entidade DEC_HEX
	PORT 
	(	L 	: IN STD_LOGIC_VECTOR(5 downto 0); 		-- vetor de entrada L[5..0]
		D  : OUT STD_LOGIC_VECTOR(6 downto 0)); 	-- vetor de saida D[6..0]
END DEC_SIM;

ARCHITECTURE SELETOR OF DEC_SIM IS      	
BEGIN
	WITH L SELECT
		D     <=	"1011100" WHEN "000001",	--  0
					"1100011" WHEN "000010",	--  1
					"1011100" WHEN "000100",	--  2
					"1011100" WHEN "001000",	--  4
					"1100011" WHEN "010000",	--  5
					"1100011" WHEN "100000",	--  7
					"1111111" WHEN OTHERS;	-- display Apagado
END SELETOR;
