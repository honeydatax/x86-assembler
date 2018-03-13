mov si,offset msg
mov di,offset endf
call token
                
                
mov cx,ax
call printoken
                
                
mov ah,0                
int 21h                
RET                
                
                
TOKEN:                
          push bx                
          push cx                
          push dx                
          push bp                
          push si                
          push di                
          xor cx,cx
          mov cs:[di],si
          inc di                
          inc di                
          inc cx                
          TOKEN1:                
                    mov al,cs:[si]
                    cmp al,32
                    JNZ TOKEN2
                    mov al,'$'
                    mov cs:[si],al
                    inc si                
                    inc cx                
                    mov cs:[di],si
                    inc di                
                    inc di                
                    mov al,32
                    JMP TOKEN3
                    TOKEN2:                 
                    inc si                
                    TOKEN3:                
                    cmp al,'$'
                    JNZ TOKEN1
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
                
                
msg db 'im love marina....',13,10,"$",0
endf db 0
                
                
                
