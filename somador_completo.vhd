library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador_completo is
    port (
        a, b, cin : in  STD_LOGIC;
        sum, cout : out STD_LOGIC
    );
end somador_completo;

architecture Behavioral of somador_completo is
begin
    sum  <= a xor b xor cin;
    cout <= (a and b) or (cin and (a xor b));
end Behavioral;