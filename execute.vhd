library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity execute is  port( 
register_rs: in std_logic_vector(31 downto 0);
register_rt: in std_logic_vector(31 downto 0);
PC4: in std_logic_vector(31 downto 0);
immediate: in std_logic_vector(31 downto 0);
ALUOp: in std_logic_vector(1 downto 0);    
ALUSrc: in std_logic:='0';    
beq_control,clk: in std_logic;    
alu_result, branch_addr: out std_logic_vector(31 downto 0);    
branch_decision: out std_logic); 
end execute;

architecture bvr of execute is 
 
begin 
process (immediate)
variable alu_output: std_logic_vector(31 downto 0);  
variable zero_flag: std_logic := '0';  
variable branch_offset, temp_branch_addr: std_logic_vector(31 downto 0); 
begin   
	if(clk'event and clk='1') then    
	case ALUOp is     
	when "00" =>      
		alu_output:=register_rs+immediate;
	when "01" =>
		alu_output:=register_rs-register_rt;
		if(alu_output = x"00000000")then
			zero_flag:='1';
		end if;
	when "10" => 
		case immediate(5 downto 0) is
			when "100000"=> --add
				alu_output:=register_rs+register_rt;
			when "100010"=>	--subtract
				alu_output:=register_rs-register_rt;
			when "100100"=>	--and
				alu_output:= register_rs and register_rt;
			when others=>	--or
				alu_output:= register_rs or register_rt;
			end case;
			
	when others=>
		alu_output:=x"ffffffff";
	end case;    
	branch_offset:=immediate;    
	temp_branch_addr:=PC4+branch_offset;    
	branch_decision <= (beq_control and zero_flag);    
	branch_addr <= temp_branch_addr;    
	alu_result <= alu_output;   
	end if; 
	end process; 
	
end bvr;