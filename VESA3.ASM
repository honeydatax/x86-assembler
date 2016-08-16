 hh equ     10
ww equ     10
h  equ     offset endf
w  equ     256*3
ccolor  equ     1
x       equ     0 + w
y       equ     0 + h
x2      equ     319 - w
y2      equ     199 - h

sizes equ 0ffffh


@myloop2:
in al,60h
and al,128
cmp al,0
jz @myloop2


mov ax,4f02h
mov bx,10dh
mov di,offset endf
int 10h

;call pals

mov dx,0
mov bp,0
mov ax,0a000h
mov es,ax
rotinaee:
rotinafff:
mov di,0
mov cx,0ffffh
mov ax,255
rep stosb


mov ax,4f05h
mov bx,0
inc dx
int 10h
cmp dx,2 
jb rotinaee

mov ax,cs
mov ds,ax

@myloop22:
in al,60h
and al,128
cmp al,0
jnz @myloop22



mov ax,4f02h
mov bx,3h
mov di,offset endf
int 10h



rotina1:
;sair programa
        mov ax,4c00h

int 21h

imprimir:


        mov ah,9
int 21h
        
ret

pals:
mov bp,offset mempal


mov al,64
mov ah,64
mov bl,64
mov bh,64

mov cx,32


pals4:
dec bh
dec ah
dec bl
call palsc1 
dec cx
cmp cx,0 
jnz pals4




mov al,0
mov ah,0
mov bl,0
mov bh,0
mov cx,32




pals1:
inc ah
call palsc1 
dec cx
cmp cx,0 
jnz pals1

mov al,0
mov ah,0
mov bl,0
mov bh,0

mov cx,32


pals2:
inc bl
call palsc1 
dec cx
cmp cx,0 
jnz pals2


mov al,0
mov ah,0
mov bl,0
mov bh,0

mov cx,32


pals3:
inc bh
call palsc1 
dec cx
cmp cx,0 
jnz pals3


mov al,0
mov ah,0
mov bl,0
mov bh,64

mov cx,32


pals5:
inc bl
inc ah
call palsc1 
dec cx
cmp cx,0 
jnz pals5

mov al,0
mov ah,0
mov bl,0
mov bh,64

mov cx,32


pals6:
inc bh
inc ah
call palsc1 
dec cx
cmp cx,0 
jnz pals6

mov al,0
mov ah,0
mov bl,0
mov bh,64

mov cx,32


pals7:
inc bh
inc bl
call palsc1 
dec cx
cmp cx,0 
jnz pals7


mov al,0
mov ah,0
mov bl,0
mov bh,0

mov cx,32


pals8:
dec bh
inc bl
call palsc1 
dec cx
cmp cx,0 
jnz pals8

mov cx,3
mov bp,h
mov al,0

pals9:
mov cs:[bp],al
inc bp
dec cx
cmp cx,0 
jnz pals9

mov cx,3 
mov bp,h+(15*3)
mov al,63

pals10:
;mov cs:[bp],al
;inc bp
;dec cx
;cmp cx,0 
;jnz pals10


call palso1
ret


palsc1:
mov al,ah 
mov cs:[bp],al
inc bp
mov al,bl
mov cs:[bp],al
inc bp
mov al,bh
mov cs:[bp],al
inc bp
ret

palso1:
mov bp,h
mov dx,03c8h
mov al,0
out dx,al
inc dx
palso2:
mov al,cs:[bp]
out dx,al
inc bp
cmp bp,h+w+1
jb palso2
ret

show:
        push ax
        mov ax,1
        int 33h
        pop ax
        ret

hide:
        push ax
        mov ax,2
        int 33h
        pop ax
        ret






msg db "video mode",13,10,"$"
mempal db 0
endf db "$$$$$$$$$$$$$$"
