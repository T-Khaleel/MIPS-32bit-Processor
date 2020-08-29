library verilog;
use verilog.vl_types.all;
entity my_package_vlg_check_tst is
    port(
        alu_Result      : in     vl_logic_vector(31 downto 0);
        aluop           : in     vl_logic_vector(1 downto 0);
        alusrc          : in     vl_logic;
        beq_control     : in     vl_logic;
        branch_addr     : in     vl_logic_vector(31 downto 0);
        branch_Dec      : in     vl_logic;
        immediate       : in     vl_logic_vector(31 downto 0);
        instruction     : in     vl_logic_vector(31 downto 0);
        jump_dec        : in     vl_logic;
        jumpaddr        : in     vl_logic_vector(31 downto 0);
        memory_data     : in     vl_logic_vector(31 downto 0);
        memtoreg        : in     vl_logic;
        pc_out          : in     vl_logic_vector(31 downto 0);
        rd              : in     vl_logic_vector(31 downto 0);
        regdst          : in     vl_logic;
        regwrite        : in     vl_logic;
        rs              : in     vl_logic_vector(31 downto 0);
        rt              : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end my_package_vlg_check_tst;
