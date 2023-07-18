# Eric Grunblatt
# egrunblatt
# 112613770

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################

.text
memcpy:
	addi $sp, $sp, -12				# allocate 12 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	move $s0, $a0					# $s0 = dest
	move $s1, $a1					# $s1 = src
	move $s2, $a2					# $s2 = n
	
	ble $s2, $0, memcpy_neg_1			# $s2 <= 0, memcpy_neg_1
	
	move $t0, $s0 					# $t0 = temporary dest
	move $t1, $s1					# $t1 = temporary src
	
	li $t2, 0					# $t2 - 0, counter until n
	memcpy_loop:
		beq $t2, $s2, end_memcpy_loop		# $t2 = n, end loop
		lbu $t3, 0($t1)				# $t3 = current element of src
		sb $t3, 0($t0)				# stores $t3 in dest
		addi $t0, $t0, 1			# add 1 to dest
		addi $t1, $t1, 1			# add 1 to src
		addi $t2, $t2, 1			# add 1 to counter
		j memcpy_loop				# jump to top of loop		
	end_memcpy_loop:
	move $v0, $s2					# $v0 = n
	j memcpy_load					# jump to memcpy_load
	
	memcpy_neg_1:
		li $v0, -1				# $v0 = -1
		j memcpy_load				# jump to memcpy_load
		
	memcpy_load:	
	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	addi $sp, $sp, 12				# deallocate 12 bytes of space
	
    	jr $ra						# return to main address
strcmp:
	addi $sp, $sp, -8				# allocate 8 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	move $s0, $a0					# $s0 = str1
	move $s1, $a1					# $s1 = str2
	
	lbu $t0, 0($s0)					# $t0 = first element of str1
	beq $t0, $0, check_0_strcmp			# $t0 = $0, check_0_strcmp
	lbu $t1, 0($s1)					# $t1 = first element of str2
	beq $t1, $0, strcmp_str1			# $t1 = $0, strcmp_str1
	j strcmp_loop_setup				# jump to strcmp_loop_setup
	
	check_0_strcmp:
		lb $t1, 0($s1)				# $t1 = first element of str2
		beq $t1, $0, strcmp_v0_0		# $t1 = $0, strcmp_v0_0
		j strcmp_str2				# jump to strcmp_str2
	
	strcmp_loop_setup:
	move $t0, $s0					# $t0 = str1
	move $t1, $s1					# $t1 = str2
	li $t4, 0					# $t4 = 0, counter
	strcmp_loop:
		lbu $t2, 0($t0)				# $t2 = current byte of str1
		lbu $t3, 0($t1)				# $t3 = current byte of str2
		beq $t2, $0, check_str_strcmp		# $t2 = $0, end loop
		bne $t2, $t3, end_strcmp_loop		# $t2 != $t3
		addi $t0, $t0, 1			# add 1 to str1
		addi $t1, $t1, 1			# add 1 to str2
		addi $t4, $t4, 1			# add 1 to counter
		j strcmp_loop				# jump to top of loop
		
		check_str_strcmp:
			beq $t3, $0, strcmp_v0_0		# $t3 = $0, strcmp_v0_0
	end_strcmp_loop:
	sub $v0, $t2, $t3					# $v0 = $t2 - $t3
	j strcmp_load						# jump to strcmp_load
	
	strcmp_str1:
		li $t0, 0					# counter
		move $t1, $s0					# $t1 = str1
		strcmp_str1_loop:
			lb $t2, 0($t1)				# $t1 = current byte of str1
			beq $t2, $0, end_strcmp_str1_loop	# $t1 = $0, end loop
			addi $t0, $t0, 1			# add 1 to counter
			addi $t1, $t1, 1			# add 1 to str1
			j strcmp_str1_loop			# jump to top of loop
		end_strcmp_str1_loop:
		move $t4, $t0					# $v0 = counter
		j strcmp_load					# jump to strcmp_load
		
	strcmp_str2:
		li $t0, 0					# counter
		move $t1, $s1					# $t1 = str2
		strcmp_str2_loop:
			lb $t2, 0($t1)				# $t1 = current byte of str2
			beq $t2, $0, end_strcmp_str2_loop	# $t1 = $0, end loop
			addi $t0, $t0, 1			# add 1 to counter
			addi $t1, $t1, 1			# add 1 to str2
			j strcmp_str2_loop			# jump to top of loop
		end_strcmp_str2_loop:
		move $t4, $t0					# $v0 = counter
		li $t0, -1					# $t0 = -1
		mul $v0, $t4, $t0				# $v0 = $t4 * -1
		j strcmp_load					# jump to strcmp_load
		
	strcmp_v0_0:
		li $v0, 0					# $v0 = 0
	
	strcmp_load:
	lw $s0, 0($sp)					# store $s0
	lw $s1, 4($sp)					# store $s1
	addi $sp, $sp, 8				# deallocate 8 bytes of space
    	jr $ra						# return to main address

initialize_hashtable:
	addi $sp, $sp, -16				# allocate 16 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	sw $s3, 12($sp)					# store $s3
	move $s0, $a0					# $s0 = hashtable
	move $s1, $a1					# $s1 = capacity
	move $s2, $a2					# $s2 = element size
	
	blez $s1, initialize_hashtable_v0_neg_1		# capacity <= 0, initialize_hashtable_v0_neg_1
	blez $s2, initialize_hashtable_v0_neg_1		# element size <= 0, initialize_hashtable_v0_neg_1
	
	li $t0, 0					# $t0 = 0
	sw $s1, 0($s0)					# capacity
	sw $t0, 4($s0)					# size
	sw $s2, 8($s0)					# element size
	
	mul $s3, $s1, $s2				# $s3 = capacity * element size
	
	li $t0, 0						# counter for loop
	move $t1, $s0						# $t1 = hashtable
	addi $t1, $t1, 12					# starts on 12th byte
	li $t2, 0						# element stored in each byte
	initialize_hashtable_loop:
		beq $t0, $s3, end_initialize_hashtable_loop	# counter = $s3, end loop
		sb $t2, 0($t1)					# store $0 in current byte
		addi $t0, $t0, 1				# add 1 to counter
		addi $t1, $t1, 1				# add 1 to hashtable
		j initialize_hashtable_loop			# jump to top of loop
	end_initialize_hashtable_loop:
	sb $0, 0($t1)						# null terminator
	li $v0, 0						# $v0 = 0
	j initialize_hashtable_load				# jump to initialize_hashtable_load
	
	initialize_hashtable_v0_neg_1:
		li $v0, -1					# $v0 = -1
		
	initialize_hashtable_load:
	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	lw $s3, 12($sp)					# load $s3
	addi $sp, $sp, 16				# deallocate 16 bytes of space
	jr $ra						# return to main address

hash_book:
	addi $sp, $sp, -8				# allocate 8 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	move $s0, $a0					# $s0 = books
	move $s1, $a1					# $s1 = isbn
	
	lw $t0, 0($s0)					# $t0 = books capacity
	li $t1, 0					# $t1 = 0, counter
	li $t2, 13					# $t2 = 13, # of isbn bytes
	move $t3, $s1					# $t3 = isbn
	li $t4, 0					# $t4 = 0, sum of isbn numbers
	hash_book_loop:
		beq $t1, $t2, end_hash_book_loop	# counter = 13, end loop
		lbu $t5, 0($t3)				# gets current isbn number
		add $t4, $t4, $t5			# $t4 += current isbn number
		addi $t1, $t1, 1			# add 1 to counter
		addi $t3, $t3, 1			# add 1 to isbn
		j hash_book_loop			# jump to top of loop
	end_hash_book_loop:
	div $t4, $t0					# divide sum by books capacity
	mfhi $v0					# $v0 = remainder
	
	hash_book_load:
    	lw $s0, 0($sp)					# store $s0
	lw $s1, 4($sp)					# store $s1
	addi $sp, $sp, 8				# deallocate 8 bytes of space
    	jr $ra						# return to main address


get_book:
	addi $sp, $sp, -32				# allocate 32 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	sw $s3, 12($sp)					# store $s3
	sw $s4, 16($sp)					# store $s4
	sw $s5, 20($sp)					# store $s5
	sw $s6, 24($sp)					# store $s6
	sw $ra, 28($sp)					# store $ra
	move $s0, $a0					# $s0 = hashtable books
	move $s1, $a1					# $s1 = isbn
	
	lbu $s2, 8($s0)					# $s2 = element size
	lbu $s3, 0($s0)					# $s3 = capacity
	li $s4, 1					# $s4 = 0, capacity counter
	lbu $t0, 4($s0)					# $t0 = size
	beq $t0, $0, get_book_size_0			# $t0 = 0, get_book_v0_neg_1
	li $s4, 0					# $s4 = 1, 
	
	
	move $a0, $s0					# $a0 = hashtable books
	move $a1, $s1					# $a1 = isbn
	jal hash_book					# jump and link hash_book
	move $s5, $v0					# $s5 = index
	
	
	move $t0, $s0					# $t0 = hashtable books
	addi $t0, $t0, 12				# add 12 to $t1
	mul $t1, $s5, $s2				# $t1 = index * element size
	add $t0, $t0, $t1				# add $t0 to hashtable books
	
	lbu $t1, 0($t0)					# $t1 = first character	
	beq $t1, $0, get_book_v0_neg_1			# $t1 = $0, get_book_v0_neg_1
	
	get_book_loop:
		beq $s4, $s3, get_book_reach_capacity	# $s4 = capacity, get_book_reach_capacity
		addi $s4, $s4, 1			# add 1 to counter
		
		lbu $t1, 0($t0)				# $t1 = first character
		li $t2, -1				# $t2 = -1
		beq $t1, $0, get_book_v0_neg_1		# $t1 = $0, get_book_v0_neg_1
		beq $t1, $t2, get_book_next		# $t1 = -1, get_book_skip
		
		move $a0, $s1				# $a0 = isbn
		move $a1, $t0				# $a1 = current string in hashtable
		jal strcmp				# jump and link strcmp
		beq $v0, $0, end_get_book_loop		# $v0 = $0, end loop
		
		get_book_next:
		addi $s5, $s5, 1			# add 1 to index
		move $t2, $s3				# $t2 = capacity
		beq $s5, $t2, get_book_reset_index	# $s5 = capacity, reset index	
		move $t0, $s0				# $t0 = hashtable books
		addi $t0, $t0, 12			# add 12 to $t0
		mul $t1, $s5, $s2			# $t1 = index * element size
		add $t0, $t0, $t1			# add $t1 to hashtable books
		j get_book_loop				# jump to top of loop 			
		
		get_book_reset_index:
			li $s5, 0			# $s5 = 0
			move $t0, $s0			# $t0 = hashtable books
			addi $t0, $t0, 12		# add 12 to $t0
			add $t0, $t0, $s2		# add $t1 to hashtable books
			j get_book_loop			# jump to top of loop
		
	end_get_book_loop:
	move $v0, $s5					# $v0 = index
	move $v1, $s4					# $v1 = counter
	j get_book_load					# jump to get_book_load
	
	get_book_v0_neg_1:
		addi $s4, $s4, 1
		li $v0, -1				# $v0 = -1
		move $v1, $s4				# $v1 = 1
		j get_book_load				# jump to get_book_load
		
	get_book_size_0:
		li $v0, -1				# $v0 = -1
		li $v1, 1				# $v0 = 1
		j get_book_load				# get_book_load
	
	get_book_reach_capacity:
		li $v0, -1				# $v0 = -1
		move $v1, $s4				# $v1 = 1
		j get_book_load				# jump to get_book_load
	
	
	get_book_load:
    	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	lw $s3, 12($sp)					# load $s3
	lw $s4, 16($sp)					# load $s4
	lw $s5, 20($sp)					# load $s5
	lw $s6, 24($sp)					# load $s6
	lw $ra, 28($sp)					# load $ra
	addi $sp, $sp, 32				# deallocate 32 bytes of space
	jr $ra						# return to main address

add_book:
	addi $sp, $sp, -36				# allocate 36 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	sw $s3, 12($sp)					# store $s3
	sw $s4, 16($sp)					# store $s4
	sw $s5, 20($sp)					# store $s5
	sw $s6, 24($sp)					# store $s6
	sw $s7, 28($sp)					# store $s7
	sw $ra, 32($sp)					# store $ra
	move $s0, $a0					# $s0 = hashtable books
	move $s1, $a1					# $s1 = isbn
	move $s2, $a2					# $s2 = title
	move $s3, $a3					# $s3 = author
	
	lbu $t0, 0($s0)					# $t0 = capacity
	lbu $t1, 4($s0)					# $t1 = size
	beq $t0, $t1, add_book_full			# capacity = size, add_book_full
	
	move $a0, $s0					# $a0 = hashtable books
	move $a1, $s1					# $a1 = isbn
	jal get_book					# jump and link get_book
	move $s4, $v0					# $s4 = index
	move $s5, $v1					# $s5 = number of places checked
	li $t0, -1					# $t0 = -1
	beq $s4, $t0, add_book_setup			# $s4 = -1, add_book_setup
	j add_book_done					# jump to add_book_final
	
	add_book_setup:
		move $a0, $s0				# $a0 = hashtable books
		move $a1, $s1				# $a1 = isbn
		jal hash_book				# jump and link hash_book
		move $s4, $v0				# $s4 = index
		li $s5, 1				# $s5 = 1, counter
		
		move $t0, $s0				# $t0 = hashtable books
		addi $t0, $t0, 12			# add 12 to hashtable books
		lbu $t1, 8($s0)				# $t1 = element capacity
		mul $t1, $t1, $v0			# $t1 = element capacity * index
		add $t0, $t0, $t1			# add $t1 to hashtable books		
		
		add_book_loop:
			lbu $t2, 0($t0)				# gets current index
			li $t3, 0x000000ff			# $t3 = -1
			beq $t2, $0, add_book_insert		# $t2 = 0, add_book_insert
			beq $t2, $t3, add_book_insert		# $t2 = -1, add_book_insert
		
			addi $s4, $s4, 1			# add 1 to index
			addi $s5, $s5, 1			# add 1 to counter
			lbu $t4, 0($s0)				# $t4 = capacity
			beq $s4, $t4, add_book_reset_index	# $s5 = capacity, reset index	
			move $t0, $s0				# $t0 = hashtable books
			addi $t0, $t0, 12			# add 12 to $t0
			lbu $t5, 8($s0)				# $t5 = element size
			mul $t1, $s4, $t5			# $t1 = index * element size
			add $t0, $t0, $t1			# add $t1 to hashtable books
			j add_book_loop				# jump to top of loop 			
		
			add_book_reset_index:
				li $s4, 0			# $s5 = 0
				move $t0, $s0			# $t0 = hashtable books
				addi $t0, $t0, 12		# add 12 to $t0
				lbu $t5, 8($s0)			# $t5 = element size
				add $t0, $t0, $t5		# add $t5 to hashtable books
				j add_book_loop			# jump to top of loop
		end_add_book_loop:	
		
	add_book_insert:
		move $s6, $t0					# $s6 = $t0
		
		# Insert ISBN
		move $a0, $s6					# $a0 = hashtable books
		move $a1, $s1					# $a1 = isbn
		li $a2, 13					# $a2 = 13
		jal memcpy					# jump and link memcpy
		addi $s6, $s6, 13				# add 13 to $t0
		sb $0, 0($s6)					# store null terminator
		addi $s6, $s6, 1				# add 1 to $t0
		
		# Insert Title
		move $t1, $s2					# $t1 = title
		li $s7, 0					# $t2 = 0, counter
		add_book_title_loop:
			lbu $t2, 0($t1)				# $t3 = current character
			beq $t2, $0, end_add_book_title_loop	# $t3 = $0, end loop
			addi $t1, $t1, 1			# add 1 to title
			addi $s7, $s7, 1			# add 1 to counter
			j add_book_title_loop			# jump to top of loop
		end_add_book_title_loop:
		
		li $t1, 24					# $t1 = 24
		ble $s7, $t1, add_book_title_setup		# $s7 <= 24, jump to setup
		li $s7, 24					# $s7 = 24 if greater
		
		add_book_title_setup:
		move $a0, $s6						# $a0 = hashtable books
		move $a1, $s2						# $a1 = title
		move $a2, $s7						# $a2 = $s7
		jal memcpy						# jump and link memcpy
		add $s6, $s6, $s7					# add $s7 to $s6
		li $t1, 24						# $t1 = 24
		sub $t1, $t1, $s7					# $t1 = 24 - $s7
		li $t2, 0						# $t1 = 0, counter for loop
		add_book_title_null_loop:
			beq $t2, $t1, end_add_book_title_null_loop	# $t2 = $t1, end loop
			sb $0, 0($s6)					# store null terminator
			addi $s6, $s6, 1				# add 1 to hashtable
			addi $t2, $t2, 1				# add 1 to counter
			j add_book_title_null_loop			# jump to top of loop
		end_add_book_title_null_loop:
		sb $0, 0($s6)					# store null terminator
		addi $s6, $s6, 1				# add 1 to hashtable
		
		# Insert Author
		move $t1, $s3					# $t1 = title
		li $s7, 0					# $t2 = 0, counter
		add_book_author_loop:
			lbu $t2, 0($t1)				# $t3 = current character
			beq $t2, $0, end_add_book_author_loop	# $t3 = $0, end loop
			addi $t1, $t1, 1			# add 1 to title
			addi $s7, $s7, 1			# add 1 to counter
			j add_book_author_loop			# jump to top of loop
		end_add_book_author_loop:
		
		li $t1, 24					# $t1 = 24
		ble $s7, $t1, add_book_author_setup		# $s7 <= 24, jump to setup
		li $s7, 24					# $s7 = 24 if greater
		
		add_book_author_setup:
		move $a0, $s6						# $a0 = hashtable books
		move $a1, $s3						# $a1 = author
		move $a2, $s7						# $a2 = $s7
		jal memcpy						# jump and link memcpy
		add $s6, $s6, $s7					# add $s7 to $s6
		li $t1, 24						# $t1 = 24
		sub $t1, $t1, $s7					# $t1 = 24 - $s7
		li $t2, 0						# $t1 = 0, counter for loop
		add_book_author_null_loop:
			beq $t2, $t1, end_add_book_author_null_loop	# $t2 = $t1, end loop
			sb $0, 0($s6)					# store null terminator
			addi $s6, $s6, 1				# add 1 to hashtable
			addi $t2, $t2, 1				# add 1 to counter
			j add_book_author_null_loop			# jump to top of loop
		end_add_book_author_null_loop:
		sb $0, 0($s6)					# store null terminator
		addi $s6, $s6, 1				# add 1 to hashtable
		sb $0, 0($t0)					# store sales 0
		
		lbu $t0, 4($s0)				# $t0 = size
		addi $t0, $t0, 1			# add 1 to size
		sb $t0, 4($s0)				# store new size
		
	add_book_done:
		move $v0, $s4				# $v0 = $s4
		move $v1, $s5				# $v0 = $s5
		j add_book_load				# jump to add_book_load
	
	add_book_full:
		li $v0, -1				# $v0 = -1
		li $v1, -1				# $v1 = -1
		j add_book_load				# jump to add_book_load
	
	add_book_load:
	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	lw $s3, 12($sp)					# load $s3
	lw $s4, 16($sp)					# load $s4
	lw $s5, 20($sp)					# load $s5
	lw $s6, 24($sp)					# load $s6
	lw $s7, 28($sp)					# load $s7
	lw $ra, 32($sp)					# load $ra
	addi $sp, $sp, 36				# deallocate 36 bytes of space
	
    	jr $ra						# returns to main address

delete_book:
	addi $sp, $sp, -16				# allocate 16 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	sw $ra, 12($sp)					# store $ra
	move $s0, $a0					# $s0 = hashtable books
	move $s1, $a1					# $s1 = isbn
	
	jal get_book					# jump and link get_book
	move $s2, $v0					# $s2 = index
	li $t0, -1					# $t0 = -1
	beq $s2, $t0, delete_book_v0_neg_1		# $v0 = -1, delete_book_v0_neg_1
	
	move $t0, $s0					# $t0 = hashtable books
	lbu $t1, 8($s0)					# $t1 = element size
	addi $t0, $t0, 12				# add 12 to hashtable books
	mul $t2, $t1, $s2				# $t2 = element size * index
	add $t0, $t0, $t2				# add $t2 to $t0
	
	li $t3, 0					# $t3 = counter
	li $t4, 0x000000ff				# $t4 = 8 byte -1
	delete_book_loop:
		beq $t3, $t1, end_delete_book_loop	# $t3 = element size, end loop
		sb $t4, 0($t0)				# store -1 in current position
		addi $t0, $t0, 1			# add 1 to hashtable books
		addi $t3, $t3, 1			# add 1 to counter
		j delete_book_loop			# jump to top of loop
	end_delete_book_loop:
	
	lbu $t0, 4($s0)					# $t0 = size
	addi $t0, $t0, -1				# subtract 1 from size
	sb $t0, 4($s0)					# store new size
	move $v0, $s2					# $v0 = index
	li $v1, 0					# $v1 = 0
	j delete_book_load				# jump to delete_book_load
	
	delete_book_v0_neg_1:
		li $v0, -1				# $v0 = -1
		li $v1, 0				# $v1 = 0
		j delete_book_load			# jump to delete_book_load
	
	delete_book_load:
	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	lw $ra, 12($sp)					# load $ra
	addi $sp, $sp, 16				# deallocate 16 bytes of space
	
    	jr $ra						# returns to main address

hash_booksale:
	addi $sp, $sp, -12				# allocate 12 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	move $s0, $a0					# $s0 = books
	move $s1, $a1					# $s1 = isbn
	move $s2, $a2					# $s2 = customer id
	
	li $t1, 0					# $t1 = 0, counter
	li $t2, 13					# $t2 = 13, # of isbn bytes
	move $t3, $s1					# $t3 = isbn
	li $t4, 0					# $t4 = 0, sum
	hash_booksale_isbn_loop:
		beq $t1, $t2, end_hash_booksale_isbn_loop	# counter = 13, end loop
		lbu $t5, 0($t3)					# gets current isbn number
		add $t4, $t4, $t5				# $t4 += current isbn number
		addi $t1, $t1, 1				# add 1 to counter
		addi $t3, $t3, 1				# add 1 to isbn
		j hash_booksale_isbn_loop			# jump to top of loop
	end_hash_booksale_isbn_loop:
	
	move $t0, $s2						# $t0 = customer id
	li $t1, 10						# $t1 = 10
	hash_booksale_cust_loop:
		beq $t0, $0, end_hash_booksale_cust_loop	# $t0 = 0, end loop
		div $t0, $t1					# divide $10 by 10
		mflo $t0					# $t0 = quotient
		mfhi $t2					# $t2 = remainder
		add $t4, $t4, $t2				# add remainder to sum
		j hash_booksale_cust_loop			# jump to top of loop
	end_hash_booksale_cust_loop:
	
	lw $t0, 0($s0)					# $t0 = books capacity
	div $t4, $t0					# divide sum by books capacity
	mfhi $v0					# $v0 = remainder
	
	hash_booksale_load:
    	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	addi $sp, $sp, 12				# deallocate 12 bytes of space
    	jr $ra						# return to main address

is_leap_year:
	addi $sp, $sp, -12				# allocate 12 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	move $s0, $a0					# $s0 = year
	
	li $t0, 1582					# $t0 = 1582
	blt $s0, $t0, is_leap_year_v0_0			# $s0 < 1582, is_leap_year_v0_0
	
	move $t0, $s0					# $t0 = year
	li $t1, 400					# $t1 = 400
	div $t0, $t1					# divide year by 400
	mfhi $t2					# $t2 = remainder
	beq $t2, $0, is_leap_year_v0_1			# $t2 = 0, is_leap_year_v0_1
	
	move $t0, $s0					# $t0 = year
	li $t1, 100					# $t1 = 100
	div $t0, $t1					# divide year by 100
	mfhi $t2					# $t2 = remainder
	beq $t2, $0, is_leap_year_v0_neg		# $t2 = 0, is_leap_year_v0_neg
	
	move $t0, $s0					# $t0 = year
	li $t1, 4					# $t1 = 4
	div $t0, $t1					# divide year by 4
	mfhi $t2					# $t2 = remainder
	beq $t2, $0, is_leap_year_v0_1			# $t2 = 0, is_leap_year_v0_1
	move $s1, $t2					# $s1= remainder
	j is_leap_year_v0_neg				# jump to is_leap_year_v0_neg
	
	
	is_leap_year_v0_0:
		li $v0, 0				# $v0 = 0
		j is_leap_year_load			# jump to is_leap_year_load
		
	is_leap_year_v0_1:
		li $v0, 1				# $v0 = 1
		j is_leap_year_load			# jump to is_leap_year_load
		
	is_leap_year_v0_neg:
		move $t0, $s0				# $t0 = year
		li $t1, 4				# $t1 = 4
		sub $s1, $t1, $s1			# $s1 = 4 - $s1
		add $s2, $t0, $s1			# add remainder for next year
		
		move $t0, $s2				# $t0 = year
		li $t1, 400				# $t1 = 400
		div $t0, $t1				# divide year by 400
		mfhi $t2				# $t2 = remainder
		beq $t2, $0, is_leap_year_final_setup	# $t2 = 0, is_leap_year_final_setup
		
		move $t0, $s2				# $t0 = year
		li $t1, 100				# $t1 = 100
		div $t0, $t1				# divide year by 100
		mfhi $t2				# $t2 = remainder
		beq $t2, $0, is_leap_year_add_4		# $t2 = 0, is_leap_year_add_4
		
		is_leap_year_final_setup:
		li $t0, -1				# $t0 = -1
		mul $s1, $s1, $t0			# $v0 = $s1 * -1
		move $v0, $s1				# $v0 = $s1
		j is_leap_year_load			# jump to is_leap_year_load
		
		is_leap_year_add_4:
			addi $s1, $s1, 4		# add 4 to remainder	
			li $t0, -1			# $t0 = -1
			mul $s1, $s1, $t0		# $v0 = $s1 * -1
			move $v0, $s1			# $v0 = $s1
	
	is_leap_year_load:
	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	addi $sp, $sp, 12				# deallocate 12 bytes of space
    	jr $ra						# return to main address

datestring_to_num_days:
	addi $sp, $sp, -36				# allocate 36 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	sw $s3, 12($sp)					# store $s3
	sw $s4, 16($sp)					# store $s4
	sw $s5, 20($sp)					# store $s5
	sw $s6, 24($sp)					# store $s6
	sw $s7, 28($sp)					# store $s7
	sw $ra, 32($sp)					# store $ra
	move $s0 $a0					# $s0 = start date
	move $s1, $a1					# $s1 = end date
	
	# Start year
	li $s2, 0					# $s2 = 0, sum
	lbu $t0, 0($s0)					# first digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	li $t1, 1000					# $t1 = 1000
	mul $t0, $t0, $t1				# $t0 * 1000
	add $s2, $s2, $t0				# add $t0
	lbu $t0, 1($s0)					# second digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	li $t1, 100					# $t1 = 100
	mul $t0, $t0, $t1				# $t0 * 100
	add $s2, $s2, $t0				# add $t0
	lbu $t0, 2($s0)					# third digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	li $t1, 10					# $t1 = 10
	mul $t0, $t0, $t1				# $t0 * 10
	add $s2, $s2, $t0				# add $t0
	lbu $t0, 3($s0)					# fourth digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	add $s2, $s2, $t0				# add $t0
	
	# Start month
	li $s3, 0					# $s3 = 0, sum
	lbu $t0, 5($s0)					# first digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	li $t1, 10					# $t1 = 10
	mul $t0, $t0, $t1				# $t0 * 10
	add $s3, $s3, $t0				# add $t0
	lbu $t0, 6($s0)					# second digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	add $s3, $s3, $t0				# add $t0
	
	# Start day
	li $s4, 0					# $s4 = 0, sum
	lbu $t0, 8($s0)					# first digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	li $t1, 10					# $t1 = 10
	mul $t0, $t0, $t1				# $t0 * 10
	add $s4, $s4, $t0				# add $t0
	lbu $t0, 9($s0)					# second digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	add $s4, $s4, $t0				# add $t0
	
	
	# End year
	li $s5, 0					# $s5 = 0, sum
	lbu $t0, 0($s1)					# first digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	li $t1, 1000					# $t1 = 1000
	mul $t0, $t0, $t1				# $t0 * 1000
	add $s5, $s5, $t0				# add $t0
	lbu $t0, 1($s1)					# second digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	li $t1, 100					# $t1 = 100
	mul $t0, $t0, $t1				# $t0 * 100
	add $s5, $s5, $t0				# add $t0
	lbu $t0, 2($s1)					# third digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	li $t1, 10					# $t1 = 10
	mul $t0, $t0, $t1				# $t0 * 10
	add $s5, $s5, $t0				# add $t0
	lbu $t0, 3($s1)					# fourth digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	add $s5, $s5 $t0				# add $t0
	
	# End month
	li $s6, 0					# $s6 = 0, sum
	lbu $t0, 5($s1)					# first digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	li $t1, 10					# $t1 = 10
	mul $t0, $t0, $t1				# $t0 * 10
	add $s6, $s6, $t0				# add $t0
	lbu $t0, 6($s1)					# second digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	add $s6, $s6, $t0				# add $t0
	
	# End day
	li $s7, 0					# $s7 = 0, sum
	lbu $t0, 8($s1)					# first digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	li $t1, 10					# $t1 = 10
	mul $t0, $t0, $t1				# $t0 * 10
	add $s7, $s7, $t0				# add $t0
	lbu $t0, 9($s1)					# second digit
	addi $t0, $t0, -48				# $t0 subtracts 48
	add $s7, $s7, $t0				# add $t0
	
	# Check years, months, days
	beq $s2, $s5, datestring_check_month		# start year = end year, check month 
	blt $s5, $s2, datestring_v0_neg_1		# end year < start year, datestring_v0_neg_1
	j datestring_find_days_different_year		# jump to datestring_find_days
	
	datestring_check_month:
		beq $s3, $s6, datestring_check_day	# start month = end month, check day
		blt $s6, $s3, datestring_v0_neg_1	# end month < start month, datestring_v0_neg_1
		j datestring_find_days			# jump to datestring_find_days
		
		datestring_check_day:
			beq $s4, $s7, datestring_v0_0		# start day = end day
			blt $s7, $s4, datestring_v0_neg_1	# end day < start day, datestring_v0_neg_1
			sub $v0, $s7, $s4			# $v0 = end day - start day
			j datestring_to_num_days_load		# jump to datestring_find_days
	
	# Different years
	datestring_find_days_different_year:
		# Check if months are the same, if so, check days
		beq $s3, $s6, different_year_check_day		# start month = end month, different_year_check_day
		j datestring_find_days				# jump to datestring_find_days
		
		different_year_check_day:
			sub $s0, $s7, $s4			# $s0 = end day - start day
			li $t0, 2				# $t0 = 2
			ble $s3, $t0, start_leap		# start month <= 2, start_leap
			addi $s2, $s2, 1			# add 1 to start year
			addi $s5, $s5, 1			# add 1 to end year
			j end_leap				# jump to end_leap
				
			start_leap:
				beq $s2, $s5, end_start_leap			# start year = end year, end_start_leap 
				move $a0, $s2					# $a0 = start year
				jal is_leap_year				# jump and link is_leap_year
				li $t0, 1					# $t0 = 1
				beq $v0, $t0, different_add_1			# $v0 = 1, different_add_1
				li $t0, -1					# $t0 = -1
				mul $t0, $v0, $t0				# $t0 = $v0 * -1
				add $s2, $s2, $t0				# $s2 = $s2 + $t0
				li $t1, 365					# $t1 = 365
				mul $t1, $t1, $t0				# $t1 = $t1 * $t0
				add $s0, $s0, $t1				# $s0 = $s0 + $t1
				j start_leap					# jump to start_leap
				
				different_add_1:
					addi $s0, $s0, 366			# $s0 = $s0 + 366
					addi $s2, $s2, 1			# $s2 = $s2 + 1
					j start_leap				# jump to datestring_to_num_days_load
			end_start_leap:
			move $v0, $s0						# $v0 = total sum
			j datestring_to_num_days_load				# jump to datestring_to_num_days_load
				
			end_leap:
				beq $s2, $s5, end_end_leap			# start year = end year, end_end_leap
				move $a0, $s2					# $a0 = start year
				jal is_leap_year				# jump and link is_leap_year
				addi $s2, $s2, 1				# add 1 to start year
				li $t0, 1					# $t0 = 1
				beq $v0, $t0, add_366_end			# $v0 = 1, add_366_end
				addi $s0, $s0, 365				# $v0 = $s0 + 365
				j end_leap					# jump to end_leap
			
				add_366_end:
					addi $s0, $s0, 366			# $v0 = $s0 + 366
					j end_leap				# jump to datestring_to_num_days_load
			end_end_leap:
			move $v0, $s0						# $v0 = total sum
			j datestring_to_num_days_load				# jump to datestring_to_num_days_load
			 
	datestring_find_days:
		julian_start:
		li $t0, 2				# $t0 = 2
		bgt $s3, $t0, julian_end		# $s3 > 2, julian_end
		addi $s3, $s3, 12			# add 12 to start month
		addi $s2, $s2, -1			# subtract 1 from start year
		
		julian_end:
		bgt $s6, $t0, julian_day_start_number	# $s6 > 2, julian_day_start_number
		addi $s6, $s6, 12			# add 12 to end month
		addi $s5, $s5, -1			# subtract 1 from start year
		
		# Julian day number for start date
		julian_day_start_number:
		li $t0, 100				# $t0 = 100 
		div $s2, $t0				# $t0 = year / 100 ($s5)
		mflo $t0				# $t0 = quotient
		
		li $t1, 4				# $t1 = 4
		div $t0, $t1				# $t1 = $t0 / $t1
		mflo $t1				# $t1 = quotient
		
		sub $t2, $t1, $t0			# $t2 = $t1 - $t0
		addi $t2, $t2, 2			# $t2 = $t2 + 2
		
		addi $t4, $s2, 4716			# $t4 = year + 4716 ($s5)
		li $t5, 365				# $t5 = 365
		mul $t3, $t4, $t5			# $t3 = $t4 * 365
		li $t5, 4				# $t4 = 4
		div $t4, $t5				# $t4 = $t4 / $t5
		mflo $t4				# $t4 = quotient
		add $t3, $t3, $t4			# $t3 = $t3 + $t4
		
		addi $t4, $s3, 1			# $t4 = month + 1 ($s6)
		li $t6, 30				# $t6 = 30
		mul $t5, $t4, $t6			# $t3 = $t4 * 365
		li $t6, 6				# $t6 = 6
		mul $t4, $t4, $t6			# $t4 = $t4 * $t6
		li $t6, 10				# $t4 = 10
		div $t4, $t6				# $t4 = $t4 / $t6
		mflo $t4				# $t4 = quotient
		add $t4, $t5, $t4			# $t3 = $t3 + $t4
		
		add $s0, $t2, $s4			# sum = $t2 + days ($s1, $s7)
		add $s0, $s0, $t3			# sum = sum + $t3 ($s1)
		add $s0, $s0, $t4			# sum = sum + $t4 ($s1)
		addi $s0, $s0, -1525			# sum = sum - 1525 ($s1)
		
		julian_day_end_number:
		li $t0, 100				# $t0 = 100 
		div $s5, $t0				# $t0 = year / 100 ($s5)
		mflo $t0				# $t0 = quotient
		
		li $t1, 4				# $t1 = 4
		div $t0, $t1				# $t1 = $t0 / $t1
		mflo $t1				# $t1 = quotient
		
		sub $t2, $t1, $t0			# $t2 = $t1 - $t0
		addi $t2, $t2, 2			# $t2 = $t2 + 2
		
		addi $t4, $s5, 4716			# $t4 = year + 4716 ($s5)
		li $t5, 365				# $t5 = 365
		mul $t3, $t4, $t5			# $t3 = $t4 * 365
		li $t5, 4				# $t4 = 4
		div $t4, $t5				# $t4 = $t4 / $t5
		mflo $t4				# $t4 = quotient
		add $t3, $t3, $t4			# $t3 = $t3 + $t4
		
		addi $t4, $s6, 1			# $t4 = month + 1 ($s6)
		li $t6, 30				# $t6 = 30
		mul $t5, $t4, $t6			# $t3 = $t4 * 365
		li $t6, 6				# $t6 = 6
		mul $t4, $t4, $t6			# $t4 = $t4 * $t6
		li $t6, 10				# $t4 = 10
		div $t4, $t6				# $t4 = $t4 / $t6
		mflo $t4				# $t4 = quotient
		add $t4, $t5, $t4			# $t3 = $t3 + $t4
		
		add $s1, $t2, $s7			# sum = $t2 + days ($s1, $s7)
		add $s1, $s1, $t3			# sum = sum + $t3 ($s1)
		add $s1, $s1, $t4			# sum = sum + $t4 ($s1)
		addi $s1, $s1, -1525			# sum = sum - 1525 ($s1)
		  
		sub $v0, $s1, $s0			# $v0 = $s1 - $s0
		j datestring_to_num_days_load		# jump to datestring_to_num_days_load
	
	datestring_v0_neg_1:
		li $v0, -1				# $v0 = -1
		j datestring_to_num_days_load		# jump to datestring_to_num_days_load
	
	datestring_v0_0:
		li $v0, 0				# $v0 = 0
		j datestring_to_num_days_load		# jump to datestring_to_num_days_load
	
	datestring_to_num_days_load:
	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	lw $s3, 12($sp)					# load $s3
	lw $s4, 16($sp)					# load $s4
	lw $s5, 20($sp)					# load $s5
	lw $s6, 24($sp)					# load $s6
	lw $s7, 28($sp)					# load $s7
	lw $ra, 32($sp)					# load $ra
	addi $sp, $sp, 36				# deallocate 36 bytes of space
    	jr $ra						# returns to main address

sell_book:
	lw $t0, 0($sp)					# $t0 = sale date
	lw $t1, 4($sp)					# $t1 = sale price
	addi $sp, $sp, -36				# allocate 36 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	sw $s3, 12($sp)					# store $s3
	sw $s4, 16($sp)					# store $s4
	sw $s5, 20($sp)					# store $s5
	sw $s6, 24($sp)					# store $s6
	sw $s7, 28($sp)					# store $s7
	sw $ra, 32($sp)					# store $ra
	move $s0, $a0					# $s0 = sales
	move $s1, $a1					# $s1 = books
	move $s2, $a2					# $s2 = isbn
	move $s3, $a3					# $s3 = customer id
	move $s4, $t0					# $s4 = sale date
	move $s5, $t1					# $s5 = sale price
	
	lbu $t0, 0($s0)					# $t0 = sales hashtable capacity
	lbu $t1, 4($s0)					# $t1 = sales hashtable size
	beq $t0, $t1, sell_book_v0_neg_1		# capacity = size, sell_book_v0_neg_1
	
	move $a0, $s1					# $a0 = hashtable books
	move $a1, $s2					# $a1 = isbn
	jal get_book					# jump and link get_book
	li $t0, -1					# $t0 = -1
	beq $v0, $t0, sell_book_v0_neg_2		# $v0 = -1, sell_book_v0_neg_2
	
	move $t0, $s1					# $t0 = hashtable books
	lbu $t1, 8($s1)					# $t1 = element size
	addi $t0, $t0, 12				# add 12 to $t0
	mul $t2, $v0, $t1				# $t1 = index * element size
	add $t0, $t0, $t2				# add $t1 to hashtable books
	addi $t1, $t1, -1				# $t1 = $t1 - 1
	add $t0, $t0, $t1				# add $t1 to hashtable books
	lbu $t1, 0($t0)					# $t1 = sales
	addi $t1, $t1, 1				# add 1 to sales
	sb $t1, 0($t0)					# store new sales
	
	move $a0, $s0					# $a0 = hashtable sales
	move $a1, $s2					# $a1 = isbn
	move $a2, $s3					# $a2 = customer id
	jal hash_booksale				# jump and link hash_booksale
	move $s6, $v0					# $s6 = $v0
	li $s7, 1					# $s7 = counter 
	
	move $t0, $s0					# $t0 = hashtable sales
	addi $t0, $t0, 12				# add 12 to hashtable sales
	lbu $t1, 8($s0)					# $t1 = element capacity
	mul $t1, $t1, $s6				# $t1 = element capacity * index
	add $t0, $t0, $t1				# add $t1 to hashtable sales
	
	sell_book_loop:
		lbu $t2, 0($t0)				# $t2 = current index
		beq $t2, $0, end_sell_book_loop		# $t2 = 0, end loop
		
		addi $s6, $s6, 1			# add 1 to index
		addi $s7, $s7, 1			# add 1 to counter
		lbu $t3, 0($s0)				# $t3 = capacity
		beq $s6, $t3, sell_book_reset_index	# $s6 = capacity, reset index
		move $t0, $s0				# $t0 = hashtable sales
		addi $t0, $t0, 12			# add 12 to $t0
		lbu $t4, 8($s0)				# $t4 = element size
		mul $t1, $s6, $t4			# $t1 = index * element size
		add $t0, $t0, $t1			# add $t1 to hashtable sales
		j sell_book_loop			# jump to top of loop
		
		sell_book_reset_index:
			li $s6, 0			# $s6 = 0
			addi $t0, $t0, 12		# add 12 to $t0
			lbu $t4, 8($s0)			# $t4 = element size
			mul $t1, $s6, $t4		# $t1 = index * element size
			add $t0, $t0, $t1		# add $t1 to hashtable sales
			j sell_book_loop		# jump to top of loop
			
	end_sell_book_loop:
	move $v0, $s6					# $v0 = $s6
	move $v1, $s7					# $v1 = $s7
	
	addi $sp, $sp, -8				# allocate 8 bytes of space
	sw $v0, 0($sp)					# store $v0
	sw $v1 4($sp)					# store $v1
	move $s6, $t0					# $s6 = $t0
	
	# Insert ISBN
	move $a0, $s6					# $a0 = hashtable sales
	move $a1, $s2					# $a1 = isbn
	li $a2, 13					# $a2 = 13
	jal memcpy					# jump and link memcpy	
	addi $s6, $s6, 13				# add 13 to $t0
	sb $0, 0($s6)					# store null terminator
	sb $0, 1($s6)					# store null terminator
	sb $0, 2($s6)					# store null terminator
	addi $s6, $s6, 3				# add 3 to $t0
	
	# Insert Customer ID
	sw $s3, 0($s6)					# store customer id
	addi $s6, $s6, 4				# add 4 to $t0
	
	addi $sp, $sp, -12				# allocate 12 bytes of space
	move $t0, $sp					# $t0 = $sp
	li $t1, '1'					# $t1 = '1'
	li $t2, '6'					# $t2 = '6'
	li $t3, '0'					# $t3 = '0'
	li $t4, '-'					# $t4 = '-'
	sb $t1, 0($t0)					# store '1'
	sb $t2, 1($t0)					# store '6'
	sb $t3, 2($t0)					# store '0'
	sb $t3, 3($t0)					# store '0'
	sb $t4, 4($t0)					# store '-'
	sb $t3, 5($t0)					# store '0'
	sb $t1, 6($t0)					# store '1'
	sb $t4, 7($t0)					# store '-'
	sb $t3, 8($t0)					# store '0'
	sb $t1, 9($t0)					# store '1'
	sb $0, 10($t0)					# store null terminator
	move $a0, $t0					# $a0 = "1600-01-01"
	move $a1, $s4					# $a1 = sale date
	jal datestring_to_num_days			# jump and link datestring_to_num_days
	addi $sp, $sp, 12				# add 12 to $sp
	
	sw $v0, 0($s6)					# store $v0
	addi $s6, $s6, 4				# add 4 to $s6
	sw $s5, 0($s6)					# store sale
	
	move $t0, $s6					# $t0 = $s6
	lw $v0, 0($sp)					# load $v0
	lw $v1, 4($sp)					# load $v1
	addi $sp, $sp, 8				# deallocate 8 bytes of space
	move $s6, $v0					# $s6 = $v0
	move $s7, $v1					# $s7 = $v1	
	
	lbu $t0, 4($s0)					# $t0 = size
	addi $t0, $t0, 1				# add 1 to size
	sb $t0, 4($s0)					# store size
	j sell_book_load				# jump to sell_book_load
	
	sell_book_v0_neg_1:
		li $v0, -1				# $v0 = -1
		li $v1, -1				# $v1 = -1
		j sell_book_load			# jump to sell_book_load
		
	sell_book_v0_neg_2:
		li $v0, -2				# $v0 = -2
		li $v1, -2				# $v1 = -2
		j sell_book_load			# jump to sell_book_load
	
	sell_book_load:
	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	lw $s3, 12($sp)					# load $s3
	lw $s4, 16($sp)					# load $s4
	lw $s5, 20($sp)					# load $s5
	lw $s6, 24($sp)					# load $s6
	lw $s7, 28($sp)					# load $s7
	lw $ra, 32($sp)					# load $ra
	addi $sp, $sp, 36				# allocate 36 bytes of space
    	jr $ra						# return to main address

compute_scenario_revenue:
	addi $sp, $sp, -36				# allocate 36 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	sw $s3, 12($sp)					# store $s3
	sw $s4, 16($sp)					# store $s4
	sw $s5, 20($sp)					# store $s5
	sw $s6, 24($sp)					# store $s6
	sw $s7, 28($sp)					# store $s7
	sw $ra, 32($sp)					# store $ra
	move $s0, $a0					# $s0 = sales list
	move $s1, $a1					# $s1 = num sales
	move $s2, $a2					# $s2 = scenario
	
	# Make 2 arrays for numbers
	li $t0, -1					# $t0 = -1
	mul $t0, $s1, $t0				# $t0 = num sales * -1
	add $sp, $sp, $t0				# allocate num sales bytes on stack
	move $s3, $sp					# $s3 = stack of 0 - (num sales - 1)
	add $sp, $sp, $t0				# allocate num sales bytes on stack
	move $s4, $sp					# $s4 = stack for order of numbers
	
	move $t0, $s3					# $t0 = stack of 0 - (num sales - 1)
	li $t1, 0					# $t1 = 0
	numbered_stack_loop:
		beq $t1, $s1, end_numbered_stack_loop	# counter = num sales, end loop
		sb $t1, 0($t0)				# store current number of current position
		addi $t0, $t0, 1			# add 1 to position
		addi $t1, $t1, 1			# add 1 to number
		j numbered_stack_loop			# jump to top of loop
	end_numbered_stack_loop:
	
	move $s5, $s4					# $s5 = stack of ordered numbers
	move $t0, $s1					# $t0 = num sales
	addi $t0, $t0, -1				# $t0 = $t0 - 1
	li $s6, 1					# $s6 = value that we check with
	sllv $s6, $s6, $t0				# shift $s6 (num sales - 1) places
	li $s7, 0					# $s7 = counter of bytes in new stack
	compute_scenario_loop:
		beq $s6, $0, end_compute_scenario_loop	# counter = num sales, end loop
		move $t0, $s2				# $t0 = scenario
		and $t1, $t0, $s6			# $t1 = scenario * current multiple of 2
		div $t1, $s6				# $t1 = $t1 / current multiple of 2
		mflo $t1				# $t1 = quotient
		li $t2, 1				# $t2 = 1
		beq $t1, $0, compute_scenario_left	# $t1 = 0, compute_scenario_left
		beq $t1, $t2, compute_scenario_right	# $t1 = 1, compute_scenario_right
		
		compute_scenario_left:
			move $t0, $s3						# $t0 = stack of 0 - (num sales - 1)
			scenario_left_loop:
				lbu $t1, 0($t0)					# $t0 = left byte
				li $t2, 0					# $t1 = counter
				move $t3, $s4					# $t2 = order stack
				check_left_loop:
					beq $t2, $s7, end_scenario_left_loop	# counter = $s7, end outer loop
					lbu $t4, 0($t3)				# $t4 = current byte of $t2
					beq $t1, $t4, end_check_left_loop	# $t0 = $t4, scenario_left_reset
					addi $t3, $t3, 1			# add 1 to $t3
					addi $t2, $t2, 1			# add 1 to counter
					j check_left_loop			# jump to top of inner loop
				end_check_left_loop:
				addi $t0, $t0, 1				# adds 1 to $t0
				j scenario_left_loop				# jump to top of outer loop
			end_scenario_left_loop:
			sb $t1, 0($s5)						# store $t0 in current position of $s5
			addi $s7, $s7, 1					# add 1 to $s7
			j compute_setup						# jump to setup
			
		compute_scenario_right:
			move $t0, $s3						# $t0 = stack of 0 - (num sales - 1)
			add $t0, $t0 $s1					# $t0 adds num sales 
			addi $t0, $t0, -1					# subtract 1 from $t0
			scenario_right_loop:
				lbu $t1, 0($t0)					# $t0 = right byte
				li $t2, 0					# $t1 = counter
				move $t3, $s4					# $t2 = order stack
				check_right_loop:
					beq $t2, $s7, end_scenario_right_loop	# counter = $s7, end outer loop
					lbu $t4, 0($t3)				# $t3 = current byte of $t2
					beq $t1, $t4, end_check_right_loop	# $t0 = $t4, scenario_left_reset
					addi $t3, $t3, 1			# add 1 to $t3
					addi $t2, $t2, 1			# add 1 to counter
					j check_right_loop			# jump to top of inner loop
				end_check_right_loop:
				addi $t0, $t0, -1				# subtracts 1 to $t0
				j scenario_right_loop				# jump to top of outer loop
			end_scenario_right_loop:
			sb $t1, 0($s5)						# store $t0 in current position of $s5
			addi $s7, $s7, 1					# add 1 to $s7
			j compute_setup						# jump to setup
			
		compute_setup:
		addi $s5, $s5, 1					# add 1 to stack of ordered numbers
		srl $s6, $s6, 1						# $s7 = $s7 / 2
		j compute_scenario_loop					# jump to top of loop
	end_compute_scenario_loop:
	
	# Second loop is the problem
	li $t0, 1							# $t0 = 1, amount multiplied to price each iteration
	li $t1, 0							# $t1 = 0, counter for loop
	li $t2, 0							# $t2 = total sum
	move $t3, $s4							# $t3 = ordered stack
	compute_scenario_revenue_loop:
		beq $t1, $s1, end_compute_scenario_revenue_loop		# counter = num sales, end loop
		move $t4, $s0						# $t4 = sales list
		lbu $t5, 0($t3)						# $t4 = current byte of ordered stack
		li $t6, 28						# $t6 = 28
		mul $t6, $t5, $t6					# $t6 = $t5 * 28 
		addi $t6, $t6, 24					# add 24 to get sale price
		add $t4, $t4, $t6					# add $t6 to sales list
		lw $t7, 0($t4)						# $t7 = current sales price from sales list
		mul $t8, $t7, $t0					# $t8 = sales price * $t0
		add $t2, $t2, $t8					# add $t8 to total sum
		
		addi $t0, $t0, 1					# add 1 to amount nultiplied to price
		addi $t1, $t1, 1					# add 1 to counter for the loop
		addi $t3, $t3, 1					# add 1 to the stack
		j compute_scenario_revenue_loop				# jump to top of loop
	end_compute_scenario_revenue_loop:
	
	move $v0, $t2					# $v0 = total sum
	
	compute_scenario_load:
	add $sp, $sp, $s1				# deallocate num sales bytes on stack
	add $sp, $sp, $s1				# deallocate num sales bytes on stack
    	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	lw $s3, 12($sp)					# load $s3
	lw $s4, 16($sp)					# load $s4
	lw $s5, 20($sp)					# load $s5
	lw $s6, 24($sp)					# load $s6
	lw $s7, 28($sp)					# load $s7
	lw $ra, 32($sp)					# load $ra
	addi $sp, $sp, 36				# allocate 36 bytes of space
    	jr $ra						# return to main address
    	
maximize_revenue:
	addi $sp, $sp, -24				# allocate 24 bytes of space
	sw $s0, 0($sp)					# store $s0
	sw $s1, 4($sp)					# store $s1
	sw $s2, 8($sp)					# store $s2
	sw $s3, 12($sp)					# store $s3
	sw $s4, 16($sp)					# store $s4
	sw $ra, 20($sp)					# store $ra
	move $s0, $a0					# $s0 = sales list
	move $s1, $a1					# $s1 = num sales
	li $s2, 0					# $s2 = 0, counter for loop/bitstring
	li $t0, 1					# $t0 = 1 
	sllv $s3, $t0, $s1				# shift left num sales spots
	li $s4, 0					# $s4 = maximum revenue
	
	maximize_loop:
		beq $s2, $s3, end_maximize_loop		# counter = $s3, end loop
		move $a0, $s0				# $a0 = sales list
		move $a1, $s1				# $a1 = num sales
		move $a2, $s2				# $a2 = bitstring
		jal compute_scenario_revenue		# jump and link compute_scenario_revenue
		addi $s2, $s2, 1			# add 1 to counter/bitstring
		ble $v0, $s4, maximize_loop		# jump to top of loop
		move $s4, $v0				# $s4 = $v0
		j maximize_loop				# jump to top of loop
	end_maximize_loop:
	move $v0, $s4					# $v0 = $s4
	
    	lw $s0, 0($sp)					# load $s0
	lw $s1, 4($sp)					# load $s1
	lw $s2, 8($sp)					# load $s2
	lw $s3, 12($sp)					# load $s3
	lw $s4, 16($sp)					# load $s4
	lw $ra, 20($sp)					# load $ra
	addi $sp, $sp, 24				# allocate 24 bytes of space
    	jr $ra						# return to main address

############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
############################ DO NOT CREATE A .data SECTION ############################
