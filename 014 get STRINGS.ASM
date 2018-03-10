                
GETNAME:                
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
                          
                          
          GETLASTNAME:
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
                                    
                    GETADDRESS:
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
                                              
                              GETPHONE:
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
                                                        
                                                        
                                                        
                                        EXIT:                
                                                  int 20h                
                                                  RET                
                
PRINTF:                
          push ax                
          push bx                
          xor bh,bh
          mov bl,70h
          mov ah,0eh
          int 10h                
          pop bx                
          pop ax                
          RET                
                
                
GETCHAR:                
          xor ax,ax
          int 16h                
          RET                
                
                
GETSTR:                
          push ax                
          push bx                
          push cx                
          push dx                
          mov dx,cx
          GETSTR1:                
                    call getchar
                    cmp al,7                
                    JNZ GETSTR2
                    inc cx                
                    dec bx                
                    cmp cx,dx
                    JB GETSTR2
                    inc bx                
                    mov cx,dx
                    GETSTR2:                
                    cmp al,13
                    JZ GETSTR3
                    mov [bx],al
                    call printf
                    inc bx                
                    dec cx                
                    cmp cx,0                
                    JA GETSTR1 
          GETSTR3:                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
                
                
CPRINT:                
          push ax                
          push bx                
          push cx                
          push dx                
          CPRINT1:                
                    mov al,[bx]
                    call printf
                    inc bx                
                    dec cx                
                    cmp cx,0                
                    JNZ CPRINT1
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
str2 db 13,10,">"
SSTR1 DB 13,10,"NAME:"
SSTR2 DB 13,10,"LAST NAME:"
SSTR3 DB 13,10,"ADDRESS:"
SSTR4 DB 13,10,"PHONE:"
str1 db "          .",13,10
str3 db "          .",13,10
str4 db "          .",13,10
str5 db "          .",13,10
