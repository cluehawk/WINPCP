; cga_interleave.inc
; Advance DI to next scanline in CGA/Plantronics interleave.
; Requires:
;   DX = 2000h
;   [bp-20h] or a constant WRAP = 80A0h (choose your style)

NEXT_SCANLINE MACRO wrapConst
    add di, dx
    jns @F
    add di, wrapConst
@@:
ENDM
