library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Somador completo de 1 bit
entity somador_completo is
    port (
        a, b, cin : in  STD_LOGIC;  -- Entradas: dois bits e o carry
        sum, cout : out STD_LOGIC   -- Saídas: soma e vai-um de saída
    );
end somador_completo;

architecture Behavioral of somador_completo is
begin
    sum  <= a xor b xor cin;                       -- Soma
    cout <= (a and b) or (cin and (a xor b));      -- Carry se duas ou mais entradas forem 1
end Behavioral;
