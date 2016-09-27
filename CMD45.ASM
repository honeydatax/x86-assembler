mov bx,80h
mov al,cs:[bx]
inc al
xor ah,ah
mov dx,bx
clc
add bx,ax
mov al,0
mov cs:[bx],al
inc bx
mov al,'$'
mov cs:[bx],al
inc dx
inc dx
mov ah,9h
int 21h

int 20h






