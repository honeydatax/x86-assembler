call getstr
call printf
                
exit:                
          int 20h                
          RET                
                
printf:                
          push ax                
          push bx                
          xor bh,bh
          mov bl,70h
          mov ah,0eh
          int 10h                
          pop bx                
          pop ax                
          RET                
                
                
getchar:                
          xor ax,ax
          int 16h                
          RET                
                
                
getstr:                
          push ax                
          push bx                
          push cx                
          push dx                
          mov dx,cx
          getstr1:                
                    call getchar
                    cmp al,8                
                    JNZ GETSTR2
          inc cx                
          cmp cx,dx
          JB GETSTR2
mov cx,dx
getstr2:                
          cmp al,13
          JZ GETSTR3
mov [bx],al
call printf
inc bx                
dec cx                
cmp cx,0                
JA GETSTR1 
getstr3:                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
                
