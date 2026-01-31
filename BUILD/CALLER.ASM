; CALLER.ASM - MASM 5.1 friendly
; Builds a small DOS EXE, calls FAR PASCAL routine, exits with AL as ERRORLEVEL.

.286
.MODEL small
.STACK 256

EXTRN AddWords:FAR PROC

.CODE
start:
        mov ax, @data
        mov ds, ax

        ; PASCAL pushes args left-to-right (a then b)
        push 2
        push 3
        call AddWords         ; FAR call, AX should be 5

        mov ah, 4Ch
        int 21h

END start
