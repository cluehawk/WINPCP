; TEST.ASM - minimal DOS EXE (small model) that just exits

.286
.MODEL small
.STACK 256

.CODE
start:
        mov ax, 4C00h
        int 21h

END start
