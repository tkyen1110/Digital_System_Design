# RISC-V Assembly Programmer's Manual
# https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.md

# System Calls
# https://www.doc.ic.ac.uk/lab/secondyear/spim/node8.html
# Service	        System Call Code	Arguments	Result
# print_int                 1
# print_float               2
# print_double              3
# print_string              4
# read_int                  5
# read_float	            6
# read_double	            7
# read_string	            8
# sbrk                      9
# exit                      10
# print_character	        11
# read_character	        12
# open	                    13
# read	                    14
# write	                    15
# close	                    16
# exit2	                    17

.globl __start

.rodata
    division_by_zero: .string "division by zero"
    remainder_by_zero: .string "remainder by zero"
    JumpTable: .word plus, minus, mult, divd, mod, pow, frac

.text
__start:
    # Read first operand
    li a0, 5    # li rd, immediate, 5 is represented the system call service code to read
    ecall       # set the kernal mode back to 0
    mv s0, a0   # addi rd, rs, 0
    # Read operation
    li a0, 5
    ecall
    mv s1, a0
    # Read second operand
    li a0, 5
    ecall
    mv s2, a0

###################################
#  TODO: Develop your calculator  #
#                                 #
###################################

#s0:first, s1:operator, s2:second

# check operator and goto
la s4, JumpTable    # s4 == jumptable[0]
slli s5, s1, 2      # s5 == s1 << 2, s1 == operator
add s6, s5, s4      # s6 == jumptable + s1 * 4
lw s7, 0(s6)
jr s7

# let s11 be the answer
plus:
    add s11, s0, s2
    jal x1, output

minus:
    sub s11, s0, s2
    jal x1, output

mult:
    mul s11, s0, s2
    jal x1, output

divd:
    beq s2, x0, division_by_zero_except
    div s11, s0, s2
    jal x1, output

mod:
    beq s2, x0, remainder_by_zero_except
    div s11, s0, s2     # s11 = s0 / s2
    mul s4, s11, s2     # s4 = s2 * s11
    sub s11, s0, s4    # s11 = s0 - s4
    jal x1, output

pow:
    addi s11, x0, 1
    bne s2, x0, pow_loop    # if x0 != 0, goto pow_loop
    jal x0, output          
pow_loop:
    addi s3, x0, 1      # s2 = s2-1
    sub s2, s2, s3
    mul s11, s11, s0
    beq s2, x0, output
    jal x0, pow_loop

frac:
    mv s11, s0
    bne s0, x0, frac_loop   # if s0 != 0, then goto frac_loop
    addi s11, x0, 1         # else s11 = 1, then goto output
    jal x0, output
    
frac_loop:
    addi s3, x0, 1      # s3 = 1
    sub s0, s0, s3      # s0 = s0-1

    beq s0, x0, output
    mul s11, s11, s0    
    jal x0, frac_loop


output:
    # Output the result
    li a0, 1        # a0: Function arguments
    mv a1, s11      # a1: return values  
    ecall

exit:
    # Exit program(necessary)
    li a0, 10
    ecall

division_by_zero_except:
    li a0, 4
    la a1, division_by_zero
    ecall
    jal zero, exit

remainder_by_zero_except:
    li a0, 4
    la a1, remainder_by_zero
    ecall
    jal zero, exit


