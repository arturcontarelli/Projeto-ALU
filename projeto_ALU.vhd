library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.componentes_package.all;

-- ALU com 8 operações diferentes
entity projeto_ALU is
    Port (
        SW : in STD_LOGIC_VECTOR(10 downto 0);    -- Entradas da placa (usadas pra definir AluOp, a e b)
        HEX0 : out STD_LOGIC_VECTOR(0 to 6);      -- Display mostra AluOp
        HEX2 : out STD_LOGIC_VECTOR(0 to 6);      -- Display mostra valor de b
        HEX4 : out STD_LOGIC_VECTOR(0 to 6);      -- Display mostra valor de a
        HEX6 : out STD_LOGIC_VECTOR(0 to 6);      -- Display mostra resultado
        LEDR : out STD_LOGIC_VECTOR(0 to 5)       -- LEDs mostram as flags
    );
end projeto_ALU;

architecture Behavioral of projeto_ALU is
    -- Sinais internos
    signal AluOp : STD_LOGIC_VECTOR(2 downto 0);           -- Código da operação
    signal a, b, result : STD_LOGIC_VECTOR(3 downto 0);    -- Operandos e resultado
    signal zero, overflow, cout, equ, grt, lst : STD_LOGIC;-- Flags
    
    -- Resultados intermediários
    signal add_result, sub_result, mul_result : STD_LOGIC_VECTOR(3 downto 0);
    signal add_cout, sub_cout : STD_LOGIC;
    
begin
    -- Pegando os valores das entradas
    AluOp <= SW(2 downto 0); 
    a <= "0000" when AluOp = "000" else SW(10 downto 7); 
    b <= "0000" when AluOp = "000" else SW(6 downto 3);

    -- Seleciona o resultado com base na operação
    result <= "0000" when AluOp = "000" else
              (a and b) when AluOp = "001" else
              (a or b) when AluOp = "010" else
              (not b) when AluOp = "011" else
              add_result when AluOp = "100" else
              sub_result when AluOp = "101" else
              mul_result when AluOp = "110" else
              "0000"; -- Para comparação (111)
    
    -- Flag zero (resultado igual a zero)
    zero <= '1' when result = "0000" else '0';

    -- Soma (ADD)
    ADD_UNIT: somador_4bits
        port map(
            a => a,
            b => b,
            cin => '0',
            sum => add_result,
            cout => add_cout
        );

    -- Subtração (SUB)
    SUB_UNIT: somador_4bits
        port map(
            a => a,
            b => not b,
            cin => '1', -- Faz complemento de 2 pra subtrair
            sum => sub_result,
            cout => sub_cout
        );

    -- Multiplicação (MUL)
    MULT_UNIT: multiplicador
        port map(
            x => a(1 downto 0),
            y => b(1 downto 0),
            p => mul_result
        );

    -- Comparação (COMP)
    COMP_UNIT: comparador_4bits
        port map(
            a => a,
            b => b,
            AeqB => equ,
            AgtB => grt,
            AltB => lst
        );

    -- Detecta overflow na soma/subtração (bit de sinal errado)
    overflow <= (not a(3) and not b(3) and add_result(3)) or 
                (a(3) and b(3) and not add_result(3)) when AluOp = "100" else
                (not a(3) and b(3) and sub_result(3)) or 
                (a(3) and not b(3) and not sub_result(3)) when AluOp = "101" else
                '0';

    -- Carry (bit que vai além do 4º bit)
    cout <= add_cout when AluOp = "100" else
            sub_cout when AluOp = "101" else
            '0';

    -- HEX0 mostra o código da operação (AluOp)
    with AluOp select
        HEX0 <= "0000001" when "000", -- 0
                "1001111" when "001", -- 1
                "0010010" when "010", -- 2
                "0000110" when "011", -- 3
                "1001100" when "100", -- 4
                "0100100" when "101", -- 5
                "0100000" when "110", -- 6
                "0001111" when "111", -- 7
                "1111111" when others;

    -- HEX2 mostra b
    with b select
        HEX2 <= "0000001" when "0000", -- 0
                "1001111" when "0001", -- 1
                "0010010" when "0010", -- 2
                "0000110" when "0011", -- 3
                "1001100" when "0100", -- 4
                "0100100" when "0101", -- 5
                "0100000" when "0110", -- 6
                "0001111" when "0111", -- 7
                "0000000" when "1000", -- 8
                "0000100" when "1001", -- 9
                "0001000" when "1010", -- A
                "1100000" when "1011", -- B
                "0110001" when "1100", -- C
                "1000010" when "1101", -- D
                "0110000" when "1110", -- E
                "0111000" when "1111", -- F
                "1111111" when others;

    -- HEX4 mostra a
    with a select
        HEX4 <= "0000001" when "0000",
                "1001111" when "0001",
                "0010010" when "0010",
                "0000110" when "0011",
                "1001100" when "0100",
                "0100100" when "0101",
                "0100000" when "0110",
                "0001111" when "0111",
                "0000000" when "1000",
                "0000100" when "1001",
                "0001000" when "1010",
                "1100000" when "1011",
                "0110001" when "1100",
                "1000010" when "1101",
                "0110000" when "1110",
                "0111000" when "1111",
                "1111111" when others;

    -- HEX6 mostra o resultado final
    with result select
        HEX6 <= "0000001" when "0000",
                "1001111" when "0001",
                "0010010" when "0010",
                "0000110" when "0011",
                "1001100" when "0100",
                "0100100" when "0101",
                "0100000" when "0110",
                "0001111" when "0111",
                "0000000" when "1000",
                "0000100" when "1001",
                "0001000" when "1010",
                "1100000" when "1011",
                "0110001" when "1100",
                "1000010" when "1101",
                "0110000" when "1110",
                "0111000" when "1111",
                "1111111" when others;

    -- LEDs indicam as flags
    LEDR(0) <= cout;                             -- Carry
    LEDR(1) <= zero;                             -- Resultado igual a zero
    LEDR(2) <= overflow;                         -- Overflow
    LEDR(3) <= equ when AluOp = "111" else '0';  -- Igual, considerado somente na comparação (111)
    LEDR(4) <= grt when AluOp = "111" else '0';  -- a > b, considerado somente na comparação (111)
    LEDR(5) <= lst when AluOp = "111" else '0';  -- a < b, considerado somente na comparação (111)
    
end Behavioral;
