// source: https://edabit.com/challenge/w9tSqwcePxAQrE8ZT

.section .rodata
s0: .string "perfect"
s1: .string "neither"

s2: .string "insert number: "

r0: .string "%d"
r1: .string "%d\n"

.section .data
divc: .long 0

.section .text
.globl divisors
divisors:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp

    movl %ecx, -4(%rbp)
    movq $0, %rcx
    call malloc
    movq %rax, -12(%rbp)

    movl $1, -16(%rbp)
    D0:
        movl -4(%rbp), %eax
        xorq %rdx, %rdx
        idivl -16(%rbp)

        cmpq $0, %rdx
        jnz D1

        movq r1(%rip), %rcx


        movq -12(%rbp), %rcx
        incl divc(%rip)
        movl divc(%rip), %eax
        movq $4, %rbx
        mulq %rbx
        movl %eax, %edx
        call realloc
        movq %rax, -12(%rbp)

        movl divc(%rip), %eax
        subl $1, %eax
        mull %ebx
        movl %eax, %ecx
        movq -12(%rbp), %rax
        addq %rcx, %rax
        movl -16(%rbp), %ecx
        movl %ecx, (%rax)

        D1:
        incl -16(%rbp)
        movl -4(%rbp), %ecx
        cmpl %ecx, -16(%rbp)
        jl D0

    movq -12(%rbp), %rax
    addq $64, %rsp
    popq %rbp
    ret

.globl isAdmirable
isAdmirable:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp

    movl %ecx, -4(%rbp)
    movq %rdx, -12(%rbp)
    movq %r8, -20(%rbp)

    movq $-1, %rax
    addq $64, %rsp
    popq %rbp
    ret

.globl isPefect
isPefect:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp

    movl %ecx, -4(%rbp)
    call divisors
    movq %rax, -12(%rbp)
    movq -12(%rbp), %rbx
    xorq %rax, %rax

    movl $0, -16(%rbp)
    movq $0, -24(%rbp)
    P0:
        movl (%rbx), %eax
        addq %rax, -24(%rbp)
        addq $4, %rbx

        incl -16(%rbp)
        movl -16(%rbp), %ecx
        cmpl %ecx, divc(%rip)
        jg P0

    movzx -4(%rbp), %rax
    cmpq %rax, -24(%rbp)
    jne P1

    movq $0, %rax
    jmp PE

    P1:
    movl -4(%rbp), %ecx
    movq -12(%rbp), %rdx
    movq -24(%rbp), %r8
    call isAdmirable

    PE:
    movq -12(%rbp), %rcx
    call free

    addq $64, %rsp
    popq %rbp
    ret

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    leaq s2(%rip), %rcx
    call printf
    leaq r0(%rip), %rcx
    leaq -4(%rbp), %rdx
    call scanf

    movl -4(%rbp), %ecx
    call isPefect
    cmpq $0, %rax
    jnz L1

    leaq s0(%rip), %rcx
    call printf

    jmp LE
    
    L1:
    cmpq $-1, %rax
    jz L2

    leaq r0(%rip), %rcx
    movq %rax, %rdx
    call printf

    jmp LE

    L2:
    leaq s1(%rip), %rcx
    call printf

    LE:
    addq $48, %rsp
    popq %rbp
    ret
