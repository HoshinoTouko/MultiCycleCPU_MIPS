library verilog;
use verilog.vl_types.all;
entity EXT is
    port(
        clk             : in     vl_logic;
        Immediate16     : in     vl_logic_vector(15 downto 0);
        EXTOp           : in     vl_logic_vector(1 downto 0);
        Immediate32     : out    vl_logic_vector(31 downto 0)
    );
end EXT;
