
getname:
mov ax,7
mov cx,10
mov dx,offset sstr1
mov bx,offset str1
call getstrings

getlastname:
mov ax,12
mov cx,10
mov dx,offset sstr2
mov bx,offset str2
call getstrings




getaddress:
mov ax,10
mov cx,10
mov dx,offset sstr3
mov bx,offset str3
call getstrings




getphone:
mov ax,8
mov cx,10
mov dx,offset sstr4
mov bx,offset str4
call getstrings


report:
call enterLine
mov bx,offset str1
mov cx,52
call cprint

call enterLine


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






sstr1 db 13,10,"name:"
sstr2 db 13,10,"last name:"
sstr3 db 13,10,"address:"
sstr4 db 13,10,"phone:"
str1 db "          .",13,10
str2 db "          .",13,10
str3 db "          .",13,10
str4 db "          .",13,10
