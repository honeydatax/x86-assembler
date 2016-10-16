jmp init
cchar resb 1
char1 resb 1
char2 resb 1
init:
mov cchar,'A'
mov char1,2

ffor:
mov al,cchar
call printf
mov al,char1
add cchar,al
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
