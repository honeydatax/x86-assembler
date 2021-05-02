jmp head
error resb 1
c1 resw 1
ad1 resd 1
ad2 resd 1
ad3 resd 1
ad4 resd 1
ad5 resd 1
srce resw 1
values resw 1
xx resw 1
yy resw 1
NN resw 1
msg db "im love marina",0
file db "marina.txt",0
NOP
NOP 

head:
;function to get a 64kb SS stack segment
call sp64k
init:
;return from sp64k 

;call main subrotine
call main
;exit
call exit

proc main
call cls
mov xx,5
mov yy,5
mov ad1,0120000h

push CS
push offset endf
call a32
add sp,2*2



mov ad2,eax

push CS
push offset quit
call a32
add sp,2*2



mov ad3,eax



push CS
push offset ssps
call a32
add sp,2*2



mov ad4,eax
mov ad5,eax
CLC 





push ad1
push ad2
push dword 50
push word 1
call step
add sp,3*4+2

push word xx
push word yy
push dword ad1
push word 50
call print
add sp,3*2+4

push dword ad3
call jmp32
add sp,4
mov ad3,eax

push dword ad1
call jmp32
add sp,4
mov ad1,eax

mov ebx,ad1
mov eax,ad3
CLI
jmp ebx



endproc



call exit 


quit dB 90h
sti
proc exit
int 20h
ret
endproc


proc fillw(dword adress,dword counter,word value)

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


endproc



proc step(dword adress,dword source ,dword counter,word st)

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


endproc



proc copy(dword adress, dword counter,word source,word st)

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


endproc

proc gotoxy(word x,word y)

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


endproc


proc print(word x,word y, dword adress,word counter)

push word x
push word y
call gotoxy
add sp,2*2

mov ebx,eax

mov AX,counter
shl eax,16
shr eax,16


push  ebx
push dword adress
push eax
push word 2
call step
add sp,4*3+2

endproc


proc a32(word seg,word offs)
mov AX,seg
mov BX,offs
shl eax,16
shr eax,12
shl ebx,16
shr ebx,16
CLC 
add eax,ebx

endproc

proc sp64k
mov AX,CS
mov BX,1000h
add AX,BX
mov ss,ax
mov AX,0FFFfh
mov sp,AX
inc AX
push ax
jmp init
endproc

proc creat(word fname,word attr)
push ds
mov AX,CS
mov DS,AX
mov cX, attr
mov DX,fname

        mov ah,3ch
int 21h
jnc createrror
mov error,1
jmp createrrors:
createrror:
mov error,0
createrrors:
pop ds
endproc

proc open(word fname,word attr)

push ds
mov AX,CS
mov DS,AX
mov aX, attr
mov DX,fname

        mov ah,3dh
int 21h

jnc openerror
mov error,1
jmp openerrors:
openerror:
mov error,0
openerrors:
pop ds

endproc

proc close(word fhandler)
mov BX,fhandler
        mov ah,3eh
int 21h
endproc

proc read(word fhandler,word counter)
push ds

mov AX,ss
mov dX,1000h


CLC
add DX,ax
push DX
pop DS
XOR DX,DX
mov CX,counter
mov BX,fhandler
        mov ah,3fh
int 21h
pop ds
endproc

proc write(word fhandler,word counter)
push ds

mov AX,ss
mov dX,1000h


CLC
add DX,ax
push DX
pop DS
XOR DX,DX
mov CX,counter
mov BX,fhandler
        mov ah,40h
int 21h

pop ds
endproc


proc diskarea
mov AX,ss
mov dX,1000h
CLC
add AX,dx
push AX
push word 0
call a32
add sp,2*2
endproc



proc into32(word value)
;convert a 16 bits var into a 32 bits var
mov ax,value
CLC 
shl eax,16
shr eax,16
endproc



proc CLS


push dword 0b8000h
push dword 80*25
push word 7020h
call fillw
add sp,2*4+2

endproc

proc jmp32(dword addrs)
mov AX,cs
mov eBX,addrs
shl eax,16
shr eax,12
CLC 
sub ebx,eax
mov eax,ebx
endproc

endf dB 90h
jmp eax
ssps dd 0,0
msg3 db "im love marina",0,0,0,0,0,0,0,0,0,0





