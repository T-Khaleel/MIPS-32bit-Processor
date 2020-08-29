library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity fetch is
	port 
		(
			pc_out, instruction: out std_logic_vector (31 downto 0);
			branch_addr, jump_addr: in std_logic_vector (31 downto 0);
			branch_dec, jump_dec,clk, reset: in std_logic
		);
end fetch;

architecture bvr of fetch is
	type mem_array is array (0 to 15) of std_logic_vector (31 downto 0);
	shared variable mem:mem_array := ( X"00861020",X"8c220000",X"8c230005",X"00622020",X"ac240000",X"00612064",X"08000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000");
	shared variable pc: std_logic_vector (31 downto 0);
	shared variable counter: integer :=0;
	signal tclk: std_logic;
	signal tempclk: std_logic_vector (31 downto 0);
	
	begin
	process(clk)
	begin
	if(rising_edge(clk))then
	tempclk<=tempclk+1;
	end if;
	end process;
	tclk<=tempclk(3);
		process(tclk)
			begin
		if(rising_edge(tclk))then
			if(reset='1')then
			counter:=7;
			pc:=x"00000000";
			
			elsif(branch_dec='1')then
			PC:=branch_addr;
	
			elsif(jump_dec='1')Then
			pc:=jump_addr;
			end if;
			
			instruction<=mem(counter);			
		 	counter:= to_integer (unsigned (pc (3 downto 0 ) ));
			pc:=pc+x"1";
			pc_out<=pc;

		
		end if;

	end process;
	
	end bvr;
		
			
			
	