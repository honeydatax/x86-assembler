 mov ax,offset array1 

;get array address into source index register
 mov si,ax
 mov ax,offset array2
; get address to put the sum in destination register
 mov di,ax
 mov cx,20 
; load the number of array counter
 mov bx,0 
; start sum register


for0:
mov ax,[si] 
; for cicle loa to acumulador register the array values
push cx
xor dx,dx 
;clear dx word of extend word division
xor cx,cx 
;clear cx word of extend word division
mov bx,11 
;load the divisor 11 
div bx 
; divide acumulator by 11
mov [di],ax 
;stores the acumulator in sum address destany place index
inc si 
; add 1 to the index source array
inc si 
; add the second byte to compleat a word size a word have 2 bytes in size
inc di 
; add 1 to the index source array
inc di 
; add the second byte to compleat a word size a word have 2 bytes in size
pop cx
dec cx 
; in counter register remain array index left
cmp cx,0 
; compare counter register id 0 count 20 array size
jnz for0 
;if the counter register is not zero jumps to for again into cx compleat 20 times


 mov dx,offset array1 
;get array address into source index register
 mov si,dx
 mov dx,offset sum 
; get address to put the sum in destination register
 mov di,dx
 mov cx,20 
; load the number of array counter
 mov bx,0 
; start sum register
for1:
mov ax,[si] 
; for cicle loa to acumulador register the array values
clc 
; clear the carry fl2g
add bx,ax 
; add last sum into acumulator in base register
inc si 
; add 1 to the index source array
inc si 
; add the second byte to compleat a word size a word have 2 bytes in size
dec cx 
; in counter register remain array index left
cmp cx,0 
; compare counter register id 0 count 20 array size
jnz for1 
;if the counter register is not zero jumps to for again into cx compleat 20 times

mov ax,offset sum
mov di,ax
mov [di],bx


  mov cx,20
  mov ax,offset array1
  mov bx,offset array2

; dont know if you can use link gnu in you scoll or must use the str function?
for4:
mov si,ax 
mov dx,offset ascii
mov di,dx
call str
mov si,bx 
mov dx,offset ascii2
mov di,dx
call str
mov dx,offset ascii10
call print
inc ax
inc ax
inc bx
inc bx
dec cx
cmp cx,0
jnz for4

mov dx,offset sum
mov si,dx
mov di,offset ascii4
mov di,dx
call str
mov dx,offset ascii3
call print


xor ax,ax 
; dos function exit to DOS
int 21h 
; function call DOS


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




; Put you 20 array data here
array1 dw 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25

; addresss of sum 
sum dw 0
array2 dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
ascii10 db '................'
ascii db '00000....'
ascii2 db '00000.',13,10,'$'
ascii3 db 'total......'
ascii4 db '00000.',13,10,'$'









