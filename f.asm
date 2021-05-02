
mov ax,cs
mov bx, offset seg1

                   mov cs:[bx],ax

mov bx, offset seg2

                   mov cs:[bx],ax

    mov bx, offset seg3

                   mov cs:[bx],ax


    mov bx, offset seg4

                  mov cs:[bx],ax
mov bx,3000h
mov ah,4ah
int 21h
         mov       dx,offset name
         mov       bx,offset blk
         mov       ax,4b00h
         int       21h
sair:
mov ax,4c00h
int 21h
name db        'ola.com',0
;
blk  dw offset env
seg1 dw  0   
 dw offset cmdline   
 seg2  dw 0   
dw  offset fcb1      
 seg3  dw  0     
dw offset fcb2    
 seg4  dw  0     


                            
fcb1  dd  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
fcb2  dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

 cmdline db        0,13,0
env    db        0 ,0   
                           
