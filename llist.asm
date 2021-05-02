
h  equ     10
w  equ     10
ccolor  equ     1
x       equ     0 + w
y       equ     0 + h
x2      equ     100
y2      equ     100


call graphic
call show
@myloop2:
call check
        cmp al,0
jz @myloop2
;

 
push CS
pop ds
mmains:


      
        mov ax,cs
        mov dx,ax
        clc 
        add dx,1000h
        ;define ds:0=bitmap
        ;define ds=0xb100
        
        mov ds,dx

        mov cx,15   ;color back screen
call back
MOV di,12


mainr:
push di

  MOV si,offset haas
MOV BP,CS:[si]
xor ax,ax
MOV al,CS:[bp]
inc BP
MOV BX,offset over
CMP bp,BX
jb @byi
MOV BP,offset hwin
@byi:
MOV CS:[si],BP

MOV CX,ax


xor ax,ax
@conter1:
CMP cx,0
jz  @countero1
clc
add ax,4
dec cx
jmp @conter1

@countero1:

add ax,offset xyz
MOV BP,ax
MOV CX,3


MOV ax,CS:[BP]
inc BP
push ax

MOV ax,CS:[BP]
inc BP
push ax

MOV ax,CS:[BP]
inc BP
push ax

MOV ax,CS:[BP]
inc BP
push ax

  
        mov ax,cs
        mov dx,ax
        clc 
        add dx,1000h
        ;define ds:0=bitmap
        ;define ds=0xb100
        
        mov ds,dx


        
pop BP
pop DX
pop BX
pop ax
and BP,255
and DX,255
and bx ,255
and ax,255
CMP ax,dx
JB @mai
push ax
mov ax,DX
pop DX
@mai:
CMP BX,bp 
JB @mai2
push BX
MOV BX,BP
pop BP 
@mai2:


       
pop di
        mov cx,di
        push di

@myll:

;write a box on a bitmap memory
call box
        

        
axb:
 

pop di

        dec di
  jz @bxa
jmp mainr
@bxa:

ovv:
         mov ax,AV
         mov es,ax
         mov cx,320*200
         xor bp,bp
         xor bx,bx
call hide
;copy bitmap to windows screen
call copy
call show



         mov ax,cs
         mov ds,ax
         mov es,ax


call clock
MOV BX,ax
MOV ax,40
clc 
add BX,ax 
and BX,255

@c1:
call clock
push ax
push bx
call check
        cmp al,0
jz @myloop3
pop bx
pop ax
CMP ax,BX
jb @c1


  MOV si,offset haas

MOV BP,offset hwin
MOV CS:[si],BP
xor ax,ax
mov CX,12
MOV al,CS:[bp]
push ax
clc 
@rrotinas:
MOV al,CS:[BP+1]
MOV CS:[bp],al
inc bp
dec cx
CMP CX,0
jnz @rrotinas
pop ax
MOV CS:[BP],al
escc:
jmp mmains
jmp @myloop3

@myloop:
call check
        cmp al,0
jnz @myloop
@myloop3:

 call hide       
call text
call exit

;.include lib.inc
msg     db      "EXIT"


xyz db 0,0,50,50
db 10,10,60,60
db 20,20,70,70
db 30,30,80,80
db 40,40,90,90
db 50,50,100,100
db 60,60,110,110
db 70,70,120,120
db 80,80,130,130
db 90,90,140,140
db 100,100,150,150
db 110,110,160,160
db 120,120,170,170
db 130,130,180,180
db 0,0,0,0
overp db 0,0,0,0
db 0,0,0,0
aadd dw offset xyz
Haas dw offset hwin


tty db 0,0,0,0
hwin db  0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
 db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
 db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
 over db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9
db  0,1,2,3,4,5,6,7,8,9






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


