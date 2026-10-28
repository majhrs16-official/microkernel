# Microkernel (x86_64 Bare-Metal)

Un microkernel experimental en ensamblador purista (`nasm`) para arquitecturas `x86_64`, diseñado para arrancar directamente desde el MBR sin depender de gestores de arranque de terceros (como GRUB), configurando todo el pipeline de hardware desde cero.

## Características Técnicas

* **Bootloader Custom (16-bit MBR):** Carga los sectores iniciales desde el disco usando interrupciones de la BIOS (`int 0x13`) con reintentos de lectura.
* **Transición a Long Mode (64-bit):** 
  * Configuración de la GDT (Global Descriptor Table) con descriptores de código y datos de 32 y 64 bits.
  * Habilitación de paginación de 4 niveles (`PML4`, `PDPT`, `PDT`) con mapeo de identidad.
  * Activación de PAE, bit `LME` en el registro `EFER` (`0xC0000080`) y modo protegido/paginado.
* **Kernel de 64 bits:**
  * Activación y soporte nativo de extensiones vectoriales **SSE** dentro del kernel (`OSFXSR`, `OSXMMEXCPT`).
  * Remapeo y configuración completa del controlador de interrupciones **PIC 8259**.
  * Manejo de interrupciones de hardware (IRQ 0 Timer) con conteo de `ticks` y bucle de sincronización basado en instrucciones `hlt` (dormir hasta la siguiente interrupción).
  * Rutinas de copia de memoria optimizadas con instrucciones no temporales (`movntdq`) usando registros de 128 bits (`xmm0`–`xmm15`).
  * Impresión directa en el búfer de video de modo texto (`0xB8000`).

## Estructura del Proyecto

```text
.
├── usr/
│   └── src/          # Código fuente en ensamblador (Boot, GDT, IDT, Kernel, Memoria)
├── bin/              # Scripts de automatización y entorno (QEMU, Make)
└── etc/              # Configuración y cabeceras
