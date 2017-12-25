`include "src/main/Define/aluop_def.v"

module alu(
    input   [31:0]  srcA,
    input   [31:0]  srcB,
    input   [4:0]   ALUOp,
    output  Zero,
    output  [31:0] ALUResult
);

    initial begin
        Zero = 0;
        ALUResult = 32'b0;
    end

    always@(*) begin

        // $display("ALU! 1: %x, 2: %x", srcA, srcB);
        // Calc
        // TODO: Resolve unsigned case
        case (ALUOp)
            `ALUOP_ADD  :   ALUResult = srcA + srcB;
            `ALUOP_ADDU :   ALUResult = srcA + srcB;

            `ALUOP_SUB  :   ALUResult = srcA - srcB;
            `ALUOP_SUBU :   ALUResult = srcA - srcB;

            `ALUOP_SLLV :   ALUResult = srcA << srcB;
            `ALUOP_SRLV :   ALUResult = srcA >> srcB;
            `ALUOP_SRAV :   ALUResult = srcA >> srcB;

            `ALUOP_AND  :   ALUResult = srcA & srcB;
            `ALUOP_OR   :   ALUResult = srcA | srcB;
            `ALUOP_XOR  :   ALUResult = srcA ^ srcB;
            `ALUOP_NOR  :   ALUResult = srcA ~| srcB;

            `ALUOP_SLT  :   ALUResult = (srcA < srcB) ? 1 : 0;
            `ALUOP_SLTU :   ALUResult = (srcA < srcB) ? 1 : 0;

            `ALUOP_SLL  :   ALUResult = srcA + srcB;
            `ALUOP_SRL  :   ALUResult = srcA + srcB;
            `ALUOP_SRA  :   ALUResult = srcA + srcB;

            default: ALUResult = 0;
        endcase

        // Zero
        if (srcA == srcB)
            Zero = 1;
        else
            Zero = 0;
    end

endmodule
