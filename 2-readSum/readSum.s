// reads two numbers and sums them, displaying the result

.section .data
s0: .string "insert two numbers: "
s1: .string "the sum is: %d\n"
s3: .string "%d %d"

.section .text
.globl sum
sum:
    addl %edx, %ecx
    movl %ecx, %eax
    ret

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    leaq s0(%rip), %rcx
    call printf

    leaq s3(%rip), %rcx
    leaq -4(%rbp), %rdx
    leaq -8(%rbp), %r8
    call scanf

    movl -4(%rbp), %ecx
    movl -8(%rbp), %edx
    call sum

    leaq s1(%rip), %rcx
    movq %rax, %rdx
    xorq %rax, %rax
    call printf

    addq $32, %rsp
    popq %rbp
    ret
