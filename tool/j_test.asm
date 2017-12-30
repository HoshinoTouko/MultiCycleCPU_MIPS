    #J
    j _J_TEST
    addi $10 $10 0xf
_J_TEST:
    addi $10 $10 0x1
    #JAL
    jal _JAL_TEST
    addi $10 $10 0xf
_JAL_TEST:
    addi $10 $10 0x1
    #JR
    addi $2 $0 0x00003000
    jalr $2
    