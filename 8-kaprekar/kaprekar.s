.section .rodata
kconst: .long 6174

S0: .string "%u"

P0: .string "insert a 4-digits number: "
P1: .string "%u - %u = %u\n"

ERR0: .string "not a 4-digits number.\n"
ERR1: .string "invalid 4-digits number.\n"

.section .data
first: .zero 4
second: .zero 4

.section .text
.globl sort
sort:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movq %rcx, %rsi
    movq %rdx, %rdi

    movl $0, -4(%rbp)
    BS0:
        movl $0, -8(%rbp)
        BS1:
            movl -8(%rbp), %ecx
            movb (%rsi, %rcx, 1), %r8b
            incl %ecx
            movb (%rsi, %rcx, 1), %r9b

            cmpb %r9b, %r8b
            jae BS2
            movb %r8b, (%rsi, %rcx, 1)
            decl %ecx
            movb %r9b, (%rsi, %rcx, 1)

            BS2:
            incl -8(%rbp)
            movl $3, %eax
            subl -4(%rbp), %eax
            cmpl %eax, -8(%rbp)
            jl BS1
        incl -4(%rbp)
        cmpl $4, -4(%rbp)
        jl BS0

    movq $0, %rax
    movq $3, %rcx
    movb (%rsi, %rax, 1), %r8b
    movb %r8b, (%rdi, %rcx, 1)
    movb (%rsi, %rcx, 1), %r8b
    movb %r8b, (%rdi, %rax, 1)
    incq %rax
    decq %rcx
    movb (%rsi, %rax, 1), %r8b
    movb %r8b, (%rdi, %rcx, 1)
    movb (%rsi, %rcx, 1), %r8b
    movb %r8b, (%rdi, %rax, 1)

    movq $0, %rax
    addq $32, %rsp
    popq %rbp
    ret

.globl process
process:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    movl %ecx, -4(%rbp)

    movl -4(%rbp), %eax
    movl $1000, %ebx
    xorq %rdx, %rdx
    idivl %ebx
    movb %al, 3+first(%rip)
    movl -4(%rbp), %eax
    movl $100, %ebx
    xorq %rdx, %rdx
    idivl %ebx
    movl $10, %ebx
    xorq %rdx, %rdx
    idivl %ebx
    movb %dl, 2+first(%rip)
    movl -4(%rbp), %eax
    movl $10, %ebx
    xorq %rdx, %rdx
    idivl %ebx
    movl $10, %ebx
    xorq %rdx, %rdx
    idivl %ebx
    movb %dl, 1+first(%rip)
    movl -4(%rbp), %eax
    movl $10, %ebx
    xorq %rdx, %rdx
    idivl %ebx
    movb %dl, first(%rip)

    leaq first(%rip), %rcx
    leaq second(%rip), %rdx
    call sort

    leaq first(%rip), %rcx
    leaq second(%rip), %rdx
    movl $0, -4(%rbp)
    movl $0, -8(%rbp)

    leaq first(%rip), %rsi
    leaq second(%rip), %rdi
    movq $3, %rbx
    movl $1000, %r8d
    movl $10, %r9d
    C0:
        xorq %rdx, %rdx
        xorq %rax, %rax
        movb (%rsi, %rbx, 1), %al
        imull %r8d
        addl %eax, -8(%rbp)
        xorq %rdx, %rdx
        xorq %rax, %rax
        movb (%rdi, %rbx, 1), %al
        imull %r8d
        addl %eax, -4(%rbp)

        movl %r8d, %eax
        idivl %r9d
        movl %eax, %r8d

        decq %rbx
        cmpq $0, %rbx
        jge C0

    movl -4(%rbp), %eax
    subl -8(%rbp), %eax
    movl %eax, -12(%rbp)

    leaq P1(%rip), %rcx
    movl -4(%rbp), %edx
    movl -8(%rbp), %r8d
    movl -12(%rbp), %r9d
    call printf

    movl -12(%rbp), %eax
    addq $48, %rsp
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

    cmpl $10000, -4(%rbp)
    jl E0
    leaq ERR0(%rip), %rcx
    call printf
    jmp E
    E0:
    cmpl $1000, -4(%rbp)
    jg E1
    leaq ERR0(%rip), %rcx
    call printf
    jmp E
    E1:

    movl -4(%rbp), %eax
    L0:
        cmpl %eax, kconst(%rip)
        jz E
        cmpl $0, %eax
        jz E2
        movl %eax, %ecx
        call process
        jmp L0

    E2:
    leaq ERR1(%rip), %rcx
    call printf
    E:
    addq $32, %rsp
    popq %rbp
    ret