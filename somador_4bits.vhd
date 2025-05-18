library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.componentes_package.all;

entity somador_4bits is
    port (
        a    : in  STD_LOGIC_VECTOR(3 downto 0);
        b    : in  STD_LOGIC_VECTOR(3 downto 0);
        cin  : in  STD_LOGIC;
        sum  : out STD_LOGIC_VECTOR(3 downto 0);
        cout : out STD_LOGIC
    );
end somador_4bits;

architecture comportamento of somador_4bits is
    signal c1, c2, c3 : STD_LOGIC;
begin
    U0: somador_completo port map(a(0), b(0), cin,  sum(0), c1);
    U1: somador_completo port map(a(1), b(1), c1,   sum(1), c2);
    U2: somador_completo port map(a(2), b(2), c2,   sum(2), c3);
    U3: somador_completo port map(a(3), b(3), c3,   sum(3), cout);
end comportamento;