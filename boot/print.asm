print:
	pusha ; Save register data to the stack

start:
	mov al, [bx] ; Load next character to al
	cmp al, 0 ; Check if the character is a null ender
	je done ; If so, finish

	mov ah, 0x0e ; Tty mode
	int 0x10 ; Call BIOS print

	add bx, 1 ; Increment to get the next character
	jmp start ; Loop again

done:
	popa ; Return old register data back
	ret