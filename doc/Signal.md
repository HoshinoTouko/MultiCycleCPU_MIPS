# *Signals*

## From Control Unit

- About PC Write
    - PCWriteCond
        - 0 Refuse ALU Zero output
        - 1 Allow ALU Zero output
    - PCWrite
        - 0 Refuse PCWrite
        - 1 Allow PCWrite
    - PCSource
        - 0 From ALU
        - 1 From ALUOut
        - 2 From Instr[25:0] << 2
    - PCNext
        - 0 PC do not output new data
        - 1 PC output new data
- About Memory
    - <del>IorD (DISCARD)</del>
        - 0 From PC
        - 1 From ALUOut (Register write back to memory)
    - BE (Byte enable)
    - MemRead
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
    - IRWrite
        - 0 Refuse new instruction
        - 1 Allow new instruction
    - RegDst
        > To RF Write Addr
        - 0 From Instr[20:16]
        - 1 From Instr[15:11]
    - RegWrite
        - 0 Refuse RF write
        - 1 Allow RF write
- About ALU
    - ALUSrcA
        - 0 From PC
        - 1 From RF Read Data 1
    - ALUSrcB
        - 0 From RF Read Data 2
        - 1 Imm 4
        - 2 From Instr[15:0] extended
        - 3 From Instr[15:0] ext << 2
- About ALUControl
    - ALUCtrlOp
        - 00 PC ADD 4
        - 01 Branch
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
    -

## From ALU Control

- ALUOp

## From ALU

## From Branch

- BranchSucceed