; =====================================================================
; WINPCP.ASM - top-level build file
; Builds a single .OBJ by including project modules.
; Phase 1: NEC V20 allowed (.186)
; =====================================================================

.186
.model large, pascal
.stack 1024

; Put shared equates/includes here later if needed:
; include ..\inc\whatever.inc

include STUBS.ASM
include ..\text\TXTENT.ASM
include ..\text\TXTCORE.ASM

end
