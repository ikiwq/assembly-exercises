section .data
        v dw 2, 14                      ; Declare first vector
        length equ ($-v)/2              ; Find vector length
        W dw 16, 16                     ; Declare second vector

section .text
        global _start

_start:
        mov rcx, length                 ; Move length inside rcx

_loopStart:
        push rbp                        ; Push last rbp value to the stack
        mov rbp, rsp                    ; Move base pointer to rsp
        mov rcx, 0                      ; Initialize counter

        sub rsp, 6                      ; Make space for 3 variables of 2 bytes each

        mov ax, length                  ; Move length to rax
        dec ax                          ; Shorten length by 1

        mov [rbp - 2], word ax          ; Initialize first variable
        xor ax, ax                      ; Clean rax

_loop:
        cmp rcx, [rbp - 2]              ; Compare counter with max length - 1
        jg _loopEnd                     ; If greater, jump to end

        mov ax, [v + 2 * rcx]           ; Move integer from first array in rax
        mov bx, 16                      ; Move 16 inside bx
        div bx                          ; Divide rax by 16

        mov [rbp - 4], dx               ; Move the remainder into variable

        xor bx, bx                      ; Cleans bx
        xor ax, ax                      ; Clean rax
        xor dx, dx                      ; Clean rdx

        mov ax, [W + 2 * rcx]           ; Move integer from second array in rax
        mov bx, 16                      ; Move 16 inside bx
        div bx                          ; Divides rax by 16

        mov [rbp - 6], dx               ; Move the remainder into variable

        xor bx, bx                      ; Cleans bx
        xor ax, ax                      ; Cleans ax
        xor dx, dx                      ; Cleans dx

        inc rcx                         ; Icrements current index

        mov ax, [rbp - 4]               ; Move first remainder inside rax
        cmp ax, [rbp - 6]               ; Compare first remainder with second one

        je _positiveCase                ; If equal, jump to positiveCase
        jmp _loop                       ; Otherwise repeat the loop

_positiveCase:
        mov rax, 60                     ; Move SYS_EXIT inside rax
        mov rdi, 1                      ; Move status 1 inside rdi
        syscall                         ; Syscall

_loopEnd:
        mov rax, 60                     ; move SYS_EXIT inside rax
        mov rdi, 0                      ; Move status 0 inside rdi
        syscall                         ; Syscall
~                                                                                                       ~                                                            