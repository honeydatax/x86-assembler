@myloop2:
call check
        cmp al,0
jz @myloop2
;
mov ax,8000
call freq


rrotina:
mov ecx,esi
rotina:
        in al,60h
        cmp al,1
jz rotinas
        cmp al,127
ja rotina
mov bp,offset cicle
xor ah,ah
call str
call on
mov dx,offset cicle
call print 
rotina80:
dec ecx
cmp ecx,0
jnz rotina80
        

@myloop212:
call check
        cmp al,0
jz @myloop212



call off        
jmp rrotina
rotinas:


call off
call exit

;.include lib.inc
msg     db      "EXIT"


freq:
push ax
mov al,10110110b
out 43h,al
pop ax
out 42h,al
mov al,ah
out 42h,al
ret


on:
in al,61h
or al,00000011b
out 61h,al
ret


off:
in al,61h
and al,11111100b
out 61h,al
ret



t2timer:
call clock
MOV BX,ax
@c9:
call clock
CMP ax,BX
jz @c9
inc bx
cmp bx,0
jz t2timer

@c1:
inc esi
call clock
CMP ax,BX
ja @cc1
CMP ax,BX
jz @c1
@cc1:
mov eax,esi
xor ecx,ecx
xor edx,edx
mov ebx,12
idiv ebx
mov esi,eax

ret


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
        push ds
        
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
        mov dx,AV
        ;mov ds,dx
        call fill
        
        pop ds
        pop ax
        pop bx
        pop cx
        pop dx
        pop bp
        ret


box:
        push si
        push di
        push ds
        push bp
        push dx
        push cx
        push bx
        push ax
        and ax,511
        and bx,255
        and dx,511
        and bp,255
        cmp ax,dx
        jb @box1
        xchg ax,dx
        @box1:
        cmp bx,bp
        jb @box2
        xchg bx,bp
        @box2:
        mov si,bp
        mov bp,offset boxxx1
        mov cs:[bp],ax
        mov bp,offset boxxx2
        mov cs:[bp],dx
        mov bp,offset boxyy1
        mov cs:[bp],bx
        mov bp,offset boxyy2
        mov cs:[bp],si
        mov bp,offset boxcolor
        mov cs:[bp],cl



        mov bp,offset boxyy1
        mov ax,cs:[bp]
        mov bx,320
        xor dx,dx
        clc
        imul bx
        mov bp,offset boxxx1
        mov bx,cs:[bp]
        clc
        add ax,bx

        mov bp,offset boxstart
        mov cs:[bp],ax
        
        mov bp,offset boxxx1
        mov bx,cs:[bp]
        mov bp,offset boxxx2
        mov ax,cs:[bp]
                
        sub ax,bx
        mov bp,offset boxxxx
        mov cs:[bp],ax
        mov bx,ax
        mov ax,320
        sub ax,bx
        mov bp,offset boxxxxx
        mov cs:[bp],ax


        mov bp,offset boxyy1
        mov bx,cs:[bp]
        mov bp,offset boxyy2
        mov ax,cs:[bp]
                
        sub ax,bx
        mov bp,offset boxyyy
        mov cs:[bp],ax
        
        ;push start -------------------

        mov bp,offset boxstart
        mov ax,cs:[bp] 
        push ax

        mov bp,offset boxcolor
        mov ax,cs:[bp] 
        push ax

        mov bp,offset boxyyy
        mov ax,cs:[bp] 
        push ax
                

        mov bp,offset boxxxx
        mov ax,cs:[bp] 
        push ax

        mov bp,offset boxxxxx
        mov ax,cs:[bp] 
        mov dx,ax

        pop si
        pop bx
        pop ax
        pop bp
        



        @boxloop1:
                mov cx,si
                @boxloop2:
                        mov ds:[bp],al
                        inc bp
                        dec cx
                jnz @boxloop2
                clc
                add bp,dx
                dec bx
        jnz @boxloop1






        pop ax
        pop bx
        pop cx
        pop dx
        pop bp
        pop ds
        pop di
        pop si
        ret


boxxx1     dw      0
boxxx2     dw      0
boxyy1     dw      0
boxyy2     dw      0
boxxxx     dw      0  
boxyyy     dw      0  
boxxxxx    dw      0  
boxyyyy    dw      0  
boxstart   dw      0  
boxcolor   dw      0  

clock:
        push bp
        push dx
        push cx
        push bx
        push ds
        mov ax,64
        mov ds,ax
        mov bp,108
        mov ax,ds:[bp]

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
        push si
        push di
        push ds
        push bp
        push dx
        push cx
        push bx
        push ax
        
        mov al,cl
        xor bp,bp
        mov cx,320*200+1
                call fill
        
        pop ax
        pop bx
        pop cx
        pop dx
        pop bp
        pop ds
        pop di
        pop si
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

copy:
        push bp
        push dx
        push cx
        push bx
        push ax
        push ds
        push es

                @copy1:
                mov al,ds:[bp]
                mov es:[bx],al
                inc bp
                inc bx
                dec cx
                       jnz @copy1

        pop es
        pop ds
        pop ax
        pop bx
        pop cx
        pop dx
        pop bp
        ret

str:
        push bp
        push dx
        push cx
        push bx
        push ax
        
        xor cx,cx
        xor dx,dx
        mov bx,10000
        clc
        idiv bx
        add al,30h
        mov ds:[bp],al
        inc bp
        mov ax,dx
        
        
        xor cx,cx
        xor dx,dx
        mov bx,1000
        clc
        idiv bx
        add al,30h
        mov ds:[bp],al
        inc bp
        mov ax,dx

        
        xor cx,cx
        xor dx,dx
        mov bx,100
        clc
        idiv bx
        add al,30h
        mov ds:[bp],al
        inc bp
        mov ax,dx

        xor cx,cx
        xor dx,dx
        mov bx,10
        clc
        idiv bx
        add al,30h
        mov ds:[bp],al
        inc bp
        mov ax,dx
        
        add al,30h
        mov ds:[bp],al
        
        


        pop ax
        pop bx
        pop cx
        pop dx
        pop bp
        ret

cicle db "00000.=$",13,10

