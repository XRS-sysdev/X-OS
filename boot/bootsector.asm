[org 0x7c00]

call clear
mov bx, Boot_Message ; Load the Boot Message string into parameter register
call print ; Call the print function

jmp $

%include "boot/16-bit-real-mode-print.asm"

Boot_Message:
    db 'X-OS', 0

times 510-($-$$) db 0
dw 0xaa55