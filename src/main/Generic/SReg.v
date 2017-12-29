module SReg(
    input               clk,
    input               RegWrite,
    input   [31:0]      Data,
    // For PC
    input               rst,

    output  reg[31:0]   Result
);

    reg[31:0]       Reg;

    always@(negedge clk) begin
        if (RegWrite)
            Result <= Data;
    end

    always@(posedge rst) begin
        Result <= {32'h00003000};
    end

endmodule
