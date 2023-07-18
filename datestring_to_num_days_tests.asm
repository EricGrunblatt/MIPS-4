.data
start_date: .asciiz "2020-10-12"
end_date: .asciiz "2020-10-25"

.data
start_date: .asciiz "2020-10-25"
end_date: .asciiz "2020-10-12"

.data
start_date: .asciiz "2019-10-25"
end_date: .asciiz "2020-10-25"

.data
start_date: .asciiz "1692-11-28"
end_date: .asciiz "2602-09-13"

.data
start_date: .asciiz "2019-01-08"
end_date: .asciiz "8410-09-08"

.data
start_date: .asciiz "3156-05-08"
end_date: .asciiz "3156-05-08"




		li $t1, 12					# $t1 = 12
		sub $t0, $t1, $s3				# 12 - start month ($s6)
		li $t1, 10					# $t1 = 10
		div $t0, $t1					# $t0 = $t0 / 10
		mflo $t0					# $t0 = quotient
		sub $t0, $s2, $t0				# $t0 = $s2 - $t0 ($s5)
	
		addi $t1, $s3, -3				# $t1 = $s3 - 3 ($s6)
		li $t2, 12					# $t2 = 12
		div $t1, $t2					# $t1 / 12
		mfhi $t1					# $t1 = remainder
		
		addi $t3, $t0, 4712				# $t3 = $t0 + 4712
		li $t4, 365					# $t4 = 365
		mul $t2, $t3, $t4				# $t2 = $t3 * 365
		li $t4, 4					# $t4 = 4
		div $t3, $t4					# $t3 / 4
		mflo $t3					# $t3 = quotient
		add $t2, $t2, $t3				# $t2 = $t2 + $t3
		
		li $t3, 0					# $t3 = 0
		li $t5, 6					# $t5 = 6
		mul $t4, $t1, $t5				# $t4 = $t1 * 6
		li $t5, 10					# $t5 = 10
		div $t4, $t5					# $t4 = $t4 / 10
		mflo $t4					# $t4 = quotient
		li $t6, 30					# $t6 = 30
		mul $t5, $t1 $t6				# $t5 = $t1 * 30
		add $t4, $t4, $t5				# $t4 = $t4 + $t5
		
		add $s0, $t2, $t4				# $s0 = $t2 + $t4 ($s1)
		add $s0, $s0, $s4				# $s0 = $s0 + $s4 ($s1, $s7)
		
		# Julian day number for end date
		li $t1, 12					# $t1 = 12
		sub $t0, $t1, $s6				# 12 - start month ($s6)
		li $t1, 10					# $t1 = 10
		div $t0, $t1					# $t0 = $t0 / 10
		mflo $t0					# $t0 = quotient
		sub $t0, $s5, $t0				# $t0 = $s2 - $t0 ($s5)
		
		addi $t1, $s6, -3				# $t1 = $s3 - 3 ($s6)
		li $t2, 12					# $t2 = 12
		div $t1, $t2					# $t1 / 12
		mfhi $t1					# $t1 = remainder
		
		addi $t3, $t0, 4712				# $t3 = $t0 + 4712
		li $t4, 365					# $t4 = 365
		mul $t2, $t3, $t4				# $t2 = $t3 * 365 
		li $t4, 4					# $t4 = 4
		div $t3, $t4					# $t3 / 4
		mflo $t3					# $t3 = quotient
		add $t2, $t2, $t3				# $t2 = $t2 + $t3
		
		li $t3, 0					# $t3 = 0
		li $t5, 6					# $t5 = 6
		mul $t4, $t1, $t5				# $t4 = $t1 * 6
		li $t5, 10					# $t5 = 10
		div $t4, $t5					# $t4 = $t4 / 10
		mflo $t4					# $t4 = quotient
		li $t6, 30					# $t6 = 30
		mul $t5, $t1 $t6				# $t5 = $t1 * 30
		add $t4, $t4, $t5				# $t4 = $t4 + $t5
		
		add $s1, $t2, $t4				# $s1 = $t2 + $t4 ($s1)
		add $s1, $s1, $s7				# $s1 = $s1 + $s7 ($s1, $s7)
		
		sub $v0, $s1, $s0				# $s6 = $s1 - $s0
		
		


























		li $t0, 14				# $t0 = 14
		sub $t1, $t0, $s3			# $t1 = 14 - month ($s6)
		li $t0, 12				# $t0 = 12
		div $t1, $t0				# (14 - month)/12
		mflo $t0				# $t0 = a, quotient
		
		li $t1, 4800				# $t1 = 4800
		add $t1, $t1, $s2			# $t1 = 4800 + year ($s5)
		sub $t1, $t1, $t0			# $t1 = y, 4800 + year - $t0
		
		li $t2, 12				# $t2 = 12
		mul $t2, $t2, $t0			# $t2 = $t0 * 12
		addi $t2, $t2, -3			# $t2 = ($t0 * 12) - 3 
		add $t2, $t2, $s3			# $t2 = m, ($t0 * 12) - 3 + month ($s6)
		
		li $t3, 153				# $t3 = 153
		mul $t3, $t3, $s3			# $t3 = 153 * month ($s6)
		addi $t3, $t3, 2			# $t3 = (153 * month) + 2
		li $t4, 5				# $t4 = 5
		div $t3, $t4				# $t3 = ((153 * month) + 2)/5
		mflo $t3				# $t3 = quotient
		
		li $t4, 365				# $t4 = 365
		mul $t4, $t4, $t1			# $t4 = 365 * $t1
		
		li $t5, 4				# $t5 = 4
		div $t1, $t5				# $t5 = $t1 / 4
		mflo $t5				# $t5 = quotient
		
		li $t6, 100				# $t6 = 100
		div $t1, $t6				# $t6 = $t1 / 100
		mflo $t6				# $t6 = quotient
		
		li $t7, 400				# $t7 = 400
		div $t1, $t7				# $t5 = $t1 / 400
		mflo $t7				# $t7 = quotient
		
		add $s0, $s4, $t3			# $s0 = $s4 + $t3 ($s1, $s7)
		add $s0, $s0, $t4			# $s0 = $s0 + $t4 ($s1)
		add $s0, $s0, $t5			# $s0 = $s0 + $t5 ($s1)
		sub $s0, $s0, $t6			# $s0 = $s0 - $t6 ($s1)
		add $s0, $s0, $t7			# $s0 = $s0 + $t7 ($s1)
		addi $s0, $s0, -32045			# $s0 = $s0 - 32045 ($s1)
		
		
		# Julian day number for end date
		julian_day_end_number:
		li $t0, 14				# $t0 = 14
		sub $t1, $t0, $s6			# $t1 = 14 - month ($s6)
		li $t0, 12				# $t0 = 12
		div $t1, $t0				# (14 - month)/12
		mflo $t0				# $t0 = a, quotient
		
		li $t1, 4800				# $t1 = 4800
		add $t1, $t1, $s5			# $t1 = 4800 + year ($s5)
		sub $t1, $t1, $t0			# $t1 = y, 4800 + year - $t0
		
		li $t2, 12				# $t2 = 12
		mul $t2, $t2, $t0			# $t2 = $t0 * 12
		addi $t2, $t2, -3			# $t2 = ($t0 * 12) - 3 
		add $t2, $t2, $s6			# $t2 = m, ($t0 * 12) - 3 + month ($s6)
		
		li $t3, 153				# $t3 = 153
		mul $t3, $t3, $s6			# $t3 = 153 * month ($s6)
		addi $t3, $t3, 2			# $t3 = (153 * month) + 2
		li $t4, 5				# $t4 = 5
		div $t3, $t4				# $t3 = ((153 * month) + 2)/5
		mflo $t3				# $t3 = quotient
		
		li $t4, 365				# $t4 = 365
		mul $t4, $t4, $t1			# $t4 = 365 * $t1
		
		li $t5, 4				# $t5 = 4
		div $t1, $t5				# $t5 = $t1 / 4
		mflo $t5				# $t5 = quotient
		
		li $t6, 100				# $t6 = 100
		div $t1, $t6				# $t6 = $t1 / 100
		mflo $t6				# $t6 = quotient
		
		li $t7, 400				# $t7 = 400
		div $t1, $t7				# $t5 = $t1 / 400
		mflo $t7				# $t7 = quotient
		
		add $s1, $s7, $t3			# $s0 = $s4 + $t3 ($s1, $s7)
		add $s1, $s1, $t4			# $s0 = $s0 + $t4 ($s1)
		add $s1, $s1, $t5			# $s0 = $s0 + $t5 ($s1)
		sub $s1, $s1, $t6			# $s0 = $s0 - $t6 ($s1)
		add $s1, $s1, $t7			# $s0 = $s0 + $t7 ($s1)
		addi $s1, $s1, -32045			# $s0 = $s0 - 32045 ($s1)
		
		sub $v0, $s1, $s0









