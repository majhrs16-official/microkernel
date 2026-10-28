[bits 64]
kernel:
	.init:
		mov ax, 0x10
		mov ds, ax
		mov es, ax
		mov fs, ax
		mov gs, ax
		mov ss, ax
		mov rsp, KERNEL_STACK

		; Habilitar SSE (OSFXSR y OSXMMEXCPT)
		mov rax, cr4
		or rax, 0x600       ; Activa los bits 9 (OSFXSR) y 10 (OSXMMEXCPT)
		mov cr4, rax

		mov rsi, OKEY
		mov rdi, VIDEO
		mov rbx, WHITE_BLACK
		mov rcx, 1
		call print

		; 2. Registrar idt_irq32 en la entrada 32 de idt.table de forma dinámica
		mov rax, irq32
		mov [idt.table + 32*16], ax         ; Bits 0-15 (Ok)
		shr rax, 16
		mov [idt.table + 32*16 + 6], ax     ; Bits 16-31 (Ok)
		shr rax, 16
		mov [idt.table + 32*16 + 8], eax    ; Bits 32-63 (Ok)

		; 3. Cargar la IDT corregida
		lidt [idt.descriptor]

		; 4. Configurar el PIC (Secuencia ICW estándar usando tus constantes)
		mov al, IRQ_INIT        ; 0x11
		out PIC_MASTER_CTRL, al ; 0x20
		out PIC_SLAVE_CTRL, al  ; 0xA0

		mov al, IRQ32           ; 0x20 (Base para Master: IRQ 0-7 -> INT 0x20-0x27)
		out PIC_MASTER_DATA, al ; 0x21
		mov al, IRQ40           ; 0x28 (Base para Slave: IRQ 8-15 -> INT 0x28-0x2F)
		out PIC_SLAVE_DATA, al  ; 0xA1

		mov al, IRQ_MASTER      ; 0x04 (Master sabe que el Slave está en IRQ2)
		out PIC_MASTER_DATA, al ; 0x21
		mov al, IRQ_SLAVE       ; 0x02 (Slave conoce su línea de cascada)
		out PIC_SLAVE_DATA, al  ; 0xA1

		mov al, MODE8086        ; 0x01
		out PIC_MASTER_DATA, al ; 0x21
		out PIC_SLAVE_DATA, al  ; 0xA1

		; Ahora sí, desenmascaramos usando tus máscaras binarias
		mov al, IRQ_TIMER       ; 0b11111010 -> En tu declaración original habilitaba Timer (IRQ0) y Teclado (IRQ1)
		out PIC_MASTER_DATA, al ; 0x21
		
		mov al, IRQ_NONE        ; 0b11111111 -> Deshabilita todo en el Slave
		out PIC_SLAVE_DATA, al  ; 0xA1

		; 5. Habilitar interrupciones de hardware de forma segura
		sti

		mov r8, 10

	.worker:
		mov rsi, OKEY
		mov rdi, VIDEO
		mov rbx, WHITE_BLACK
		mov rcx, 1
		call print

		mov rbx, 10
		call sleep

		mov rsi, CLEAR
		mov rdi, VIDEO
		mov rbx, WHITE_BLACK
		mov rcx, 1
		call print

		mov rbx, 10
		call sleep

		dec r8
		jnz .worker

	.exit:
		hlt
		jmp .exit
