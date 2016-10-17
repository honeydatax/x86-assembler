mov bx,offset endf

ffor:
mov al,[bx]
call printf
inc bx
cmp bx,offset endf+26
jb ffor


exit:
int 20h
ret

printf:

xor bh,bh
mov bl,70h
mov ah,0eh
int 10h
ret


endf db "ABCDEFGHIJKLMNOPQRSTUVWXYZ$."
