https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
# we would use this (4*i*M)+(j*4) 	
# to calculate the index of a 2d-array
# i is our ith-index (index in row)
# j is our jth-index (index in column)
# M is the total number of columns for respective arrays

.data



enter_rows_cols: .asciiz "Please Enter values for n, k and m:\n"
enter_first_matrix: .asciiz "\nPlease enter values for the first matrix ("
enter_second_matrix: .asciiz "\nPlease enter values for the second matrix ("

tab:			.asciiz "\t"
extra_1:		.asciiz "):\n"
str1:	.asciiz "\n ------------- \n"
str2:	.asciiz "\nmultiplied by\n"
str3:	.asciiz "\n\nequals\n"
nLine:	.asciiz "\n\n"
space:  .asciiz " "
t1:	.asciiz "*********"
t2:	.asciiz "\n========="

arrayA:  .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
arrayARow:	.word 0
arrayACol:	.word 0


arrayB: 	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
arrayBRow:	.word 0
arrayBCol:	.word 0

arrayC: 	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 		# arrayARow x arrayBCol



.text
.global main
main:

##############################
# Assigning address to regs
##############################


lw $s0,arrayA($zero)
lw $s1,arrayB($zero)
lw $s2,arrayC($zero)


##############################
# Declaring variables
##############################
li $t0,0
li $t1,0  	# total column or rows

###############################

# print string asking values for n k & m
li $v0,4
la $a0,enter_rows_cols
syscall


# prompt user to enter value for n
li $v0,5
syscall
sw $v0,arrayARow($zero)	# save that value in memory

# prompt user to enter value for k
li $v0,5
syscall
sw $v0,arrayACol($zero)

# prompt user to enter value for m
li $v0,5
syscall
sw $v0,arrayBCol($zero)


# assigning values
lw $s5,arrayARow($zero)
lw $s6,arrayACol($zero)
lw $s7,arrayBCol($zero)

# ****** print's string :Please enter values for the first matrix (nxk): *********
li $v0,4
la $a0,enter_first_matrix
syscall

move $a0,$s5
li $v0,1
syscall

li $a0,'x'
li $v0,11
syscall

move $a0,$s6
li $v0,1
syscall

li $v0,4
la $a0,extra_1
syscall

# ****************************************************************

li $t0,0
mul $t1,$s5,$s6	# t1 =  nxk, so that we can set counter for our loop to read upto t1 num
li $s0,0

read_matrix_A_loop:
beq $t0,$t1,read_matrix_A_loop_end

li $v0,5
syscall

sw $v0,arrayA($s0)

addi $t0,$t0,1
addi $s0,$s0,4

j read_matrix_A_loop


read_matrix_A_loop_end:

# ****** print's string :Please enter values for the second matrix (kxm): *********

li $v0,4
la $a0,enter_second_matrix
syscall

move $a0,$s6
li $v0,1
syscall

li $a0,'x'
li $v0,11
syscall

move $a0,$s7
li $v0,1
syscall

li $v0,4
la $a0,extra_1
syscall

# ****************************************************************


li $t0,0
mul $t1,$s6,$s7
li $s0,0

read_matrix_B_loop:
beq $t0,$t1,read_matrix_B_loop_end

li $v0,5
syscall

sw $v0,arrayB($s0)

addi $t0,$t0,1
addi $s0,$s0,4

j read_matrix_B_loop

read_matrix_B_loop_end:
li $t0,0
mul $t1,$s5,$s7
li $s0,0


set_matrix_C_0_loop:
beq $t0,$t1,set_matrix_C_0_loop_end

sw $0,arrayC($s0)

addi $t0,$t0,1
addi $s0,$s0,4

j set_matrix_C_0_loop

set_matrix_C_0_loop_end:

move $a1,$s5
move $a2,$s6
la $a3,arrayA
jal print

li $v0,4
la $a0,str2
syscall

move $a1,$s6
move $a2,$s7
la $a3,arrayB
jal print


li $v0,4
la $a0,str3
syscall


add $t0,$t0,$zero
addi $t3 ,$zero ,0 	
###############################


##############################
# Matrix Multiplication 
##############################

li $t0,0
jal multiply
##############################

afterMulitplication:



##############################
# Printing  
##############################
li $s0,0
li $s1,0

move $a1,$s5
move $a2,$s7
la $a3,arrayC
jal print

j exit
##############################


##############################
# Exit
##############################
exit:
li $v0,10
syscall
##############################



multiply:


	addi $t0,$zero,0 					# t0 =0
	loop0:
		beq $t0,$s5,loop0End	# t0 == $s5 (arrayARow)
		addi $t1,$zero,0	# i



		loop1:
			beq $t1,$s7,loop1End 		# t1 == $s6 (arrayACol)
			addi $t2,$zero,0	# j

			
			loop2:
				beq $t2,$s6,loop2End 	# t2 == $s6 (arrayACol)
				addi $s3,$zero,4
				

				#add of array A
				mul $t3,$t0,$s3	# 8*i
				mul $t4,$t3,$s6	# (8*i) * M
				
				mul $t3,$t2,$s3	# j * 8
				
				add $t5,$t3,$t4	# index of array A -> t5

				#dadd $s0,$s0,$t5	# add the index to the array base address
				lw $t6,arrayA($t5)	# element of arrayA A[i][j]


				#add of array B
				mul $t3,$t2,$s3	# 8*j
				mul $t4,$t3,$s7	# (8*j) * M
				
				mul $t3,$t1,$s3	# i * 8
				
				add $t5,$t3,$t4	# index of array A -> t5
				
			#	dadd $s1,$s1,$t5	# add the index to the array base address
				lw $t7,arrayB($t5)	# element of arrayB B[j][i]


				#add of array C
				mul $t3,$t0,$s3	# 8* main counter 0*8
				mul $t4,$t3,$s7	# (8*i) * M  0*3

				mul $t3,$t1,$s3	# j * 8      3*8 

				add $t5,$t3,$t4	# index of array C -> t5 24

				#dadd $s2,$s2,$t5	# arrayC baseAddr + index


				mul $t3,$t6,$t7	# t3 = A[i][j] * B[j][i]
				
				

				lw $t4,arrayC($t5)	# t4 =load the element of C[i][j]
				add $t4,$t4,$t3	# add the element with the 
				sw $t4,arrayC($t5)	# C[i][j] = t3
				


				addi $t2,$t2,1 	# increment j counter

				
			
			j loop2
			
			loop2End:
			addi $t1,$t1,1 		# increment i  counter


		j loop1
			
		loop1End:
			addi $t0,$t0,1 		# increment main counter
		
	j loop0

	loop0End:
				
jr $ra # return


print:
li $t0,0
move $s0,$a1
move $s1,$a2

	loop3:
		beq $t0,$s0,break3
		li $t1,0
		
		addi $t0,$t0,1
		addi $v0,$zero,4
		la $a0,nLine
		syscall
		
		li $a0,'['
		li $v0,11
		syscall
		
		loop4:
			beq $t1,$s1,loop4_end
			lw $a0,0($a3)
			addi $v0,$zero,1
			syscall
			
			li $v0,4
			la $a0,tab
			syscall
			
			#addi $s0,$s0,4
			addi $a3,$a3,4
			addi $t1,$t1,1
		j loop4
		
		loop4_end:
		li $a0,']'
		li $v0,11
		syscall
				
		j loop3
	break3:  	
	
jr $ra
