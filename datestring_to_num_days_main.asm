.data
start_date: .asciiz "1600-01-01"
end_date: .asciiz "2025-01-08"

.text
.globl main
main:
la $a0, start_date
la $a1, end_date
jal datestring_to_num_days

# Write code to check the correctness of your code!
li $v0, 10
syscall

.include "hwk4.asm"

