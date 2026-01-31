; CPU_ABS.INC
; Define V20_OK for Phase 1 builds

IFDEF V20_OK
  PROLOG MACRO locals
    enter locals, 0
  ENDM
  EPILOG MACRO
    leave
  ENDM

  PUSHI MACRO imm
    push imm
  ENDM

  SAVEALL MACRO
    pusha
  ENDM
  RESTALL MACRO
    popa
  ENDM

  SHLI MACRO reg, cnt
    shl reg, cnt
  ENDM

  IMULI MACRO reg, src, imm
    imul reg, src, imm
  ENDM
ELSE
  PROLOG MACRO locals
    push bp
    mov  bp, sp
    IF locals
      sub sp, locals
    ENDIF
  ENDM
  EPILOG MACRO
    mov sp, bp
    pop bp
  ENDM

  PUSHI MACRO imm
    mov ax, imm
    push ax
  ENDM

  ; Prefer saving only what you need on 8086 builds.
  SAVEALL MACRO
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
  ENDM
  RESTALL MACRO
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
  ENDM

  SHLI MACRO reg, cnt
    IF cnt EQ 1
      shl reg, 1
    ELSE
      mov cl, cnt
      shl reg, cl
    ENDIF
  ENDM

  ; 8086: no IMUL imm form — replace per-usage later (shift/add).
  IMULI MACRO reg, src, imm
    ; placeholder - force a build error if used without rewrite
    .ERR <IMULI used in 8086 build>
  ENDM
ENDIF
