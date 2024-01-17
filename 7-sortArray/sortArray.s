.section .rodata
D0: .string "%d"

.section .text
.globl sort
sort:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    addq $32, %rsp
    popq %rbp
    ret

.globl main
main:
    pushq %rbp
    movq %rbp, %rsp
    subq $32, %rsp

    leaq D0(%rip), %rcx
    movl array(%rip), %edx
    call printf

    addq $32, %rsp
    popq %rbp
    ret
