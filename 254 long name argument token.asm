mov si,offset msg
mov di,offset endf
call longn

mov cx,ax
call printoken


mov ah,0
int 21h
ret


longn:
push bx
push cx
push dx
push bp
push si
push di
jmp longn20
longn50 db ","
longn51 db "'"
longn20:
mov bh,0
mov bp,offset longn50
mov bl,cs:[bp]
inc bp
mov ah,cs:[bp]
xor cx,cx
mov cs:[di],si
inc di
inc di
inc cx
longn1:
mov al,cs:[si]
cmp al,ah
jnz longn23
cmp bh,0
jz longn24
mov bh,0
jmp longn23
longn24:
mov bh,1
longn23:
cmp bh,0
jnz longn2
cmp al,32
jz longn22
cmp al,bl
jz longn22
jmp longn2
longn22:
mov al,'$'
mov cs:[si],al
inc si
inc cx
mov cs:[di],si
inc di
inc di
mov al,32
jmp longn3
longn2: 
inc si
longn3:
cmp al,'$'
jnz longn1
mov ax,cx
pop di
pop si
pop bp
pop dx
pop cx
pop bx
ret


printoken:
push ax
push bx
push cx
push dx
push bp
push si
push di
jmp printoken2
printoken3 db 13,10,'$'
printoken2:
mov dx,offset printoken3
mov ah,9
int 21h
mov dx,cs:[di]
inc di
inc di
mov ah,9
int 21h
dec cx
cmp cx,0
jnz printoken2
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret


msg db "command 'c:\arg 1','c:\arg 2','c:\arg 3','c:\arg 4',5,6,7,8,9,0$",0
endf db 0



