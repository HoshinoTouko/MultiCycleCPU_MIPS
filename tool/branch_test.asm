    addi $1 $0 1
    addi $2 $0 2
    addi $3 $0 2
    addi $4 $0 -1

_Start:
    #Clear $10
    add  $10 $0 $0
    # BEQ
    beq  $2 $3 _beqSuccess
    addi $10 $10 0xff
_beqSuccess:
    addi $10 $10 0x1
    beq  $1 $2 _Start # If test failed, it will jump to start
    #BNE
    bne  $1 $2 _bneSuccess
    addi $10 $10 0xff
_bneSuccess:
    addi $10 $10 0x1
    bne  $2 $3 _Start # If test failed, it will jump to start
    #BLEZ
    blez $4 _blezSuccess
    addi $10 $10 0xff
_blezSuccess:
    addi $10 $10 0x1
    blez $1 _Start # If test failed, it will jump to start
    #BGTZ
    bgtz $1 _bgtzSuccess
    addi $10 $10 0xff
_bgtzSuccess:
    addi $10 $10 0x1
    bgtz $4 _Start # If test failed, it will jump to start
    #BLTZ
    bltz $4 _bltzSuccess
    addi $10 $10 0xff
_bltzSuccess:
    addi $10 $10 0x1
    bltz $1 _Start # If test failed, it will jump to start
    #BGEZ
    bgez $1 _bgezSuccess
    addi $10 $10 0xff
_bgezSuccess:
    addi $10 $10 0x1
    bgez $4 _Start # If test failed, it will jump to start
