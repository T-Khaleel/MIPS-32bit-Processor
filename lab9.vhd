library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab9 is
	port (	
				instruction,memory_data, Alu_result : in std_logic_vector(31 downto 0);
				regdst, regwrite,memtoreg,reset,clk: in std_logic;
				register_rs, register_rt, register_rd, jump_addr,immediate: out std_logic_vector (31 downto 0)
				);
	end lab9;

architecture bvr of lab9 is
	type reg is array (0 to 7) of std_logic_vector (31 downto 0);
	shared variable mem: reg := (x"00000000", x"00000001",x"00000002",x"00000003", x"00000004",x"00000005", x"00000006",x"00000007");
	
begin	
 process(reset, memory_data, Alu_result,clk)
	variable write_value: std_logic_vector (31 downto 0);
	variable addr1, addr2, addr3: std_logic_vector(4 downto 0);
	variable write_reg: std_logic_vector (4 downto 0);
	variable reg_write: std_logic_vector (4 downto 0);
	variable rt, rs, imm : std_logic_vector(31 downto 0);  
	begin
	if(clk='1' and clk'event)then
			addr1:= instruction(25 downto 21); -- rs
			addr2:= instruction(20 downto 16); -- rt
			addr3:= instruction(15 downto 11); -- rd
		if(reset='1') then
			mem(0):=x"00000000";
			mem(1):=x"11111111";
			mem(2):=x"22222222";
			mem(3):=x"33333333";
			mem(4):=x"44444444";
			mem(5):=x"55555555";
			mem(6):=x"66666666";
			mem(7):=x"77777777";
			
		else	
		if(regdst='0')then
			reg_write:=addr2;  -- regwrite=rt
		else
			reg_write:=addr3;	 -- regwrite=rd
		end if;
	
		if(regwrite='1')then
			if (memtoreg = '1')then
				write_value:=memory_data;
			else
				write_value:=Alu_result;
			end if;
	
			if(to_integer(unsigned(reg_write)) = 0)then
				mem(0):=x"00000000";
			else
				mem( to_integer(unsigned(reg_write)) ):=write_value;
			end if;
	end if;
	end if;
			rs:=mem( to_integer (unsigned (addr1)));
			register_rs<=rs;
			rt:=mem( to_integer (unsigned (addr2)));	
			register_rt<=rt;
			register_rd<=mem(to_integer (unsigned(addr3)));
			imm(15 downto 0):=instruction(15 downto 0);  
		
		if (instruction(15)='1')then  
			imm(31 downto 16):=x"ffff";  
		else  
			imm(31 downto 16):=x"0000";  
		end if; 
	
		jump_addr(31 downto 0)<= "000000" & instruction(25 downto 0);
		--register_rs<=rs;
		--register_rt<=rt;
		immediate<=imm;
end if;
end process reg_write;	


--process(instruction)
	--	variable rt, rs, imm : std_logic_vector(31 downto 0);  
	--	variable addr1, addr2 : std_logic_vector(4 downto 0);  
	--begin 
		--	addr1:= instruction(25 downto 21); -- rs
		--	addr2:= instruction(20 downto 16); -- rt
			
		
		--imm(15 downto 0):=instruction(15 downto 0);  
		--if (instruction(15)='1')then  
			--imm(31 downto 16):=x"ffff";  
		--else  
		--	imm(31 downto 16):=x"0000";  
		--end if; 
	
		--jump_addr(31 downto 0)<= "000000" & instruction(25 downto 0);
		--register_rs<=rs;
		--register_rt<=rt;
		--immediate<=imm;
		
	--end process;
end bvr;			