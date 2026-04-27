adrp    x8, 0xfffffff0078b7000    ; load page base
ldr     x8, [x8, #0x728]          ; load from page + offset
; → effective address: 0xfffffff0078b7728
