library ieee;
use ieee.std_logic_1164.all;

package my_components is
component control is
port (
		instruction: in std_logic_vector (31 downto 0);
		reset: in std_logic;
		aluop: out std_logic_vector (1 downto 0):="00";
		jump_dec, regdst, regwrite,memtoreg,alusrc,beq_control,memread,memwrite : out std_logic:='0'
	);
	end component;
component datamem is
	--generic (module_delay: time := 10 ns);
	port (
		address,write_data: in std_logic_vector (31 downto 0);
		memwrite,memread: in std_logic;
		read_data: out std_logic_vector (31 downto 0)
	);
end component;
	component execute is 
	  port( 
register_rs: in std_logic_vector(31 downto 0);
register_rt: in std_logic_vector(31 downto 0);
PC4: in std_logic_vector(31 downto 0);
immediate: in std_logic_vector(31 downto 0);
ALUOp: in std_logic_vector(1 downto 0);    
ALUSrc: in std_logic:='0';    
beq_control,clk: in std_logic;    
alu_result, branch_addr: out std_logic_vector(31 downto 0);    
branch_decision: out std_logic);
end component;

component fetch is
	port 
		(
			pc_out, instruction: out std_logic_vector (31 downto 0);
			branch_addr, jump_addr: in std_logic_vector (31 downto 0);
			branch_dec, jump_dec,clk, reset: in std_logic
		);


end component;

component lab9 is
port (	
				instruction,memory_data, Alu_result : in std_logic_vector(31 downto 0);
				regdst, regwrite,memtoreg,reset,clk: in std_logic;
				register_rs, register_rt, register_rd, jump_addr,immediate: out std_logic_vector (31 downto 0)
				);

end component;
end my_components;