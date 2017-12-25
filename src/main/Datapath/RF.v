module RF(
    input   clk,
    input   RegWrite, // Write data signal
    
    input   [4:0]   ReadAddr1, // Address of 1st. reg to read
    input   [4:0]   ReadAddr2, // Address of 2nd. reg to read

    input   [4:0]   WriteAddr, // Address of 1st. reg to write
    input   [31:0]  WriteData, // Write data
    
    output  [31:0]  ReadData1, // Read data 1
    output  [31:0]  ReadData2  // Read data 2
);

reg[31:0]   register[31:0];
integer     i;

initial 
begin
    for(i = 0; i < 32; i = i + 1)
        register[i] = 0;
end

always@(posedge clk)
begin
    if (WriteAddr != 0 && RegWrite) 
    begin
        register[WriteAddr] = WriteData[31:0];
        $display("RF Write: %x to %d", WriteData[31:0], WriteAddr);
    end
end

assign ReadData1 = register[ReadAddr1];
assign ReadData2 = register[ReadAddr2];

endmodule
