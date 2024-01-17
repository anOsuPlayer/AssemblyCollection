.section .data
s0: .string "%d"
s1: .string "%s"
s2: .string "write a number: "
s3: .string "your number: %d\n"

.section .text
.globl main
main:
    pushq %rbp
    subq $32, %rsp
    movq %rsp, %rbp

    leaq s1(%rip), %rcx
    leaq s2(%rip), %rdx
    call printf

    leaq s0(%rip), %rcx
    leaq (%rbp), %rdx
    call scanf

    leaq s3(%rip), %rcx
    movq (%rbp), %rdx
    call printf

    popq %rbp
    addq $32, %rsp
    ret
