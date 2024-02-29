// asks for an array length, allocates it on the stack and reads all of its content.

.section .data
S0: .string "%d"

D0: .string "%d\n"

P0: .string "input array length: "
P1: .string "input number: "

.section .text
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    leaq P0(%rip), %rcx
    call printf
    leaq S0(%rip), %rcx
    leaq -4(%rbp), %rdx
    call scanf

    movl -4(%rbp), %eax
    movl $4, %ebx
    mull %ebx
    movq %rbp, %rsi
    addl $8, %eax
    movl %eax, -8(%rbp)
    cltq
    movq %rbp, %rdi
    subq %rax, %rdi

    movl -8(%rbp), %eax
    cltq
    subq %rax, %rsp

    movl $0, %ebx
    L0:
        leaq P1(%rip), %rcx
        call printf
        leaq S0(%rip), %rcx
        leaq (%rdi, %rbx, 4), %rdx
        call scanf
        incl %ebx
        cmpl %ebx, -4(%rbp)
        jnz L0

    movl -8(%rbp), %eax
    cltq
    addq %rax, %rsp

    movq $0, %rax
    addq $32, %rsp
    popq %rbp
    ret
