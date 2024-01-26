// https://leetcode.com/problems/count-subarrays-with-score-less-than-k/description/
// find the number of sub-arrays of a given array N which score is less than a given number K

.section .rodata
R0: .string "%llu"
R1: .string "%u"

P0: .string "insert number K: "
P1: .string "insert array length: "
P2: .string "insert number: "

.section .data

K: .quad 0

.section .text
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $72, %rsp

    leaq P0(%rip), %rcx
    call printf
    leaq R0(%rip), %rcx
    leaq K(%rip), %rdx
    call scanf

    leaq P1(%rip), %rcx
    call printf
    leaq R1(%rip), %rcx
    leaq -4(%rbp), %rdx
    call scanf

    movq -4(%rbp), %rax
    movq $4, %rbx
    mulq %rbx
    movq %rax, %rcx
    call malloc
    movq %rax, -12(%rbp)

    movl $0, -16(%rbp)
    movq -12(%rbp), %rsi
    L0:
        leaq P2(%rip), %rcx
        call printf
        leaq R1(%rip), %rcx
        movq -16(%rbp), %rax
        leaq (%rsi, %rax, 4), %rdx
        call scanf

        incl -16(%rbp)
        movl -4(%rbp), %eax
        cmpl -16(%rbp), %eax
        jg L0

    movq -12(%rbp), %rcx
    call free

    addq $72, %rsp
    popq %rbp
    ret
