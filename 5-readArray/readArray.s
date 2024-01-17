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
    movq %rbp, %rdi
    subl %eax, %edi

    subl -8(%rbp), %esp

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

    addl -8(%rbp), %esp

    addq $32, %rsp
    popq %rbp
    ret
