.globl __start

# t1 = a, t2 = b, a3 = &arr[0] (fixed)
# t3 = i (for loop), t5 = n, sp
# t6 = cur index, s11 = each ans
.text
__start:
    # Read Int
    li a0, 5            # a0 = 5 for reading int from stdin
    ecall               # read input to a0
    mv t5, a0           # move a0 to t5

    li t6, 1            # init cur to 1 in t6
    # max_size = 205, 205 * 4 = 820 bytes
    addi sp, sp, -820   # allocate stack for array
    mv a3, sp           # init a3 = &sp[0]
    beq t5, zero, res   # if t5 == 0, print(0)
    
    # call function
    jal ra, recm
res: 
    slli t0, t5, 2      # arr[n]
    add t0, t0, sp
    lw a1, 0(t0)        # put ans to a1
    # Print Int
    li a0, 1            # a0 = 1 for printing int to stdout
    ecall               # printInt(a1)
    # exit program
    li a0, 10           # a0 = 10 for exit()
    ecall               # exit()
recm: # (n, cur, arr) = (t5, t6, sp), n >= 1
    addi t0, t6, -1     # t0 = cur-1
    slli t0, t0, 2      # cur index*4
    add t0, t0, a3      # find the address of arr[cur-1]
    lw t0, 0(t0)        # t0 = arr[cur-1]
    # (t1, t2) = (a, b)
    sub t1, t0, t6      # t1 = a = t0-t6
    add t2, t0, t6      # t2 = b = t0+t6
    mv s11, t2          # ans = s11 = b
    ble t1, zero, ANS
    
    mv t3, zero         # i = t3 = 0
LOOP:
    slli t0, t3, 2
    add t0, t0, a3
    lw t0, 0(t0)        # t0 = arr[i]
    beq t0, t1, ANS

    addi t3, t3, 1      # i++
    blt t3, t6, LOOP     # if i < cur go to LOOP
    
    mv s11, t1          # ans = a
ANS:
    slli t0, t6, 2
    add t0, t0, a3
    sw s11, 0(t0)        # arr[cur] = ans

    addi t6, t6, 1       # cur++
    ble t6, t5, recm
    jr ra
