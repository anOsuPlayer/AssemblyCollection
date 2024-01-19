// implementation of a simple bubble-sort over a 5 elements array, read from keyboard.

.section .rodata
S0: .string "%d"
P0: .string "insert number: "

P1: .string "%d\n"

.section .data
arr: .zero 20

.section .text
.globl sort
sort:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movl $0, -4(%rbp)
    L1:
        movl $0, -8(%rbp)
        L2:
        movl -8(%rbp), %edx
        movl (%rcx, %rdx, 4), %r14d
        incl %edx
        movl (%rcx, %rdx, 4), %r15d

        cmpl %r15d, %r14d
        jle L3
        movl %r14d, (%rcx, %rdx, 4)
        decl %edx
        movl %r15d, (%rcx, %rdx, 4)

        L3:
        incl -8(%rbp)
        movl $4, %eax
        subl -4(%rbp), %eax
        cmpl %eax, -8(%rbp)
        jl L2
    incl -4(%rbp)
    cmpl $5, -4(%rbp)
    jl L1

    movq $0, %rax
    addq $32, %rsp
    popq %rbp
    ret

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    leaq arr(%rip), %rdi
    movl $0, %ebx

    L0:
        leaq P0(%rip), %rcx
        call printf
        leaq S0(%rip), %rcx
        leaq (%rdi, %rbx, 4), %rdx
        call scanf
        incl %ebx
        cmpl $5, %ebx
        jnz L0

    movq %rdi, %rcx
    call sort

    movq $0, %rbx
    L4:
        leaq P1(%rip), %rcx
        movq (%rdi, %rbx, 4), %rdx
        call printf
        incl %ebx
        cmpl $5, %ebx
        jnz L4

    addq $32, %rsp
    popq %rbp
    ret
