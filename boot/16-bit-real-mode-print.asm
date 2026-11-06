print_char_temp db 0
VGA_MEMORY equ 0xB800
VGA_WIDTH  equ 80
VGA_HEIGHT equ 25
VGA_ATTR   equ 0x0F

cursor_x dw 0
cursor_y dw 0

print:
    pusha

.loop:
    mov al, [bx]
    test al, al
    jz .done

    call print_char

    inc bx
    jmp .loop

.done:
    popa
    ret

print_char:
    pusha

    mov [print_char_temp], al

    mov ax, [cursor_y]
    mov cx, VGA_WIDTH
    mul cx

    add ax, [cursor_x]
    shl ax, 1

    mov di, ax

    mov ax, VGA_MEMORY
    mov es, ax

    mov al, [print_char_temp]
    mov ah, VGA_ATTR
    mov [es:di], ax

    inc word [cursor_x]

    cmp word [cursor_x], VGA_WIDTH
    jb .update

    call print_nl_internal

.update:
    call update_cursor

.done:
    popa
    ret

print_nl:
    pusha
    call print_nl_internal
    popa
    ret

print_nl_internal:
    mov word [cursor_x], 0
    inc word [cursor_y]

    cmp word [cursor_y], VGA_HEIGHT
    jb .done

    mov word [cursor_y], 0

.done:
    ret

update_cursor:
    pusha

    mov ax, [cursor_y]
    mov bx, VGA_WIDTH
    mul bx

    add ax, [cursor_x]

    mov bx, ax

    mov dx, 0x3D4
    mov al, 0x0F
    out dx, al

    inc dx
    mov al, bl
    out dx, al

    dec dx
    mov al, 0x0E
    out dx, al

    inc dx
    mov al, bh
    out dx, al

    popa
    ret

clear:
    pusha

    mov ax, VGA_MEMORY
    mov es, ax

    xor di, di

    mov ax, 0x0F20

    mov cx, VGA_WIDTH * VGA_HEIGHT

    cld
    rep stosw

    mov word [cursor_x], 0
    mov word [cursor_y], 0

    call update_cursor

    popa
    ret