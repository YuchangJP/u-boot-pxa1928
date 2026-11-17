/* Binary images recovered from the stock 2019-11-25 BR2 U-Boot.
 * See docs/br2-production-coprocessor.md for provenance and checksums.
 * Uncompressed from .bin.gz at build time by drivers/power/Makefile. */
    .section .rodata,"a",%progbits
    .balign 4
    .global br2_d2_07e_image
br2_d2_07e_image:
    .incbin "br2_d2_07e.bin"
    .global br2_d2_07e_image_end
br2_d2_07e_image_end:
    .balign 4
    .global br2_d2_07f_image
br2_d2_07f_image:
    .incbin "br2_d2_07f.bin"
    .global br2_d2_07f_image_end
br2_d2_07f_image_end:
    .section .note.GNU-stack,"",%progbits
