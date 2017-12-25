module Memory(
    input   clk,

    input	wire[11:2] Addr,
    input	reg[31:0] WriteData,
    input   MemRead,
    input   MemWrite,

    output	reg[31:0] ReadData
);

reg[31:0]	mainMemory[1023:0];
integer     fd, pointer;

reg[31:0]   temp_instr;

always @(posedge clk)
begin
    if (MemRead)
    begin
        ReadData = mainMemory[Addr[11:2]][31:0];
        $display("Mem get Addr: %x, ReadData: %b", Addr, ReadData);
    end

    if (MemWrite)
    begin
        mainMemory[Addr[11:2]][31:0] = WriteData;
        $display("Mem set Addr: %x, ReadData: %b", Addr, WriteData);
    end
end
endmodule
