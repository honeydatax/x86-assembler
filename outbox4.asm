; programa to exit out of dosbox on  use in int 16h

push offset MSG
call print

call waitkey

call outbox4

call exit

proc outbox4
XOR AX,AX
jmp far  0f000h:0fff0h
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
