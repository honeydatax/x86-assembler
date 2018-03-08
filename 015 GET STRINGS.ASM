                
GETNAME:                
          mov ax,7                
          mov cx,10
          mov dx,offset sstr1
          mov bx,offset str1
          call getstrings
                          
          GETLASTNAME:
                    mov ax,12
                    mov cx,10
                    mov dx,offset sstr2
                    mov bx,offset str2
                    call getstrings
                                    
                                    
                                    
                                    
                    GETADDRESS:
                              mov ax,10
                              mov cx,10
                              mov dx,offset sstr3
                              mov bx,offset str3
                              call getstrings
                                              
                                              
                                              
                                              
                              GETPHONE:
                                        mov ax,8                
                                        mov cx,10
                                        mov dx,offset sstr4
                                        mov bx,offset str4
                                        call getstrings
                                                        
                                                        
                                        REPORT:                
                                                  call enterLine
                                                  mov bx,offset str1
                                                  mov cx,52
                                                  call cprint
                                                                  
                                                  call enterLine
                                                                  
                                                                  
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
                    jnz getstr2
                    inc cx                
                    dec bx                
                    cmp cx,dx
                    jb getstr2
                    inc bx                
                    mov cx,dx
                    GETSTR2:                
                              cmp al,13
                              jz getstr3
                              mov [bx],al
                              call printf
                              inc bx                
                              dec cx                
                              cmp cx,0                
                              ja getstr1 
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
                    jnz cprint1
                    pop dx                
                    pop cx                
                    pop bx                
                    pop ax                
                    RET                
                
                
                
GETSTRINGS:
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
          RET                
cf db 13,10,32,"."
                
ENTERLINE:
          push bx                
          push cx                
          mov bx,offset cf
          mov cx,2                
          call cprint
          pop cx                
          pop bx                
          RET                
                
                
                
                
                
                
SSTR1 DB 13,10,"NAME:"
          SSTR2 DB 13,10,"LAST NAME:"
                    SSTR3 DB 13,10,"ADDRESS:"
                              SSTR4 DB 13,10,"PHONE:"
                                        str1 db "          .",13,10
                                        str2 db "          .",13,10
                                        str3 db "          .",13,10
                                        str4 db "          .",13,10
