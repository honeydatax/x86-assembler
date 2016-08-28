c1 resd 1
ad1 resd 1
srce resw 1
values resw 1


mov dword c1,80
mov dword ad1,0b8001h
mov word srce,0fh
mov word values,2

FFF:
push dword ad1

push dword c1
push word srce
push word values
call copy

add srce,10h
add ad1,160
CMP srce,180h
JB fff


call exit 

 MSG dB "marina"

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



proc step(dword adress,dword source ,dword counter,word st)
push AX
push BX
push CX
push DX
push si
push di
push DS
XOR AX,AX
mov DS,ax
mov edi,source
mov esi,adress
mov ecx,counter
mov BX,st
shl ebx,16
shr ebx,16
steprotina:
mov al,DS:[edi]
mov DS:[esi],al
inc edi
CLC 
add esi,ebx
dec ecx
CMP ecx,0 
jnz steprotina

pop ds
pop di 
pop si
pop dx
pop CX 
pop BX
pop ax

endproc



proc copy(dword adress, dword counter,word source,word st)
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
mov BX,st
shl ebx,16
shr ebx,16
mov ax,source
copyrotina:
mov DS:[esi],al

CLC 
add esi,ebx
dec ecx
CMP ecx,0 
jnz copyrotina

pop ds
pop di 
pop si
pop dx
pop CX 
pop BX
pop ax

endproc



