// source: https://edabit.com/challenge/w9tSqwcePxAQrE8ZT

.section .rodata
s0: .string "perfect"
s1: .string "admirable"
s2: .string "neither"

s3: .string "insert number: "

r0: .string "%d"

.section .text
.globl divisors
divisors:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    movq $0, %rax
    addq $48, %rsp
    popq %rbp
    ret

.globl isAdmirable
isAdmirable:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    movq $0, %rax
    addq $48, %rsp
    popq %rbp
    ret

.globl isPefect
isPefect:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    movq $0, %rax
    addq $48, %rsp
    popq %rbp
    ret

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    leaq s3(%rip), %rcx
    call printf
    leaq r0(%rip), %rcx
    leaq -4(%rbp), %rdx
    call scanf

    movl -4(%rbp), %ecx
    call isPefect
    cmpq $1, %rax
    jnz L1

    leaq s0(%rip), %rcx
    call printf

    jmp LE
    
    L1:
    movl -4(%rbp), %ecx
    call isAdmirable
    cmpq $1, %rax
    jnz L2

    leaq s1(%rip), %rcx
    call printf

    jmp LE

    L2:
    leaq s2(%rip), %rcx
    call printf

    LE:
    addq $48, %rsp
    popq %rbp
    ret
