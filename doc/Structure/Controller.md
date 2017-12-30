# Folder *Controller*

# !! This document need to be updated to fits the current change.

## States

Multiple cycle CPU use states to control data flow

### State details

#### State 0 - Instruction Fetch

- Read instruction from memory.
- Write PC+4 back to PC.

```
IorD = 0
ALUSrcA = 0
ALUSrcB = 01
ALUOp = 00
PCSource = 00
PCWrite = 1
MemRead = 1
IRWrite = 1
```

##### Next State 1

#### State 1 - Decode

```
ALUSrcA = 0
ALUSrcB = 11
ALUOp = 00
PCWriteCond = 0
```

##### Next State 2 6 8 9

#### State 2 - Execute (lw or sw)

- Save PC + imm << 2 to ALUOut
- Prevent PC be written

```
ALUSrcA=1
ALUSrcB=10
ALUOp=00
PCWriteCond=0
```

##### Next State 3 5

#### State 6 - Execute (R-Type)

- ALUSrcA <= Read Data 1
- ALUSrcB <= Read Data 2
- ALUControl decode funct
- Prevent PCWrite's write back

```
ALUSrcA=1
ALUSrcB=00
ALUOp=10
PCWriteCond=0
```

##### Next State 7

#### State 8 - Execute (beq)

- ALUSrcA <= Read Data 1
- ALUSrcB <= Read Data 2
- ALUControl <= beq
- PCSource choose ALUOut as PCSource

```
ALUSrcA=1
ALUSrcB=00
ALUOp=01
PCSource=01
PCWriteCond
```

##### Next State 0

#### State 9 - Execute (j)

- PCSource <= Instr[25:0]<<2

```
PCSource=10
PCWrite
```

##### Next State 0

#### State 3 - Memory Access (lw)

- Read Memory
- Address(DM) <= ALUOut

```
MemRead
IorD=1
PCWriteCond=0
```

##### Next State 4

#### State 5 - Memory Access (sw)

- Write Memory
- Address(Mem) <= ALUOut
- Write Data(Mem)[$s + offset] <= $t

```
MemWrite
IorD=1
PCWriteCond=0
```

##### Next State 0

#### State 7 - Write Back (R-Type)

- instr[15:11] <= ALUOut

```
RegDst=1
RegWrite
MemtoReg=0
PCWriteCond=0
```

##### Next State 0

#### State 4 - Write Back (lw)

- Write Data(Reg)[$t] <= MEM[$s + offset]

```
RegDst=0
RegWrite
MemtoReg=1
PCWriteCond=0
```

##### Next State 0
