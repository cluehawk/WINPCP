; =====================================================================
; WINPCP.ASM - top-level build file
; Builds a single .OBJ by including project modules.
; Phase 1: NEC V20 allowed (.186)
; =====================================================================

.186
.model large, pascal

; Put shared equates/includes here later if needed:
; include ..\inc\whatever.inc

include ..\src\STUBS.ASM
include ..\src\text\TEXT_ENTRY.ASM
include ..\src\text\TEXT_CORE.ASM

end
