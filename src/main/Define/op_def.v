// R-Type
`define OP_R    6'b000000

// I-Type
// TODO: Fix LBU, LH, LHU, SH, JALR
    // Memory
`define OP_LB   6'100000
`define OP_LBU  6'000000
`define OP_LH   6'000000
`define OP_LHU  6'000000
`define OP_LW   6'100011
`define OP_SB   6'101000
`define OP_SH   6'000000
`define OP_SW   6'101011

    // Imm calculate
`define OP_ADDI 6'001000
`define OP_ADDIU 6'001001
`define OP_ANDI 6'001100
`define OP_ORI  6'001101
`define OP_XORI 6'001110
`define OP_LUI  6'001111
`define OP_SLTI 6'001010
`define OP_SLTIU 6'001011

// Branch
`define OP_BEQ  6'000100
`define OP_BNE  6'000101
`define OP_BLEZ 6'000110
`define OP_BGTZ 6'000111
`define OP_BLTZ 6'000001
`define OP_BGEZ 6'000001

// J
`define OP_J    6'000010
`define OP_JAL  6'000011
`define OP_JALR 6'000000
`define OP_JR   6'000000
