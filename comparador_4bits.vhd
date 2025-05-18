library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
LIBRARY work;
USE work.componentes_package.all;

entity comparador_4bits is
    Port (
        a   : in  STD_LOGIC_VECTOR(3 downto 0);  
        b   : in  STD_LOGIC_VECTOR(3 downto 0);  
        AeqB : out STD_LOGIC;                     -- A igual a B
        AgtB : out STD_LOGIC;                     -- A maior que B
        AltB : out STD_LOGIC                      -- A menor que B
    );
end comparador_4bits;

architecture comportamento of comparador_4bits is
    signal eq3, eq2, eq1, eq0 : STD_LOGIC;
    signal gt3, gt2, gt1, gt0 : STD_LOGIC;
    signal int_AgtB, int_AeqB : STD_LOGIC;  -- Internal signals

begin

    eq3 <= a(3) xnor b(3);
	   eq2 <= a(2) xnor b(2);
		 eq1 <= a(1) xnor b(1);
		   eq0 <= a(0) xnor b(0);
		
    gt3 <= a(3) and not b(3);
	    gt2 <= a(2) and not b(2) and eq3;
		    gt1 <= a(1) and not b(1) and eq3 and eq2;
			     gt0 <= a(0) and not b(0) and eq3 and eq2 and eq1;
				  
				  
	     int_AgtB <= gt3 or gt2 or gt1 or gt0;
    int_AeqB <= eq3 and eq2 and eq1 and eq0;
    
    
    -- Atribuição das saídas
    AgtB <= int_AgtB;
    AeqB <= int_AeqB;
    AltB <= not (int_AgtB or int_AeqB);
	 
end comportamento;
