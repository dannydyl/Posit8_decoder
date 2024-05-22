
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2024 08:42:54 PM
-- Design Name: 
-- Module Name: posit_decoder_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity posit_decoder_tb is
--  Port ( );
end posit_decoder_tb;

architecture Behavioral of posit_decoder_tb is
    -- Testbench signals
    signal posit_in : STD_LOGIC_VECTOR(7 downto 0);
    signal sign_out : STD_LOGIC;
    signal regime_out : INTEGER;
    signal exponent_out : STD_LOGIC_VECTOR(1 downto 0);
    signal fraction_out : STD_LOGIC_VECTOR(3 downto 0);
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity posit_decoder
        Port map (
            posit_in => posit_in,
            sign_out => sign_out,
            regime_out => regime_out,
            exponent_out => exponent_out,
            fraction_out => fraction_out
        );

        -- Test process
    stim_proc: process
    begin
        -- Test case: input POSIT8 value
        posit_in <= "11110110";  -- Example POSIT8 value

        -- Wait for some time to observe the outputs
        wait for 30 ns;

        -- Stop simulation
        wait;
    end process;
    
end Behavioral;
