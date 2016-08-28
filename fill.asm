c1 resd 1
ad1 resd 1
values resw 1


mov dword c1,80*25
mov dword ad1,0b8000h
mov al,'-'
mov ah,4fh
mov word values,ax

push dword ad1
push dword c1
push word values
call fillw



call exit 


proc exit
int 20h
ret
endproc


proc fillw(dword adress,dword counter,word value)
push AX
push BX
push CX
push DX
push si
push di
push DS
XOR AX,AX
mov DS,ax

mov esi,adress
mov ecx,counter
mov AX ,value
rotina:
mov DS:[esi],AX
inc esi
inc esi
dec ecx
CMP ecx,0 
jnz rotina

pop ds
pop di 
pop si
pop dx
pop CX 
pop BX
pop ax

endproc