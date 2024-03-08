// source: https://edabit.com/challenge/DMswF7WwaXfKN5Hd9
// compute the percentage covered by a certain country of the total world's landmass

.section .rodata
r0: .string "%s"
r1: .string "%d"
r2: .string "%f"

p0: .string "insert country name: "
p1: .string "insert country area: "
p2: .string "%s is %f of the total world's landmass"

mass: .long 148940000
fact: .float 100.0

.section .text
.globl compute
compute:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    movq %rcx, -8(%rbp)

    movl %edx, %eax
    cvtsi2ss %rax, %xmm0
    movl mass(%rip), %eax
    cvtsi2ss %rax, %xmm1
    divss %xmm1, %xmm0
    movq fact(%rip), %xmm1
    mulss %xmm1, %xmm0
    
    leaq p2(%rip), %rcx
    leaq -8(%rbp), %rdx
    cvtss2sd %xmm0, %xmm0
    movq %xmm0, %r8
    call printf

    addq $48, %rsp
    popq %rbp
    ret

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    leaq p0(%rip), %rcx
    call printf
    leaq r0(%rip), %rcx
    leaq -8(%rbp), %rdx
    call scanf

    leaq p1(%rip), %rcx
    call printf
    leaq r1(%rip), %rcx
    leaq -12(%rbp), %rdx
    call scanf

    movq -8(%rbp), %rcx
    movl -12(%rbp), %edx
    call compute

    addq $48, %rsp
    popq %rbp
    ret
