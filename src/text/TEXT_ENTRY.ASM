; =====================================================================
; TEXT_ENTRY.ASM
; Win3 display driver text entrypoints:
;   - StrBlt (ordinal 11)
;   - ExtTextOut (ordinal 14)
;
; Phase 1 baseline: NEC V20 allowed (.186)
; Calling convention: FAR PASCAL (callee pops args using RETF n)
;
; This file contains ONLY entrypoints / marshaling.
; Rendering logic lives in TEXT_CORE.ASM (Text_RenderStringPlantronics).
; Hot loop lives in TEXT_GLYPH.ASM (later).
; =====================================================================

.186
.model large

; ---- Optional: include your common project headers here ----
; If you already have DDK-style headers, include them.
; (Not required for this file to assemble, since we don't use structs yet.)
; include ..\inc\cpu_abs.inc
; include ..\inc\plantronics.inc

; ---- Public exports ----
public  StrBlt
public  ExtTextOut

; ---- External core routine (you implement in TEXT_CORE.ASM) ----
; Signature should match ExtTextOut exactly (FAR PASCAL), returning DX:AX status.
extrn   Text_RenderStringPlantronics:FAR

; Optional: if you want extents early, implement this later.
; extrn Text_ExtentsPlantronics:FAR

; ---- Code segment ----
_TEXT segment word public 'CODE'
assume cs:_TEXT

; ---------------------------------------------------------------------
; StrBlt
;
; StrBlt has the first 9 parameters of ExtTextOut.
; ExtTextOut has 3 extra parameters at the end:
;   lpCharWidths : DWORD
;   lpOpaqueRect : DWORD
;   Options      : WORD
;
; This routine must:
;   - preserve the original FAR return address
;   - push NULLs for the 3 extra params
;   - restore FAR return address
;   - JMP into ExtTextOut (tailcall)
;
; Stack on entry to StrBlt:
;   [SP+00]  return IP
;   [SP+02]  return CS
;   [SP+04]  lpDestDev (DWORD)
;   ...
;   total StrBlt args = 30 bytes
;
; After pushing 10 bytes of dummy ExtTextOut extras, ExtTextOut will RETF 40.
; ---------------------------------------------------------------------
StrBlt proc far

    ; DO NOT build a frame here. We are going to tailcall ExtTextOut.
    ; Save return address in BX:CX
    pop     cx              ; IP
    pop     bx              ; CS

    ; Push dummy ExtTextOut extras (NULL pointers, Options=0)
    xor     ax, ax

    ; lpCharWidths (DWORD) = 0
    push    ax              ; low
    push    ax              ; high

    ; lpOpaqueRect (DWORD) = 0
    push    ax              ; low
    push    ax              ; high

    ; Options (WORD) = 0
    push    ax

    ; Restore return address
    push    bx              ; CS
    push    cx              ; IP

    jmp     ExtTextOut      ; tailcall

StrBlt endp


; ---------------------------------------------------------------------
; ExtTextOut
;
; Parameters (total 40 bytes):
;   1  lpDestDev    DWORD
;   2  DestXOrg     WORD
;   3  DestYOrg     WORD
;   4  lpClipRect   DWORD
;   5  lpString     DWORD
;   6  Count        WORD
;   7  lpFontInfo   DWORD
;   8  lpDrawMode   DWORD
;   9  lpTextXForm  DWORD
;  10  lpCharWidths DWORD
;  11  lpOpaqueRect DWORD
;  12  Options      WORD
;
; Return:
;   DX:AX = 0000:0000 success
;   DX:AX = 8000:0000 failure
;   If Count < 0: DX:AX = Yext:Xext (packed)   (we stub for now)
; ---------------------------------------------------------------------
ExtTextOut proc far

    push    bp
    mov     bp, sp

    ; Count is the 6th parameter. With FAR call:
    ; [bp+06] = lpDestDev low word
    ; [bp+08] = lpDestDev high word
    ; ...
    ; Offset to Count:
    ;   return IP/CS = 4 bytes
    ;   lpDestDev    = 4  -> total 8
    ;   DestXOrg     = 2  -> 10
    ;   DestYOrg     = 2  -> 12
    ;   lpClipRect   = 4  -> 16
    ;   lpString     = 4  -> 20
    ;   Count        = 2  -> at [bp+20]? careful: bp points to saved bp.
    ;
    ; Layout relative to BP:
    ;   [bp+00] saved BP
    ;   [bp+02] return IP
    ;   [bp+04] return CS
    ;   [bp+06] param1 low  (lpDestDev low)
    ;
    ; So Count is at:
    ;   +06 lpDestDev (4) -> +10
    ;   +0A DestXOrg (2)  -> +12
    ;   +0C DestYOrg (2)  -> +14
    ;   +0E lpClipRect(4) -> +18
    ;   +12 lpString(4)   -> +22
    ;   +16 Count(2)      -> [bp+16]
    ;
    mov     ax, [bp+16]     ; AX = Count
    or      ax, ax
    jns     short eto_draw

    ; ---- Count < 0: extents request ----
    ; Phase 1: we don't compute extents yet. Return failure for now.
    ; Later: call Text_ExtentsPlantronics with same params.
    mov     dx, 8000h
    xor     ax, ax
    jmp     short eto_exit

eto_draw:
    ; Delegate to core implementation (FAR PASCAL).
    ; Core should read parameters directly from our stack frame.
    ; Simplest approach: just call it and return its DX:AX.
    call    Text_RenderStringPlantronics

eto_exit:
    mov     sp, bp
    pop     bp
    retf    40              ; pop 40 bytes of parameters (12 params)

ExtTextOut endp


_TEXT ends
end
