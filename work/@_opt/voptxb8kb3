library verilog;
use verilog.vl_types.all;
entity Ctrl is
    port(
        clk             : in     vl_logic;
        OP              : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        PC              : in     vl_logic_vector(31 downto 0);
        PCWriteCond     : out    vl_logic;
        PCWrite         : out    vl_logic;
        PCSource        : out    vl_logic_vector(1 downto 0);
        MemRead         : out    vl_logic;
        MemWrite        : out    vl_logic;
        Mem2Reg         : out    vl_logic_vector(1 downto 0);
        IRWrite         : out    vl_logic;
        RegDst          : out    vl_logic_vector(1 downto 0);
        RegWrite        : out    vl_logic;
        ALUSrcA         : out    vl_logic_vector(1 downto 0);
        ALUSrcB         : out    vl_logic_vector(1 downto 0);
        ALUCtrlOp       : out    vl_logic_vector(1 downto 0)
    );
end Ctrl;
