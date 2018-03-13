mov si,offset msg
mov di,offset endf
call longn
                
mov cx,ax
call printoken
                
                
mov ah,0                
int 21h                
RET                
                
                
LONGN:                
          push bx                
          push cx                
          push dx                
          push bp                
          push si                
          push di                
          JMP LONGN20
          longn50 db ","
          longn51 db "'"
          LONGN20:                
          mov bh,0                
          mov bp,offset longn50
          mov bl,cs:[bp]
          inc bp                
          mov ah,cs:[bp]
          xor cx,cx
          mov cs:[di],si
          inc di                
          inc di                
          inc cx                
          LONGN1:                
                    mov al,cs:[si]
                    cmp al,ah
                    JNZ LONGN23
                    cmp bh,0                
                    JZ LONGN24
                    mov bh,0                
                    JMP LONGN23
                    LONGN24:                
                    mov bh,1                
                    LONGN23:                
                    cmp bh,0                
                    JNZ LONGN2
                    cmp al,32
                    JZ LONGN22
                    cmp al,bl
                    JZ LONGN22
                    JMP LONGN2
                    LONGN22:                
                    mov al,'$'
                    mov cs:[si],al
                    inc si                
                    inc cx                
                    mov cs:[di],si
                    inc di                
                    inc di                
                    mov al,32
                    JMP LONGN3
                    LONGN2:                 
                    inc si                
                    LONGN3:                
                    cmp al,'$'
                    JNZ LONGN1
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
                
                
msg db "command 'c:\arg 1','c:\arg 2','c:\arg 3','c:\arg 4',5,6,7,8,9,0$",0
endf db 0
                
                
                
