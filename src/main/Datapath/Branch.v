module alu(
    input   [31:0]  srcA,
    input   [31:0]  srcB,
    input   [5:0]   OP,
    input   [4:0]   Branch_funct,
    output  BranchSucceed
);

    initial begin
        Zero = 0;
        ALUResult = 32'b0;
    end

    always@(*) begin
        case (OP)
            `OP_BEQ     :   BranchSucceed = srcA == srcB    ? 1 : 0;
            `OP_BNE     :   BranchSucceed = srcA != srcB    ? 1 : 0;
            `OP_BLEZ    :   BranchSucceed = srcA <= 0       ? 1 : 0;
            `OP_BGTZ    :   BranchSucceed = srcA >  0       ? 1 : 0;
            `OP_BLTZ, `OP_BGEZ  : begin
                if (Branch_funct == 5'b00000)
                    BranchSucceed = srcA <  0   ? 1 : 0;
                else
                    BranchSucceed = srcA >= 0   ? 1 : 0;
            end
            default: BranchSucceed = 0;
        endcase

    end

endmodule
