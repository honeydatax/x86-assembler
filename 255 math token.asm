mov dx,offset msg
mov ah,9
int 21h


mov dx,offset msg2
mov ah,9
int 21h



mov si,offset msg
mov di,offset endf
call mathc


mov ah,0
int 21h
ret


mathc:
push bx
push cx
push dx
push bp
push si
push di
push ax
mov al,13
call printChar
mov al,10
call printChar
pop ax
xor cx,cx
mov cs:[di],si
inc di
inc di
inc cx
mov bl,0
mathc1:
mov al,cs:[si]
cmp al,'_'
jz mathc2
cmp al,'@'
jz mathc2
cmp al,'a'-1
ja mathc30
cmp al,'A'-1
ja mathc40
cmp al,'0'-1
ja mathc70
jmp mathc22
mathc40:
cmp al,'A'+27
jb mathc2
jmp mathc22
mathc30:
cmp al,'a'+27
jb mathc2
jmp mathc22
mathc70:
cmp al,'a'+27
jb mathc2
jmp mathc22
mathc22:
inc cx
push ax
mov al,13
call printChar
mov al,10
call printChar
pop ax
call printChar
mov cs:[di],si
inc di
inc di
inc si
mov bl,1
jmp mathc3
mathc2: 
cmp bl,0
jz math222
push ax
mov al,13
call printChar
mov al,10
call printChar
pop ax
math222:
call printChar
inc si
mov bl,0
mathc3:
cmp al,'$'
jnz mathc1
mov ax,cx
pop di
pop si
pop bp
pop dx
pop cx
pop bx
ret


printChar:
push ax
push bx
push cx
push dx
push bp
push si
push di
mov dl,al
mov ah,6
int 21h
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret


msg db "(aa1+bb2+cc3+10)$",0
msg2 db 13,10,"$",0
endf db 0



