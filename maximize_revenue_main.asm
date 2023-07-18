.data
num_sales: .word 11
.align 2
sales_list:
# BookSale struct start
.align 2
.ascii "5289996563210\0"
.byte 0 0
.word 50402
.word 1912
.word 114
# BookSale struct start
.align 2
.ascii "4878656880115\0"
.byte 0 0
.word 14181
.word 1025
.word 40
# BookSale struct start
.align 2
.ascii "1545953167947\0"
.byte 0 0
.word 74773
.word 1453
.word 419
# BookSale struct start
.align 2
.ascii "4163887205026\0"
.byte 0 0
.word 11881
.word 1088
.word 316
# BookSale struct start
.align 2
.ascii "3994954632401\0"
.byte 0 0
.word 25708
.word 1418
.word 346
# BookSale struct start
.align 2
.ascii "2840757350273\0"
.byte 0 0
.word 79850
.word 1501
.word 89
# BookSale struct start
.align 2
.ascii "2690573805693\0"
.byte 0 0
.word 75967
.word 1093
.word 147
# BookSale struct start
.align 2
.ascii "6412500793328\0"
.byte 0 0
.word 20379
.word 1997
.word 380
# BookSale struct start
.align 2
.ascii "1956670228687\0"
.byte 0 0
.word 95494
.word 1343
.word 275
# BookSale struct start
.align 2
.ascii "4719224196873\0"
.byte 0 0
.word 30863
.word 1956
.word 194
# BookSale struct start
.align 2
.ascii "1049903854879\0"
.byte 0 0
.word 40347
.word 1980
.word 281

.text
.globl main
main:
la $a0, sales_list
lw $a1, num_sales
jal maximize_revenue

# Write code to check the correctness of your code!
li $v0, 10
syscall

.include "hwk4.asm"
