; programa to exit out of dosbox on  use in int 19h

push offset MSG
call print

call waitkey

call outbox

call exit

proc outbox
XOR AX,AX
int 19h
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
