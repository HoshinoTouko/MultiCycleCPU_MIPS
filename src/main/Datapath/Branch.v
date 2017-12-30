`include "src/main/Define/op_def.v"
module Branch(
    input           clk,
    input   [31:0]  SrcA,
    input   [31:0]  SrcB,
    input   [5:0]   OP,
    input   [4:0]   Branch_funct,
    output  reg     BranchSucceed
);

    initial begin
        BranchSucceed = 0;
    end

    always@(negedge clk) begin
        $display("Branch ------ SrcA: %x", SrcA);
        case (OP)
            `OP_BEQ     :   BranchSucceed = SrcA            == SrcB    ? 1 : 0;
            `OP_BNE     :   BranchSucceed = SrcA            != SrcB    ? 1 : 0;
            `OP_BLEZ    :   BranchSucceed = $signed(SrcA)   <= 0       ? 1 : 0;
            `OP_BGTZ    :   BranchSucceed = $signed(SrcA)   >  0       ? 1 : 0;
            `OP_BLTZ, `OP_BGEZ  : begin
                    if (Branch_funct == 5'b00000)
                            BranchSucceed = $signed(SrcA)   <  0       ? 1 : 0;
                    else
                            BranchSucceed = $signed(SrcA)   >= 0       ? 1 : 0;
            end
            default: BranchSucceed = 0;
        endcase
        if(BranchSucceed)
            $display("JUMPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    end

endmodule
