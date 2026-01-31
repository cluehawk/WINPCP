; =====================================================================
; TEXT_ENTRY.ASM
; Win3 display driver text entrypoints:
;   - StrBlt (ordinal 11)
;   - ExtTextOut (ordinal 14)
;
; Phase 1 baseline: NEC V20 allowed (.186)
; Calling convention: FAR PASCAL (callee pops args using RETF n)
; =====================================================================

.186
.model large

public  StrBlt
public  ExtTextOut

extrn   Text_RenderStringPlantronics:FAR

_TEXT segment word public 'CODE'
assume cs:_TEXT

; ---------------------------------------------------------------------
; StrBlt tailcalls ExtTextOut after pushing ExtTextOut extras:
;   lpCharWidths : DWORD = 0
;   lpOpaqueRect : DWORD = 0
;   Options      : WORD  = 0
; ---------------------------------------------------------------------
StrBlt proc far
    ; Preserve original FAR return address
    pop     cx              ; return IP
    pop     bx              ; return CS

    xor     ax, ax

    ; lpCharWidths (DWORD) = 0
    push    ax
    push    ax

    ; lpOpaqueRect (DWORD) = 0
    push    ax
    push    ax

    ; Options (WORD) = 0
    push    ax

    ; Restore return address
    push    bx              ; CS
    push    cx              ; IP

    jmp     ExtTextOut
StrBlt endp

; ---------------------------------------------------------------------
; ExtTextOut wrapper:
; - checks Count
; - if Count < 0: return failure for now
; - else: tail-jump into core implementation
;
; FAR stack layout with BP frame:
;   [bp+00] saved BP
;   [bp+02] return IP
;   [bp+04] return CS
;   [bp+06] lpDestDev (DWORD)     (low/high)
;   [bp+10] DestXOrg  (WORD)
;   [bp+12] DestYOrg  (WORD)
;   [bp+14] lpClipRect (DWORD)
;   [bp+18] lpString   (DWORD)
;   [bp+22] Count      (WORD)   <-- THIS IS THE IMPORTANT FIX
;   ... (rest)
; ---------------------------------------------------------------------
ExtTextOut proc far
    push    bp
    mov     bp, sp

    mov     ax, [bp+22]     ; Count (FIXED)
    or      ax, ax
    jns     short eto_draw

    ; Count < 0: extents request (Phase 1: not supported yet)
    mov     dx, 8000h
    xor     ax, ax

    mov     sp, bp
    pop     bp
    retf    40

eto_draw:
    ; Tailcall into core (core will retf 40)
    mov     sp, bp
    pop     bp
    jmp     Text_RenderStringPlantronics
ExtTextOut endp

_TEXT ends
end
