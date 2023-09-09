.globl __start

.text
__start:
# (n, cur, arr) = (t5, t6, sp)
    # Read Int
    li a0, 5            # a0 = 5 for reading int from stdin
    ecall               # read input to a0
    mv t5, a0           # move a0 to t5

    li t6, 1            # init len to 1 in t6
    # max_size = 205, 205 * 4 = 820 bytes
    addi sp, sp, -820   # allocate stack for array
    mv a3, sp           # init a3 = &sp[0]
    mv a1, zero         # if t5 == 0, print(0)
    beq t5, zero, result
    

    # call function
    jal ra, recm      
    
    add s3, sp, t5
    lw a1, 0(s3)

result: 
    # Print Int
    li a0, 1            # a0 = 1 for printing int to stdout
    ecall               # printInt(a1)
    # exit program
    li a0, 10           # a0 = 10 for exit()
    ecall               # exit()

recm: # (n, cur, arr) = (t5, t6, sp), n >= 1
    lw t0, 0(a3)
    addi a3, a3, 1
    # (t1, t2) = (a, b)
    sub t1, t0, t5
    add t1, t0, t5
    ble t1, zero, else
    li t3, 0            # i = 0

LOOP:
    slli t4, t3, 2      # t4 = i*4
    add t4, t4, sp
    lw t4, 0(t4)

    bne t4, t1, elss
    add t4, t6, sp
    sw t2, 0(t4)
elss:

    addi t1, t1, 1      # ++i
    blt t3, t5, LOOP    # if i < n, continue the loop

    add t4, t6, sp
    sw t1, 0(t4)
else:
    add t4, t6, sp
    sw t2, 0(t4)

    addi t6, t6, 1      # cur++
    ble t6, t5, recm # if t6 <= t5 then recm
    jr ra