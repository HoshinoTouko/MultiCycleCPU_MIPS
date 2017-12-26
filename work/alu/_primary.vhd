library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        SrcA            : in     vl_logic_vector(31 downto 0);
        SrcB            : in     vl_logic_vector(31 downto 0);
        ALUOp           : in     vl_logic_vector(5 downto 0);
        Zero            : out    vl_logic;
        ALUResult       : out    vl_logic_vector(31 downto 0)
    );
end alu;
