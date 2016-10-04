jmp ini
nop
nop
ini:


mov dx,offset msg
mov ah,9
int 021h


int 20h

msg db "im love marina$"
