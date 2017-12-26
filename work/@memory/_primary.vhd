library verilog;
use verilog.vl_types.all;
entity Memory is
    port(
        clk             : in     vl_logic;
        Addr            : in     vl_logic_vector(11 downto 2);
        BE              : in     vl_logic_vector(3 downto 0);
        WriteData       : in     vl_logic_vector(31 downto 0);
        MemWrite        : in     vl_logic;
        ReadData        : out    vl_logic_vector(31 downto 0)
    );
end Memory;
