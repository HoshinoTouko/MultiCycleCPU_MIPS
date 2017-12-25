module Ctrl(
    input clk,

    input   [5:0]   OP,

    // About PC Write
    output          PCWriteCond,
    output          PCWrite,
    output  [1:0]   PCSource,
    output          PCNext,
    
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
            PCNext      =   1;
            IorD        =   0;
            ALUSrcA     =   2'b00;
            ALUSrcB     =   2'b01;
            ALUOp       =   2'b00;
            PCSource    =   2'b00;
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
            PCNext      =   0;
            // State 1
            ALUSrcA     =   2'b00;
            ALUSrcB     =   2'b11;
            ALUOp       =   2'b00;
            PCWriteCond =   0;
            // Next State
            case (OP)
                `OP_R:      State = 6;
                default:    State = 0;
            endcase
        end

        2： begin
            // Reset some signals
            // State 2: lw and sw
            ALUSrcA=1
            ALUSrcB=10
            ALUOp=00
            PCWriteCond=0
            // Next State
            case (OP)
                `OP_LW:     State = 3;
                `OP_SW:     State = 5;
                default:    State = 0;
            endcase
        end

        3: begin
            // Reset some signals
            // State 3: lw
            MemRead     =   1;
            IorD        =   1;
            PCWriteCond =   0;
            // Next State
            State       =   4;
        end

        4: begin
            // Reset some signals
            // State 4: lw Write back
            RegDst      =   0;
            RegWrite    =   1;
            MemtoReg    =   1;
            PCWriteCond =   0;
            // Next State
            State       =   0;
        end

        5: begin
            // Reset some signals
            // State 5: sw
            MemWrite    =   1;
            IorD        =   1;
            PCWriteCond =   0;
            // Next State
            State       =   0;
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

        8: begin
            // Reset some signals
            // State 8: R-Type
            ALUSrcA     =   1;
            ALUSrcB     =   2'b00;
            ALUOp       =   2'b01;
            PCSource    =   2'b01;
            PCWriteCond =   1;
            // Next State
            State       =   0;
        end

        9: begin
            // Reset some signals
            PCWriteCond =   0;
            // State 9: R-Type
            PCSource    =   2'b10;
            PCWrite     =   1;
            // Next State
            State       =   0;
        end

        default: State  =   0;

        endcase
    end

endmodule