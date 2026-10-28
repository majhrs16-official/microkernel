;boot
BOOT_STACK equ 0x7C00
ENTRY      equ 0x7E00
CYLINDER   equ 0
HEAD       equ 0
SECTOR     equ 2

;kernel
PML4         equ 0x1000
PDPT         equ 0x2000
PDT          equ 0x3000
KERNEL_STACK equ 0xF000

EFER         equ 0xC0000080
VIDEO        equ 0xB8000

IRQ_INIT     equ 0x11
MODE8086     equ 0x01
IRQ_MASTER   equ 0x04
IRQ_SLAVE    equ 0x02
IRQ32        equ 0x20
IRQ40        equ 0x28
EOI          equ 0x20

PIC_MASTER_CTRL equ 0x20
PIC_MASTER_DATA equ 0x21
PIC_SLAVE_CTRL  equ 0xA0
PIC_SLAVE_DATA  equ 0xA1

DUMP equ 0xFF000

