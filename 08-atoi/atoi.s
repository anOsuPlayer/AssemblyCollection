// source: https://leetcode.com/problems/string-to-integer-atoi/
// converts a string of characters into a 32-bit integer.

.section .rodata
P0: .string "input string: "
P1: .string "output number: %d"
R0: .string "%s"
D0: .string "%d"

MAX: .long 0x7fffffff
MIN: .long 0xffffffff

YADD: .long 1
NADD: .long 0

WRITE: .long 1
CRIT: .long -1

.section .data
N: .quad 0
buf: .zero 100
.align 16
dig: .zero 20

.section .text
.globl isValid
isValid:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    cmpb $0, %dl
    jnz V0
        cmpb $32, %cl
        cmovzl NADD(%rip), %eax
        jz VR
        cmpb $43, %cl
        cmovzl WRITE(%rip), %edx
        cmovzl YADD(%rip), %eax
        jz VR
        cmpb $45, %cl
        cmovzl WRITE(%rip), %edx
        cmovzl YADD(%rip), %eax
        jz VR
        cmpb $48, %cl
        cmovll CRIT(%rip), %edx
        cmovll NADD(%rip), %eax
        jl VR
        cmpb $57, %cl
        cmovgl CRIT(%rip), %edx
        cmovgl NADD(%rip), %eax
        jg VR

        movl YADD(%rip), %eax
        jmp VR
    V0:
        cmpb $48, %cl
        cmovll CRIT(%rip), %edx
        cmovll NADD(%rip), %eax
        jl VR
        cmpb $57, %cl
        cmovgl CRIT(%rip), %edx
        cmovgl NADD(%rip), %eax
        jg VR

        movl YADD(%rip), %eax

    VR:
    addq $48, %rsp
    popq %rbp
    ret

.globl myAtoi
myAtoi:
    pushq %rbp
    movq %rsp, %rbp
    subq $72, %rsp

    movq %rcx, %rsi
    leaq dig(%rip), %rdi
    movl $0, -4(%rbp)
    movl $0, -8(%rbp)
    movb $0, %dl
    L0:
        movl -4(%rbp), %ecx
        movb (%rsi, %rcx, 1), %al

        pushq %rax
        movb %al, %cl
        call isValid

        cmpl $1, %eax
        jnz L1
        movl -8(%rbp), %ecx
        popq %rax
        movb %al, (%rdi, %rcx, 1)
        incl -8(%rbp)
        jmp L2
        L1:
        popq %rax
        L2:

        cmpb $-1, %dl
        jz LE

        incl -4(%rbp)
        cmpb $0, %al
        jnz L0

    LE:

    movq $1, %r10
    movq $10, %r11
    movq $0, -16(%rbp)
    L3:
        decl -8(%rbp)
        movl -8(%rbp), %ecx

        movsxb (%rdi, %rcx, 1), %rax
        cmpq $43, %rax
        jz L3E
        cmpq $45, %rax
        jnz L4
        movq -16(%rbp), %rax
        movq $-1, %rbx
        mulq %rbx
        movq %rax, -16(%rbp)
        jmp L3E
        L4:

        subq $48, %rax
        mulq %r10
        addq %rax, -16(%rbp)

        movq %r10, %rax
        mulq %r11
        movq %rax, %r10

        cmpl $0, -8(%rbp)
        jg L3
    L3E:

    movq -16(%rbp), %rax

    MR:
    addq $72, %rsp
    popq %rbp
    ret

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    leaq P0(%rip), %rcx
    call printf
    leaq R0(%rip), %rcx
    leaq buf(%rip), %rdx
    call scanf

    leaq buf(%rip), %rcx
    call myAtoi
    movq %rax, N(%rip)

    leaq P1(%rip), %rcx
    movq N(%rip), %rdx
    call printf

    addq $48, %rsp
    popq %rbp
    ret
