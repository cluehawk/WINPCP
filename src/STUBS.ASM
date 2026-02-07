; =====================================================================
; STUBS.ASM - export stubs for WINPCP
;
; Phase 1 bring-up:
;   - Provide all Win3 CGA-style exports so the driver links/loads.
;   - These are temporary stubs; most return 0 except ENABLE/DISABLE.
;
; Calling convention note:
;   Windows display driver exports are FAR routines; most reference drivers
;   use a caller-clean convention (RETF with no immediate).
;   These stubs therefore use plain RETF (no stack pop).
; =====================================================================

public  STRBLT, EXTTEXTOUT
public  BITBLT, COLORINFO, CONTROL, DISABLE, ENABLE
public  ENUMDFONTS, ENUMOBJ, OUTPUT, PIXEL, REALIZEOBJECT
public  SCANLR, DEVICEMODE, GETCHARWIDTH, DEVICEBITMAP
public  FASTBORDER, SETATTRIBUTE, DEVICEBITMAPBITS
public  CREATEBITMAP, DIBSCREENBLT
public  DO_POLYLINES, DO_SCANLINES
public  INQUIRE, SETCURSOR, MOVECURSOR, CHECKCURSOR
public  USERREPAINTDISABLE

; --- Wrappers for text entrypoints implemented in TEXT_ENTRY.ASM ---
; (TEXT_ENTRY.ASM currently defines StrBlt and ExtTextOut)
STRBLT proc far
    jmp StrBlt
STRBLT endp

EXTTEXTOUT proc far
    jmp ExtTextOut
EXTTEXTOUT endp

; --- CGA-aligned exports (stubs) ---
BITBLT proc far
    xor ax, ax
    xor dx, dx
    retf
BITBLT endp

COLORINFO proc far
    xor ax, ax
    xor dx, dx
    retf
COLORINFO endp

CONTROL proc far
    xor ax, ax
    xor dx, dx
    retf
CONTROL endp

DISABLE proc far
    mov ax, 1
    xor dx, dx
    retf
DISABLE endp

ENABLE proc far
    mov ax, 1
    xor dx, dx
    retf
ENABLE endp

ENUMDFONTS proc far
    xor ax, ax
    xor dx, dx
    retf
ENUMDFONTS endp

ENUMOBJ proc far
    xor ax, ax
    xor dx, dx
    retf
ENUMOBJ endp

OUTPUT proc far
    xor ax, ax
    xor dx, dx
    retf
OUTPUT endp

PIXEL proc far
    xor ax, ax
    xor dx, dx
    retf
PIXEL endp

REALIZEOBJECT proc far
    xor ax, ax
    xor dx, dx
    retf
REALIZEOBJECT endp

SCANLR proc far
    xor ax, ax
    xor dx, dx
    retf
SCANLR endp

DEVICEMODE proc far
    xor ax, ax
    xor dx, dx
    retf
DEVICEMODE endp

GETCHARWIDTH proc far
    xor ax, ax
    xor dx, dx
    retf
GETCHARWIDTH endp

DEVICEBITMAP proc far
    xor ax, ax
    xor dx, dx
    retf
DEVICEBITMAP endp

FASTBORDER proc far
    xor ax, ax
    xor dx, dx
    retf
FASTBORDER endp

SETATTRIBUTE proc far
    xor ax, ax
    xor dx, dx
    retf
SETATTRIBUTE endp

DEVICEBITMAPBITS proc far
    xor ax, ax
    xor dx, dx
    retf
DEVICEBITMAPBITS endp

CREATEBITMAP proc far
    xor ax, ax
    xor dx, dx
    retf
CREATEBITMAP endp

DIBSCREENBLT proc far
    xor ax, ax
    xor dx, dx
    retf
DIBSCREENBLT endp

DO_POLYLINES proc far
    xor ax, ax
    xor dx, dx
    retf
DO_POLYLINES endp

DO_SCANLINES proc far
    xor ax, ax
    xor dx, dx
    retf
DO_SCANLINES endp

INQUIRE proc far
    xor ax, ax
    xor dx, dx
    retf
INQUIRE endp

SETCURSOR proc far
    xor ax, ax
    xor dx, dx
    retf
SETCURSOR endp

MOVECURSOR proc far
    xor ax, ax
    xor dx, dx
    retf
MOVECURSOR endp

CHECKCURSOR proc far
    xor ax, ax
    xor dx, dx
    retf
CHECKCURSOR endp

USERREPAINTDISABLE proc far
    xor ax, ax
    xor dx, dx
    retf
USERREPAINTDISABLE endp
