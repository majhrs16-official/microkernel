;global
HALT      equ 0xF4
NOPE      equ 0x90

;kernel
CLEAR       dq  0xF020_F020_F020_F020
OKEY        dq  0xF020_F04B_F04F_F020
WHITE_BLACK equ 0x0F

;boot
MBR       equ 0xAA55
SIZE      db  15 ; 16 sectors - 1 or 8 KiB - MBR = 15 or 7.5KB
BIOS_DISK db  0x80
