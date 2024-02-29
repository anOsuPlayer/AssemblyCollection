// allocates an array and reads it using malloc() and free()

.section .rodata
P0: .string "insert array length: "
P1: .string "insert array element: "
P2: .string "given array: "

R0: .string "%u"
R1: .string "%u "

.section .data
addr: .quad 0

.section .text
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp
        
    leaq P0(%rip), %rcx
    call printf
    leaq R0(%rip), %rcx
    leaq -4(%rbp), %rdx
    call scanf

    movl -4(%rbp), %eax
    movl %eax, %r12d
    movl $4, %ebx
    mull %ebx
    movl %eax, -4(%rbp)

    movl -4(%rbp), %ecx
    call malloc

    movq %rax, -12(%rbp)
    movq %rax, -20(%rbp)
    movl %r12d, %r13d
    L0:
        leaq P1(%rip), %rcx
        call printf
        leaq R0(%rip), %rcx
        movq -20(%rbp), %rdx
        call scanf

        addq $4, -20(%rbp)

        decl %r12d
        cmpl $0, %r12d
        jg L0

    leaq P2(%rip), %rcx
    call printf
    movq -12(%rbp), %rbx
    movl $0, %r12d
    L1:
        leaq R1(%rip), %rcx
        movl (%rbx), %edx
        call printf

        addq $4, %rbx

        incl %r12d
        cmpl %r12d, %r13d
        jg L1

    movq -12(%rbp), %rcx
    call free

    addq $64, %rsp
    popq %rbp
    ret