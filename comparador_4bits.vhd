library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
LIBRARY work;
USE work.componentes_package.all;

-- Comparador de 4 bits: compara se A é igual, maior ou menor que B
entity comparador_4bits is
    Port (
        a   : in  STD_LOGIC_VECTOR(3 downto 0);  -- Entrada A (4 bits)
        b   : in  STD_LOGIC_VECTOR(3 downto 0);  -- Entrada B (4 bits)
        AeqB : out STD_LOGIC;                    -- A == B
        AgtB : out STD_LOGIC;                    -- A > B
        AltB : out STD_LOGIC                     -- A < B
    );
end comparador_4bits;

architecture comportamento of comparador_4bits is
    -- Sinais auxiliares pra igualdade e maior
    signal eq3, eq2, eq1, eq0 : STD_LOGIC;
    signal gt3, gt2, gt1, gt0 : STD_LOGIC;
    signal int_AgtB, int_AeqB : STD_LOGIC;
begin

    -- Verifica se os bits são iguais (XNOR)
    eq3 <= a(3) xnor b(3);
    eq2 <= a(2) xnor b(2);
    eq1 <= a(1) xnor b(1);
    eq0 <= a(0) xnor b(0);

    -- Verifica se A é maior bit a bit, considerando igualdade dos anteriores
    gt3 <= a(3) and not b(3);
    gt2 <= a(2) and not b(2) and eq3;
    gt1 <= a(1) and not b(1) and eq3 and eq2;
    gt0 <= a(0) and not b(0) and eq3 and eq2 and eq1;

    -- A > B se qualquer gt for verdadeiro
    int_AgtB <= gt3 or gt2 or gt1 or gt0;

    -- A == B se todos os bits forem iguais
    int_AeqB <= eq3 and eq2 and eq1 and eq0;

    -- Saídas finais
    AgtB <= int_AgtB;
    AeqB <= int_AeqB;
    AltB <= not (int_AgtB or int_AeqB); -- A < B se não for maior nem igual

end comportamento;
