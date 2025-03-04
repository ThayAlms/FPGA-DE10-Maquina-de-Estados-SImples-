--*****************************************************************************
-- CENTRO UNIVERSITARIO FEI
-- Sistemas Digitais II  -  Projeto 1  - 2o Semestre de 2024
-- Prof. Dr. Valter F. Avelino - 07/2024
-- Componente VHDL: FSM_Exemplo.vhd
-- Rev. 0
-- Especificacoes: Entradas: INI, CK, CK_EN, X, Y
-- 				    Saidas:   Q[3..0], L[5..0]
-- Esse codigo eh um exemplo de descricao VHDL de uma Maquina de Estados
-- Finitos (FSM) de um gerador de codigo de chave automiva para o Projeto 1 
-- da disciplina de Sistemas Digitais II do Centro Universitario FEI.
--**************************************************************************** 
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FSM IS
    PORT (INI, CK, CK_EN, X, Y: IN STD_LOGIC;	  	-- sinais de entrada
	 Q: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);		-- digito gerado
	 L: OUT STD_LOGIC_VECTOR(5 DOWNTO 0));          -- estado da FSM
END FSM;

ARCHITECTURE BEHAVIOR OF FSM IS
    TYPE ME IS (N0, N1, N2, N3, N4, N7);-- declaracao de tipos enumerados
	 SIGNAL E: ME;									-- declaracao de variaveis de estado
    SIGNAL XY: STD_LOGIC_VECTOR(1 DOWNTO 0);
       
BEGIN
	XY <= X & Y;
PROCESS (CK, CK_EN, INI) -- processo para gerar sequencia de codigos
    BEGIN
        IF (INI='0') THEN  E <= N0; 			-- estado inicial do sistema
        ELSIF (CK'event and CK='1'and CK_EN='1') THEN 	
        CASE E IS
			WHEN N0 => 
				IF XY="00" OR XY="11" THEN E<=N1;
				ELSIF XY="10" THEN E<=N2;
				ELSIF XY="01" THEN E<=N7;
				ELSE E <= N0;
				END IF;
			WHEN N1 => 
				IF XY="00" OR XY="10" THEN E<=N2;
				ELSIF XY="11" THEN E<=N4;
				ELSIF XY="01" THEN E<=N0;
				ELSE E <= N1;
				END IF;
			WHEN N2 => 
				IF XY="00" OR XY="10" THEN E<=N3;
				ELSIF XY="11" THEN E<=N4;
				ELSIF XY="01" THEN E<=N1;
				ELSE E <= N2;
				END IF;
			WHEN N3 => 
				IF XY="00" OR XY="11" THEN E<=N4;
				ELSIF XY="10" THEN E<=N0;
				ELSIF XY="01" THEN E<=N2;
				ELSE E <= N3;
				END IF;
			WHEN N4 => 
				IF XY="00" OR XY="11" THEN E<=N7;
				ELSIF XY="10" THEN E<=N0;
				ELSIF XY="01" THEN E<=N3;
				ELSE E <= N4;
				END IF;
			WHEN N7 => 
				IF XY="00" OR XY="10" THEN E<=N0;
				ELSIF XY="11" THEN E<=N1;
				ELSIF XY="01" THEN E<=N4;
				ELSE E <= N3;
				END IF;	
			WHEN OTHERS => E <= N0;
		END CASE;
      END IF;
 END PROCESS;
   
 PROCESS (E)		-- processo para definir variaveis de saida
    BEGIN
	CASE E IS								  
		WHEN N0 => Q <= "0000"; L<= "000001";
		WHEN N1 => Q <= "0001"; L<= "000010";
		WHEN N2 => Q <= "0010"; L<= "000100";
		WHEN N3 => Q <= "0100"; L<= "001000";
		WHEN N4 => Q <= "0101"; L<= "010000";
		WHEN N7 => Q <= "0111"; L<= "100000";
		WHEN OTHERS => NULL;
        END CASE;
END PROCESS;
END BEHAVIOR;
