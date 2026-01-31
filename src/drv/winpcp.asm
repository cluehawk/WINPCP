; winpcp.asm - top-level module and common stubs
; Assemble with MASM 5/6 in Win3 DDK environment.

.MODEL  LARGE, PASCAL
.286

PUBLIC  Enable, Disable, Inquire, Control, DeviceMode
PUBLIC  BitBlt, PatBlt, Pixel, LineTo, ScanLR
PUBLIC  StrBlt, ExtTextOut
PUBLIC  SetCursor, MoveCursor, CheckCursor

_TEXT SEGMENT WORD PUBLIC 'CODE'

; ----------------------------------------------------------------------
; Minimal success/fail conventions:
; Many Win3 driver calls return AX = 1 for success, 0 for failure.
; We'll refine per function once we compare with CGA/TANDY.
; ----------------------------------------------------------------------

RET_SUCCESS MACRO
    mov ax,1
    ret
ENDM

RET_FAIL MACRO
    xor ax,ax
    ret
ENDM

; ----------------------------------------------------------------------
; Stubs (wire real implementations later)
; ----------------------------------------------------------------------

Enable PROC FAR
    ; TODO: initialize device, set mode, return pointer(s) expected by GDI
    RET_SUCCESS
Enable ENDP

Disable PROC FAR
    ; TODO: restore mode, cleanup
    RET_SUCCESS
Disable ENDP

Inquire PROC FAR
    ; TODO: return cursor/capability info as expected by GDI
    RET_SUCCESS
Inquire ENDP

Control PROC FAR
    ; TODO: handle escape/control codes
    RET_FAIL
Control ENDP

DeviceMode PROC FAR
    ; TODO: optional config UI; can be stubbed
    RET_SUCCESS
DeviceMode ENDP


BitBlt PROC FAR
    RET_FAIL
BitBlt ENDP

PatBlt PROC FAR
    RET_FAIL
PatBlt ENDP

Pixel PROC FAR
    RET_FAIL
Pixel ENDP

LineTo PROC FAR
    RET_FAIL
LineTo ENDP

ScanLR PROC FAR
    RET_FAIL
ScanLR ENDP

; StrBlt is a wrapper in TANDYDSP that pushes 0s and tail-calls ExtTextOut.
; We'll keep that behavior once we implement ExtTextOut.
StrBlt PROC FAR
    ; TODO: translate StrBlt args into ExtTextOut call signature
    RET_FAIL
StrBlt ENDP

ExtTextOut PROC FAR
    RET_FAIL
ExtTextOut ENDP

SetCursor PROC FAR
    RET_SUCCESS
SetCursor ENDP

MoveCursor PROC FAR
    RET_SUCCESS
MoveCursor ENDP

CheckCursor PROC FAR
    RET_SUCCESS
CheckCursor ENDP

_TEXT ENDS
END
