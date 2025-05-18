library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.componentes_package.all;

Entity multiplicador is
    PORT(
        x, y : IN std_logic_vector(1 downto 0);  -- Entradas de 2 bits
        p    : OUT std_logic_vector(3 downto 0)   -- Produto de 4 bits
    );
end multiplicador;

architecture Behavioral of multiplicador is
    signal partial_prod : std_logic_vector(3 downto 0);
    signal carry, sum : std_logic_vector(1 downto 0);
begin
    -- Cálculo dos produtos parciais
    partial_prod(0) <= y(0) and x(0);  -- bit 0 * bit 0
    partial_prod(1) <= y(0) and x(1);  -- bit 1 * bit 0
    partial_prod(2) <= y(1) and x(0);  -- bit 0 * bit 1
    partial_prod(3) <= y(1) and x(1);  -- bit 1 * bit 1
    
    -- Primeiro somador: partial_prod(1) + partial_prod(2)
    SOMA1: somador_completo 
        PORT MAP(
            a => partial_prod(1),
            b => partial_prod(2),
            cin => '0',
            sum => sum(0),
            cout => carry(0)
        );
    
    -- Segundo somador: carry(0) + partial_prod(3) + 0
    SOMA2: somador_completo 
        PORT MAP(
            a => carry(0),
            b => partial_prod(3),
            cin => '0',
            sum => sum(1),
            cout => carry(1)
        );
    
    -- Montagem do produto final
    p(0) <= partial_prod(0);  -- Bit menos significativo
    p(1) <= sum(0);           -- Segundo bit
    p(2) <= sum(1);           -- Terceiro bit
    p(3) <= carry(1);         -- Bit mais significativo
end Behavioral;