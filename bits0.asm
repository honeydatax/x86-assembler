
        mov dx,offset escii2
        call print
        mov di,offset array1
        call input
        mov dx,offset escii3
        call print
        mov si,offset array1
        mov al,[si]
        mov cl,8
        mov ah,1
        mov dx,0
for1:
        mov bl,al
        and bl,ah
        cmp bl,0
        jz for2
        inc dx
for2:
        shl ah,1
        dec cl
        jnz for1
        mov si,offset array1
        mov [si],dx
        mov si,offset array1
        mov di,offset escii1
        call str
        mov dx,offset escii1
        call print
        
        
exit:        
exits:
        
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

inputstring:
push ax
push bx
push cx
push dx
push bp
push si
push di
        mov bx,offset L16
        mov dx,bx
        mov bx,dx
        mov [bx],cx
        mov ah,0ah
        int 21h
        mov bx,offset L16
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret



array1 dw 0,0,0,0,0
L16 db '                                         $'
escii1 db '00000 $'
escii2 db 'get number from 0 255 ? $'
escii3 db 13,10,'$'












