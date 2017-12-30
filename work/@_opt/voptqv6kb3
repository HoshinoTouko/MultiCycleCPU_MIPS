library verilog;
use verilog.vl_types.all;
entity RF is
    port(
        clk             : in     vl_logic;
        RegWrite        : in     vl_logic;
        ReadAddr1       : in     vl_logic_vector(4 downto 0);
        ReadAddr2       : in     vl_logic_vector(4 downto 0);
        WriteAddr       : in     vl_logic_vector(4 downto 0);
        WriteData       : in     vl_logic_vector(31 downto 0);
        ReadData1       : out    vl_logic_vector(31 downto 0);
        ReadData2       : out    vl_logic_vector(31 downto 0)
    );
end RF;
