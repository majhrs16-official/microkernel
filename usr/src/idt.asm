align 8
idt:
	.descriptor:
		dw (256 * 16) - 1      ; Cambiado a 256 para cubrir toda la tabla
		dq idt.table

	.table:
		times 32 * 16 db 0     ; Las primeras 32 excepciones de la CPU (vacías)

		; Entrada 32: El Timer (IRQ 0). Dejamos los offsets en 0 para llenarlos en el init
		dw 0                  ; Offset bits 0-15
		dw 0x08               ; Selector de código de la GDT (Selector 1 = 0x08)
		db 0                  ; IST
		db 0x8E               ; Tipo: Interrupt Gate, Ring 0, Presente
		dw 0                  ; Offset bits 16-31
		dd 0                  ; Offset bits 32-63
		dd 0                  ; Reservado

		times (256 - 33) * 16 db 0 ; El resto de las 256 interrupciones vacías

align 8
ticks: dq 0

irq32:
	inc qword [rel ticks]
	mov al, EOI
	out PIC_MASTER_CTRL, al
	iretq

isr0:
	iretq
