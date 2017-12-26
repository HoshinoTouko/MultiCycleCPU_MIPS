library verilog;
use verilog.vl_types.all;
entity SReg is
    port(
        clk             : in     vl_logic;
        RegWrite        : in     vl_logic;
        Data            : in     vl_logic_vector(31 downto 0);
        Result          : out    vl_logic_vector(31 downto 0)
    );
end SReg;
