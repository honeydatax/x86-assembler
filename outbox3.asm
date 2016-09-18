; programa to exit out of dosbox on  use in int 16h

push offset MSG
call print

call waitkey

call outbox3

call exit

proc outbox3
mov ah,42h
mov al,1
int 15h
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
