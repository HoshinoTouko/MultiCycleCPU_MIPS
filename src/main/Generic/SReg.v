module SReg(
    input   RegWrite,
    input   [31:0]  Data,

    output  [31:0]  Result
);

    reg[31:0]       Reg;

    always@(RegWrite or Data) begin
        if (RegWrite)
            Reg = Data;
    end

    assign Result = Reg;

endmodule
