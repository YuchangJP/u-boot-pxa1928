# BR2 production U-Boot restoration

The stock BR2 U-Boot inside `CT2-Uboot-flasher(1).apk` differs from the
published MA04 source. These changes are deliberately limited to the MA04
build; MA03/BS continues to use the original CP/MSA arrays and mapping.

## Recovered changes

- MA04 early MFP table: append 0x01081002, 0x0254c000 (GPIO148 pull-up),
  0x0258c000 (GPIO149 pull-up) before MFP_EOC. Original BR2 binary has a
  112-byte copy versus 100 bytes on BS.
- BR2 `cp_d2` copies two images into 0x07e00000 (8544 bytes) and
  0x07f00000 (8828 bytes). The original source used 0x06000000 and
  0x07000000 with shorter payloads.
- BR2 `release_seagull` writes 0x000107e0 to 0xd4051084 instead of
  0x00010600. The earlier timeout restoration is retained.
- The `handle_dtb` GPIO148/149 strap branch and MMC/DTB fixups were already
  restored in commit ca9677ca785ddc8dfc0636297786fe3439830413.

## Payload provenance

Both gzip files contain exactly the corresponding bytes from the stock BR2
1-MiB U-Boot. They were gzip-compressed with mtime=0 for reproducibility.

| File | Original offset | Copy destination | Uncompressed size | SHA-256 |
| --- | --- | --- | ---: | --- |
| br2_d2_07e.bin.gz | 0x95c30 | 0x07e00000 | 8544 | f6be2161a74e1f04e2b9837552e3b724f7709bc39281ceba6a3c9857035984a1 |
| br2_d2_07f.bin.gz | 0x939b0 | 0x07f00000 | 8828 | a38f9ec65a140e6929ff8b9019015f50ed62306ac6454f5d7a5cb1aa3cf75507 |

For MA04 builds, the Makefile expands gzip files before assembling
`br2_coprocessor_blobs.S`. Host `gzip` is required. The uncompressed .bin
files are generated artifacts and should not be committed.

## Verification limitations

The image bytes and MFP values were compared against the supplied BR2 U-Boot.
The complete U-Boot was **not** rebuilt against the original Android GCC 4.9
BSP and has **not** been flashed or tested on physical hardware. Keep a
verified recovery path and original bootloader backup; don't flash this as
an untested production replacement. The payloads may be subject to separate
redistribution terms; review that before republishing them.
