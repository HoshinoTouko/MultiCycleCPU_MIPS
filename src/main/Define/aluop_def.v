// Classical funct
`define ALUOP_ADD   6'b100000
`define ALUOP_ADDU  6'b100001
`define ALUOP_SUB   6'b100010
`define ALUOP_SUBU  6'b100011
`define ALUOP_SLLV  6'b000100
`define ALUOP_SRLV  6'b000110
`define ALUOP_SRAV  6'b000111
`define ALUOP_AND   6'b100100
`define ALUOP_OR    6'b100101
`define ALUOP_XOR   6'b100110
`define ALUOP_NOR   6'b100111
`define ALUOP_SLT   6'b101010
`define ALUOP_SLTU  6'b101001
// Special funct
`define ALUOP_SLL   6'b000000
`define ALUOP_SRL   6'b000010
`define ALUOP_SRA   6'b000011
// LUI
`define ALUOP_LUI   6'b110000
// JR
`define JROP_JALR   6'b001001
`define JROP_JR     6'b001000
