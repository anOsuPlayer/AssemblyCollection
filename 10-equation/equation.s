// solves a standard second degree equation

.section .rodata
p: .string "ax^2 + bx + c = 0\n"
n1: .string "insert 'a': "
n2: .string "insert 'b': "
n3: .string "insert 'c': "

res: .string "results: %lf, %lf"
res2: .string "result: %lf"
res3: .string "no solutions"

r0: .string "%lf"

.align 8
m: .double 2.0
f1: .double 4.0
retCode: .double -1.0
zero: .double 0

.section .text
.globl compute
compute:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    // square "b"
    movsd %xmm2, %xmm0
    mulsd %xmm0, %xmm0
    movsd %xmm0, -8(%rbp)
    
    // subtract "4*a*b"
    movsd f1(%rip), %xmm0
    mulsd %xmm1, %xmm0
    mulsd %xmm3, %xmm0
    movsd -8(%rbp), %xmm3
    subsd %xmm0, %xmm3
    movsd %xmm3, -8(%rbp)

    // check for negative result
    ucomisd zero(%rip), %xmm3
    jle C1
        movq retCode(%rip), %xmm3
        jmp CE
    C1:

    // handling both -b and +b solutions
    movsd %xmm3, -16(%rbp)

    movsd zero(%rip), %xmm3
    CE:
    addq $48, %rsp
    popq %rbp
    ret

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp

    leaq p(%rip), %rcx
    call printf

    leaq n1(%rip), %rcx
    call printf
    leaq r0(%rip), %rcx
    leaq -8(%rbp), %rdx
    call scanf
    leaq n2(%rip), %rcx
    call printf
    leaq r0(%rip), %rcx
    leaq -16(%rbp), %rdx
    call scanf
    leaq n3(%rip), %rcx
    call printf
    leaq r0(%rip), %rcx
    leaq -24(%rbp), %rdx
    call scanf

    movsd -8(%rbp), %xmm1
    movsd -16(%rbp), %xmm2
    movsd -24(%rbp), %xmm3
    call compute

    ucomisd retCode(%rip), %xmm3
    jne L1
        leaq res3(%rip), %rcx
        call printf
        jmp LE
    L1:
    ucomisd %xmm1, %xmm2
    jne L0
        leaq res2(%rip), %rcx
        movq %xmm1, %rdx
        call printf
    jmp LE
    L0:
        leaq res(%rip), %rcx
        movq %xmm1, %rdx
        movq %xmm2, %r8
        call printf
    LE:

    addq $64, %rsp
    popq %rbp
    ret