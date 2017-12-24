// R-Type
`define R_OP 6'b000000

// I-Type
// TODO: Fix LBU, LH, LHU, SH, JALR
    // Memory
`define LB_OP 6'100000
`define LBU_OP 6'000000
`define LH_OP 6'000000
`define LHU_OP 6'000000
`define LW_OP 6'100011
`define SB_OP 6'101000
`define SH_OP 6'000000
`define SW_OP 6'101011

    // Imm calculate
`define ADDI_OP 6'001000
`define ADDIU_OP 6'001001
`define ANDI_OP 6'001100
`define ORI_OP 6'001101
`define XORI_OP 6'001110
`define LUI_OP 6'001111
`define SLTI_OP 6'001010
`define SLTIU_OP 6'001011

// Branch
`define BEQ_OP 6'000100
`define BNE_OP 6'000101
`define BLEZ_OP 6'000110
`define BGTZ_OP 6'000111
`define BLTZ_OP 6'000001
`define BGEZ_OP 6'000001

// J
`define J_OP 6'000010
`define JAL_OP 6'000011
`define JALR_OP 6'000000
`define JR_OP 6'000000
