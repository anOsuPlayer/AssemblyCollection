.section .rodata
S0: .string "%d"
P0: .string "insert number: "

.section .data
arr: .zero 20

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
    movq %rsp, %rbp
    subq $32, %rsp

    leaq arr(%rip), %rdi
    movl $5, -4(%rbp)
    movl $0, %ebx

    L0:
        leaq P0(%rip), %rcx
        call printf
        leaq S0(%rip), %rcx
        leaq (%rdi, %rbx, 4), %rdx
        call scanf
        incl %ebx
        cmpl -4(%rbp), %ebx
        jnz L0

    addq $32, %rsp
    popq %rbp
    ret
