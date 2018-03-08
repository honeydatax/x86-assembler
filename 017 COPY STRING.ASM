MAIN:                
          mov dx,offset endf
          mov bx,offset str1
          call copystr
                          
          mov bx,offset endf
          mov cx,14
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
                
FILLCHAR:
          push ax                
          push bx                
          push cx                
          FILLCHAR1:
                    mov [bx],al
                    inc bx                
                    dec cx                
                    jnz fillchar1
                    pop cx                
                    pop bx                
                    pop ax                
                    RET                
                
COPYSTR:                
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov cx,255
          mov si,bx
          mov di,dx
          COPYSTR1:
                    mov al,[si]
                    cmp al,0                
                    jz copyStr2
                    mov [di],al
                    inc di                
                    inc si                
                    dec cx                
                    jnz copyStr1
                    COPYSTR2:
                              pop si                
                              pop di                
                              pop dx                
                              pop cx                
                              pop bx                
                              pop ax                
                              RET                
                
                
                
                
str1 db "im love marina",0
endf db " "
                
