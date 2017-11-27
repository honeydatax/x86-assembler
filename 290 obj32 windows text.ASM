jmp stack
p1 resd 1
address1 resd 1
address2 resd 1
ty resb 1
ttx resb 1
tty resb 1
main:
call startmem





mov ax,0
mov ds,ax

mov ecx,260*4
call reserves
mov esi,eax
mov al,1
mov ds:[esi],al
inc esi
mov cs:p1,esi
mov cs:address1,esi



mov ecx,16
call reserves

mov ebx,cs:p1
mov ds:[ebx],eax
push eax
push eax



mov ecx,81
call reserves

dec ecx

mov edi,eax
pop esi
inc edi
call settext32
dec edi

mov al,80
mov ds:[edi],al
inc edi
mov ecx,80
mov edx,1
mov ax,0
clc
add al,'0'
call fill32

pop esi
mov al,2
call setx32
mov al,2
call sety32

mov al,17
call setw32

mov al,5
call seth32

mov al,17h
call setcolor32





; -------

mov eax,cs:address1
mov esi,eax


call drawwins32


jmp exitdo

exitdo:


jmp exit



text1 db 15,"im love marina.",0
text2  db "                                                                                                 "
text3  db "                                                                                                 "
text4  db "                                                                                                 "
text5  db "                                                                                                 "
text6  db "                                                                                                 "
text7  db "                                                                                                 "
text8  db "                                                                                                 "
text9  db "                                                                                                 "



rand dw 0
randomize db  " "


;lib start

variantetablesize equ 256*4

varianteblock resb 1
variantetable resw 1
varianteptrpos resw 1

x     db 0     
y     db 0
w    db 0
h     db 0
color db 07h
sstring dd 0
z db 0


exit:
xor ah,ah
int 21h
int 20h
ret


str32:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov eax,cs:[si]
mov ebp,1000000000
str321:
xor edx,edx
xor ecx,ecx
mov ebx,ebp
clc 
div ebx
mov esi,edx
mov ah,'0'
clc
add al,ah
mov cs:[di],al
inc di
mov eax,ebp
xor edx,edx
xor ecx,ecx
mov ebx,10
clc
div ebx
mov ebp,eax
mov eax,esi
cmp ebp,0
jnz str321

pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret







read32:
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
jmp read321
read32addrs1 resd 1
read32addrs2 resd 1
read32counter1 resd 1
read32counter2 resd 1
read32counter3 resd 1
read32output     resd 1
read32f1             resw 1
read32seg1        resw 1
read32seg2        resw 1
read32size         resd 1

read321:

mov cs:read32addrs1,esi
mov cs:read32counter1,ecx
mov cs:read32f1,di
mov cs:read32seg2,0
mov eax,ecx
cmp eax,0
jz read325

xor edx,edx
xor ecx,ecx
mov ebx,0ffffh
clc
div ebx
mov cs:read32counter3,eax
mov cs:read32output,edx
mov ax,cs
mov bx,2000h
clc
add ax,bx
mov cs:read32seg1,ax
mov si,0
call mem32
mov cs:read32addrs2,eax
mov eax,0
mov cs:read32counter2,eax
mov eax,0ffffh
mov cs:read32size,eax
mov eax,cs:read32counter3
cmp eax,0
jz read323
read322:
mov ax,cs:read32seg1
mov ds,ax
mov si,0
mov di,cs:read32f1
mov cx,0ffffh
call read16

mov ax,cs:read32seg2
mov ds,ax
mov ecx,cs:read32size
mov esi,cs:read32addrs2
mov edi,cs:read32addrs1
mov edx,1
call copymem32


mov eax,cs:read32addrs1
mov ebx,cs:read32size 
clc
add eax,ebx
mov cs:read32addrs1,eax
mov eax,cs:read32counter3
dec eax
mov cs:read32counter3,eax
cmp eax,0
jnz read322

read323:
cmp cs:read32output ,0
jz read325
mov ax,cs:read32seg1
mov ds,ax
mov si,0
mov di,cs:read32f1
mov ecx,cs:read32output
call read16
mov ax,cs:read32seg2
mov ds,ax
mov cx,cs:read32output
mov esi,cs:read32addrs2
mov edi,cs:read32addrs1
mov edx,1
call copymem32


read324:
read325:
pop ds
pop ebp
pop edi
pop esi
pop edx
pop ecx 
pop ebx
pop eax
ret




write32:
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
jmp write321
write32addrs1 resd 1
write32addrs2 resd 1
write32counter1 resd 1
write32counter2 resd 1
write32counter3 resd 1
write32output     resd 1
write32f1             resw 1
write32seg1        resw 1
write32seg2        resw 1
write32size         resd 1

write321:

mov cs:write32addrs1,esi
mov cs:write32counter1,ecx
mov cs:write32f1,di
mov ax,0
mov cs:write32seg2,ax
mov eax,ecx
cmp eax,0
jz write325

xor edx,edx
xor ecx,ecx
mov ebx,0ffffh
clc
div ebx
mov cs:write32counter3,eax
mov cs:write32output,edx
mov ax,cs
mov bx,2000h
clc
add ax,bx
mov cs:write32seg1,ax
mov si,0
call mem32
mov cs:write32addrs2,eax
mov eax,0
mov cs:write32counter2,eax
mov eax,0ffffh
mov cs:write32size,eax
mov eax,cs:write32counter3
cmp eax,0
jz write323
write322:

mov ax,cs:write32seg2
mov ds,ax
mov ecx,cs:write32size
mov esi,cs:write32addrs1
mov edi,cs:write32addrs2
mov edx,1
call copymem32
mov ax,cs:write32seg1
mov ds,ax
mov si,0
mov di,cs:write32f1
mov cx,0ffffh
call write16
mov eax,cs:write32addrs1
mov ebx,cs:write32size 
clc
add eax,ebx
mov cs:write32addrs1,eax
mov eax,cs:write32counter3
dec eax
mov cs:write32counter3,eax
cmp eax,0
jnz write322

write323:
cmp cs:write32output ,0
jz write325
mov ax,cs:write32seg2
mov ds,ax
mov ecx,cs:write32output
mov esi,cs:write32addrs1
mov edi,cs:write32addrs2
mov edx,1
call copymem32
mov ax,cs:write32seg1
mov ds,ax
mov si,0
mov di,cs:write32f1
mov cx,cs:write32output
call write16

write324:
write325:
pop ds
pop ebp
pop edi
pop esi
pop edx
pop ecx 
pop ebx
pop eax
ret




fillstrings:
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
cmp ecx,0
jz fillstrings1
cmp eax,0
jz fillstrings1
mov edx,eax
mov ebx,eax
fillstrings2:
mov al,ds:[esi]
mov ds:[edi],al
inc esi
inc edi
dec edx
cmp edx,0
jnz fillstrings3
mov edx,ebx
sub esi,ebx
fillstrings3:
dec ecx
cmp ecx,0
jnz fillstrings2
fillstrings1:
pop ds
pop ebp
pop edi
pop esi
pop edx
pop ecx 
pop ebx
pop eax
ret




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
mov al,cs:x
mov bl,cs:y
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
mov al,cs:x
mov bl,cs:y
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
mov cs:y,al
mov cs:x,dl
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
mov ax,sp
mov bx,500
clc
sub ax,bx
mov di,ax
mov ax,cs
mov bx,1000h
clc 
add ax,bx
mov ds,ax
mov si,0ffffh
stack64:
mov al,cs:[si]
mov ds:[si],al
dec si
cmp si,di
jnz stack64
mov ax,ds
mov ss,ax
mov bx,offset endf
mov cs:variantetable,bx
mov cs:varianteblock,0
mov cx,cs:variantetablesize
clc
add bx,cx
inc bx
mov cs:varianteptrpos,bx
mov ax,cs
mov ds,ax
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


startmem:
push eax
push ebx
push cx
push dx
push di
push si
push bp
push ds
push es
jmp startmem2
startmemadd resd 1
startmemadd2 resd 1
startmem2:
xor ax,ax
mov ds,ax
mov eax,100h
mov ebx,120000h 
clc
add eax,ebx
mov ds:[ebx],eax
pop es
pop ds
pop bp
pop si
pop di
pop dx
pop cx
pop ebx
pop eax
ret


reserves:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
jmp reserves2
reservemem resd 1
reservemem2 resd 1
reserves2:
xor ax,ax
mov ds,ax
mov ebx,120000h 
mov eax,ds:[ebx]
mov edx,eax
clc
add edx,ecx
add edx,4
mov ds:[ebx],edx
mov ebx,eax
mov ds:[ebx],ecx
add eax,4
pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx

ret

twindows:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
jmp ttwindows2
ttwindowsx resd 1
ttwindowsy resd 1
ttwindowsw resd 1
ttwindowsh resd 1
ttwindows2:
xor eax,eax
mov ds,ax
mov al,cs:h
mov cs:ttwindowsh,eax
xor eax,eax
mov al,cs:x
mov cs:ttwindowsx,eax
xor eax,eax
mov al,cs:y
mov cs:ttwindowsy,eax
ttwindows4:
xor eax,eax
mov al,cs:w
mov cs:ttwindowsw,eax
ttwindows5:
mov eax,cs:ttwindowsy
mov ebx,cs:ttwindowsh
clc 
add eax,ebx
mov ebx,160
xor edx,edx
xor ecx,ecx
clc
mul ebx
mov ebx,cs:ttwindowsx
clc
add eax,ebx
clc
add eax,ebx
mov ebx,cs:ttwindowsw
clc
add eax,ebx
clc
add eax,ebx
mov ebx,0b8000h
clc
add eax,ebx
mov ebx,eax
mov al,32
mov ah,cs:color
mov ds:[ebx],ax
mov ecx,cs:ttwindowsw
dec ecx
mov cs:ttwindowsw,ecx
cmp ecx,0ffffffffh
jnz ttwindows5

mov ecx,cs:ttwindowsh
dec ecx
mov cs:ttwindowsh,ecx
cmp ecx,0ffffffffh
jnz ttwindows4







pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx

ret



otwindows:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
jmp ottwindows2
ottwindowsx resd 1
ottwindowsy resd 1
ottwindowsw resd 1
ottwindowsh resd 1
ottwindowsc resd 1
ottwindows2:
xor ax,ax
mov eax,cs:x
push eax
mov al,cs:color
push ax
mov eax,cs:[si]
mov cs:x,eax
mov al,cs:[si+4]
mov cs:color,al
call twindows
pop ax
mov cs:color,al
pop eax
mov cs:x,eax
pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx

ret

setx:
mov cs:[si],al
ret

sety:
mov cs:[si+1],al
ret

setw:
mov cs:[si+2],al
ret

seth:
mov cs:[si+3],al
ret

setcolor:
mov cs:[si+4],al
ret


settext:
mov cs:[si+5],edi
ret



preserve:
push bx
push cx
push dx
push di
push si
push bp
mov bp,sp
mov bx,[bp+12]
mov dx,[bx]
cmp varianteblock,255
jz preserve1
mov si,varianteptrpos
mov ax,si
mov bx,variantetable
mov [bx],dx
inc bx
inc bx
mov [bx],si
clc 
add variantetable,4
mov bx,si
mov [bx],cx
clc 
add ax,cx
mov varianteptrpos,ax
mov ax,si
jmp preserve2:
preserve1:
mov ax,0ffffh
preserve2:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
ret

cls:

push ax
push cx
push bx
push ds
mov ax,0b800h
mov ds,ax
mov cx,80*25
mov bx,0
mov ax,07020h
cls1:
mov ds:[bx],ax
inc bx
inc bx
dec cx
cmp cx,0
jnz cls1
pop ds
pop bx
pop cx
pop ax

ret

print32w:
push eax
push ebx
push ecx
push edx
push esi
push edi
push ebp
cmp ecx,0
jz print32w13
mov al,cs:x
mov bl,cs:y
and ax,0ffh
and bx,0ffh
call gotoxy
mov edi,eax
cmp ecx,255
jb print32w12
mov ebx,255
print32w12:
mov edx,2
call copymem32 
mov al,cs:x
mov bl,cs:y
and ax,0ffh
and bx,0ffh
mov si,bx
clc
add ax,cx
cmp ax,80
jb print32w8
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
jb print32w8
mov ax,24
print32w8:
print32w13:
pop ebp
pop edi
pop esi
pop edx
pop ecx 
pop ebx
pop eax
ret

twprint:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
jmp twprint1
twprintx resb 1
twprinty resb 1
twprintw resb 1
twprinth resb 1
twprintcolor resb 1
twprintdx resb 1
twprintdy resb 1
twprint1:
mov al,cs:x
push ax
mov al,cs:y
push ax
mov al,cs:w
push ax
mov al,cs:color
push ax
mov eax,cs:sstring
push eax



mov ax,cs
call mem32
mov ebx,eax


mov si,offset x
mov ax,cs
call mem32



mov esi,ebx
mov edi,eax
mov ecx,9
mov edx,1
call copymem32

mov al,cs:x
mov cs:twprintx,al

mov al,cs:x
mov ah,cs:w
clc
add al,ah
mov cs:twprintdx,al

mov al,cs:y
mov ah,cs:h
clc
add al,ah
mov cs:twprintdy,al
mov bx,offset sstring
mov esi,cs:[bx]
mov ebx,esi
dec ebx
push ds
xor ax,ax
mov ds,ax
mov al,ds:[ebx]
pop ds
xor bh,bh
mov bl,al

twprint3:

mov ecx,1

call print32w
inc esi
dec bx
mov al,cs:x
inc al
mov ah,cs:twprintdx
mov cs:x,al
cmp al,ah
jbe twprint4
mov al,cs:twprintx
mov cs:x,al
mov al,cs:y
inc al
mov cs:y,al
twprint4:
mov al,cs:y
mov ah,cs:twprintdy
cmp al,ah
jbe twprint5
xor bx,bx
twprint5:
cmp bx,0
jnz twprint3

pop eax
mov cs:sstring,eax
pop ax
mov cs:color,al
pop ax
mov cs:w,al
pop ax
mov cs:y,al
pop ax
mov cs:x,al
pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret

rnd:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
mov ax,cs:rand
cmp ax,0
jnz rnd1
mov ax,offset randomize
mov cs:rand,ax
rnd1:
mov bx,cs:rand
mov eax,cs:[bx]
inc bx
inc bx
inc bx
inc bx
mov cs:rand,bx
pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret

randtimer:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
mov ax,40h
mov ds,ax
mov bx,6ch
mov al,ds:[bx]
mov ah,1
mov cs:rand,ax

pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret



randn:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es

mov ebx,eax
mov eax,0ffffffffh
xor edx,edx
xor ecx,ecx
clc
idiv ebx
mov edx,eax

call rnd

mov ebx,edx
xor edx,edx
xor ecx,ecx
clc
idiv ebx

pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret

creatstack:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
mov eax,8
clc
add ecx,eax
call reserves
mov edx,eax
mov ebx,eax
mov ecx,eax
xor ax,ax
mov ds,ax
mov eax,8
clc
add ecx,eax
mov ds:[ebx],ecx
xor ecx,ecx
inc ebx
inc ebx
inc ebx
inc ebx
mov ds:[ebx],ecx
mov eax,edx

pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret

pushstack32:
push eax
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es

mov edx,eax
xor ax,ax
mov ds,ax
mov edi,esi
inc esi
inc esi
inc esi
inc esi
mov ecx,ds:[esi]
inc ecx
mov ds:[esi],ecx
mov esi,edi
mov ecx,ds:[esi]
mov esi,ecx
mov ds:[esi],edx
inc esi
inc esi
inc esi
inc esi
mov edx,esi
mov esi,edi
mov ds:[esi],edx

pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
pop eax
ret


popstack32:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es

mov edi,esi
xor ax,ax
mov ds,ax
inc esi
inc esi
inc esi
inc esi
mov ecx,ds:[esi]
cmp ecx,0
jnz popstack321
mov eax,0ffffffffh
jmp popstack325
popstack321:
dec ecx
mov ds:[esi],ecx
mov esi,edi
mov ecx,ds:[esi]
mov esi,ecx
mov edx,ds:[esi]
mov eax,esi
mov ebx,4
clc
sub eax,ebx
mov esi,edi
mov ds:[esi],eax
mov eax,edx


popstack325:
pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret


timer:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es

mov ax,40h
mov ds,ax
mov bx,6ch
mov eax,ds:[bx]

pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret





sleep:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
mov ecx,eax
mov ebx,eax
call timer
clc
add ebx,eax
mov ecx,ebx
jo sleep5
sleep1:
call timer
cmp eax,ecx
jb sleep1
jmp sleep6
sleep5:
call timer
cmp eax,ecx
ja sleep5
jmp sleep1
sleep6:

pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret


twindows32:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
jmp twindows321
twindows32x dd 0,0,0,0,0,0,0,0,0
twindows32xx dd 0,0,0,0,0,0,0,0,0
twindows321:

push esi




mov si,offset twindows32x
mov ax,cs
call mem32
mov edi,eax

pop esi

mov ecx,9
mov edx,1
call copymem32

mov si,offset twindows32x

call otwindows





pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret


twprint32:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
jmp twprint321
twprint32x dd 0,0,0,0,0,0,0,0,0
twprint32xx dd 0,0,0,0,0,0,0,0,0
twprint321:

push esi

mov si,offset twprint32x
mov ax,cs
call mem32
mov edi,eax

pop esi

mov ecx,9
mov edx,1
call copymem32

mov si,offset twprint32x


call twprint

pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret




otwindows32:
call twindows32
call twprint32
ret




drawwins32:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es
call cls
mov ax,0
mov ds,ax
mov ebx,esi
dec ebx
mov cl,ds:[ebx]
inc ebx
drawwins321:
mov esi,ds:[ebx]
call otwindows32
clc
add ebx,4
dec cl
cmp cl,0
jnz drawwins321


pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret


movetop:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es

push ax
dec esi
mov ax,0
mov ds,ax
mov cl,ds:[esi]
dec cl
inc esi
pop ax
push ax
push cx

and eax,0ffh
mov ebx,4
xor ecx,ecx
xor edx,edx
clc
mul ebx
clc
add esi,eax
mov edi,esi
clc
add esi,4
mov ebx,ds:[edi]
pop dx
pop cx

movetop1:
mov eax,ds:[esi]
mov ds:[edi],eax
clc
add edi,4
clc
add esi,4
inc cl
cmp cl,dl
jnz movetop1


mov ds:[edi],ebx

pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret


moveback:
push ebx
push ecx
push edx
push edi
push esi
push ebp
push ds
push es

push ax
dec esi
mov ax,0
mov ds,ax
mov cl,ds:[esi]
dec cl
inc esi
pop ax
push ax
push cx

and eax,0ffh
mov ebx,4
xor ecx,ecx
xor edx,edx
clc
mul ebx
clc
add esi,eax
mov edi,esi
clc
sub esi,4
mov ebx,ds:[esi]
pop dx
pop cx

moveback1:
mov eax,ds:[esi]
mov ds:[edi],eax
clc
sub edi,4
clc
sub esi,4
dec cl
cmp cl,0
jnz moveback1


mov ds:[edi],ebx

pop es
pop ds
pop ebp
pop esi
pop edi
pop edx
pop ecx
pop ebx
ret

setx32:
push ds
push ax
xor ax,ax
mov ds,ax
pop ax
mov ds:[esi],al
pop ds
ret

sety32:
push ds
push ax
xor ax,ax
mov ds,ax
pop ax
mov ds:[esi+1],al
pop ds
ret

setw32:
push ds
push ax
xor ax,ax
mov ds,ax
pop ax
mov ds:[esi+2],al
pop ds
ret

seth32:
push ds
push ax
xor ax,ax
mov ds,ax
pop ax
mov ds:[esi+3],al
pop ds
ret

setcolor32:
push ds
push ax
xor ax,ax
mov ds,ax
pop ax
mov ds:[esi+4],al
pop ds
ret


settext32:
push ds
push ax
xor ax,ax
mov ds,ax
pop ax
mov ds:[esi+5],edi
pop ds
ret

ret
ret
ret
ret
ret

ret
ret
ret
ret
ret

endf   db " "








