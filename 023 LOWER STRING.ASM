MAIN:                
          mov bx,offset str1
          call print
          mov bx,offset str1
          call lowerString
          mov bx,offset str1
          call print
                          
                          
                          
                          
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
                    JNZ FILLCHAR1
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
                    JZ COPYSTR2
                    mov [di],al
                    inc di                
                    inc si                
                    dec cx                
                    JNZ COPYSTR1
          COPYSTR2:
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
COPYMEM:                
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov si,bx
          mov di,dx
          COPYMEM1:
                    mov al,[si]
                    mov [di],al
                    inc di                
                    inc si                
                    dec cx                
                    JNZ COPYMEM1
          COPYMEM2:
                    pop si                
                    pop di                
                    pop dx                
                    pop cx                
                    pop bx                
                    pop ax                
                    RET                
                
                
PRINT:                
          push ax                
          push bx                
          push cx                
          push dx                
          mov cx,255
          PRINT1:                
                    mov al,[bx]
                    cmp al,0                
                    JZ PRINT2
                    call printf
                    inc bx                
                    dec cx                
                    cmp cx,0                
                    JNZ PRINT1
          PRINT2:                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
LEN:                
          push bx                
          push cx                
          push dx                
          mov cx,0                
          LEN1:                
                    mov al,[bx]
                    cmp al,0                
                    JZ LEN2                
                    inc bx                
                    inc cx                
                    cmp cx,0                
                    JNZ LEN1                
          LEN2:                
          mov ax,cx
          pop dx                
          pop cx                
          pop bx                
          RET                
                
COMPSTR:                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov cx,0                
          mov si,bx
          mov di,dx
          COMPSTR1:
                    mov al,[si]
                    mov ah,[di]
                    cmp al,0                
                    JZ COMPSTR2
                    cmp ah,0                
                    JZ COMPSTR2
                    cmp al,ah
                    JNZ COMPSTR2
                    inc di                
                    inc si                
                    inc cx                
                    cmp cx,0                
                    JNZ COMPSTR1
          COMPSTR2:
          mov ax,cx
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          RET                
                
                
COMPSTRING:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov cx,0                
          mov si,bx
          mov di,dx
          COMPSTRING1:
                    mov al,[si]
                    mov ah,[di]
                    cmp al,0                
                    JZ COMPSTRING2
                    cmp ah,0                
                    JZ COMPSTRING2
                    cmp al,ah
                    JNZ COMPSTRING2
                    inc di                
                    inc si                
                    inc cx                
                    cmp cx,0                
                    JNZ COMPSTRING1
          COMPSTRING2:
          cmp al,ah
          JZ COMPSTRING3
          JB COMPSTRING4
          mov ax,1                
          jmp compString5
          COMPSTRING3:
          mov ax,0                
          jmp compString5
          COMPSTRING4:
          mov ax,2                
          COMPSTRING5:
                    pop si                
                    pop di                
                    pop dx                
                    pop cx                
                    pop bx                
                    RET                
                
LOWERSTRING:
          push ax                
          push bx                
          push cx                
          push dx                
          mov cx,0                
          LOWERSTRING1:
                    mov al,[bx]
                    cmp al,0                
                    JZ LOWERSTRING2
                    cmp al,'A'
                    JB LOWERSTRING3
                    cmp al,'Z'
                    JA LOWERSTRING3
                    mov ah,'a'-'A'
                    add al,ah
                    mov [bx],al
                    LOWERSTRING3:
                    inc bx                
                    inc cx                
                    cmp cx,255
                    JNZ LOWERSTRING1
          LOWERSTRING2:
          mov ax,cx
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
                
                
str1 db "im LOVE MARINA",13,10,0
endf db " "
                
