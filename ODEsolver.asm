.data
.text
.globl main
main:

#getting addresses of arguments from $a1
lw $t1 0 ($a1)
lw $s0 4 ($a1)
lw $s1 8 ($a1)
#Loading arguments from their adddresses
lb $t1 0 ($t1)
lb $s0 0 ($s0)
lb $s1 0 ($s1)
#conversion from unicode 
addi $s0 $s0 -48
addi $s1 $s1 -48
addi $t1 $t1 -48
#passing arguments to euler_fn
add $a0,$zero,$t1
add $a1,$zero,$s0
add $a2 $zero,$s1

jal euler_fn

lui $t1 4097
sw $v0 0 ($t1)
lw $t2 0 ($t1)

j tt 
mul:    #function responisble for multiplication
add $t3 $zero $zero
slt $at, $a0,$zero   #if k<0
beq $at, $zero, Exit11

sub $a0, $zero, $a0  
addi $s7 $zero 1    #flag register to know number of negative arguments
Exit11:
slt $at, $a1,$zero  
beq $at, $zero, Exit
addi $s7 $s7 1
sub $a1, $zero, $a1   #l=l*-1
Exit:
loopx:
andi $t2, $a1, 1    
beq $t2, $zero, loopy  
add $t3, $t3, $a0   #the program may terminates here in case of overflow 
loopy:
sll $a0, $a0, 1     
srl $a1, $a1, 1     
bne $a1, $zero, loopx  
addi $s6 $zero 1 
bne $s7, $s6, Exit22        
sub $t3 $zero $t3
Exit22:
add $v0,$t3,$zero 
add $s7 $zero $zero
jr $ra
pow:        #function of power 
addi $sp $sp -4
sw $ra 0 ($sp)
addi $t4,$zero,1 #t3 is the result
add $t6, $zero, $zero # i = 0   t2  
add $t8 $zero $a1
add $s5 $zero $a0
For1: slt $t7,$t6,$t8 # test if i < k
beq $t7, $zero, Exit2
add $a0,$s5,$zero         
add $a1,$t4,$zero                  
addi $sp $sp -8
sw $a0 4 ($sp)
sw $a1 0 ($sp)
jal mul
lw $a1 0 ($sp)
lw $a0 4 ($sp)
addi $sp $sp 8
add $t5,$v0,$zero
add $t4 ,$t5,$zero  #result=l*result
addi $t6,$t6, 1 # increment i
j For1
Exit2:
add $v0,$t4,$zero 
lw $ra 0 ($sp)
addi $sp $sp 4
jr $ra
equ: #function working on given equation
addi $sp $sp -4
sw $ra 0 ($sp)
add $t0 $zero $a0      # x>>>t1
add $t1 $zero $a1      # y>>>t2
add $a0,$zero,$a0
addi $a1,$zero,2
addi $sp $sp -12
sw $t0 8 ($sp)
sw $t1 4 ($sp)
jal pow
lw $t1 4 ($sp)
lw $t0 8 ($sp)
addi $sp $sp 12
addi $sp $sp -12
sw $t0 8 ($sp)
sw $t1 4 ($sp)
addi $a0,$zero,57
add $a1,$zero,$v0
jal mul
lw $t1 4 ($sp)
lw $t0 8 ($sp)
addi $sp $sp 12
add $t9 $v0 $zero  #t0 = 57*x^2
addi $a0,$zero,14
add $a1,$zero,$t0
addi $sp $sp -12
sw $t0 8 ($sp)
sw $t1 4 ($sp)
jal mul
lw $t1 4 ($sp)
lw $t0 8 ($sp)
addi $sp $sp 12
sub $t9 $t9 $v0      #t0 = 57*x^2-14*x
add $a0,$zero,$t1
addi $a1,$zero,3
addi $sp $sp -12
sw $t0 8 ($sp)
sw $t1 4 ($sp)
jal pow
lw $t1 4 ($sp)
lw $t0 8 ($sp)
addi $sp $sp 12
add $a0,$zero,$v0
addi $a1,$zero,462
addi $sp $sp -12
sw $t0 8 ($sp)
sw $t1 4 ($sp)
jal mul
lw $t1 4 ($sp)
lw $t0 8 ($sp)
addi $sp $sp 12
sub  $t9 $t9 $v0 #t0 = 57*x^2-14*x -462*y*y*y
add $a0,$zero,$t1
addi $a1,$zero,2
addi $sp $sp -12
sw $t0 8 ($sp)
sw $t1 4 ($sp)
jal pow
lw $t1 4 ($sp)
lw $t0 8 ($sp)
addi $sp $sp 12

add $a0,$zero,$v0
addi $a1,$zero,38
addi $sp $sp -12
sw $t0 8 ($sp)
sw $t1 4 ($sp)
jal mul
lw $t1 4 ($sp)
lw $t0 8 ($sp)
addi $sp $sp 12
add $t9 $t9 $v0 #t0 = 57*x^2-14*x -462*y*y*y +38*y*y
addi $a0,$zero,65
add $a1,$zero,$t1
addi $sp $sp -12
sw $t0 8 ($sp)
sw $t1 4 ($sp)
jal mul
lw $t1 4 ($sp)
lw $t0 8 ($sp)
addi $sp $sp 12
add $t9 $t9 $v0 #t0 = 57*x^2-14*x -462*y*y*y +38*y*y+65*y
addi $t9 $t9 -73    #t0 = 57*x^2-14*x -462*y*y*y +38*y*y+65*y-73
lw $ra 0 ($sp)
addi $sp $sp 4
add $v0 $t9 $zero
jr $ra
euler_fn:     #function for euler calculation for each step
addi $sp $sp -8               
sw $ra 4 ($sp)
sw $s0 0 ($sp)
add $t0 $zero $zero   #i=0   
For3 : slt $at $t0 $a2 # if i<n
      beq $at $zero Exit3 #
      add $a0 $zero $t2
      add $a1 $zero $t1
      addi $sp $sp -28
      sw $a0 24  ($sp)
      sw $a1 20 ($sp)
      sw $a2 16 ($sp)
      sw $t0 12 ($sp)
      sw $t1 8 ($sp)
      sw $t2 4 ($sp)
      sw $at 0 ($sp)
      jal equ
      lw $at 0 ($sp)
      lw $t2 4 ($sp)
      lw $t1 8 ($sp)
      lw $t0 12 ($sp)
      lw $a2 16 ($sp)
      lw $a1 20 ($sp)
      lw $a0 24 ($sp)
      addi $sp $sp 28
      add $a0 $zero $v0
      add $a1 $zero $s0
      addi $sp $sp -28
      sw $a0 24  ($sp)
      sw $a1 20 ($sp)
      sw $a2 16 ($sp)
      sw $t0 12 ($sp)
      sw $t1 8 ($sp)
      sw $t2 4 ($sp)
      sw $at 0 ($sp)    
      jal mul
      lw $at 0 ($sp)
      lw $t2 4 ($sp)
      lw $t1 8 ($sp)
      lw $t0 12 ($sp)
      lw $a2 16 ($sp)
      lw $a1 20 ($sp)
      lw $a0 24 ($sp)
      addi $sp $sp 28
      add $t1 $t1 $v0      #  y=y+h*equ(x,y)
      add $t2 $t2 $s0      #x=x+h
      addi $t0 $t0 1       # i+=1
      j For3
Exit3:
add $v0 $t1 $zero 
lw $s0 0 ($sp)
lw $ra 4 ($sp)
addi $sp $sp 8
jr $ra
tt:
#Mohamed_Nader_junior_ECE