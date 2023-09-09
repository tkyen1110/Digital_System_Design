.globl __start

# t1 = a, t2 = b, a3 = &arr[0] (fixed)
# t3 = i (for loop), t5 = n, sp
# t6 = cur index, s11 = each ans

# a0 = n, a1 = seq, a2 = seq_len
# s1 = res
.text
__start:
    # Read Int
    li a0, 5            # a0 = 5 for reading int from stdin
    ecall               # read input to a0 (a0=n)

    # max_size = 205, 205 * 4 = 820 bytes
    addi sp, sp, -820   # allocate stack for array
    mv a1, sp           # a1 = seq = &sp[0]
    mv a2, zero         # a2 = seq_len = 0

    jal ra, recmaman    # recmaman(n=a0, seq=a1, seq_len=a2)

    # Print Int
    addi a2, a2, -1
    slli t0, a2, 2      # t0 = a2 * 4
    add t0, a1, t0      # t0 = a1 + t0
    lw a1, 0(t0)        # res = seq[*seq_len]
    li a0, 1            # a0 = 1 for printing int to stdout
    ecall               # printInt(a1)
    # exit program
    li a0, 10           # a0 = 10 for exit()
    ecall               # exit()

recmaman:
    bne a0, zero, recm
    mv s1, zero         # res = 0
    jal zero, add2seq
recm:
    addi sp, sp, -16    # store 4 registers a0, a1, a2, ra to stack
    sw a0, 0(sp)        # store a0 to stack
    # sw a1, 4(sp)        # store a1 to stack
    # sw a2, 8(sp)        # store a1 to stack
    sw ra, 12(sp)       # store ra to stack

    # mv s0, a0
    addi a0, a0, -1
    jal ra, recmaman    # recmaman(n=a0-1, seq=a1, seq_len=a2)
    mv t1, s1
    lw ra, 12(sp)       # restore ra from stack
    # lw a2, 8(sp)        # restore a2 from stack
    # lw a1, 4(sp)        # restore a1 from stack
    lw a0, 0(sp)        # restore a0 from stack
    addi sp, sp, 16     # restore stack

    sub t2, t1, a0      # a = t - n
    add t3, t1, a0      # b = t + n
    mv s1, t2           # res = a
    mv t4, zero         # int i = 0
    bgt t2, zero, loop
    mv s1, t3           # res = b
    jal zero, add2seq

loop:
    bge t4, a2, add2seq
    slli t0, t4, 2      # t0 = t4 * 4
    add t0, a1, t0      # t0 = a1 + t0
    lw t5, 0(t0)        # t5 = seq[*seq_len]
    addi t4, t4, 1      # t4 = t4 + 1
    bne t5, t2, loop
    mv s1, t3           # res = b
    jal zero, add2seq

add2seq:
    slli t0, a2, 2      # t0 = a2 * 4
    add t0, a1, t0      # t0 = a1 + t0
    sw s1, 0(t0)        # seq[*seq_len] = res
    addi a2, a2, 1
    jr ra



# return:
#     # Print Int
#     li a0, 1            # a0 = 1 for printing int to stdout
#     ecall               # printInt(a1)
#     # exit program
#     li a0, 10           # a0 = 10 for exit()
#     ecall               # exit()


# res: 
#     slli t0, t5, 2      # arr[n]
#     add t0, t0, sp
#     lw a1, 0(t0)        # put ans to a1
#     # Print Int
#     li a0, 1            # a0 = 1 for printing int to stdout
#     ecall               # printInt(a1)
#     # exit program
#     li a0, 10           # a0 = 10 for exit()
#     ecall               # exit()
# recm: # (n, cur, arr) = (t5, t6, sp), n >= 1
#     addi t0, t6, -1     # t0 = cur-1
#     slli t0, t0, 2      # cur index*4
#     add t0, t0, a3      # find the address of arr[cur-1]
#     lw t0, 0(t0)        # t0 = arr[cur-1]
#     # (t1, t2) = (a, b)
#     sub t1, t0, t6      # t1 = a = t0-t6
#     add t2, t0, t6      # t2 = b = t0+t6
#     mv s11, t2          # ans = s11 = b
#     ble t1, zero, ANS
    
#     mv t3, zero         # i = t3 = 0
# LOOP:
#     slli t0, t3, 2
#     add t0, t0, a3
#     lw t0, 0(t0)        # t0 = arr[i]
#     beq t0, t1, ANS

#     addi t3, t3, 1      # i++
#     blt t3, t6, LOOP     # if i < cur go to LOOP
    
#     mv s11, t1          # ans = a
# ANS:
#     slli t0, t6, 2
#     add t0, t0, a3
#     sw s11, 0(t0)        # arr[cur] = ans

#     addi t6, t6, 1       # cur++
#     ble t6, t5, recm
#     jr ra
