module Ctrl(
    input clk,

    input   [5:0]   OP,

    // About PC Write
    output          PCWriteCond,
    output          PCWrite,
    output  [1:0]   PCSource,
    
    // About Memory
    output          IorD,
    output          MemRead,
    output          MemWrite,
    
    // About Register
    output          Mem2Reg,
    output          IRWrite,
    output          RegDst,
    output          RegWrite,
    
    // About ALU
    output  [1:0]   ALUSrcA,
    output  [1:0]   ALUSrcB,
    
    // About ALUControl
    output  [1:0]   ALUCtrlOp
);
    integer State;

    initial begin
        State = 0;
    end

    always@(posedge clk) begin

        case (State)

        0:  begin
            // State 0
            IorD        =   0;
            ALUSrcA     =   2'b00;
            ALUSrcB     =   2'b01;
            ALUOp       =   2'b00;
            PCSource    =   2'b01;
            PCWrite     =   1;
            MemRead     =   1;
            IRWrite     =   1;
            // Next State
            State       =   1;
        end

        1:  begin
            // Reset some signals
            PCWrite     =   0;
            MemRead     =   0;
            IRWrite     =   0;
            // State 1
            ALUSrcA     =   2'b00;
            ALUSrcB     =   2'b11;
            ALUOp       =   2'b00;
            PCWriteCond =   0;
            // Next State
            case (OP)
                `OP_R:      State = 6;
                default:    State = 0;
        end

        6:  begin
            // Reset some signals
            // State 6: R-Type
            ALUSrcA     =   2'b01;
            ALUSrcB     =   2'b00;
            ALUOp       =   2'b10;
            PCWriteCond =   0;
            // Next State
            State       =   7;
        end

        7:  begin
            // Reset some signals
            // State 7: R-Type
            RegDst      =   1;
            RegWrite    =   1;
            Mem2Reg     =   0;
            PCWriteCond =   0;
            // Next State
            State       =   0;
        end

        default: State  =   0;

        endcase
    end

endmodule