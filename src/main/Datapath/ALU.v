`include "src/main/Define/aluop_def.v"

module ALU(
    input   [31:0]      SrcA,
    input   [31:0]      SrcB,
    input   [5:0]       ALUOp,

    output              Zero,
    output  reg[31:0]   ALUResult
);

    initial begin
        ALUResult = 32'b0;
    end

    always@(*) begin

        // $display("ALU! 1: %x, 2: %x", SrcA, SrcB);
        // Calc
        // TODO: Resolve unsigned case
        case (ALUOp)
            `ALUOP_ADD  :   ALUResult = SrcA + SrcB;
            `ALUOP_ADDU :   ALUResult = SrcA + SrcB;

            `ALUOP_SUB  :   ALUResult = SrcA - SrcB;
            `ALUOP_SUBU :   ALUResult = SrcA - SrcB;

            `ALUOP_SLLV :   ALUResult = SrcB << SrcA[4:0];
            `ALUOP_SRLV :   ALUResult = SrcB >> SrcA[4:0];
            `ALUOP_SRAV :   ALUResult = (SrcB >> SrcA[4:0]) | ({32{SrcB[31]}}<<(6'd32-{1'b0,SrcA[4:0]}));

            `ALUOP_AND  :   ALUResult = SrcA & SrcB;
            `ALUOP_OR   :   ALUResult = SrcA | SrcB;
            `ALUOP_XOR  :   ALUResult = SrcA ^ SrcB;
            `ALUOP_NOR  :   ALUResult = ~(SrcA | SrcB);

            `ALUOP_SLT  :   ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 1 : 0;
            `ALUOP_SLTU :   ALUResult = (SrcA < SrcB) ? 1 : 0;

            `ALUOP_SLL  :   ALUResult = SrcB << SrcA[4:0];
            `ALUOP_SRL  :   ALUResult = SrcB >> SrcA[4:0];
            `ALUOP_SRA  :   ALUResult = (SrcB >> SrcA[4:0]) | ({32{SrcB[31]}}<<(6'd32-{1'b0,SrcA[4:0]}));

            `ALUOP_LUI  :   ALUResult = {SrcB[15:0], 16'b0};

            default: ALUResult = 32'b0;
        endcase
        //$display("ALUOp: %b, ALU A:%x, B:%x, Calculate %x", ALUOp, SrcA, SrcB, ALUResult);
    end

endmodule
