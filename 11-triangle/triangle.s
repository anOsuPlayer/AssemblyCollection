// prints on the console a triangle of arbitrary long base

.section .rodata
S0: .string "%d"
S1: .string "* "
S2: .string "  "
S3: .string "insert triangle base's length : "

.section .text
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    leaq S3(%rip), %rcx
    call printf
    leaq S0(%rip), %rcx
    leaq -4(%rbp), %rdx
    call scanf

    addq $48, %rsp
    popq %rbp
    ret
