module SReg(
    input   clk,
    input   RegWrite,
    input   [31:0]  Data,

    output  [31:0]  Result
);

    reg[31:0]       Reg;

    always@(posedge clk) begin
        if (RegWrite)
            Reg = Data;
    end

    assign Result = Reg;

endmodule
