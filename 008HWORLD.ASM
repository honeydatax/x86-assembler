mov bx,offset endf

ffor:
mov al,[bx]
call printf
inc bx
cmp bx,offset endf+15
jb ffor


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


endf db "im love marina."
