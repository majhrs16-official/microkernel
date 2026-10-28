;gdt
GDT_NULL     equ 0x0000000000000000
GDT_CODE_x64 equ 0x00209A000000FFFF   ; 0x08 -> Flags: 9A, L=1, D=0
GDT_CODE_x86 equ 0x00CF9A000000FFFF   ; 0x18 -> Flags: 9A, L=0, D=1
GDT_DATA_x64 equ 0x0000920000000000   ; 0x10 -> Flags: 92

;kernel
PG           equ 0x80000000
NXE          equ 0x800
OSFXSR       equ 0x200
LME          equ 0x00000100
PS           equ 0x83
PAE          equ 0x10
RW           equ 0x3
SCE          equ 0x00000001
PE           equ 0x00000001
IRQ_TIMER    equ 0xFA
IRQ_NONE     equ 0xFF

;boot
READ         equ 0x02
DISK         equ 0x13
