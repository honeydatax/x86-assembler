         mov di,offset array2

         push di
         mov di,offset ascii3
         mov dx,di
         call print
         pop di
         call input
         inc di
         inc di
         push di
         mov di,offset ascii4
         mov dx,di
         call print
         pop di
         call input
         inc di
         inc di

         push di
         mov di,offset ascii5
         mov dx,di
         call print
         pop di
         call input
         inc di
         inc di


         mov dx,offset ascii7
         call print


         mov cx,3
         mov si,offset array2

for2:
         mov di,offset ascii2
         call str
         mov dx,di
         call print
         inc si
         inc si
         dec cx
         jnz for2



         mov dx,offset ascii7
         call print

         mov cx,0
         mov dx,offset ascii8
         mov ah,3ch
         int 21h

         mov bx,ax
         mov al,2
         mov cx,0
         mov dx,offset ascii8
         mov ah,3dh
         int 21h

         mov al,0
         mov cx,6
         mov dx,offset array2
         mov ah,40h
         int 21h
         
         mov ah,3eh
         int 21h


         



xor ax,ax ; dos function exit to DOS
int 21h ; function call DOS


str:
push ax
push bx
push cx
push dx
push bp
push si
push di
         mov ax,[si]
         mov bp,10000
         str16:
         xor dx,dx
         xor cx,cx
         mov bx,bp
         clc
         div bx
         mov si,dx
         mov ah,48
         clc
         add al,ah
         mov [di],al
         inc di
         mov ax,bp
         xor dx,dx
         xor cx,cx
         mov bx,10
         clc
         div bx
         mov bp,ax
         mov ax,si
         cmp bp,0
         jnz str16
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
         ret
         ret
 
print:
push ax
push bx
push cx
push dx
push bp
push si
push di
mov ah,9
int 21h
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret

val:
push ax
push bx
push cx
push dx
push bp
push si
push di
        mov cl,0
        mov dx,0
        mov bx,1
val2:
        mov al,[si]
        cmp al,48
        jb val3
        cmp al,57
        ja val3
        jmp val4
val3:
        cmp cl,0
        jz val40
        jmp val5
val4:
        cmp cl,4
        jz val55
        inc cl
        inc si
        jmp val2
val55:
        dec cl
val5:
        dec si
val6:
        push cx
        push dx
        xor ax,ax
        mov al,[si]
        clc
        sub al,48
        xor cx,cx
        xor dx,dx
        push bx
        imul bx
        xor cx,cx
        xor dx,dx
        pop bx
        push ax
        mov ax,10
        imul bx
        mov bx,ax
        pop ax
        pop dx
        pop cx
        clc
        add dx,ax
        dec si
        dec cl
        cmp cl,0
        jz val40
        jmp val6
val40:
        mov ax,dx
        mov [di],ax
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret



input:
push ax
push bx
push cx
push dx
push bp
push si
push di
         mov bx,offset L16
         mov dx,bx
         mov cx,5
         mov bx,dx
         mov [bx],cx
         mov ah,0ah
         int 21h
         mov bx,offset L16
         mov si,bx
         inc si
         inc si
         call val
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret




sum dw 0
big dw 0
low dw 0
array2 dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
ascii2 db '00000.$'
L16 db '                                         '
ascii3 db 13,10,'enter x?$'
ascii4 db 13,10,'enter y?$'
ascii5 db 13,10,'enter z?$'
ascii7 db 13,10,'$'
ascii8 db 'xyz.dat',0,'$'






