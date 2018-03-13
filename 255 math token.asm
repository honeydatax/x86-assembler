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
RET                
                
                
MATHC:                
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
          MATHC1:                
                    mov al,cs:[si]
                    cmp al,'_'
                    JZ MATHC2
                    cmp al,'@'
                    JZ MATHC2
                    cmp al,'a'-1
                    JA MATHC30
                    cmp al,'A'-1
                    JA MATHC40
                    cmp al,'0'-1
                    JA MATHC70
                    JMP MATHC22
                    MATHC40:                
                    cmp al,'A'+27
                    JB MATHC2
                    JMP MATHC22
                    MATHC30:                
                    cmp al,'a'+27
                    JB MATHC2
                    JMP MATHC22
                    MATHC70:                
                    cmp al,'a'+27
                    JB MATHC2
                    JMP MATHC22
                    MATHC22:                
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
                    JMP MATHC3
                    MATHC2:                 
                    cmp bl,0                
                    JZ MATH222
                    push ax                
                    mov al,13
                    call printChar
                    mov al,10
                    call printChar
                    pop ax                
                    MATH222:                
                    call printChar
                    inc si                
                    mov bl,0                
                    MATHC3:                
                    cmp al,'$'
                    JNZ MATHC1
          mov ax,cx
          pop di                
          pop si                
          pop bp                
          pop dx                
          pop cx                
          pop bx                
          RET                
                
                
PRINTCHAR:
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
          RET                
                
                
msg db "(aa1+bb2+cc3+10)$",0
msg2 db 13,10,"$",0
endf db 0
                
                
                
