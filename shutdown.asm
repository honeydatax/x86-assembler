; programa to exit out of dosbox on  use in int 16h

push offset MSG
call print

call waitkey

call outbox5

call exit

proc outbox5
MOV     AX,5300h
MOV     BX,0000h
INT     15h
MOV     AX,5301h
MOV     BX,0000h
INT     15h
MOV     AX,5304h
MOV     BX,0000h
INT     15h
MOV     AX,5308h
MOV     BX,0001h
MOV     CX,0001h
INT     15h
MOV     AX,5307h
MOV     BX,0001h
MOV     CX,0003h
INT     15h
endproc


proc waitkey

XOR ah,ah
int 16h

endproc


proc print(word address)
mov DX,address
mov ah,9
int 21h
pop DX
pop BX
add sp,2
push BX
push dx
endproc 



proc exit

int 20h
endproc

MSG dB "press a key to exit$"
kebout dB "exit", 13,0,0,0,0,0,0,0,0
