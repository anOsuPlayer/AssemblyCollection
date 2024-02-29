// simple integral signed division (idivq), displaying both the quotient and the remainder.

.section .data
.P0: .string "%d : %d\n"

.section .text
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $96, %rsp

    movq $12, %rax
    movq $5, %rbx
    xorq %rdx, %rdx
    idivq %rbx

    leaq .P0(%rip), %rcx
    movq %rdx, %rbx
    movq %rax, %rdx
    movq %rbx, %r8
    call printf

    popq %rbp
    addq $96, %rsp
    ret
