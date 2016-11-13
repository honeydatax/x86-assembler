jmp main
sourcetext resd 1
destenytext resd 1
main:

mov si,offset text1+1
mov ax,cs
call mem32

mov esi,eax
mov ecx,16
mov ax,0


for1:
mov x,al
mov y,al
call print32
inc ax
cmp ax,16
jb for1

call scrollup


exitdo:


exit:
int 20h
xor ah,ah
int 21h
ret



text1    db   15,"im love marina.",0




x     db 0     
y     db 0
color dw 07h

print:
push ax
push bx
push cx
push dx
push di
push si
push bp
push es
mov ax,cs
mov es,ax
xchg dx,bp 
mov bx,bp
mov cl,cs:[bx]
inc bp
and cx,0ffh 
mov bx,offset x
mov dx,cs:[bx]
mov bx,offset color
mov al,cs:[bx]
mov bl,al
mov bh,0
mov al,0
mov ah,13h
int 10h
pop es
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret


fill32:
push eax
push ebx
push ecx
push edx
push esi
push edi
push ebp
push ds
mov bp,0
mov ds,bp
cmp edx,0
jnz fill3211
inc edx
fill3211:
fill321:
mov ds:[edi],al
clc
add edi,edx
dec ecx
jnz fill321:
pop ds
pop ebp
pop edi
pop esi
pop edx
pop ecx 
pop ebx
pop eax
ret




copymem32:
push eax
push ebx
push ecx
push edx
push esi
push edi
push ebp
push ds
mov bp,0
mov ds,bp
cmp edx,0
jnz copymem3211
inc edx
copymem3211:
cmp ecx,0
jz copymem326
copymem321:
mov al,ds:[esi]
mov ds:[edi],al
clc
add edi,edx
inc esi
dec ecx
jnz copymem321:
copymem326:
pop ds
pop ebp
pop edi
pop esi
pop edx
pop ecx 
pop ebx
pop eax
ret



mem32:
push esi

and eax,0ffffh
clc
shl eax,4
and esi,0ffffh
clc 
add eax,esi

pop esi
ret



gotoxy:
push ebx
push ecx
push edx
push esi
push edi
push ebp
mov si,ax
mov di,bx
and si,0fffh
and di,0fffh
xor cx,cx
xor dx,dx
mov ax,si
mov bx,2
clc
mul bx
mov si,ax
mov ax,di
mov bx,160
clc
mul bx
mov bx,si
clc
add ax,bx
and eax,0ffffh
mov ebx,0b8000h
clc
add eax,ebx
pop ebp
pop edi
pop esi
pop edx
pop ecx 
pop ebx
ret


print32:
push eax
push ebx
push ecx
push edx
push esi
push edi
push ebp
cmp ecx,0
jz print3213
mov al,x
mov bl,y
and ax,0ffh
and bx,0ffh
call gotoxy
mov edi,eax
cmp ecx,255
jb print3212
mov ebx,255
print3212:
mov edx,2
call copymem32 
mov al,x
mov bl,y
and ax,0ffh
and bx,0ffh
mov si,bx
clc
add ax,cx
cmp ax,80
jb print328
mov bx,80
sub ax,bx
xor dx,dx
xor cx,cx
mov bx,80
clc
div bx
clc
add ax,si
cmp ax,24
jb print328
mov ax,24
print328:
mov y,ax
mov x,dx 
print3213:
pop ebp
pop edi
pop esi
pop edx
pop ecx 
pop ebx
pop eax
ret

scrollup:
push eax
push ebx
push ecx
push edx
push esi
push edi
push ebp
push ds
mov ax,0
mov ds,ax
mov edi,0b8000h
mov esi,0b8000h+160  
mov ecx,80*24*2
mov edx,1
call copymem32
pop ds
pop ebp
pop edi
pop esi
pop edx
pop ecx 
pop ebx
pop eax
ret

















endf   db " "










