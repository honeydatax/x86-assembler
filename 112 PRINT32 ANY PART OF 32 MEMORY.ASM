JMP MAIN                
sourcetext resd 1
destenytext resd 1
main:                
                
mov si,offset text1+1
mov ax,cs
call mem32
                
mov esi,eax
mov ecx,16
mov ax,1                
                
                
for1:                
mov x,al                
mov y,al                
call print32
inc ax                
cmp ax,16
JB FOR1                
                
                
                
exitdo:                
                
                
exit:                
int 20h                
xor ah,ah
int 21h                
RET                
                
                
                
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
RET                
                
                
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
JNZ FILL3211
inc edx                
fill3211:
fill321:                
mov ds:[edi],al
clc                
add edi,edx
dec ecx                
JNZ FILL321:
pop ds                
pop ebp                
pop edi                
pop esi                
pop edx                
pop ecx                 
pop ebx                
pop eax                
RET                
                
                
                
                
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
JNZ COPYMEM3211
inc edx                
copymem3211:
cmp ecx,0
JZ COPYMEM326
copymem321:
mov al,ds:[esi]
mov ds:[edi],al
clc                
add edi,edx
inc esi                
dec ecx                
JNZ COPYMEM321:
copymem326:
pop ds                
pop ebp                
pop edi                
pop esi                
pop edx                
pop ecx                 
pop ebx                
pop eax                
RET                
                
                
                
mem32:                
push esi                
                
and eax,0ffffh
clc                
shl eax,4
and esi,0ffffh
clc                 
add eax,esi
                
pop esi                
RET                
                
                
                
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
RET                
                
                
print32:                
push eax                
push ebx                
push ecx                
push edx                
push esi                
push edi                
push ebp                
cmp ecx,0
JZ PRINT3213
mov al,x                
mov bl,y                
and ax,0ffh
and bx,0ffh
call gotoxy
mov edi,eax
cmp ecx,255
JB PRINT3212
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
JB PRINT328
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
JB PRINT328
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
RET                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
endf   db " "
                
                
                
                
                
                
                
                
                
                
