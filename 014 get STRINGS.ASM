
getname:
mov bx,offset sstr1
mov cx,7
call cprint
mov bx,offset str1
mov cx,10
call getstr
mov bx,offset str2
mov cx,2
call cprint
mov bx,offset str1
mov cx,13
call cprint


getlastname:
mov bx,offset sstr2
mov cx,12
call cprint
mov bx,offset str3
mov cx,10
call getstr
mov bx,offset str2
mov cx,2
call cprint
mov bx,offset str3
mov cx,13
call cprint

getaddress:
mov bx,offset sstr3
mov cx,10
call cprint
mov bx,offset str4
mov cx,10
call getstr
mov bx,offset str2
mov cx,2
call cprint
mov bx,offset str4
mov cx,13
call cprint

getphone:
mov bx,offset sstr4
mov cx,8
call cprint
mov bx,offset str5
mov cx,10
call getstr
mov bx,offset str2
mov cx,2
call cprint
mov bx,offset str5
mov cx,13
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


str2 db 13,10,">"
sstr1 db 13,10,"name:"
sstr2 db 13,10,"last name:"
sstr3 db 13,10,"address:"
sstr4 db 13,10,"phone:"
str1 db "          .",13,10
str3 db "          .",13,10
str4 db "          .",13,10
str5 db "          .",13,10
