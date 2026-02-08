; =====================================================================
; TEXT_CORE.ASM
; Core text renderer for Plantronics - Phase 1 stub
;
; For now: returns success (caller-clean: does NOT pop ExtTextOut args).
; Later: implement rendering and keep hottest loops in separate module.
; =====================================================================

.186
.model large

public  Text_RenderStringPlantronics

_TEXT segment word public 'CODE'
assume cs:_TEXT

Text_RenderStringPlantronics proc far
    ; Phase 1: pretend success
    xor ax, ax          ; AX=0
    xor dx, dx          ; DX=0   => DX:AX = 0000:0000 success

    retf                ; Win3 display driver exports are caller-clean
Text_RenderStringPlantronics endp

_TEXT ends
end
