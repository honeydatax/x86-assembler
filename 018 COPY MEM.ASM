main:
mov cx,14
mov dx,offset endf
mov bx,offset str1
call copymem
call cprint




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


getstr:
push ax
push bx
push cx
push dx
mov dx,cx
getstr1:
call getchar
cmp al,7
jnz getstr2
inc cx
dec bx
cmp cx,dx
jb getstr2
inc bx
mov cx,dx
getstr2:
cmp al,13
jz getstr3
mov [bx],al
call printf
inc bx
dec cx
cmp cx,0
ja getstr1 
getstr3:
pop dx
pop cx
pop bx
pop ax
ret




cprint:
push ax
push bx
push cx
push dx
cprint1:
mov al,[bx]
call printf
inc bx
dec cx
cmp cx,0
jnz cprint1
pop dx
pop cx
pop bx
pop ax
ret



getStrings:
push ax
push bx
push cx
push dx
push cx
push bx
push dx
push ax
mov bx,offset cf
mov cx,2
call cprint
pop cx
pop bx
call cprint
pop bx
pop cx
call getstr
mov bx,offset cf
mov cx,2
call cprint
pop dx
pop cx
pop bx
pop ax
ret
cf db 13,10,32,"."

enterLine:
push bx
push cx
mov bx,offset cf
mov cx,2
call cprint
pop cx
pop bx
ret

fillchar:
push ax
push bx
push cx
fillchar1:
mov [bx],al
inc bx
dec cx
jnz fillchar1
pop cx
pop bx
pop ax
ret

copyStr:
push ax
push bx
push cx
push dx
push di
push si
mov cx,255
mov si,bx
mov di,dx
copyStr1:
mov al,[si]
cmp al,0
jz copyStr2
mov [di],al
inc di
inc si
dec cx
jnz copyStr1
copyStr2:
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret

copymem:
push ax
push bx
push cx
push dx
push di
push si
mov si,bx
mov di,dx
copymem1:
mov al,[si]
mov [di],al
inc di
inc si
dec cx
jnz copymem1
copymem2:
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret




str1 db "im love marina",0
endf db " "

