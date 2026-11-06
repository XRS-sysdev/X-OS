[org 0x7c00]

call clear
mov bx, real_mode
call print
call print_nl
mov bx, protected_mode_switch
call print

// TODO: Add 32 bit switching

jmp $

%include "boot/16_bit_real_mode_print.asm"

real_mode db "16-Bit Real Mode", 0
protected_mode_switch db "Switching To 32-Bit Protected Mode", 0

times 510-($-$$) db 0
dw 0xaa55