// solves a standard second degree equation

.section .rodata
p: .string "ax^2 + bx + c = 0\n"
n1: .string "insert 'a': "
n2: .string "insert 'b': "
n3: .string "insert 'c': "

res: .string "results: %lf, %lf"
res2: .string "result: %lf"

r0: .string "%lf"

.section .text
.globl compute
compute:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp



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
    leaq n2(%rip), %rcx
    call printf
    leaq r0(%rip), %rcx
    leaq -24(%rbp), %rdx
    call scanf

    movsd -8(%rbp), %xmm1
    movsd -16(%rbp), %xmm2
    movsd -24(%rbp), %xmm3
    call compute

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