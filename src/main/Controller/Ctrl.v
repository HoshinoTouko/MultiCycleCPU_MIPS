
`include "src/main/Define/op_def.v"
module Ctrl(
    input               clk,

    input   [5:0]       OP,

    // About PC Write
    output  reg         PCWriteCond,
    output  reg         PCWrite,
    output  reg[1:0]    PCSource,
    
    // About Memory
    output  reg         MemRead,
    output  reg         MemWrite,
    
    // About Register
    output  reg[1:0]    Mem2Reg,
    output  reg         IRWrite,
    output  reg[1:0]    RegDst,
    output  reg         RegWrite,
    
    // About ALU
    output  reg[1:0]    ALUSrcA,
    output  reg[1:0]    ALUSrcB,
    
    // About ALUControl
    output  reg[1:0]    ALUCtrlOp
);
    integer State;

    initial begin
        State = 0;
    end

    always@(posedge clk) begin

        $display("Current OP: %b", OP);
        $display("Current state: %d", State);

        case (State)

        0:  begin
            // State 0
            PCWriteCond =   0;
            PCWrite     =   1;
            PCSource    =   2'b00;

            MemWrite    =   0;

            Mem2Reg     =   2'b00;
            RegDst      =   2'b00;
            IRWrite     =   1;
            RegWrite    =   0;

            ALUSrcA     =   2'b00;
            ALUSrcB     =   2'b01;
            ALUCtrlOp   =   2'b00;

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
            ALUCtrlOp       =   2'b00;
            PCWriteCond =   0;
            // Next State
            case (OP)
                // R-Type
                `OP_R:      State = 6;
                // Immediate Type
                `OP_ADDI, `OP_ADDIU, `OP_ANDI, `OP_ORI, `OP_XORI, `OP_LUI, `OP_SLTI, `OP_SLTIU:
                            State = 10;
                // Memory
                `OP_LB, `OP_LBU, `OP_LH, `OP_LHU, `OP_LW, `OP_SB, `OP_SH, `OP_SW:
                            State = 2;
                // Branch
                `OP_BEQ, `OP_BNE, `OP_BLEZ, `OP_BGTZ, `OP_BLTZ, `OP_BGEZ:
                            State = 8;
                `OP_J, `OP_JAL, `OP_JALR, `OP_JR:
                            State = 9;
                default:    State = 0;
            endcase
        end

        2:  begin
            // Reset some signals
            // State 2: lw and sw
            ALUSrcA     =   1;
            ALUSrcB     =   10;
            ALUCtrlOp   =   00;
            PCWriteCond =   0;
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
            PCWriteCond =   0;
            // Next State
            State       =   4;
        end

        4: begin
            // Reset some signals
            // State 4: lw Write back
            RegDst      =   2'b00;
            RegWrite    =   1;
            Mem2Reg     =   2'b01;
            PCWriteCond =   0;
            // Next State
            State       =   0;
        end

        5: begin
            // Reset some signals
            // State 5: sw
            MemWrite    =   1;
            PCWriteCond =   0;
            // Next State
            State       =   0;
        end

        6:  begin
            // Reset some signals
            // State 6: R-Type
            ALUSrcA         =   2'b01;
            ALUSrcB         =   2'b00;
            ALUCtrlOp       =   2'b10;
            PCWriteCond =   0;
            // Next State
            State       =   7;
        end

        7:  begin
            // Reset some signals
            // State 7: R-Type / I-Type Write to Reg
            RegDst      =   2'b01;
            RegWrite    =   1;
            Mem2Reg     =   2'b00;
            PCWriteCond =   0;
            // Next State
            State       =   0;
        end

        8: begin
            // Reset some signals
            // State 8: Branch
            ALUSrcA     =   1;
            ALUSrcB     =   2'b00;
            ALUCtrlOp   =   2'b01;
            PCSource    =   2'b01;
            PCWriteCond =   1;
            // Next State
            State       =   0;
        end

        9: begin
            // Reset some signals
            PCWriteCond =   0;
            // State 9: Jump
            PCSource    =   2'b10;
            PCWrite     =   1;
            // Next State
            State       =   0;
        end

        10: begin
            // Reset some signals
            ALUSrcA         =   2'b01;
            ALUSrcB         =   2'b10;
            ALUCtrlOp       =   2'b11;
            PCWriteCond =   0;
            // Next State
            State       =   7;
        end

        default: State  =   0;

        endcase
    end

endmodule