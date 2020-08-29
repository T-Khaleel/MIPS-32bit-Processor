library verilog;
use verilog.vl_types.all;
entity my_package is
    port(
        jump_dec        : out    vl_logic;
        regdst          : out    vl_logic;
        regwrite        : out    vl_logic;
        memtoreg        : out    vl_logic;
        alusrc          : out    vl_logic;
        beq_control     : out    vl_logic;
        jumpaddr        : out    vl_logic_vector(31 downto 0);
        branch_Dec      : out    vl_logic;
        aluop           : out    vl_logic_vector(1 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        instruction     : out    vl_logic_vector(31 downto 0);
        rs              : out    vl_logic_vector(31 downto 0);
        rt              : out    vl_logic_vector(31 downto 0);
        rd              : out    vl_logic_vector(31 downto 0);
        branch_addr     : out    vl_logic_vector(31 downto 0);
        immediate       : out    vl_logic_vector(31 downto 0);
        alu_Result      : out    vl_logic_vector(31 downto 0);
        pc_out          : out    vl_logic_vector(31 downto 0);
        memory_data     : out    vl_logic_vector(31 downto 0)
    );
end my_package;
