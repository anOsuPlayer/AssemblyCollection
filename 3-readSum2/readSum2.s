.section .data
s0: .string "insert two numbers: "
s1: .string "the sum is: %d\n"
s2: .string "%s"
s3: .string "%d %d"

.section .text
.globl sum
sum:
    addq %rdx, %rcx
    movq %rcx, %rax
    ret

.globl main
main:
    pushq %rbp
    subq $32, %rsp
    movq %rsp, %rbp

    leaq s2(%rip), %rcx
    leaq s0(%rip), %rdx
    call printf

    leaq s3(%rip), %rcx
    leaq -32(%rbp), %rdx
    leaq -24(%rbp), %r8
    call scanf

    movq -32(%rbp), %rcx
    movq -24(%rbp), %rdx
    call sum

    leaq s2(%rip), %rcx
    movq %rax, %rdx
    xorq %rax, %rax
    call printf

    popq %rbp
    addq $32, %rsp
    ret
