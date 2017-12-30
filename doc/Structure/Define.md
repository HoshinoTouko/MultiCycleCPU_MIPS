# Folder *Define*

## op_def.v

In this file, all instruction's op will be defined to improve the program's readability.

### R-Type

> ALL 6'b000000

- ADD、ADDU、SUB、SUBU、SLL、SRL、SRA、SLLV、SRLV、SRAV、AND、OR、XOR、NOR、SLT、SLTU

### I-Type

#### Memory

| Instr     | Op Code   | Syntax            | Operation |
| :---:     | :-----:   | :----:            | :-------: |
| LB        | 100000    | lb $t, offset($s) | $t = MEM[$s + offset]; advance_pc (4);|
| LBU       | 100100    | lbu $t, offset($s)| |
| LH        | 100001    | lh $t, offset($s) | |
| LHU       | 100101    | lhu $t, offset($s)| |
| LW        | 100011    | lw $t, offset($s) | $t = MEM[$s + offset]; advance_pc (4);|
| SB        | 101000    | sb $t, offset($s) | MEM[$s + offset] = (0xff & $t); advance_pc (4);|
| SH        | 101001    | sh $t, offset($s) | |
| SW        | 101011    | sw $t, offset($s) | MEM[$s + offset] = $t; advance_pc (4);|

#### Imm calculate

| Instr     | Op Code   | Syntax            | Operation |
| :---:     | :-----:   | :----:            | :-------: |
| ADDI      | 001000    | addi $t, $s, imm  | $t = $s + imm; advance_pc (4);|
| ADDIU     | 001001    | addiu $t, $s, imm | $t = $s + imm; advance_pc (4);|
| ANDI      | 001100    | andi $t, $s, imm  | $t = $s & imm; advance_pc (4);|
| ORI       | 001101    | ori $t, $s, imm   | $t = $s | imm; advance_pc (4);|
| XORI      | 001110    | xori $t, $s, imm  | $t = $s ^ imm; advance_pc (4);|
| LUI       | 001111    | lui $t, imm       | $t = (imm << 16); advance_pc (4);|
| SLTI      | 001010    | slti $t, $s, imm  | if $s < imm $t = 1; advance_pc (4); else $t = 0; advance_pc (4);|
| SLTIU     | 001011    | sltiu $t, $s, imm | if $s < imm $t = 1; advance_pc (4); else $t = 0; advance_pc (4);|

### Branch

| Instr     | Op Code   | Syntax            | Operation |
| :---:     | :-----:   | :----:            | :-------: |
| BEQ       | 000100    | beq $s, $t, offset| if $s == $t advance_pc (offset << 2)); else advance_pc (4);|
| BNE       | 000101    | bne $s, $t, offset| if $s != $t advance_pc (offset << 2)); else advance_pc (4);|
| BLEZ      | 000110    | blez $s, offset   | if $s <= 0 advance_pc (offset << 2)); else advance_pc (4);|
| BGTZ      | 000111    | bgtz $s, offset   | if $s > 0 advance_pc (offset << 2)); else advance_pc (4);|
| BLTZ      | 000001    | bltz $s, offset   | if $s < 0 advance_pc (offset << 2)); else advance_pc (4);|
| BGEZ      | 000001    | bgez $s, offset   | if $s >= 0 advance_pc (offset << 2)); else advance_pc (4);|

### J

| Instr     | Op Code   | Syntax        | Operation |
| :---:     | :-----:   | :----:        | :-------: |
| J         | 000010    | j target      | PC = nPC; nPC = (PC & 0xf0000000) | (target << 2);|
| JAL       | 000011    | jal target    | $31 = PC + 8 (or nPC + 4); PC = nPC; nPC = (PC & 0xf0000000) OR (target << 2);|
| JALR(R)   | 000000    | jalr target   | $31 = PC + 8 (or nPC + 4); PC = nPC; nPC = $s;|
| JR(R)     | 000000    | jr $s         | PC = nPC; nPC = $s;|

## aluop_def.v

http://www2.engr.arizona.edu/~ece369/Resources/spim/MIPSReference.pdf

### Classical funct

| Instr     | Funct  |
| :---:     | :---:  |
| ADD       | 100000 |
| ADDU      | 100001 |
| SUB       | 100010 |
| SUBU      | 100011 |
| SLLV      | 000100 |
| SRLV      | 000110 |
| SRAV      | 000111 |
| AND       | 100100 |
| OR        | 100101 |
| XOR       | 100110 |
| NOR       | 100111 |
| SLT       | 101010 |
| SLTU      | 101001 |

### Special funct

| Instr     | Funct  |
| :---:     | :---:  |
| SLL       | 000000 |
| SRL       | 000010 |
| SRA       | 000011 |

## signal_def.v

| SignalName        | Code  |
| :--------:        | :--:  |
| EXTOP_UNSIGNED    | 00    |
| EXTOP_SIGNED      | 01    |
| EXTOP_INST        | 10    |


