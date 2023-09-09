.globl __start

.text
__start:
    # Read Int
    li a0, 5      # a0 = 5 for reading int from stdin
    ecall         # read input to a0
    mv s0, a0     # store input to s0
    jal ra, fib   # fib(a0)
    # Print Int
    li a0, 1      # a0 = 1 for printing int to stdout
    ecall         # printInt(a1)
    # exit program
    li a0, 10     # a0 = 10 for exit()
    ecall         # exit()

fib: # a0 = n (argument), a1(return value)
    beq a0, zero, fib0
    li t0, 1
    beq a0, t0, fib1
    
    addi sp, sp, -12 # store 3 registers s0, s1, ra to stack
    sw s0, 0(sp)     # store s0 to stack
    sw s1, 4(sp)     # store s1 to stack
    sw ra, 8(sp)     # store ra to stack
    mv s0, a0        # s0 is callee saved
    addi a0, s0, -1  # a0 = s0 - 1
    jal ra, fib      # pass n-1 to fib
    mv s1, a1        # store fib(n-1) to s1
    addi a0, s0, -2  # a0 = s0 - 2
    jal ra, fib      # pass n-2 to fib
    add a1, a1, s1   # a1 = fib(n-2), s1 = fib(n-1)
    lw ra, 8(sp)     # restore ra from stack
    lw s1, 4(sp)     # restore s1 from stack
    lw s0, 0(sp)     # restore s0 from stack
    addi sp, sp, 12  # restore stack
    jr ra

fib0:
    mv a1, zero
    jr ra

fib1:
    li t0, 1
    mv a1, t0
    jr ra