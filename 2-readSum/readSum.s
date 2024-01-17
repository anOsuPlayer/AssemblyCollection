.section .data
s0: .string "insert first number: "
s1: .string "insert second number: "
s2: .string "the sum is: %d\n"
s3: .string "%s"
s4: .string "%d"

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

    leaq s3(%rip), %rcx
    leaq s0(%rip), %rdx
    call printf

    leaq s4(%rip), %rcx
    leaq -32(%rbp), %rdx
    call scanf

    leaq s3(%rip), %rcx
    leaq s1(%rip), %rdx
    call printf

    leaq s4(%rip), %rcx
    leaq -24(%rbp), %rdx
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
