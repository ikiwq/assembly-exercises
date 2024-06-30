section .text
        global _start

_start:
        mov rax, 50             ; Move first number inside rax
        mov rdi, 20             ; Move second number inside rdi

        call _findGCD           ; Calls subroutine

        mov rdi, rax            ; Move GCD contained in rax to rdi
        mov rax, 60             ; Move SYS_EXIT inside rax
        syscall                 ; Call the kernel

_findGCD:
        mov rbx, rdi            ; Move second parameter into rbx

_findGCDLoop:                   ; Find GCD by using Euclide's algorithm
        cmp rbx, 0              ; Compare smallest number with 0
        je _findGCDEnd          ; Jump to end if equals to 0

        xor rdx, rdx            ; Clear remainder inside rdx for division

        div rbx                 ; Divide rax by rbx

        mov rax, rbx            ; Move smallest number to rax
        mov rbx, rdx            ; Move remainder to rbx

        jmp _findGCDLoop        ; Jump to start

_findGCDEnd:
        ret                     ; Return to call point