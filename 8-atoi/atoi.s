// source: https://leetcode.com/problems/string-to-integer-atoi/
// target: convert a string of characters into a 32-bit integer.

.section .rodata
P0: .string "input string: "
P1: .string "output number: %d"
R0: .string "%s"
D0: .string "%c"

.section .data
N: .quad 0
buf: .zero 100

.section .text
.globl myAtoi
myAtoi:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movq %rcx, %rsi
    movl $0, %ecx
    L0:
        cmpb $0, (%rsi, %rcx, 1)
        incl %ecx
        jnz L0

    addq $32, %rsp
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

    leaq P1(%rip), %rcx
    movq N(%rip), %rdx
    call printf

    addq $48, %rsp
    popq %rbp
    ret
