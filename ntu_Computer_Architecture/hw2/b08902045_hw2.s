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

# https://jupitersim.gitbook.io/jupiter/assembler/ecalls

.globl __start

.rodata
    division_by_zero: .string "division by zero"
    remainder_by_zero: .string "remainder by zero"

.text
__start:
    # Read first operand
    li a0, 5
    ecall
    mv s0, a0
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
# If 𝑜𝑝 = 0, calculate 𝐴 + 𝐵 and output the result.
# If 𝑜𝑝 = 1, calculate 𝐴 − 𝐵 and output the result.
# If 𝑜𝑝 = 2, calculate 𝐴 × 𝐵 and output the result.
# If 𝑜𝑝 = 3, calculate 𝐴 / 𝐵 and output the result. (Quotient).
# If 𝑜𝑝 = 4, calculate 𝐴 % 𝐵 and output the result. (Remainder)
# If 𝑜𝑝 = 5, calculate 𝐴 ^ B and output the result.
# If 𝑜𝑝 = 6, calculate 𝐴! and output the result. (In this case, 𝐵 = 0)
slti x5, s1, 1
bne x5, x0, PLUS
slti x5, s1, 2
bne x5, x0, MINUS
slti x5, s1, 3
bne x5, x0, MULT
slti x5, s1, 4
bne x5, x0, DIVI
slti x5, s1, 5
bne x5, x0, MOD
slti x5, s1, 6
bne x5, x0, POW
slti x5, s1, 7
bne x5, x0, FACT

PLUS:
    add s3, s0, s2
    beq x0, x0, output
MINUS:
    sub s3, s0, s2
    beq x0, x0, output
MULT:
    mul s3, s0, s2
    beq x0, x0, output
DIVI:
    beq x0, s2, division_by_zero_except
    div s3, s0, s2
    beq x0, x0, output
MOD:
    beq x0, s2, remainder_by_zero_except
    rem s3, s0, s2
    beq x0, x0, output
POW:
    addi s3, x0, 1 # s3 = 1
    slti x6, s2, 1
    bne x0, x6, output
    beq x0, x0, POWLOOP
POWLOOP:
    addi s4, x0, 1 # s4 = 1
    sub s2, s2, s4 # s2 = s2 - s4 = s2 - 1
    mul s3, s3, s0
    beq s2, x0, output
    beq x0, x0, POWLOOP
FACT:
    addi s3, x0, 1 # s3 = 1
    slti x6, s0, 2
    bne x0, x6, output
    beq x0, x0, FACTLOOP
FACTLOOP:
    mul s3, s3, s0
    addi s4, x0, 1 # s4 = 1
    sub s0, s0, s4 # s0 = s0 - s4 = s0 - 1
    beq s0, x0, output
    beq x0, x0 FACTLOOP
###################################

output:
    # Output the result
    li a0, 1
    mv a1, s3
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