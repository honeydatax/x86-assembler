mov edx,offset a
mov ah,9
int 21h

mov ah,0 
int 21h


a db 'HELLO WORLD$'
