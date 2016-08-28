mov DX, offset MSG
mov ah,9h
int 21h

int 20

ret

msg db "im love marina$"