# Folder *Datapath*

# !! This document need to be updated to fits the current change.

## Units

### ALU

#### IN

- ALUOp[5:0]
- SrcA[31:0]
- SrcB[31:0]

#### OUT

- Zero (Signal)
- ALUOut[31:0]

### RF (Register File)

#### IN

- RegWrite (Signal)
- ReadAddr1[4:0]
- ReadAddr2[4:0]
- WriteAddr[4:0]
- WriteData[31:0]

#### OUT

- ReadData1[31:0]
- ReadData2[31:0]

### Memory

#### IN

- MemRead (Signal)
- MemWrite (Signal)
- Addr[31:0]
- WriteData[31:0]

#### OUT

- ReadData[31:0]

> TODO: Split Memory and add SignExt