jmp init
cchar resb 1
char1 resb 1
char2 resb 1
init:
mov cchar,'A'
mov char2,1
mov char1,2

ffor:
mov al,cchar
call printf
mov al,char2
mov bl,char1
xor cx,cx
xor dx,dx
mul bl
inc char2
mov bl,'A'
add al,bl
mov cchar,al
cmp cchar,'Z'+1
jb ffor

call exit

exit:
int 20h
ret

printf:

xor bh,bh
mov bl,70
mov ah,0eh
int 10h
ret
