[bits 32]

loader:
	.init:
		cli
		mov ax, 0x10
		mov ds, ax
		mov es, ax
		mov ss, ax
		mov esp, BOOT_STACK

		mov al, 'E'
		call debug_print32

	.clear_tables:
		mov eax, PML4
		mov edi, eax
		mov cr3, eax
		xor eax, eax
		mov ecx, 3072
		rep stosd

	.identity_map:
		mov dword [PML4], PDPT | 0x03
		mov dword [PML4 + 4], 0

		mov dword [PDPT], PDT | 0x03
		mov dword [PDPT + 4], 0

		mov dword [PDT], 0x00000000 | 0x83
		mov dword [PDT + 4], 0

		mov al, 'F'
		call debug_print32

	.extensions:
		mov eax, cr4
		or eax, 0x20
		mov cr4, eax

		mov al, 'G'
		call debug_print32

	.efer:
		mov ecx, 0xC0000080 ; EFER MSR
		rdmsr
		or eax, 0x00000100 ; Bit 8: LME
		wrmsr

		mov al, 'H'
		call debug_print32

	.paging:
		mov eax, gdt
		mov [gdt.descriptor + 2], eax  ; Parcheamos dinámicamente la dirección base de la GDT
		lgdt [gdt.descriptor]

		mov eax, cr0
		or eax, 0x80000000 ; Bit 31: PG
		mov cr0, eax

		mov al, 'I'
		call debug_print32

	.worker:
		mov al, 'M'
		call debug_print32

		jmp 0x08:kernel.init

; Destruye EAX
debug_print32:
    mov [0xB8002], al
    mov byte [0xB8003], 0x1F ; Fondo azul, texto blanco brillante
    ret
