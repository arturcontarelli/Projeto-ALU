library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.componentes_package.all;

-- Somador de 4 bits com carry-in e carry-out
entity somador_4bits is
    port (
        a    : in  STD_LOGIC_VECTOR(3 downto 0);  -- Entrada A (4 bits)
        b    : in  STD_LOGIC_VECTOR(3 downto 0);  -- Entrada B (4 bits)
        cin  : in  STD_LOGIC;                     -- Carry de entrada
        sum  : out STD_LOGIC_VECTOR(3 downto 0);  -- Saída da soma
        cout : out STD_LOGIC                      -- Carry final
    );
end somador_4bits;

architecture comportamento of somador_4bits is
    -- Sinais pra passar o carry entre os somadores
    signal c1, c2, c3 : STD_LOGIC;
begin
    -- Somador do bit 0
    U0: somador_completo port map(a(0), b(0), cin,  sum(0), c1);
    -- Somador do bit 1
    U1: somador_completo port map(a(1), b(1), c1,   sum(1), c2);
    -- Somador do bit 2
    U2: somador_completo port map(a(2), b(2), c2,   sum(2), c3);
    -- Somador do bit 3
    U3: somador_completo port map(a(3), b(3), c3,   sum(3), cout);
end comportamento;
