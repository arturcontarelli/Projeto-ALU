library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.componentes_package.all;

-- Multiplicador de 2 bits, resultado dá 4 bits
Entity multiplicador is
    PORT(
        x, y : IN std_logic_vector(1 downto 0);  -- Entradas (2 bits cada)
        p    : OUT std_logic_vector(3 downto 0)  -- Saída (produto)
    );
end multiplicador;

architecture Behavioral of multiplicador is
    signal partial_prod : std_logic_vector(3 downto 0);  -- Produtos parciais
    signal carry, sum : std_logic_vector(1 downto 0);    -- Sinais pra soma
begin
    -- Multiplica os bits direto, sem somar ainda
    partial_prod(0) <= y(0) and x(0);
    partial_prod(1) <= y(0) and x(1);
    partial_prod(2) <= y(1) and x(0);
    partial_prod(3) <= y(1) and x(1);

    -- Soma os produtos do meio
    SOMA1: somador_completo 
        PORT MAP(
            a => partial_prod(1),
            b => partial_prod(2),
            cin => '0',
            sum => sum(0),
            cout => carry(0)
        );
    
    -- Soma o resultado anterior com o último parcial
    SOMA2: somador_completo 
        PORT MAP(
            a => '0',
            b => partial_prod(3),
            cin => carry(0),
            sum => sum(1),
            cout => carry(1)
        );
    
    -- Junta tudo no vetor final de saída
    p(0) <= partial_prod(0);
    p(1) <= sum(0);
    p(2) <= sum(1);
    p(3) <= carry(1);
end Behavioral;
