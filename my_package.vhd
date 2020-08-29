library ieee;
use ieee.std_logic_1164.all;
use work.my_components.all;

entity my_package is
port (
jump_dec,regdst,regwrite,memtoreg,alusrc,beq_control: out std_logic;
jumpaddr: out std_logic_vector (31 downto 0);
branch_Dec: out std_logic;
aluop: out std_logic_vector (1 downto 0);
clk, reset: in std_logic;
instruction,rs,rt,rd,branch_addr,immediate,alu_Result,pc_out,memory_data: out std_logic_vector (31 downto 0)
);
end my_package;
architecture bvr of my_package is
signal bd,j_dec,regd,regw,memtreg,alusr,beqc,memread,memwrite: std_logic;
signal alop: std_logic_vector (1 downto 0);
signal a,pc4,regrs,regrt,imm,branchad,jumpad,ar: std_logic_vector (31 downto 0);
signal regrd: std_logic_vector (31 downto 0);
signal memdata: std_logic_vector (31 downto 0);
begin
	
	
	u1:fetch port map(pc4,a,branchad,jumpad,bd,j_dec,clk,reset);
		instruction<=a;
		pc_out<=pc4;
		u4: control port map(a,reset,alop,j_dec,regd,regw,memtreg,alusr,beqc,memread,memwrite);
		jump_dec<=j_dec;
		regdst<=regd;
		regwrite<=regw;
		memtoreg<=memtreg;
		alusrc<=alusr;
		beq_control<=beqc;
		aluop<=alop;
		
	u2: lab9 port map(a,memdata,ar,regd,regw,memtreg,reset,clk,regrs,regrt,regrd,jumpad,imm);
	rs<=regrs;
	rt<=regrt;
	rd<=regrd;
	immediate<=imm;
	u3: execute port map (regrs,regrt,pc4,imm, alop,alusr,beqc,clk,ar,branchad,bd);
	branch_addr<=branchad;
	jumpaddr<=jumpad;
	branch_Dec<=bd;
	alu_Result<=ar;
		u6: datamem port map(ar,regrt,memwrite,memread,memdata);
memory_data<=memdata;
end bvr;