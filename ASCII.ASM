jmp init
cchar resb 1
char1 resb 1
char2 resb 1
init:
mov cchar,0

ffor:
mov al,cchar
call printf
inc cchar
cmp cchar,0
jnz ffor

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
