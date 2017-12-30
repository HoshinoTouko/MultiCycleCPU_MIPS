# *Signals*

## From Control Unit

- About PC Write
    - PCWriteCond
        - 0 Refuse Branch output
        - 1 Allow Branch output
    - PCWrite
        - 0 Refuse PCWrite
        - 1 Allow PCWrite
    - PCSource
        - 0 From ALU
        - 1 From ALUOut
        - 2 From Instr[25:0] << 2
        - 3 From RF Read Data 1
    - PCNext
        - 0 Refuse PC Simple Reg get new data
        - 1 Allow PC Simple Reg get new data
- About Memory
    - <del>IorD (DISCARD)</del>
        - 0 From PC
        - 1 From ALUOut (Register write back to memory)
    - BE (Byte enable)
    - <del>MemRead(DISCARD)</del>
        - 0 Refuse memory read operation
        - 1 Allow memory read operation
    - MemWrite
        - 0 Refuse memory write operation
        - 1 Allow memory write operation
- About Register
    - Mem2Reg
        > To RF Write Data
        - 0 From ALUOut
        - 1 From Memory Read Data
        - 2 From PC SReg
    - IRWrite
        - 0 Refuse new instruction
        - 1 Allow new instruction
    - RegDst
        > To RF Write Addr
        - 0 From Instr[20:16]
        - 1 From Instr[15:11]
        - 2 Immediate 31 (For JAL & JALR)
    - RegWrite
        - 0 Refuse RF write
        - 1 Allow RF write
- About ALU
    - ALUSrcA
        - 0 From PC SReg
        - 1 From RF Read Data 1
        - 2 {27'b0, Instr[10:6]} (For SLL, SRL & SRA)
    - ALUSrcB
        - 0 From RF Read Data 2
        - 1 Imm 4
        - 2 From Instr[15:0] ext
        - 3 From Instr[15:0] ext << 2
- About ALUControl
    - ALUCtrlOp
        - 00 PC ADD 4 (Signed)
        - 01 PC ADD 4 (Unsigned)
        - 10 R-Type
        - 11 I-Type
- About Branch Unit
    - BranchOp
        - 000 Equal
        - 001 Not equal
        - 010 Less than or equal to zero
        - 011 Greater than zero
        - 100 Less than zero
        - 101 Greater than or equal to zero
- About SignExt
    > See *../src/Define/signal_def.v*

## From ALU Control

- ALUOp
    > See *../src/Define/aluop_def.v*

## From BE Control

## From ALU

- Nothing

## From Branch

- BranchSucceed
    - 0 Branch failed, do not jump.
    - 1 Branch succeed, jump.
