module dm(
    input   clk,

    input	[11:2]      addr,
    input   [3:0]       BE, // Byte enable
    input	[31:0]      din,
    input               DMWr,

    output	reg[31:0]   dout
);

    reg[31:0]   mainMemory[1023:0];
    integer     fd, pointer;

    reg[31:0]   temp_instr;

    always @(posedge clk) begin

        dout = mainMemory[addr[11:2]][31:0];
        $display("DM get addr: %x, dout: %b", addr, dout);

        if (DMWr) begin
            mainMemory[addr[11:2]][31:0] = din;
            $display("DM set addr: %x, dout: %b", addr, din);
        end
    end
endmodule
