jmp main
main:

mov al,70h
mov color,al


xor cl,cl
mov bx,offset x

mov si,offset text1


for1:
mov cs:[bx],cl
mov cs:[bx+1],cl

call print 


inc cl
cmp cl,19
jb for1






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
xchg si,bp 
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





















endf   db " "










