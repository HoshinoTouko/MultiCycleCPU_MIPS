// R-Type
`define OP_R    6'b000000

// I-Type
    // Memory
`define OP_LB   6'b100000
`define OP_LBU  6'b100100
`define OP_LH   6'b100001
`define OP_LHU  6'b100101
`define OP_LW   6'b100011
`define OP_SB   6'b101000
`define OP_SH   6'b101001
`define OP_SW   6'b101011

    // Imm calculate
`define OP_ADDI 6'b001000
`define OP_ADDIU 6'b001001
`define OP_ANDI 6'b001100
`define OP_ORI  6'b001101
`define OP_XORI 6'b001110
`define OP_LUI  6'b001111
`define OP_SLTI 6'b001010
`define OP_SLTIU 6'b001011

// Branch
`define OP_BEQ  6'b000100
`define OP_BNE  6'b000101
`define OP_BLEZ 6'b000110
`define OP_BGTZ 6'b000111
`define OP_BLTZ 6'b000001
`define OP_BGEZ 6'b000001

// J
`define OP_J    6'b000010
`define OP_JAL  6'b000011

