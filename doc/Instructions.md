# Instructions

## Support instructions

### Overview

MIPS-C2＝{LB、LBU、LH、LHU、LW、SB、SH、SW、ADD、ADDU、SUB、SUBU、SLL、SRL、SRA、SLLV、SRLV、SRAV、AND、OR、XOR、NOR、SLT、SLTU、ADDI、ADDIU、ANDI、ORI、XORI、LUI、SLTI、SLTIU、BEQ、BNE、BLEZ、BGTZ、BLTZ、BGEZ、J、JAL、JALR、JR}

(42 instructions)

### Sort

#### R-Type

> ALL 6'b000000

> $d = $s ALUOp $t; advance_pc (4);

- ADD、ADDU、SUB、SUBU、SLL、SRL、SRA、SLLV、SRLV、SRAV、AND、OR、XOR、NOR、SLT、SLTU

#### I-Type

##### Memory

| Instr     | Syntax            | Operation |
| :---:     | :----:            | :-------: |
| LB        | lb $t, offset($s) | $t = MEM[$s + offset]; advance_pc (4);|
| LBU       | lbu $t, offset($s)| |
| LH        | lh $t, offset($s) | |
| LHU       | lhu $t, offset($s)| |
| LW        | lw $t, offset($s) | $t = MEM[$s + offset]; advance_pc (4);|
| SB        | sb $t, offset($s) | MEM[$s + offset] = (0xff & $t); advance_pc (4);|
| SH        | sh $t, offset($s) | |
| SW        | sw $t, offset($s) | MEM[$s + offset] = $t; advance_pc (4);|

##### Imm calculate

| Instr     | Syntax            | Operation |
| :---:     | :----:            | :-------: |
| ADDI      | addi $t, $s, imm  | $t = $s + imm; advance_pc (4);|
| ADDIU     | addiu $t, $s, imm | $t = $s + imm; advance_pc (4);|
| ANDI      | andi $t, $s, imm  | $t = $s & imm; advance_pc (4);|
| ORI       | ori $t, $s, imm   | $t = $s | imm; advance_pc (4);|
| XORI      | xori $t, $s, imm  | $t = $s ^ imm; advance_pc (4);|
| LUI       | lui $t, imm       | $t = (imm << 16); advance_pc (4);|
| SLTI      | slti $t, $s, imm  | if $s < imm $t = 1; advance_pc (4); else $t = 0; advance_pc (4);|
| SLTIU     | sltiu $t, $s, imm | if $s < imm $t = 1; advance_pc (4); else $t = 0; advance_pc (4);|

#### Branch

| Instr     | Syntax            | Operation |
| :---:     | :----:            | :-------: |
| BEQ       | beq $s, $t, offset| if $s == $t advance_pc (offset << 2)); else advance_pc (4);|
| BNE       | bne $s, $t, offset| if $s != $t advance_pc (offset << 2)); else advance_pc (4);|
| BLEZ      | blez $s, offset   | if $s <= 0 advance_pc (offset << 2)); else advance_pc (4);|
| BGTZ      | bgtz $s, offset   | if $s > 0 advance_pc (offset << 2)); else advance_pc (4);|
| BLTZ      | bltz $s, offset   | if $s < 0 advance_pc (offset << 2)); else advance_pc (4);|
| BGEZ      | bgez $s, offset   | if $s >= 0 advance_pc (offset << 2)); else advance_pc (4);|

#### J

| Instr     | Syntax        | Operation |
| :---:     | :----:        | :-------: |
| J         | j target      | PC = nPC; nPC = (PC & 0xf0000000) | (target << 2);|
| JAL       | jal target    | $31 = PC + 8 (or nPC + 4); PC = nPC; nPC = (PC & 0xf0000000) | (target << 2);|
| JALR      | jalr target   | No Op |
| JR        | jr $s         | PC = nPC; nPC = $s;|

