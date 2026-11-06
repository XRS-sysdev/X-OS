mov ah, 0x0e ; Tty mode

mov al, 'X' ; Put a character into parameter register
int 0x10 ; Call BIOS print
mov al, '-' ; Put a character into parameter register
int 0x10 ; Call BIOS print
mov al, 'O' ; Put a character into parameter register
int 0x10 ; Call BIOS print
mov al, 'S' ; Put a character into parameter register
int 0x10 ; Call BIOS print

jmp $

times 510-($-$$) db 0
dw 0xaa55