// reads and prints a number using printf and scanf.

.section .data
s0: .string "%d"
s2: .string "write a number: "
s3: .string "your number: %d\n"

.section .text
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    leaq s2(%rip), %rcx
    call printf
    leaq s0(%rip), %rcx
    leaq -4(%rbp), %rdx
    call scanf

    leaq s3(%rip), %rcx
    movl -4(%rbp), %edx
    call printf

    popq %rbp
    addq $32, %rsp
    ret
