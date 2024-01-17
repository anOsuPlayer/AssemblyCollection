.section .data
S0: .string "%d"

P0: .string "input array length: "
P1: .string "insert number: "
P2: .string "the sum of all elements is: %lld"

.section .text
.globl sumArr
sumArr:
pushq %rbp
movq %rsp, %rbp
subq $32, %rsp

movq $0, -8(%rbp)
movl %edx, %edi
movq $0, %rbx
L1:
    movl (%rcx, %rbx, 4), %eax
    cltq
    addq %rax, -8(%rbp)
    incl %ebx
    cmpl %ebx, %edi
    jnz L1

movq -8(%rbp), %rax
addq $32, %rsp
popq %rbp
ret

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    leaq P0(%rip), %rcx
    call printf
    leaq S0(%rip), %rcx
    leaq -4(%rbp), %rdx
    call scanf

    movl -4(%rbp), %eax
    movl $4, %ebx
    mull %ebx
    movq %rbp, %rsi
    addl $8, %eax
    movl %eax, -8(%rbp)
    cltq
    movq %rbp, %rdi
    subq %rax, %rdi

    movl -8(%rbp), %eax
    cltq
    subq %rax, %rsp

    movl $0, %ebx
    L0:
        leaq P1(%rip), %rcx
        call printf
        leaq S0(%rip), %rcx
        leaq (%rdi, %rbx, 4), %rdx
        call scanf
        incl %ebx
        cmpl %ebx, -4(%rbp)
        jnz L0

    movq %rdi, %rcx
    movl -4(%rbp), %edx
    call sumArr

    leaq P2(%rip), %rcx
    movq %rax, %rdx
    call printf

    movl -8(%rbp), %eax
    cltq
    addq %rax, %rsp

    addq $32, %rsp
    popq %rbp
    ret
