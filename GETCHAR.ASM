call getchar
call printf

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


getchar:
xor ax,ax
int 16h
ret
