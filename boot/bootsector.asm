[org 0x7c00]

mov bx, Boot_Message ; Load the Boot Message string into parameter register
call print ; Call the print function

jmp $

%include "boot/print.asm"

Boot_Message:
    db 'X-OS', 0

times 510-($-$$) db 0
dw 0xaa55