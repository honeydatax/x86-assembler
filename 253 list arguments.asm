mov si,offset msg
mov di,offset endf
call strong


mov cx,ax
call printoken


mov ah,0
int 21h
ret


strong:
push bx
push cx
push dx
push bp
push si
push di
jmp strong20
strong50 db ","
strong20:
mov bp,offset strong50
mov bl,cs:[bp]
xor cx,cx
mov cs:[di],si
inc di
inc di
inc cx
strong1:
mov al,cs:[si]
cmp al,32
jz strong22
cmp al,bl
jz strong22
jmp strong2
strong22:
mov al,'$'
mov cs:[si],al
inc si
inc cx
mov cs:[di],si
inc di
inc di
mov al,32
jmp strong3
strong2: 
inc si
strong3:
cmp al,'$'
jnz strong1
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


msg db "command arg1,arg2,arg3,arg4,5,6,7,8,9,0$",0
endf db 0



