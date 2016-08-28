c1 resw 1

mov c1,10
rotina:


push offset msg
call print
dec c1
CMP c1,0
jnz rotina


call exit

MSG dB "im move marina",13,10,"$"


proc exit
int 20h
ret
endproc

proc print(word texto)
push DX
push ax
mov DX,texto
mov ah,09h
int 21h
pop AX
pop dx
endproc