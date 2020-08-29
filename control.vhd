library ieee;
use ieee.std_logic_1164.all;

entity control is
	
	port (
		instruction: in std_logic_vector (31 downto 0);
		reset: in std_logic;
		aluop: out std_logic_vector (1 downto 0):="00";
		jump_dec, regdst, regwrite,memtoreg,alusrc,beq_control,memread,memwrite : out std_logic:='0'
	);
end control;

architecture bvr of control is
--signal instruction: std_logic_vector (31 downto 0):= x"00000020";
shared variable rformat,lw,sw,beq,jump,addi : std_logic :='0';
shared variable opcode: std_logic_vector (5 downto 0);
begin
process(instruction,reset)
	begin
		if(reset='1')then
			regdst<='0';
			regwrite<='0';
			memtoreg<='0';
			aluop<="00";
			memwrite<='0';
			memread<='0';
			jump_dec<='0';
			beq_control<='0';
			alusrc<='0';
		else
			opcode:=instruction(31 downto 26);
			if(opcode = "000000")then
				rformat:='1';
				addi:='0';
				jump:='0';
				beq:='0';
				sw:='0';
				lw:='0';
				alusrc<='0';		

			elsif(opcode = "100011")then
				lw:='1';
				alusrc<='1';
				rformat:='0';		
				addi:='0';
				jump:='0';
				beq:='0';
				sw:='0';
			elsif(opcode = "101011")then
				sw:='1';
				alusrc<='1';
				rformat:='0';		
				addi:='0';
				jump:='0';
				beq:='0';
				lw:='0';
			elsif(opcode = "000100")then
				beq:='1';
				alusrc<='0';
				rformat:='0';		
				addi:='0';
				jump:='0';
				sw:='0';
				lw:='0';
			elsif(opcode = "000010")then
				jump:='1';
				rformat:='0';		
				addi:='0';
				beq:='0';
				sw:='0';
				lw:='0';
			elsif(opcode = "001000")then
				addi:='1';
				alusrc<='1';
				rformat:='0';		
				jump:='0';
				beq:='0';
				sw:='0';
				lw:='0';
			else 
				rformat:='0';		
				addi:='0';
				jump:='0';
				beq:='0';
				sw:='0';
				lw:='0';
				alusrc<='0';
			end if;
regdst<=rformat;
memtoreg<=lw;
			beq_control<=beq;
			
			if(sw='1' or beq = '1')then
				regwrite<='0';
			else
				regwrite<='1';
			end if;
			
			if(rformat='1')then
					aluop<="10";
			elsif(sw = '1' or lw = '1' )then
					aluop<="00";
			elsif(beq = '1')then
					aluop<="01";
			else 
					aluop<="11";
			end if;
			
			jump_dec<=jump;
			memwrite<=sw;
			memread<=lw;
end if;
end process;
			

	end bvr;
	