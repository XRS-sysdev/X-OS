loop:
    jmp loop ; Our OS base

times 510-($-$$) db 0
dw 0xaa55