library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package componentes_package is
    -- Somador completo (1 bit)
    component somador_completo
        port (
            a, b, cin : in STD_LOGIC;
            sum, cout : out STD_LOGIC
        );
    end component;
    
    -- Somador de 4 bits
    component somador_4bits
        port (
            a    : in  STD_LOGIC_VECTOR(3 downto 0);
            b    : in  STD_LOGIC_VECTOR(3 downto 0);
            cin  : in  STD_LOGIC;
            sum  : out STD_LOGIC_VECTOR(3 downto 0);
            cout : out STD_LOGIC
        );
    end component;
     
    -- Multiplicador 2x2 bits
    component multiplicador
        port (
            x, y : in  std_logic_vector(1 downto 0);
            p    : out std_logic_vector(3 downto 0)
        );
    end component; 
     
    -- Comparador de 4 bits
    component comparador_4bits
        port (
            a    : in  STD_LOGIC_VECTOR(3 downto 0);  
            b    : in  STD_LOGIC_VECTOR(3 downto 0);  
            AeqB : out STD_LOGIC;  -- A igual a B
            AgtB : out STD_LOGIC;  -- A maior que B
            AltB : out STD_LOGIC   -- A menor que B
        );
    end component;
end package componentes_package;