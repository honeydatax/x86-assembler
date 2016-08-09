
call graphic
@myloop2:
call check
        cmp al,0
jz @myloop2
;
        mov cx,15        ;color back screen
call back
     mov cx,10
MOV BP,offset offsets
MOV BX,0
MOV ax,0a000h
MOV DS,ax

@myloop42:
MOV dX,10
      

@myloop41:
MOV al,CS:[BP]
MOV DS:[BX],al
inc BP
inc bx
     


      dec dx
       cmp dx,0

       jnz @myloop41
clc 
add BX,310
      dec cx
       cmp cx,0

       jnz @myloop42

@myloop44:
call check
        cmp al,0
jnz @myloop44




call text
call exit


offsets  db 15,15,15,15,04,04,15,15,15,15
o1          db 15,15,15,04,15,15,04,15,15,15
o2          db 15,15,15,15,04,04,15,15,15,15
o3          db 15,15,15,04,04,04,04,04,15,15
o4          db 15,15,04,15,04,04,15,04,15,15
o5          db 15,15,04,15,04,04,15,04,15,15
o6          db 15,15,15,15,04,04,15,04,15,15
o7          db 15,15,15,15,04,04,15,15,15,15
o8          db 15,15,15,04,15,04,15,15,15,15
o9          db 15,15,15,04,15,04,15,15,15,15


vline:
        push di
        push si
        push bp
        push dx
        push cx
        push bx
        push ax
        push ds

                
        and ax,511
        and bx,255
        and dx,255
        clc
        sub dx,bx
        and dx,255
        push cx
        push dx
        push ax
        mov ax,320
        xor dx,dx
        xor cx,cx
        clc
        imul bx
        clc
        pop bx
        xor dx,dx
        xor cx,cx
        add ax,bx
        mov bp,ax
        pop cx
        pop ax
        
        mov dx,AV
        mov ds,dx
        mov bx,320

        @vline1:
        mov ds:[bp],al
        add bp,bx
        dec cx
        jnz @vline1
        
        pop ds
        pop ax
        pop bx
        pop cx
        pop dx
        pop bp
        pop si
        pop di
ret


;.include lib.inc






AV      equ 40960


print: 
        mov ah,9
        int 21h
        ret

exit:
        mov ah,0 
        int 21h
        ret

graphic:
        xor eax,eax
        mov al,13h
        int 10h
        ret

text:
        xor ax,ax
        mov al,3
        int 10h
        ret

key:
        xor ah,ah
        int 16h
        ret


fill:
        push bp
        push cx
        push ax
        @mfill1:
        mov ds:[bp],al
        inc bp
        cmp bp,cx
        jnz @mfill1
        pop ax
        pop cx
        pop bp
        ret

line:
        push bp
        push dx
        push cx
        push bx
        push ax
        and ax,511
        and bx,255
        and dx,511
        clc
        sub dx,ax
        and dx,511
        push cx
        push dx
        push ax
        mov ax,320
        xor dx,dx
        xor cx,cx
        clc
        imul bx
        clc
        pop bx
        xor dx,dx
        xor cx,cx
        add ax,bx
        mov bp,ax
        pop cx
        add cx,bp
        pop ax
        push ds
        mov dx,AV
        mov ds,dx
        call fill
        pop ds
        
        pop ax
        pop bx
        pop cx
        pop dx
        pop bp
        ret


box:
        push bp
        push dx
        push cx
        push bx
        push ax
        and ax,511
        and bx,255
        and dx,511
        and bp,255
        
        @mbox1:
        call line
        inc bx
        cmp bx,bp
        jnz @mbox1
        pop ax
        pop bx
        pop cx
        pop dx
        pop bp
        ret

clock:
        push bp
        push dx
        push cx
        push bx
        push ds
        mov ax,64
        mov ds,ax
        mov bp,108
        mov al,ds:[bp]

        pop ds
        pop bx
        pop cx
        pop dx
        pop bp
        ret

check:
        in al,60h
        and al,128
        ret

back:
        mov ax,0        ;x
        mov bx,0        ;y
        mov dx,320      ;x2
        mov bp,200      ;y2

        call box
        ret


show:
        push ax
        mov ax,1
        int 33h
        pop ax
        ret

hide:
        push ax
        mov ax,2
        int 33h
        pop ax
        ret

