[bits 16]
[org 0x7c00]

boot:
    .init:
        mov [BIOS_DISK], dl
        xor ax, ax
        mov ds, ax
        mov es, ax
        mov ss, ax
        mov sp, BOOT_STACK

    .loader:
        mov cl, 'A'
        call debug_print16

        mov ah, READ
        mov al, 15
        mov ch, CYLINDER
        mov cl, SECTOR
        mov dh, HEAD
        mov dl, [BIOS_DISK]

        xor bx, bx
        mov es, bx
        mov bx, ENTRY

    .retry:
        int DISK
        jc .retry

    .worker:
		mov cl, 'C'
        call debug_print16
        cli
        lgdt [gdt.descriptor]

        mov eax, cr0
        or eax, 1                   ; PE = 1
        mov cr0, eax

        jmp 0x18:ENTRY

debug_print16:
	; Destruye AX y BX
    push es
    mov ax, 0xB800       
    mov es, ax
    mov byte [es:0], cl  
    mov byte [es:1], 0x4F
    pop es
    ret

times 510-($-$$) db HALT
dw MBR
