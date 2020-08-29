library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity datamem is
	--generic (module_delay: time := 10 ns);
	port (
		address,write_data: in std_logic_vector (31 downto 0);
		memwrite,memread: in std_logic;
		read_data: out std_logic_vector (31 downto 0)
	);
end datamem;

architecture bvr of datamem is
		shared variable addr: std_logic_vector (2 downto 0);
		shared variable r: std_logic_vector (31 downto 0);
	begin
		process(memwrite,memread)
			variable mem0: std_logic_vector (31 downto 0):=x"00000000";
			variable mem1: std_logic_vector (31 downto 0):=x"11111111";
			variable mem2: std_logic_vector (31 downto 0):=x"22222222";
			variable mem3: std_logic_vector (31 downto 0):=x"33333333";
			variable mem4: std_logic_vector (31 downto 0):=x"44444444";
			variable mem5: std_logic_vector (31 downto 0):=x"55555555";
			variable mem6: std_logic_vector (31 downto 0):=x"66666666";
			variable mem7: std_logic_vector (31 downto 0):=x"77777777";

			type mem_data is array (0 to 7) of std_logic_vector (31 downto 0);
			variable mem: mem_data := (x"00000000", x"11111111",x"22222222",x"33333333", x"44444444",x"55555555", x"66666666",x"77777777");
			begin	
			addr := address(2 downto 0);
			r:= mem(to_integer(unsigned(addr)));
				if(memwrite='1')then
				mem(to_integer(unsigned(addr))):=write_data;
				end if;
				
				if(memread='1')then
					case addr is
						when "000" =>
						read_data<=mem0;
						when "001" =>
						read_data<=mem1;
						when "010" =>
						read_data<=mem2;
						when "011" =>
						read_data<=mem3;
						when "100" =>
						read_data<=mem4;
						when "101" =>
						read_data<=mem5;
						when "110" =>
						read_data<=mem6;
						when others=>
						read_data<=mem7;
					end case;
				end if;
		end process;
end bvr;