----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2024 04:43:57 PM
-- Design Name: 
-- Module Name: posit_decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity posit_decoder is
    port(
        posit_in : in std_logic_vector(7 downto 0);
        sign_out : out std_logic;   -- 0 is positive 1 is negative
        regime_out : out integer;   -- regime can be both negative or positive
        exponent_out : out std_logic_vector(1 downto 0); -- exponent size 2
        fraction_out : out std_logic_vector(3 downto 0) -- fraction part 4bits
        );
end posit_decoder;

architecture Behavioral of posit_decoder is
    signal exponent : std_logic_vector(1 downto 0);
    signal count_k : integer := 0;

begin
    process (posit_in)
    variable count_k2 : integer := 0;
    variable posit_bits : std_logic_vector(6 downto 0); -- excluding sign bit
    variable regime_k : integer := 0;
    variable fraction : std_logic_vector(3 downto 0);
    begin
        -- extract sign bit
        sign_out <= posit_in(7);
        
        regime_k := 0;
        posit_bits := posit_in(6 downto 0);
        
        if posit_bits(6) = '1' then -- this if does not work for some reason
            -- positive regime
            count_k2 := 0;
            for i in 6 downto 0 loop
                if posit_bits(i) = '1' then
                    count_k2 := count_k2 + 1;
                else
                    exit;
                end if;
            end loop;
            regime_k := count_k2 - 1;
            count_k <= count_k2;
        else
            -- negative regime
            count_k2 := 0;
            for i in 6 downto 0 loop
                if posit_bits(i) = '0' then
                    count_k2 := count_k2 + 1;
                else
                    exit;
                end if;
            end loop;
            regime_k := -count_k2;
            count_k <= count_k2;
        end if;
        
        -- extract exponent
        --exponent <= posit_bits(count_k - 1 downto count_k - 2); -- 2 bits for exponent, starting from count_k - 1 downto count_k - 2
                -- ensure count_k is within valid range before extracting exponent and fraction
        if count_k2 >= 2 then
            -- extract exponent
            exponent <= posit_bits(count_k2 - 1 downto count_k2 - 2); -- 2 bits for exponent, starting from count_k - 1 downto count_k - 2
        else
            exponent <= (others => '0'); -- default value if range is invalid
        end if;
        
--        if count_k2 >= 3 then
--            -- extract fraction field
--            fraction <= posit_bits(count_k2 - 3 downto 0) & '1'; -- ensure valid range
--        else
--            fraction <= (others => '0'); -- default value if range is invalid
--        end if;
        -- extract fraction field
        fraction := posit_bits(3 downto 0);
        
        --output regime
        regime_out <= regime_k;
        
        --output exponent and fraction
        exponent_out <= exponent;
        fraction_out <= fraction;       
    end process;


end Behavioral;
