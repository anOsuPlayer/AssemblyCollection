// prints on the console a triangle of arbitrary long base

.section .rodata
S0: .string "%d"
S1: .string "*"
S2: .string " "
S3: .string "insert triangle base's length : "
S4: .string "\n"

.section .text
.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp

    leaq S3(%rip), %rcx
    call printf
    leaq S0(%rip), %rcx
    leaq -4(%rbp), %rdx
    call scanf

    movl -4(%rbp), %eax
    movl $2, %ebx
    xorq %rdx, %rdx
    imull %ebx
    subl $1, %eax
    movl %eax, -4(%rbp)

    movl %eax, -8(%rbp)
    L0:
        movl -4(%rbp), %eax
        subl -8(%rbp), %eax
        subl $1, %eax
        movl $2, %ebx
        xorq %rdx, %rdx
        idivl %ebx
        movl %eax, -12(%rbp)
        L1:
            cmpl $0, %eax
            jne LE
            leaq S2(%rip), %rcx
            call printf
            decl -12(%rbp)
            movl -12(%rbp), %eax
            jmp L1
        LE:            
        
        movl $0, -12(%rbp)
        L2:
            leaq S1(%rip), %rcx
            call printf
            incl -12(%rbp)
            movl -12(%rbp), %eax
            cmpl %eax, -8(%rbp)
            jg L2
        
        leaq S4(%rip), %rcx
        call printf

        subl $2, -8(%rbp)
        cmpl $1, -8(%rbp)
        jge L0;

    addq $48, %rsp
    popq %rbp
    ret
