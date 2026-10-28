[bits 64]

align 8
gdt:
	.data:
		dq GDT_NULL     ; 0x00
		dq GDT_CODE_x64 ; 0x08
		dq GDT_DATA_x64 ; 0x10
		dq GDT_CODE_x86 ; 0x18

	.descriptor:
		dw $ - gdt - 1
		dq gdt
