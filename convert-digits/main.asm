section .data
        bufSize db 3                    ; Define the size of the string buffer

section .bss
        strBuf resb 3                   ; Define the buffer where to store the string

section .text
        global _start

_start:
        mov rax, 57                     ; Move the number to print inside RAX
        movzx rdi, byte [bufSize]       ; Move the buffer size inside RDI with zero-extend
        mov rsi, strBuf                 ; Move the string pointer inside RSI
        call _printRAXDigits            ; Calls the subroutine to print digits inside RAX

        mov rax, 60                     ; Move _EXIT inside RAX
        move rdi, 0                     ; Move error code 0 inside RDI
        syscall


_printRAXDigits:
        push rsi                        ; Save the pointer to the string inside the stack
        push rdi                        ; Save the buffer size inside the stack

        add rsi, rdi                    ; Move the pointer to the end of the string
        mov byte [rsi], 0               ; Add string terminator
        dec rsi                         ; Move the pointer backwards

        mov rbx, 10                     ; Store the base (in this case, 10) to divide the decimal value inside RAX

_RAXDigitsLoop:
        cmp rax, 0                      ; Compare the value inside RAX with 0
        je _RAXDigitsEnd                ; If the value is 0, end the loop

        xor rdx, rdx                    ; Clear rdx for division
        div rbx                         ; Divide RAX by RBX (10)
        add dl, '0'                     ; Add '0' to the remainder's least significant byte to obtain the ASCII value
        mov [rsi], dl                   ; Moves the numerical ASCII value inside the memory address currently held by RSI
        dec rsi                         ; Move the pointer backwards

        jmp _RAXDigitsLoop              ; Jumps to the end of the loop

_RAXDigitsEnd:
        mov rax, 1                      ; Write system call
        mov rdi, 1                      ; Write to STDOUT
        pop rdx                         ; Pop the buffer size inside RDX
        pop rsi                         ; Pop the buffer inside RSI
        syscall
        ret