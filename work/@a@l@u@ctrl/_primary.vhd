library verilog;
use verilog.vl_types.all;
entity ALUCtrl is
    port(
        funct           : in     vl_logic_vector(5 downto 0);
        ALUCtrlOp       : in     vl_logic_vector(1 downto 0);
        ALUOp           : out    vl_logic_vector(31 downto 0)
    );
end ALUCtrl;
