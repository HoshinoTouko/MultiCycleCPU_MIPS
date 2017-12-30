`include "src/main/Define/signal_def.v"
`include "src/main/Define/op_def.v"
`include "src/main/Define/aluop_def.v"
module Ctrl(
    input               clk,

    input   [5:0]       OP,
    input   [5:0]       funct,

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

        // $display("Current OP: %b", OP);
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
            ALUCtrlOp   =   `ALUCTRL_ADD;
            // Next State
            State       =   1;
            $stop;
        end

        1:  begin
            // Signals
            PCWriteCond =   0;
            PCWrite     =   0;
            PCSource    =   2'b00;

            MemWrite    =   0;

            Mem2Reg     =   2'b00;
            RegDst      =   2'b00;
            IRWrite     =   0;
            RegWrite    =   0;

            ALUSrcA     =   2'b00;
            ALUSrcB     =   2'b11;
            ALUCtrlOp   =   `ALUCTRL_ADD;
            // Reset some signals
            // Next State
            case (OP)
                // R-Type
                `OP_R: begin
                    case (funct)
                        `JROP_JALR, `JROP_JR:
                            State = 9;
                        default:
                            State = 6;
                    endcase
                end
                // Immediate Type
                `OP_ADDI, `OP_ADDIU, `OP_ANDI, `OP_ORI, `OP_XORI, `OP_LUI, `OP_SLTI, `OP_SLTIU:
                            State = 10;
                // Memory
                `OP_LB, `OP_LBU, `OP_LH, `OP_LHU, `OP_LW, `OP_SB, `OP_SH, `OP_SW:
                            State = 2;
                // Branch
                `OP_BEQ, `OP_BNE, `OP_BLEZ, `OP_BGTZ, `OP_BLTZ, `OP_BGEZ:
                            State = 8;
                `OP_J, `OP_JAL:
                            State = 9;
                default:    State = 0;
            endcase
        end

        // State 2: lw & sw
        2:  begin
            // Signals
            PCWriteCond =   0;
            PCWrite     =   0;
            PCSource    =   2'b00;

            MemWrite    =   0;

            Mem2Reg     =   2'b00;
            RegDst      =   2'b00;
            IRWrite     =   0;
            RegWrite    =   0;

            ALUSrcA     =   2'b01;
            ALUSrcB     =   2'b10;
            ALUCtrlOp   =   `ALUCTRL_ADD;
            // Next State
            case (OP)
                `OP_LB, `OP_LBU, `OP_LH, `OP_LHU, `OP_LW:
                    State = 3;
                `OP_SB, `OP_SH, `OP_SW:
                    State = 5;
                default:    State = 0;
            endcase
        end

        // State 3: lw
        3: begin
            // Signals
            PCWriteCond =   0;
            PCWrite     =   0;
            PCSource    =   2'b00;

            MemWrite    =   0;

            Mem2Reg     =   2'b00;
            RegDst      =   2'b00;
            IRWrite     =   0;
            RegWrite    =   0;

            ALUSrcA     =   2'b01;
            ALUSrcB     =   2'b10;
            ALUCtrlOp   =   `ALUCTRL_ADD;
            // Next State
            State       =   4;
        end

        // State 4: lw Write back
        4: begin
            // Signal
            PCWriteCond =   0;
            PCWrite     =   0;
            PCSource    =   2'b00;

            MemWrite    =   0;

            Mem2Reg     =   2'b01;
            RegDst      =   2'b00;
            IRWrite     =   0;
            RegWrite    =   1;

            ALUSrcA     =   2'b01;
            ALUSrcB     =   2'b10;
            ALUCtrlOp   =   `ALUCTRL_ADD;
            // Next State
            State       =   0;
        end

        // State 5: sw write to mem
        5: begin
            // Signals
            PCWriteCond =   0;
            PCWrite     =   0;
            PCSource    =   2'b00;

            MemWrite    =   1;

            Mem2Reg     =   2'b00;
            RegDst      =   2'b00;
            IRWrite     =   0;
            RegWrite    =   0;

            ALUSrcA     =   2'b01;
            ALUSrcB     =   2'b10;
            ALUCtrlOp   =   `ALUCTRL_ADD;
            // Next State
            State       =   0;
        end

        // State 6: R-Type execute
        6:  begin
            // Signals
            PCWriteCond =   0;
            PCWrite     =   0;
            PCSource    =   2'b00;

            MemWrite    =   0;

            Mem2Reg     =   2'b00;
            RegDst      =   2'b00;
            IRWrite     =   0;
            RegWrite    =   0;

            case(funct)
                `ALUOP_SLL, `ALUOP_SRL, `ALUOP_SRA:
                    ALUSrcA     =   2'b10;
                default:
                    ALUSrcA     =   2'b01;
            endcase
            ALUSrcB     =   2'b00;
            ALUCtrlOp   =   `ALUCTRL_RTYPE;
            // Next State
            State       =   7;
        end

        // State 7: R-Type Write to Reg
        7:  begin
            // Signals
            PCWriteCond =   0;
            PCWrite     =   0;
            PCSource    =   2'b00;

            MemWrite    =   0;

            Mem2Reg     =   2'b00;
            RegDst      =   2'b01;
            IRWrite     =   0;
            RegWrite    =   1;

            ALUSrcA     =   2'b01;
            ALUSrcB     =   2'b00;
            ALUCtrlOp   =   `ALUCTRL_ADD;
            // Next State
            State       =   0;
        end

        // State 8: Branch execute
        8: begin
            // Signals
            PCWriteCond =   1;
            PCWrite     =   0;
            PCSource    =   2'b01;

            MemWrite    =   0;

            Mem2Reg     =   2'b00;
            RegDst      =   2'b00;
            IRWrite     =   0;
            RegWrite    =   0;

            ALUSrcA     =   2'b01;
            ALUSrcB     =   2'b00;
            ALUCtrlOp   =   `ALUCTRL_ADD;
            // Next State
            State       =   0;
        end

        // State 9: Jump / JR
        9: begin
            // Signals
            PCWriteCond =   0;
            PCWrite     =   1;
            case(OP)
                `OP_J, `OP_JAL:
                    PCSource    =   2'b10;
                `OP_R:
                    PCSource    =   2'b11;
                default:
                    PCSource    =   2'b10;
            endcase

            MemWrite    =   0;

            Mem2Reg     =   2'b10;
            RegDst      =   2'b10;
            IRWrite     =   0;
            //RegWrite    =   0;
            if(OP == `OP_J || funct == `JROP_JR)
                RegWrite    =   0;
            else
                RegWrite    =   1;

            ALUSrcA     =   2'b00;
            ALUSrcB     =   2'b11;
            ALUCtrlOp   =   `ALUCTRL_ADD;
            // Next State
            State       =   0;
        end

        // State 10: I-Type
        10: begin
            // Signals
            PCWriteCond =   0;
            PCWrite     =   0;
            PCSource    =   2'b00;

            MemWrite    =   0;

            Mem2Reg     =   2'b00;
            RegDst      =   2'b00;
            IRWrite     =   0;
            RegWrite    =   0;

            ALUSrcA     =   2'b01;
            ALUSrcB     =   2'b10;
            ALUCtrlOp   =   `ALUCTRL_ITYPE;
            // Next State
            State       =   11;
        end

        // State 11: I-Type Write to Reg
        11:  begin
            // Signals
            PCWriteCond =   0;
            PCWrite     =   0;
            PCSource    =   2'b00;

            MemWrite    =   0;

            Mem2Reg     =   2'b00;
            RegDst      =   2'b00;
            IRWrite     =   0;
            RegWrite    =   1;

            ALUSrcA     =   2'b01;
            ALUSrcB     =   2'b00;
            ALUCtrlOp   =   `ALUCTRL_ADD;
            // Next State
            State       =   0;
        end

        default: State  =   0;

        endcase
        //$display("ALUCtrlOp: %b", ALUCtrlOp);
    end

endmodule