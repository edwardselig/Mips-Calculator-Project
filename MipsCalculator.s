.globl main

.data
#v:     .half 802
#w:     .half 380
#x:     .half 15961
#y:     .half 29
#z:     .half 700
#equation: .asciiz "x=1000+x/5629-971"
v:     .half 0x0027
w:     .half 0x876A
x:     .half 0x3A7D
y:     .half 0x3A8D
z:     .half 0x7CF0
equation: .asciiz "w=-x+x/(w+z)*(y-x)+28 "
#v:     .half 0xFFFF
#w:     .half 0x0030
#x:     .half 0xFFAE
#y:     .half 0x0020
#z:     .half 0x0024
#equation: .asciiz "y=v*x*y/(z+v)"
#v:     .half 3
#w:     .half 15
#x:     .half 231
#y:     .half 100
#z:     .half 25
#equation: .asciiz "v=3 *x - y + 17"
#v:     .half 0x0030
#w:     .half 0xFFFF
#x:     .half 0xFFC9
#y:     .half 0x0000
#z:     .half 0x0004
#equation: .asciiz "w=v*49+z*w"
#v:     .half 0xFFFC
#w:     .half 27
#x:     .half 9
#y:     .half 17
#z:     .half 165
#equation: .asciiz "x=-z+x^4/(x+z)"
.text
#do not change t5,t6
main:
        lui $a0, 0x1000
        addi $a0, $a0, 10 #start address of equation
        addi $t5,$0,1 #number indicator
	addi $t9 $0,0 #negate indicator
        sb $t5, ($sp) #cushion
	add $0, $0, $0
        addi $sp, $sp, -4 #increment stack
        add $t6, $0, $sp #original sp
	add $t8, $0, $sp #original sp
	add $s3, $0, $0 #answer goes here
	addi $s4, $0, 1 #parenthesis indicator
addtostack:
        lb $t2, ($a0) #get char
        or $0, $0, $0
        addi $a0, $a0, 1#increment address
        addi $t3, $0, 0x2F
        slt $t4, $t3, $t2 #break if t2 is less that 10
        addi $t3, $0, 0x3A
        slt $t1, $t2, $t3 #break if t2 is less that 10
        beq $t4, $t1, number1
        add $0, $0, $0
        addi $t5, $0, 1 #reset
	addi $t3, $0, 118 #v
	beq $t3, $t2, v1
	add $0, $0, $0
	addi $t3, $0, 119 #w
        beq $t3, $t2, w1 
        add $0, $0, $0
	addi $t3, $0, 120 #x
        beq $t3, $t2, x1 
        add $0, $0, $0
	addi $t3, $0, 121 #y
        beq $t3, $t2, y1 
        add $0, $0, $0
	addi $t3, $0, 122 #z
        beq $t3, $t2, z1
        add $0, $0, $0
	addi $t3, $0, 45 #negate
        beq $t3, $t2, negateop
        add $0, $0, $0
	addi $t3, $0, 32 #space
        beq $t3, $t2, addtostack #skip spaces
        add $0, $0, $0
	addi $t3, $0, 61 #equal
        beq $t3, $t2, equals #skip equal
        add $0, $0, $0
        addi $t2, $t2, 0x7F39
        sw $t2, ($sp) #push to stack
        addi $sp, $sp, -4#increment stack
        add $t3, $0, 0x7F39
        bne $t2, $t3, addtostack #if not nullrepeat
        addi $t9, $0, 0 #op indicator is on
	j openparen
	add $0, $0, $0
equals:
	add $t9, $0, $0
	j addtostack
	add $0, $0, $0
openparen:
	addi $t3, $0, 40 #(
	addi $t3, $t3, 0x7F39
	lw $t2, ($t6)
	add $0, $0, $0
	add $s7, $0, $t6 #start
	beq $t2, $t3, closeparen
	add $0, $0, $0
	addi $t6, $t6, -4 #increase
	bne $t6, $sp, openparen
	add $0, $0, $0
	j searchfornegate
	add $t6, $t8, $0
closeparen:
	addi $t6, $t6, -4
	addi $t3, $0, 40 #(
	addi $t3, $t3, 0x7F39
	lw $t2, ($t6)
	add $0, $0, $0
	beq $t2, $t3, openparen
	add $0, $0, $0
	addi $t3, $0, 41 #)
	addi $t3, $t3, 0x7F39
	bne $t3, $t2, closeparen
	add $0, $0, $0
	add $s4, $0, $0
	add $s5, $t8, $0
	add $s6, $sp, $0 #finish
	add $sp, $t6, $0
	add $t8, $s7, $0
	j searchfornegate
	add $t6, $t8, $0 #reset
number1:
	j number
	add $0, $0, $0
negateop:
	beq $t9, $0, negateop2
	add $0, $0, $0
	addi $t2, $t2, 0x7F39
	addi $t3, $0, 0x7F39
	sw $t2, ($sp) #push to stack
        addi $sp, $sp, -4#increment stack
        bne $t2, $t3, addtostack #if not nullrepeat
        addi $t9, $0, 0 #op indicator is on
negateop2:
	addi $t2, $t2,1 # '.' char is 46
	addi $t2, $t2, 0x7F39
	sw $t2, ($sp) #push to stack
        addi $sp, $sp, -4#increment stack
        j addtostack
        addi $t9,$0, 1 #negate is off
searchforothers: #t6 is start
        addi $t3, $0, 42 # *
        addi $t3, $t3, 0x7F39
        lw $t2, ($t6)
        add $0, $0, $0
        beq $t2, $t3, mult1
	add $s0, $0, $t6
	addi $t3, $0, 47 # div0
	addi $t3, $t3, 0x7F39
        beq $t2, $t3, div2
	add $s0, $0, $t6
	addi $t3, $0, 37 # MOD
	addi $t3, $t3, 0x7F39
        beq $t2, $t3, modulus
	add $s0, $0, $t6
        addi $t6, $t6, -4 #increase
        bne $t6, $sp, searchforothers
        add $0, $0, $0
        j searchforplusminus
        add $t6, $t8, $0 #reset
searchforplusminus:
	addi $t3, $0, 43 # +
	addi $t3, $t3, 0x7F39
        lw $t2, ($t6)
        add $0, $0, $0
        beq $t2, $t3, addition
        add $s0, $0, $t6
        addi $t3, $0, 45 # -
        addi $t3, $t3, 0x7F39
        beq $t2, $t3, subtraction
        add $s0, $0, $t6
        addi $t6, $t6, -4 #increase
        bne $t6, $sp, searchforplusminus
        add $0, $0, $0
        j enditall
        add $t6, $t8, $0 #reset
repeatall:
	addi $s4, $0, 1
	addi $t3, $0, 65
	addi $t3, $t3, 0x7F39
	sw $t3, ($t8)
	sw $t3, ($sp)
	add $t8, $s5, $0
	add $t6, $t8, $0
	add $sp, $s6, $0
	j openparen
	add $0, $0, $0
enditall:
	beq $0, $s4, repeatall
	add $0, $0, $0
	lw $t2, -4($t6)
        add $0, $0, $0
	addi $t3, $0, 65
	addi $t3, $t3, 0x7F39
        beq $t2, $t3, enditall
	addi $t6, $t6, -4 #increase
enditall2:
	sh $t2 ($s3) #store in target
	j enditall3
	add $0, $0, $0
subtraction:
        addi $s0, $s0, -4 #look for A, s0 is copy of t6
        lw $t2, ($s0)
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $t2, subtraction
	add $0, $0, $0
	addi $t1, $0, 65 #A sign
	addi $t1, $t1, 0x7F39
        sw $t1, ($s0)
        add $0, $0, $0
	add $s0, $0, $t6
subtraction1:
	addi $s0, $s0, 4 #look for A, s0 is copy of t6
        lw $t1, ($s0)#test if this works!
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $t1, subtraction1
        add $0, $0, $0
        sub $t3, $t1, $t2
        sw $t3, ($t6) #store number
        addi $t3, $0, 65 #A sign
        addi $t3, $t3, 0x7F39
        sw $t3, ($s0)
        addi $t6, $t6, -4 #increase
        j searchforplusminus
        add $0, $0, $0
addition:
        addi $s0, $s0, -4 #look for A, s0 is copy of t6
        lw $t2, ($s0)
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $t2, addition
        add $0, $0, $0
        addi $t1, $0, 65 #A sign
        addi $t1, $t1, 0x7F39
        sw $t1, ($s0)
        add $0, $0, $0
        add $s0, $0, $t6
addition1:
        addi $s0, $s0, 4 #look for A, s0 is copy of t6
        lw $t1, ($s0)#test if this works!
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $t1, addition1
        add $0, $0, $0
        add $t3, $t1, $t2
        sw $t3, ($t6) #store number
        addi $t3, $0, 65 #A sign
        addi $t3, $t3, 0x7F39
        sw $t3, ($s0)
        addi $t6, $t6, -4 #increase
        j searchforplusminus
        add $0, $0, $0
div2:
        addi $s0, $s0, 4 #look for A, s0 is copy of t6
        lw $v1, ($s0)
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $v1, div2
        add $0, $0, $0
        addi $t1, $0, 65 #A sign
        addi $t1, $t1, 0x7F39
        sw $t1, ($s0) 
        add $0, $0, $0
        add $s0, $0, $t6
div1:#v1 is dividen/ remainder a1 is divisor
	addi $s0, $s0, -4 #look for A
        lw $t2, ($s0)
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $t2, div1
        add $0, $0, $0
        add $a1, $t2, $0
        jal divide
        add $0, $0, $0
        sw $v0, ($t6) #store number
        addi $t3, $0, 65 #A sign
        addi $t3, $t3, 0x7F39
        sw $t3, ($s0)
        addi $t6, $t6, -4 #increase
        j searchforothers
        add $0, $0, $0
modulus:
        addi $s0, $s0, 4 #look for A, s0 is copy of t6
        lw $v1, ($s0)
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $v1, modulus
        add $0, $0, $0
        addi $t1, $0, 65 #A sign
        addi $t1, $t1, 0x7F39
        sw $t1, ($s0)
        add $0, $0, $0
        add $s0, $0, $t6
modulus1:#v1 is dividen/ remainder a1 is divisor
        addi $s0, $s0, -4 #look for A
        lw $t2, ($s0)
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $t2, modulus1
        add $0, $0, $0
        add $a1, $t2, $0
        jal divide
        add $0, $0, $0
        sw $v1, ($t6) #store number
        addi $t3, $0, 65 #A sign
        addi $t3, $t3, 0x7F39
        sw $t3, ($s0)
        addi $t6, $t6, -4 #increase
        j searchforothers
        add $0, $0, $0
mult1:
        addi $s0, $s0, 4 #look for A, s0 is copy of t6
        lw $t1, ($s0)
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $t1, mult1
        add $0, $0, $0
        addi $t2, $0, 65 #A sign
        addi $t2, $t2, 0x7F39
        sw $t2, ($s0)
        add $0, $0, $0
        add $s0, $0, $t6
mult2:#v1 is dividen/ remainder a1 is divisor
        addi $s0, $s0, -4 #look for A
        lw $t0, ($s0)
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $t0, mult2
        add $0, $0, $0
mult3:
        jal multiply
        add $0, $0, $0
        sw $t3, ($t6) #store number
        addi $t3, $0, 65 #A sign
        addi $t3, $t3, 0x7F39
        sw $t3, ($s0)
        addi $t3, $0, 65 #A sign
        addi $t3, $t3, 0x7F39
        sw $t3, 4($t6)
        addi $t6, $t6, -4 #increase
        j searchforothers
        add $0, $0, $0
searchforpower: #t6 is start
	addi $t3, $0, 94 #power
	addi $t3, $t3, 0x7F39
        lw $t2, ($t6)
        add $0, $0, $0
        beq $t2, $t3, power
	add $0, $0, $0
        addi $t6, $t6, -4 #increase
        bne $t6, $sp, searchforpower
        add $0, $0, $0
	j searchforothers
	add $t6, $t8, $0 #reset
power:
	add $s0, $0, $t6
        addi $s0, $s0, 4 #look for A, s0 is copy of t6
        lw $t1, ($s0)
        add $0, $0, $0
        addi $t3,$0, 65 #A
        addi $t3, $t3, 0x7F39
        beq $t3, $t1, power #t1 is base
        add $0, $0, $0
        addi $t2, $0, 65 #A sign
        addi $t2, $t2, 0x7F39
        sw $t2, ($s0)
        add $0, $0, $0
        add $s0, $0, $t6
power1:
	addi $s0, $s0, -4 #look for exponent
	lw $t2, ($s0)
	add $0, $0, $0
	addi $t3,$0, 65 #A
	addi $t3, $t3, 0x7F39
        beq $t3, $t2, power1
	add $0, $0, $0
	addi $t2, $t2, -1 
	add $t0, $t1, $0 #copy
	add $s2, $t1, $0
power2:
	jal multiply
	add $0, $0, $0
	addi $t2, $t2, -1
	add $t0, $t3, $0 #move product to next multiply
	add $t1, $s2, $0
	bne $0, $t2, power2 #repeat if not equal
	add $0, $0, $0
	sw $t3, ($t6) #store number
	addi $t3, $t3, 0x7F39
	addi $t3, $0, 65 #A sign
	addi $t3, $t3, 0x7F39
	sw $t3, 4($t6)
	addi $t3, $0, 65 #A sign
	addi $t3, $t3, 0x7F39
        sw $t3, ($s0)
	addi $t6, $t6, -4 #increase
        j searchforpower
        add $0, $0, $0
searchfornegate: #$t6 is starting point
	addi $t3, $0, 46 #negation
	addi $t3, $t3, 0x7F39
	lw $t2, ($t6)
	add $0, $0, $0
	beq $t2, $t3, negate
	add $0, $0, $0
	addi $t6, $t6, -4 #increase
	bne $t6, $sp, searchfornegate
	add $0, $0, $0
	j searchforpower
	add $t6, $t8, $0 #reset
negate:
	lw $t2, -4($t6) #value after negation sign
	add $0, $0, $0
	sub $t2, $0, $t2 #negate
	sw $t2, -4($t6)
	addi $t3, $0, 65 #A char
	addi $t3, $t3, 0x7F39
	sw $t3, ($t6) #a char
	addi $t6, $t6, -4 #increase
	j searchfornegate
	add $0, $0, $0
v1:
	addi $t9, $0, 1 #reset
	beq $0, $s3, v2
	add $0, $0, $0
	lui $t2, 0x1000
	lh $t2, ($t2)
	add $0, $0, $0
	sw $t2, ($sp) #push to stack
        addi $sp, $sp, -4#increment stack
        j addtostack
	add $0, $0, $0
v2:
	lui $s3, 0x1000
	addi $s3, $s3, 0
	addi $sp, $sp, -4#increment stack
	j addtostack
        add $0, $0, $0
w1:
	addi $t9, $0, 1 #reset
	beq $0, $s3, w2
        add $0, $0, $0
        lui $t2, 0x1000
        lh $t2, 2($t2)
        add $0, $0, $0
        sw $t2, ($sp) #push to stack
        addi $sp, $sp, -4#increment stack
        j addtostack
        add $0, $0, $0
w2:
        lui $s3, 0x1000
        addi $s3, $s3, 2
        addi $sp, $sp, -4#increment stack
        j addtostack
        add $0, $0, $0
x1:
	addi $t9, $0, 1 #reset
	beq $0, $s3, x2
        add $0, $0, $0
        lui $t2, 0x1000
        lh $t2, 4($t2)
        add $0, $0, $0
        sw $t2, ($sp) #push to stack
        addi $sp, $sp, -4#increment stack
        j addtostack
        add $0, $0, $0
x2:
        lui $s3, 0x1000
        addi $s3, $s3, 4
        addi $sp, $sp, -4#increment stack
        j addtostack
        add $0, $0, $0
y1:
	addi $t9, $0, 1 #reset
	beq $0, $s3, y2
        add $0, $0, $0
        lui $t2, 0x1000
        lh $t2, 6($t2)
        add $0, $0, $0
        sw $t2, ($sp) #push to stack
        addi $sp, $sp, -4#increment stack
        j addtostack
        add $0, $0, $0
y2:
        lui $s3, 0x1000
        addi $s3, $s3, 6
        addi $sp, $sp, -4#increment stack
        j addtostack
        add $0, $0, $0
z1:
	addi $t9, $0, 1 #reset
	beq $0, $s3, z2
        add $0, $0, $0
        lui $t2, 0x1000
        lh $t2, 8($t2)
        add $0, $0, $0
        sw $t2, ($sp) #push to stack
        addi $sp, $sp, -4#increment stack
        j addtostack
        add $0, $0, $0
z2:
        lui $s3, 0x1000
        addi $s3, $s3, 8
        addi $sp, $sp, -4#increment stack
        j addtostack
        add $0, $0, $0
number:
	addi $t9, $0, 1 #reset
        beq $t5, $0, morenumber
        sub $t2, $t2, 0x30 #if prev was number
        sw $t2,($sp) #push
        addi $sp, $sp, -4
        addi $t5,$0,0 #number indicator
        j addtostack
        add $0, $0, $0
morenumber:
        lw $t1,4($sp)
        add $0, $0, $0
        addi $t0, $0, 10 #time by 10
        jal multiply
        add $0, $0, $0
        add $t2, $t3, $t2 #combine
        sw $t2,4($sp) #store t2
        addi $t5,$0,0 #number indicator
        j addtostack
        add $0, $0, $0
multiply:
	slt $t3, $t1, $0
	bne $t3, $0, multiply3
	add $0, $0, $0 #t1 is positive
	slt $t3, $t0, $0
	bne $t3, $0, multiply5
	addi $t7, $0, 1
	j multiply2
	add $0, $0, $0
multiply3: #t1 is negative
	slt $t3, $t0, $0
	bne $t3, $0, multiply4
	add $0, $0, $0 #t0 is positive t1 is negative
	sub $t1, $0, $t1
	addi $t7, $0, 0 #indicator on
	j multiply2
	add $0, $0, $0
multiply4: #t1 and t0 are negative
	sub $t0, $0, $t0
	sub $t1, $0, $t1
	addi $t7, $0, 1 #indicator off
	j multiply2
	add $0, $0, $0
multiply5: #t1 is positive t0 is neg
	sub $t0, $0, $t0
	addi $t7, $0, 0 #indicator on
	j multiply2
	add $0, $0, $0
multiply2:
	addi $t4, $0, 0
	addi $t5, $0, 32
	add $t3, $0, $0 #product register
loop:
	and $s1, $t0, 1
	beq $s1, $0, multiply0
	add $0, $0, $0
	add $t3, $t1, $t3
	sll $t1, $t1, 1
	srl $t0, $t0, 1
	addi $t4, $t4, 1
	bne $t5, $t4, loop
	add $0, $0, $0
	beq $t7, $0, multiply6
	add $0, $0, $0
	jr $ra
	add $0, $0, $0
multiply0:
	sll $t1, $t1 1
	srl $t0, $t0 1
	addi $t4, $t4, 1
	bne $t5, $t4, loop
	add $0, $0, $0
	beq $t7, $0, multiply6
	add $0, $0, $0
	jr $ra
	add $0, $0, $0
multiply6:
	addi $t7, $0, 1
	sub $t3, $0, $t3
	jr $ra
	add $0, $0, $0
divide:
	slt $t3, $a1, $0
	bne $t3, $0, divide3
	add $0, $0, $0 #a1 is positive
	slt $t3, $v1, $0
	bne $t3, $0, divide5
	addi $t7, $0, 1
	j divide2
	add $0, $0, $0
divide3: #a1 is negative
	slt $t3, $v1, $0
	bne $t3, $0, divide4
	add $0, $0, $0 #v1 is positive a1 is negative
	sub $a1, $0, $a1
	addi $t7, $0, 0 #indicator on
	j divide2
	add $0, $0, $0
divide4: #a1 and t0 are negative
	sub $v1, $0, $v1
	sub $a1, $0, $a1
	addi $t7, $0, 1 #indicator off
	j divide2
	add $0, $0, $0
divide5: #a1 is positive t0 is neg
	sub $v1, $0, $v1
	addi $t7, $0, 0 #indicator on
	j divide2
	add $0, $0, $0
divide2:
        add $v0, $0, $0 #initilize quotient register to 0
        sll $a1, $a1, 16 #algorithm needs the divisor shifted to top half
        add $t1, $0, $0 #counter
        j begin #begin division algorithm
        add $0, $0, $0 #no op
begin:
        sub $v1, $v1, $a1 #subtract divisor from dividend
        slt $t0, $v1, $0 #set if v1 is less than 0
        bne $t0, $0, lessthanzero #will branch if v1 is less than zero
        add $0, $0, $0 #no op
        sll $v0, $v0, 1 #shift quotient 1 to left
        addi $v0, $v0, 1 #set first bit to 1
        srl $a1, $a1, 1 #shift divisor register 1 to right
        addi $t1, $t1, 1 #increment counter
        addi $t3, $0,17 #test if 16 repititions
        beq $t1, $t3, end #is is 16 repitiion?
        add $0, $0, $0 #no op
        j begin #repeat begin loop
        add $0, $0, $0 #no op 
lessthanzero:
        add $v1, $v1, $a1 #add divisor and remainder, store in remainder
        sll $v0, $v0, 1 #shift quotient 1 to left
        sra $a1, $a1, 1 # shift divisor 1 to right
        addi $t1, $t1, 1 #increment counter
        addi $t3,$0, 17 #test if 16 repititions
        beq $t1, $t3, end #is is 16 repitiion?
        add $0, $0, $0 #no op
        j begin # repeat begin loop
        add $0, $0, $0 #no op
end:
	beq $t7, $0, end2
	add $0, $0, $0
	jr $ra #go back to main
    add $0, $0, $0 #no op:
end2:
	addi $t7, $0, 1
	sub $v0, $0, $v0
	jr $ra #go back to main
    add $0, $0, $0 #no op:
enditall3:
