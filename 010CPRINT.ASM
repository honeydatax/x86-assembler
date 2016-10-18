mov bx,offset endf
mov cx,15
call cprint


exit:
int 20h
ret

printf:
push ax
push bx
xor bh,bh
mov bl,70h
mov ah,0eh
int 10h
pop bx
pop ax
ret


cprint:
push ax
push bx
push cx
push dx
cprint1:
mov al,[bx]
call printf
inc bx
dec cx
cmp cx,0
jnz cprint1
pop dx
pop cx
pop bx
pop ax
ret


endf db "im love marina."
