`include "src/main/Define/signal_def.v"
`include "src/main/Define/aluop_def.v"
`include "src/main/Define/op_def.v"

module ALUCtrl(
    input   [5:0]       OP,
    input   [5:0]       funct,
    input   [1:0]       ALUCtrlOp,

    output  reg[31:0]   ALUOp
);

    always@(*) begin
        case(ALUCtrlOp)
            `ALUCTRL_ADD4:
                ALUOp = `ALUOP_ADD;
            `ALUCTRL_RTYPE:
                ALUOp = funct;
            `ALUCTRL_ITYPE: begin
                case(OP)
                    `OP_ADDI:   ALUOp = `ALUOP_ADD;
                    `OP_ADDIU:  ALUOp = `ALUOP_ADDU;
                    `OP_ANDI:   ALUOp = `ALUOP_AND;
                    `OP_ORI:    ALUOp = `ALUOP_OR;
                    `OP_XORI:   ALUOp = `ALUOP_XOR;
                    `OP_LUI:    ALUOp = `ALUOP_LUI;
                    `OP_SLTI:   ALUOp = `ALUOP_SLT;
                    `OP_SLTIU:  ALUOp = `ALUOP_SLTU;
                endcase
            end
            default:
                ALUOp = 0;
        endcase
    end

endmodule
