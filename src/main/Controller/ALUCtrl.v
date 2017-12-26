`include "src/main/Define/signal_def.v"
`include "src/main/Define/aluop_def.v"

module ALUCtrl(
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
            default:
                ALUOp = 0;
        endcase
    end

endmodule
