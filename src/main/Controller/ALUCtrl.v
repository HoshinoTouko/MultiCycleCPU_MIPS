`include "src/main/Define/signal_def.v"
`include "src/main/Define/aluop_def.v"
`include "src/main/Define/op_def.v"

module ALUCtrl(
    input   [5:0]       OP,
    input   [5:0]       funct,
    input   [1:0]       ALUCtrlOp,

    output  reg[5:0]    ALUOp,
    output  reg[1:0]    EXTOp
);

    always@(*) begin
        case(ALUCtrlOp)
            `ALUCTRL_ADD: begin
                EXTOp = `EXTOP_SIGNED;
                ALUOp = `ALUOP_ADD;
            end
            `ALUCTRL_ADDU: begin
                EXTOp = `EXTOP_UNSIGNED;
                ALUOp = `ALUOP_ADD;
            end
            `ALUCTRL_RTYPE: begin
                ALUOp = funct;
            end
            `ALUCTRL_ITYPE: begin
                case(OP)
                    `OP_ADDI:   begin
                        EXTOp   =   `EXTOP_SIGNED;
                        ALUOp   =   `ALUOP_ADD;
                    end
                    `OP_ADDIU:  begin
                        EXTOp   =   `EXTOP_UNSIGNED;
                        ALUOp   =   `ALUOP_ADDU;
                    end
                    `OP_ANDI:   begin
                        EXTOp   =   `EXTOP_UNSIGNED;
                        ALUOp   =   `ALUOP_ANDI;
                    end
                    `OP_ORI:    begin
                        EXTOp   =   `EXTOP_UNSIGNED;
                        ALUOp   =   `ALUOP_ORI;
                    end
                    `OP_XORI:   begin
                        EXTOp   =   `EXTOP_UNSIGNED;
                        ALUOp   =   `ALUOP_XORI;
                    end
                    `OP_LUI:    begin
                        EXTOp   =   `EXTOP_UNSIGNED;
                        ALUOp   =   `ALUOP_LUI;
                    end
                    `OP_SLTI:   begin
                        EXTOp   =   `EXTOP_SIGNED;
                        ALUOp   =   `ALUOP_SLT;
                    end
                    `OP_SLTIU:  begin
                        EXTOp   =   `EXTOP_UNSIGNED;
                        ALUOp   =   `ALUOP_SLTU;
                    end
                    default:    ALUOp = 2'b000000;
                endcase
            end
            default:
                ALUOp = 0;
        endcase
        //$display("ALUCtrl INFO: ALUCtrlOp: %b, ALUOp: %b", ALUCtrlOp, ALUOp);
    end

endmodule
