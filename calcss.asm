main:
        mov di,offset array2
        call input
again:
        mov dx,offset ascii3
        call print
        mov cx,2
        call inputstring
        mov si,offset L16
        inc si
        inc si
        mov dx,offset ascii1
        call print
        mov al,[si]
        cmp al,43
        jz sums
        cmp al,45
        jz subs
        cmp al,42
        jz muls
        cmp al,47
        jz divs
        jmp again

sums:
        mov di,offset array2
        inc di
        inc di
        call input
        mov dx,offset ascii7
        call print
        mov si,offset array2
        mov ax,[si]
        inc si
        inc si
        mov bx,[si]        
        add ax,bx
        inc si
        inc si
        mov [si],ax        
        mov di,offset ascii2
        call str
        mov dx,offset ascii2
        call print
        jmp exits
subs:
        mov di,offset array2
        inc di
        inc di
        call input
        mov dx,offset ascii7
        call print
        mov si,offset array2
        mov ax,[si]
        inc si
        inc si
        mov bx,[si]        
        sub ax,bx
        inc si
        inc si
        mov [si],ax        
        mov di,offset ascii2
        call str
        mov dx,offset ascii2
        call print
        jmp exits
muls:
        mov di,offset array2
        inc di
        inc di
        call input
        mov dx,offset ascii7
        call print
        mov si,offset array2
        mov ax,[si]
        inc si
        inc si
        mov bx,[si]        
        xor cx,cx
        xor dx,dx
        mul bx
        inc si
        inc si
        mov [si],ax        
        mov di,offset ascii2
        call str
        mov dx,offset ascii2
        call print
        jmp exits
divs:
        mov di,offset array2
        inc di
        inc di
        call input
        mov dx,offset ascii7
        call print
        mov si,offset array2
        mov ax,[si]
        inc si
        inc si
        mov bx,[si]        
        xor cx,cx
        xor dx,dx
        div bx
        inc si
        inc si
        mov [si],ax        
        mov di,offset ascii2
        call str
        mov dx,offset ascii2
        call print
        jmp exits

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



sum dw 0
big dw 0
low dw 0
array2 dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
ascii2 db '00000.$'
ascii1 db 13,10,'$'
L16 db '                                         $'
ascii3 db 13,10,'+ - * / ? $'
ascii4 db 13,10,'passing grade',13,10,'$'
ascii5 db 13,10,'failed grade',13,10,'$'
ascii6 db 13,10,'even grade',13,10,'$'
ascii8 db 13,10,'odd grade',13,10,'$'
ascii7 db 13,10,'$'







