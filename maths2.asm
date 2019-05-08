        mov di,0
        mov si,offset array1
        mov cx,[si]
        mov ax,0
        mov si,offset a
        mov bx,[si]
main:
        clc
        add ax,bx
        jo main2
        jmp main3
main2:
        mov di,1
main3:
        dec cx
        cmp cx,0
        jnz main
        mov si,offset b
        mov bx,[si]
        clc
        add ax,bx
        jo main5
        jmp main6
main5:
        mov di,1
main6:
        mov si,offset c
        mov bx,[si]
        clc
        sub ax,bx
        jo main7
        jmp main8
main7:
        mov di,1
main8:
        mov si,offset r
        mov [si],ax
        cmp di,1
        jz overflod

notflood:
        mov si,offset b
        mov cx,[si]
        mov ax,0
        mov si,offset r
        mov bx,[si]
        mov di,0
for1:
        clc
        add ax,bx
        jo main10
        jmp main11
main10:
        mov di,1
main11:
        dec cx
        cmp cx,0
        jnz for1
        mov si,offset z
        mov bx,[si]
        clc
        add ax,bx
        jo main14
        jmp main15
main14:
        mov di,1
main15:
        mov si,offset r
        mov [si],ax
        cmp di,1
        jz overflod
        mov si,offset e
        mov ax,0
        mov [si],ax
        jmp exits
overflod:
        mov si,offset r
        mov ax,[si]
        mov di,offset e
        mov [di],ax
        mov si,offset r
        mov ax,0
        mov [si],ax
        mov dx,offset escii2
        call print
        
exit:        
exits:
        mov dx,offset escii3
        call print
        mov si,offset r
        mov di,offset escii1
        call str
        mov dx,offset escii1
        call print
        mov dx,offset escii4
        call print
        mov si,offset e
        mov di,offset escii1
        call str
        mov dx,offset escii1
        call print
        
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



array1 dw 4
a dw 2
b dw 2
c dw 3
d dw 1
e dw 1
f dw 1
g dw 1
h dw 1
r dw 1
z dw 100
L16 db '                                         $'
escii1 db '00000 $'
escii2 db 13,10,'overflod ',13,10,'$'
escii3 db 13,10,'r: $'
escii4 db 13,10,'e: $'





