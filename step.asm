c1 resd 1
ad1 resd 1
srce resd 1
values resw 1


mov dword c1,6
mov dword ad1,0b8000h
mov dword srce,0
mov values,2

mov AX,CS
clc
shl eax,16
clc
shr eax,12
mov ebx,eax
mov AX,offset MSG 
CLC
shl eax,16
clc
shr eax,16


CLC
add eax,ebx
mov dword srce,eax


FFF:

push dword ad1
push dword srce
push dword c1
push word values
call step

clc
add dword ad1,10
CMP ad1,0b8000h+(80*25*2)
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


