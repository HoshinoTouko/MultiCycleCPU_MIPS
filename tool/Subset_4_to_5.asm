# Test File for 42 Instruction, include:
# 1. Subset 1:
# ADD/ADDU/SUB/SUBU/SLL/SRL/SRA/SLLV/SRLV/SRAV/AND/OR/XOR/NOR/  
# SLT/SLTU														14				
# 2. Subset 2:
# ADDI/ADDIU/ANDI/ORI/XORI/LUI/SLTI/SLTIU						8
# 3. Subset 3:
# LB/LBU/LH/LHU/LW/SB/SH/SW 									8
# 4. Subset 4:
# BEQ/BNE/BGEZ/BGTZ/BLEZ/BLTZ									6
# 5. Subset 5:
# J/JAL/JR/JALR													4
#																42
##################################################################
### Make sure following Settings :
# Settings -> Memory Configuration -> Compact, Data at address 0

.data
.globl array cnt
array:
	.word 0:16	# array of 16 words
cnt:
	.word 0		# counter of Branch
.text
	##################
	# Test Subset 2  #
	ori $v0, $0, 0x1234
	lui $v1, 0x9876
	addi $a0, $v0, 0x3456
	addiu $a1, $v1, -1024
	xori $a2, $v0, 0xabcd
	sltiu $a1, $a0, 0x34
	sltiu $a1, $v0, -1
	andi $a3, $a2, 0x7654
	slti $t0, $v1, 0x1234 

	##################
	# Test Subset 4  #
	la $sp, cnt
	sw $0, 0($sp)
	and $v0, $0, $t0
	bne $t0, $t1, _lb1
	addiu $v0, $v0, 1

	_lb1:
	bgtz $t0, _lb2
	addiu $v0, $v0, 1

	_lb2:
	blez $t0, _lb3
	addiu $v0, $v0, 1

	_lb3:
	bltz $t1, _lb4
	addiu $v0, $v0, 1

	_lb4:
	bgez $t0, _lb5
	addiu $v0, $v0, 1

	_lb5:
	beq $t1, $t2, _lb6
	addiu $v0, $v0, 1

	_lb6:
	sw $v0, 0($sp)

	
	##################
	# Test Subset 5  #
	la $sp, cnt
	lw $v0, 0($sp)
	j _target
	addu $v0, $v0, $t0

	_target:
	addiu $v0, $v0, 1
	jal F_Test_JAL
	addu $a1, $a1, $v0
	_loop:
	j _loop		# Dead loop


F_Test_JAL:
	la $sp, array
	sw $ra, 40($sp)
	ori $v0, $v0, 0x5500
	la $t1, F_Test_JALR
	jalr $t1
	la $sp, cnt
	sw $v0, 0($sp)
	la $sp, array
	lw $ra, 40($sp)
	jr $ra

F_Test_JALR:
	la $sp, array
	sw $ra, 44($sp)
	ori $v0, $v0, 0x50
	jr $ra
