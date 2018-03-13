mov si,offset msg
mov di,offset endf
call strong
                
                
mov cx,ax
call printoken
                
                
mov ah,0                
int 21h                
RET                
                
                
STRONG:                
          push bx                
          push cx                
          push dx                
          push bp                
          push si                
          push di                
          JMP STRONG20
          strong50 db ","
          STRONG20:
          mov bp,offset strong50
          mov bl,cs:[bp]
          xor cx,cx
          mov cs:[di],si
          inc di                
          inc di                
          inc cx                
          STRONG1:                
                    mov al,cs:[si]
                    cmp al,32
                    JZ STRONG22
                    cmp al,bl
                    JZ STRONG22
                    JMP STRONG2
                    STRONG22:
                    mov al,'$'
                    mov cs:[si],al
                    inc si                
                    inc cx                
                    mov cs:[di],si
                    inc di                
                    inc di                
                    mov al,32
                    JMP STRONG3
                    STRONG2: 
                    inc si                
                    STRONG3:                
                    cmp al,'$'
                    JNZ STRONG1
          mov ax,cx
          pop di                
          pop si                
          pop bp                
          pop dx                
          pop cx                
          pop bx                
          RET                
                
                
PRINTOKEN:
          push ax                
          push bx                
          push cx                
          push dx                
          push bp                
          push si                
          push di                
          JMP PRINTOKEN2
          printoken3 db 13,10,'$'
          PRINTOKEN2:
          mov dx,offset printoken3
          mov ah,9                
          int 21h                
          mov dx,cs:[di]
          inc di                
          inc di                
          mov ah,9                
          int 21h                
          dec cx                
          cmp cx,0                
          JNZ PRINTOKEN2
pop di                
pop si                
pop bp                
pop dx                
pop cx                
pop bx                
pop ax                
RET                
                
                
msg db "command arg1,arg2,arg3,arg4,5,6,7,8,9,0$",0
endf db 0
                
                
                
