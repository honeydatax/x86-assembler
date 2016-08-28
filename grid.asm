jmp head

c1 resd 1
ad1 resd 1
srce resw 1
values resw 1
xx resw 1
yy resw 1
NN resw 1

head:
mov AX,CS
mov BX,1000h
add AX,BX
mov ss,ax



mov dword c1,80
mov dword ad1,0
mov word srce,0fh
mov word values,2

mov word yy,0



FFF:
mov word xx,0
fff1:

push xx
push yy
call gotoxy


inc eax
mov ad1,eax


push dword ad1
push dword c1
push word srce
push word values
call copy



add srce,10h
CMP srce,20h
JB nlin
mov srce,0fh
nlin:
clc 
add xx,10
CMP xx, 70
JB fff1
inc yy
CMP yy,23
JB fff


call exit




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

proc gotoxy(word x,word y)
push BX
push CX
push DX
push si
push di
push DS
mov AX,y
mov BX,160
XOR DX,DX
XOR CX,CX
CLC
imul bx
mov BX,x
CLC
add BX,BX
CLC
add AX,BX
mov ebx,0b8000h
CLC 
shl eax,16
CLC
shr eax,16
CLC 
add eax ,ebx


pop ds
pop di 
pop si
pop dx
pop CX 
pop BX

endproc

