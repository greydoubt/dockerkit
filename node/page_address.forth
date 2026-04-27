; Global variables such as allproc, kernproc, & nprocs are stored in the __DATA segment and provide entry points into a kernel's data structures once a known address is referenced by functions via adrp/ldr instruction pairs.
adrp    x8, 0xfffffff0078b7000    ; load page base
ldr     x8, [x8, #0x728]          ; load from page + offset
; → effective address: 0xfffffff0078b7728
