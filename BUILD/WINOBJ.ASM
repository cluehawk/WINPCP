; WINOBJ.ASM
; Minimal Windows-style callable routine:
; FAR + PASCAL calling convention (callee pops args)

; WINOBJ.ASM - MASM 5.1 friendly (uses BP for stack args)

.286
.MODEL large, PASCAL

.CODE
PUBLIC AddWords

AddWords PROC FAR
        push bp
        mov  bp, sp

        ; FAR call stack layout after "push bp / mov bp,sp":
        ; [bp+0]  saved BP
        ; [bp+2]  return IP
        ; [bp+4]  return CS
        ; [bp+6]  a
        ; [bp+8]  b

        mov  ax, [bp+6]
        add  ax, [bp+8]

        pop  bp
        retf 4              ; pop args (2 words)
AddWords ENDP

END
