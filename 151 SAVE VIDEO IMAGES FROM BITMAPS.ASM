jmp stack
xx resw 1
yy resw 1
main:

call text

mov byte x,10
mov byte y,10

mov ax,cs
mov bx,2000h
clc 
add ax,bx

push ds
mov ds,ax
mov di,0
mov si,offset file1
mov ax,cs
call loadbitmap
pop ds
cmp ax,0ffffh
jz error1:
push ds
push es

mov ax,cs
mov bx,2000h
clc
add ax,bx
mov ds,ax
mov bx,1000h
clc 
add ax,bx
mov es,ax

mov ax,cs
mov si,offset file2
call save13
pop es
pop ds
cmp ax,0ffffh
jz error1:



jmp escerror
error1:
mov dx,offset text1
call print 
escerror:

exitdo:


exit:
int 20h
xor ah,ah
int 21h
ret


file1    db   "128.bmp",0
file2    db   "128.v13",0
text1    db  18,"error open a files.",0


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

stack:
mov ax,cs
mov bx,1000h
clc 
add ax,bx
mov ss,ax
jmp main
ret


creat16:
push cx
push dx
mov dx,si
xor cx,cx
mov ah,3ch
int 21h
pop dx 
pop cx
ret




close16:
push bx
mov bx,di
mov ah,3eh
int 21h
pop bx
ret


write16:
push bx
push dx
mov dx,si
mov bx,di
mov ah,40h
int 21h
pop dx 
pop bx
ret


read16:
push bx
push dx
mov dx,si
mov bx,di
mov ah,3fh
int 21h
pop dx 
pop bx
ret


open16:
push cx
push dx
mov dx,si
mov al,2
mov ah,3dh
clc
int 21h
jnc open163
mov ax,0ffffh
open163:
pop dx 
pop cx
ret


graphics:
push ax
mov ax,13h
int 10h
pop ax
ret

text:
push ax
mov ax,3
int 10h
pop ax
ret


getkey:
mov ax,0
int 16h
ret


setpalete:
push eax
push ebx
push ecx
push edx
push edi
push esi
mov eax,esi
mov ebx,256*3
clc
add eax,ebx
mov edi,eax
mov dx,03c8h
mov al,0
out dx,al
inc dx
setpalete2:
mov al,ds:[esi]
out dx,al
inc esi
cmp esi,edi
jb setpalete2
pop esi 
pop edi
pop edx
pop ecx
pop ebx
pop eax
ret



getrgb:
mov bl,al
mov ah,al
and bl,11000000b
and al,00000111b
and ah,00111000b
clc
shr bl,2
clc
shl al,3
ret

storergb:
mov ds:[edi],al
inc edi
mov ds:[edi],ah
inc edi
mov ds:[edi],bl
inc edi
ret


creatpallet:
push ax
push bx
push cx
push dx
mov edi,esi
mov cx,0
creatpallet1:
mov al,cl
call getrgb
call storergb
inc cx
cmp cx,256
jb creatpallet1
call setpalete
mov edi,esi
pop dx
pop cx
pop bx
pop ax
ret


loadbitmap:
push bx
push cx
push dx
push di
push si
push bp
push ds
mov ds,ax
call open16
pop ds
cmp ax,0ffffh
jz loadbitmap1
xchg si,di
mov dx,si
mov di,ax
mov cx,1024*63
call read16
call close16
mov si,dx
mov al,ds:[si]
cmp al,'B'
jnz loadbitmap2
inc si
mov al,ds:[si]
cmp al,'M'
jnz loadbitmap2
inc si
mov eax,ds:[si]
cmp eax,63*1024
ja loadbitmap2
mov bx,16
clc
add si,bx
mov eax,ds:[si]
cmp eax,319
ja loadbitmap2
inc si
inc si
inc si
inc si
mov eax,ds:[si]
cmp eax,199
ja loadbitmap2
inc si
inc si
inc si
inc si
mov ax,ds:[si]
cmp ax,1
jnz loadbitmap2
inc si
inc si
mov ax,ds:[si]
cmp ax,24
jnz loadbitmap2
inc si
inc si
mov eax,ds:[si]
cmp eax,0
jnz loadbitmap2
inc si
inc si
inc si
inc si
mov eax,ds:[si]
cmp eax,63*1024
ja loadbitmap2
jmp loadbitmap1
loadbitmap2:
mov ax,0ffffh
loadbitmap1:


pop bp
pop si
pop di
pop dx
pop cx
pop bx
ret


drawbitmap:
push bx
push cx
push dx
push di
push si
push bp
jmp drawbitmap9
drawbitmapbit resb 1
drawbitmapw   resw 1
drawbitmaph   resw 1
drawbitmapxcopy resw 1
drawbitmapx   resw 1
drawbitmapy   resw 1
drawbitmapline resw 1
drawbitmapstart resw 1
drawbitmappoint resw 1
drawbitmapreturn resw 1
drawbitmap9:
mov cs:drawbitmapx,ax
mov cs:drawbitmapy,bx
mov si,0
mov al,ds:[si]
cmp al,'B'
jnz drawbitmap12
inc si
mov al,ds:[si]
cmp al,'M'
jnz drawbitmap12
inc si
mov eax,ds:[si]
cmp eax,63*1024
ja drawbitmap12
mov bx,16
clc
add si,bx
mov eax,ds:[si]
cmp eax,319
ja drawbitmap12
inc si
inc si
inc si
inc si
mov eax,ds:[si]
cmp eax,199
ja drawbitmap12
inc si
inc si
inc si
inc si
mov ax,ds:[si]
cmp ax,1
jnz drawbitmap12
inc si
inc si
mov ax,ds:[si]
cmp ax,24
jnz drawbitmap12
inc si
inc si
mov eax,ds:[si]
cmp eax,0
jnz drawbitmap12
inc si
inc si
inc si
inc si
mov eax,ds:[si]
cmp eax,63*1024
ja drawbitmap12
mov cs:drawbitmapbit,1
mov si,18
mov ax,ds:[si]
mov cs:drawbitmapw,ax
cmp ax,2
jz  drawbitmap10
cmp ax,4
jz  drawbitmap10
cmp ax,8
jz  drawbitmap10
cmp ax,16
jz  drawbitmap10
cmp ax,32
jz  drawbitmap10
cmp ax,64
jz  drawbitmap10
cmp ax,128
jz  drawbitmap10
cmp ax,256
jz  drawbitmap10
jmp drawbitmap11:
drawbitmap10:
mov cs:drawbitmapbit,0
drawbitmap11:
mov si,22
mov ax,ds:[si]
mov drawbitmaph,ax
mov si,10
mov ax,ds:[si]
mov cs:drawbitmapstart,ax
mov ax,cs:drawbitmapy
mov bx,cs:drawbitmaph
clc
add ax,bx
xor dx,dx
xor cx,cx
mov bx,320
clc
mul bx
mov bx,cs:drawbitmapx
clc
add ax,bx
mov cs:drawbitmappoint,ax
mov ax,320
mov bx,cs:drawbitmapw
clc
add ax,bx 
mov cs:drawbitmapreturn,ax

mov si,cs:drawbitmapstart
mov di,cs:drawbitmappoint
mov bh,cs:drawbitmapbit
mov dx,cs:drawbitmapreturn


drawbitmap91:
mov ax,cs:drawbitmapw
mov cs:drawbitmapxcopy,ax 
drawbitmap90:
mov al,ds:[si]
inc si
mov ah,ds:[si]
inc si
mov bl,ds:[si]
inc si
and al,11000000b
and ah,11100000b
and bl,11100000b
shr ah,2
shr bl,5
or al,ah
or al,bl
mov es:[di],al
inc di
dec cs:drawbitmapxcopy
cmp cs:drawbitmapxcopy,0
jnz drawbitmap90
clc
sub di,dx
cmp bh,0
jz drawbitmap92
inc si
drawbitmap92:
dec cs:drawbitmaph
cmp cs:drawbitmaph,0
jnz drawbitmap91


jmp drawbitmap13
drawbitmap12:
mov ax,0ffffh
drawbitmap13:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
ret


save13:
push bx
push cx
push dx
push di
push si
push bp
push ds
push es
jmp save139
save13bit resb 1
save13w   resw 1
save13h   resw 1
save13xcopy resw 1
save13x   resw 1
save13y   resw 1
save13line resw 1
save13start resw 1
save13point resw 1
save13return resw 1
save13si resw 1
save1313size resw 1
save139:
mov cs:save13si,si
mov cs:save13x,ax
mov si,0
mov al,ds:[si]
cmp al,'B'
jnz save1312
inc si
mov al,ds:[si]
cmp al,'M'
jnz save1312
inc si
mov eax,ds:[si]
cmp eax,63*1024
ja save1312
mov bx,16
clc
add si,bx
mov eax,ds:[si]
cmp eax,319
ja save1312
inc si
inc si
inc si
inc si
mov eax,ds:[si]
cmp eax,199
ja save1312
inc si
inc si
inc si
inc si
mov ax,ds:[si]
cmp ax,1
jnz save1312
inc si
inc si
mov ax,ds:[si]
cmp ax,24
jnz save1312
inc si
inc si
mov eax,ds:[si]
cmp eax,0
jnz save1312
inc si
inc si
inc si
inc si
mov eax,ds:[si]
cmp eax,63*1024
ja save1312
mov cs:save13bit,1
mov si,18
mov ax,ds:[si]
mov cs:save13w,ax
cmp ax,2
jz  save1310
cmp ax,4
jz  save1310
cmp ax,8
jz  save1310
cmp ax,16
jz  save1310
cmp ax,32
jz  save1310
cmp ax,64
jz  save1310
cmp ax,128
jz  save1310
cmp ax,256
jz  save1310
jmp save1311:
save1310:
mov cs:save13bit,0
save1311:
mov si,22
mov ax,ds:[si]
mov cs:save13h,ax
mov ax,cs:save13h
mov bx,cs:save13w
xor dx,dx
xor cx,cx
clc
mul bx
mov bx,6
clc
add ax,bx
mov cs:save1313size,ax
mov si,10
mov ax,ds:[si]
mov cs:save13start,ax
mov di,0
mov al,'X'
mov es:[di],al
inc di
mov al,'Y'
mov es:[di],al
inc di
mov ax,cs:save13w
mov es:[di],ax
inc di
inc di
mov ax,cs:save13h
mov es:[di],ax
mov bh,cs:save13bit
mov si,cs:save13start
mov di,cs:save1313size


save1391:
mov ax,cs:save13w
mov cs:save13xcopy,ax 
save1390:
mov al,ds:[si]
inc si
mov ah,ds:[si]
inc si
mov bl,ds:[si]
inc si
and al,11000000b
and ah,11100000b
and bl,11100000b
shr ah,2
shr bl,5
or al,ah
or al,bl
mov es:[di],al
dec di
dec cs:save13xcopy
cmp cs:save13xcopy,0
jnz save1390
clc
cmp bh,0
jz save1392
inc si
save1392:
dec cs:save13h
cmp cs:save13h,0
jnz save1391


mov si,cs:save13si
push ds
mov ax,cs:save13x
mov ds,ax
call creat16
jc save13125
mov di,ax
mov ax,es
mov ds,ax
mov si,0
mov cx,cs:save1313size
call write16
pop ds 
call close16
jmp save1313
save13125:
pop es
pop ds
save1312:
mov ax,0ffffh
save1313:
pop es
pop ds
pop bp
pop si
pop di
pop dx
pop cx
pop bx
ret











endf   db " "










