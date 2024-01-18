.section .rodata
R0: .string "%s"
P0: .string "insert a word: "

D0: .string "%d\n"

ERR0: .string "invalid word."

.section .data
ARR:
    .byte -1
    .byte -1
    .byte -1
    .byte -1

.section .text
.globl editstr
editstr:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    cmpl %edx, %r9d
    jl EE0
    movl %r9d, %edi
    jmp EE1
    EE0:
    movl %edx, %edi
    EE1:
        
    movq $0, %rax
    addq $32, %rsp
    popq %rbp
    ret

.globl checkstr
checkstr:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movq %rcx, %rsi
    movl $0, %ecx
    C0:
        movb (%rsi, %rcx, 1), %al
        cmpb $0, %al
        jz CLE 
        cmpb $97, %al
        jl CE0
        cmpb $122, %al
        jg CE0
        incl %ecx
        jmp C0
    CLE:
    movl %ecx, %eax
    jmp CE
    CE0:
    movl $-1, %eax
    CE:
    addq $32, %rsp
    popq %rbp
    ret

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $112, %rsp

    leaq P0(%rip), %rcx
    call printf
    leaq R0(%rip), %rcx
    leaq -66(%rbp), %rdx
    call scanf

    leaq -66(%rbp), %rcx
    call checkstr
    cmpl $0, %eax
    jl E0

    leaq -66(%rbp), %rcx
    movl %eax, %edx
    leaq ARR(%rip), %r8
    movl $4, %r9d
    call editstr

    leaq R0(%rip), %rcx
    leaq -66(%rbp), %rdx
    call printf

    jmp E
    E0:
    leaq ERR0(%rip), %rcx
    call printf
    E:
    addq $112, %rsp
    popq %rbp
    ret
