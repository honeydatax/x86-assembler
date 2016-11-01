jmp main
files resw 1
counter resw 1
main:


mov dx,offset file
call creat
mov files,ax
mov bx,offset text
call len
mov cx,ax
mov bx,files
mov dx,offset text
call write
call close

exit:
int 20h
ret



file db "marina.txt",0,0
text db "im love marina.",0



variantetablesize equ 256*4

varianteblock resb 1
variantetable resw 1
varianteptrpos resw 1


printf:
push ax
push bx
xor bh,bh
mov bl,70h
mov ah,0eh
int 10h
pop bx
pop ax
ret


getchar:
xor ax,ax
int 16h
ret


getstr:
push ax
push bx
push cx
push dx
mov dx,cx
getstr1:
call getchar
cmp al,7
jnz getstr2
inc cx
dec bx
cmp cx,dx
jb getstr2
inc bx
mov cx,dx
getstr2:
cmp al,13
jz getstr3
mov [bx],al
call printf
inc bx
dec cx
cmp cx,0
ja getstr1 
getstr3:
pop dx
pop cx
pop bx
pop ax
ret




cprint:
push ax
push bx
push cx
push dx
cprint1:
mov al,[bx]
call printf
inc bx
dec cx
cmp cx,0
jnz cprint1
pop dx
pop cx
pop bx
pop ax
ret



getStrings:
push ax
push bx
push cx
push dx
push cx
push bx
push dx
push ax
mov bx,offset cf
mov cx,2
call cprint
pop cx
pop bx
call cprint
pop bx
pop cx
call getstr
mov bx,offset cf
mov cx,2
call cprint
pop dx
pop cx
pop bx
pop ax
ret
cf db 13,10,32,"."

enterLine:
push bx
push cx
mov bx,offset cf
mov cx,2
call cprint
pop cx
pop bx
ret

fillchar:
push ax
push bx
push cx
fillchar1:
mov [bx],al
inc bx
dec cx
jnz fillchar1
pop cx
pop bx
pop ax
ret

copyStr:
push ax
push bx
push cx
push dx
push di
push si
mov cx,255
mov si,bx
mov di,dx
copyStr1:
mov al,[si]
cmp al,0
jz copyStr2
mov [di],al
inc di
inc si
dec cx
jnz copyStr1
copyStr2:
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret

copymem:
push ax
push bx
push cx
push dx
push di
push si
mov si,bx
mov di,dx
copymem1:
mov al,[si]
mov [di],al
inc di
inc si
dec cx
jnz copymem1
copymem2:
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret


print:
push ax
push bx
push cx
push dx
mov cx,255
print1:
mov al,[bx]
cmp al,0
jz print2
call printf
inc bx
dec cx
cmp cx,0
jnz print1
print2:
pop dx
pop cx
pop bx
pop ax
ret

len:
push bx
push cx
push dx
mov cx,0
len1:
mov al,[bx]
cmp al,0
jz len2
inc bx
inc cx
cmp cx,0
jnz len1
len2:
mov ax,cx
pop dx
pop cx
pop bx
ret

compStr:
push bx
push cx
push dx
push di
push si
mov cx,0
mov si,bx
mov di,dx
compStr1:
mov al,[si]
mov ah,[di]
cmp al,0
jz compStr2
cmp ah,0
jz compStr2
cmp al,ah
jnz compStr2
inc di
inc si
inc cx
cmp cx,0
jnz compStr1
compStr2:
mov ax,cx
pop si
pop di
pop dx
pop cx
pop bx
ret


compString:
push bx
push cx
push dx
push di
push si
mov cx,0
mov si,bx
mov di,dx
compString1:
mov al,[si]
mov ah,[di]
cmp al,0
jz compString2
cmp ah,0
jz compString2
cmp al,ah
jnz compString2
inc di
inc si
inc cx
cmp cx,0
jnz compString1
compString2:
cmp al,ah
jz compString3
jb compString4
mov ax,1
jmp compString5
compString3:
mov ax,0
jmp compString5
compString4:
mov ax,2
compString5:
pop si
pop di
pop dx
pop cx
pop bx
ret

lowerString:
push ax
push bx
push cx
push dx
mov cx,0
lowerString1:
mov al,[bx]
cmp al,0
jz lowerString2
cmp al,'A'
jb lowerString3
cmp al,'Z'
ja lowerString3
mov ah,'a'-'A'
add al,ah
mov [bx],al
lowerString3:
inc bx
inc cx
cmp cx,255
jnz lowerString1
lowerString2:
mov ax,cx
pop dx
pop cx
pop bx
pop ax
ret

lowerStr:
push ax
push bx
push cx
push dx
lowerStr1:
mov al,[bx]
cmp al,0
jz lowerStr2
cmp al,'A'
jb lowerStr3
cmp al,'Z'
ja lowerStr3
mov ah,'a'-'A'
add al,ah
mov [bx],al
lowerStr3:
inc bx
dec cx
cmp cx,0
jnz lowerStr1
lowerStr2:
mov ax,cx
pop dx
pop cx
pop bx
pop ax
ret


upperStr:
push ax
push bx
push cx
push dx
upperStr1:
mov al,[bx]
cmp al,0
jz upperStr2
cmp al,'a'
jb upperStr3
cmp al,'z'
ja upperStr3
mov ah,'a'-'A'
sub al,ah
mov [bx],al
upperStr3:
inc bx
dec cx
cmp cx,0
jnz upperStr1
upperStr2:
mov ax,cx
pop dx
pop cx
pop bx
pop ax
ret


upperString:
push ax
push bx
push cx
push dx
mov cx,0
upperString1:
mov al,[bx]
cmp al,0
jz upperString2
cmp al,'a'
jb upperString3
cmp al,'z'
ja upperString3
mov ah,'a'-'A'
sub al,ah
mov [bx],al
upperString3:
inc bx
inc cx
cmp cx,255
jnz upperString1
upperString2:
mov ax,cx
pop dx
pop cx
pop bx
pop ax
ret



findchar:
push bx
push cx
push dx
mov cx,0
mov ah,al
findchar1:
mov al,[bx]
cmp al,0
jz findchar2
cmp al,ah
jz findchar3
inc bx
inc cx
cmp cx,255
jnz findchar1
findchar2:
mov cx,0ffffh
findchar3:
mov ax,cx
pop dx
pop cx
pop bx
ret

findcharstr:
push bx
push cx
push dx
mov dx,0
mov ah,al
findcharstr1:
mov al,[bx]
cmp al,0
jz findcharstr2
cmp al,ah
jz findcharstr3
inc bx
inc dx
dec cx
cmp cx,0
jnz findcharstr1
findcharstr2:
mov cx,0ffffh
findcharstr3:
mov ax,dx
pop dx
pop cx
pop bx
ret


asc:
mov al,[bx]
ret


left:
clc
add ax,bx
ret

rigth:
push dx
mov dx,ax
call len
clc
sub ax,dx
pop dx
ret

findstring:
push bx
push cx
push dx
push di
push si
mov si,dx
xor ax,ax
mov al,[si]
mov di,ax
mov si,bx
mov bx,dx
call len 
cmp ax,0
jnz findstring9
mov ax,0ffffh
jmp  findstring8
findstring9:
mov bx,si
mov si,ax
findstring1:
mov ax,di
call findchar
cmp ax,0ffffh
jz findstring8
clc 
add bx,ax
call compStr
cmp si,ax
jz findstring10
inc bx
jmp findstring1
findstring10:
mov ax,bx
findstring8:
pop si
pop di
pop dx
pop cx
pop bx

ret


findpos:
call findstring
cmp ax,0ffffh
jz findpos1
sub ax,bx
findpos1:
ret

compSize:
push bx
push cx
push dx
push di
push si
push bp
mov dx,0
compsize1:
mov al,[si]
mov ah,[di]
cmp al,0
jz compSize2
cmp ah,0
jz compSize2
cmp al,ah
jnz compSize2
inc di
inc si
inc dx
dec bp
dec cx
cmp bp,0
jz compSize2
cmp cx,0
jnz compSize1
compSize2:
mov ax,dx
pop bp
pop si
pop di
pop dx
pop cx
pop bx
ret

compStringsize:
push bx
push cx
push dx
push di
push si
push bp
mov dx,0
compStringsize1:
mov al,[si]
mov ah,[di]
cmp al,0
jz compStringsize2
cmp ah,0
jz compStringsize2
cmp al,ah
jnz compStringsize2
inc di
inc si
dec cx
dec bp
cmp bp,0
jz compStringsize2
cmp cx,0
jnz compStringsize1
compStringsize2:
cmp al,ah
jz compStringsize3
jb compStringsize4
mov ax,1
jmp compStringsize5
compStringsize3:
mov ax,0
jmp compStringsize5
compStringsize4:
mov ax,2
compStringsize5:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
ret

findptsize:
push bx
push cx
push dx
push di
push si
push bp
mov al,[di]
mov bl,al
findptsize1:
mov al,bl
xchg bx,si
call findcharstr
cmp ax,0ffffh
jz findptsize8
xchg bx,si
clc 
add si,ax
clc 
sub cx,ax
call compSize
cmp bp,ax
jz findptsize10
inc si
dec cx
cmp cx,0fff0h
ja findptsize11
cmp cx,0
jz findptsize1
findptsize11:
mov si,0ffffh
findptsize10:
mov ax,si
findptsize8:
pop bp
pop si
pop di
pop dx
pop cx
pop bx

ret


findposize:
call findptsize
cmp ax,0ffffh
jz findposize1
sub ax,si
findposize1:
ret

hhex db "0123456789ABCDEF.$",0

hex:
push ax
push bx
push dx
push si
push di
inc bx
xor ah,ah
mov dx,ax
and ax,0fh
mov si,offset hhex
clc
add si,ax 
mov al,cs:[si]
mov [bx],al
dec bx
mov ax,dx
and ax,0f0h
shr ax,4
mov si,offset hhex
clc
add si,ax 
mov al,cs:[si]
mov [bx],al

pop di
pop si
pop dx
pop bx
pop ax
ret



debugs:
push ax
push bx
push cx
push dx
inc bx
inc bx
mov dx,ax
and ax,0ffh
call hex
dec bx
dec bx
mov ax,dx
and ax,0ff00h
shr ax,8
call hex
pop dx
pop cx
pop bx
pop ax
ret


moveford:
push bx
push cx
push dx
push di
push si
push bp

clc
add di,cx
clc
add si,cx
moveford1:
mov al,[si]
mov [di],al
dec si
dec di
dec cx
cmp cx,0
jnz moveford1

pop bp
pop si
pop di
pop dx
pop cx
pop bx

ret

moveback:
push ax
push bx
push cx
push dx
push di
push si
push bp

moveback1:
mov al,[si]
mov [di],al
inc si
inc di
dec cx
cmp cx,0
jnz moveback1

pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret


gotoxy:
push ax
push bx
push dx
mov ah,2
mov bh,0
int 10h
pop dx
pop bx
pop ax
ret 



getxy:
push ax
push bx
push cx
mov ah,3
mov bh,0
int 10h
pop cx
pop bx
pop ax
ret 


input:
jmp input2
inputpos     resw 1
inputsize    resw 1
inputptr     resw 1
inputptrpos  resw 1
inputcounter resw 1
input2:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov inputptr,bx
mov inputptrpos,bx
call getxy
mov inputpos,dx
mov inputsize,cx
clc 
add bx,cx
mov inputcounter,bx
input3:
call getchar
cmp al,13
jz input4
cmp al,8
jz input8
cmp al,32
jb input3
input8:
cmp al,8
jnz input5
mov dx,inputptrpos
mov cx,inputptr
cmp dx,cx
jz input3
dec inputptrpos
mov al,32
mov bx,inputptrpos
mov [bx],al
jmp input22
input5: 
mov dx,inputptrpos
mov cx,inputcounter
cmp dx,cx
jz input3
mov bx,inputptrpos
mov [bx],al
inc bx
input22:
mov inputptrpos,bx
mov dx,inputpos
call gotoxy
mov cx,inputsize
mov bx,inputptr
call cprint 
jmp input3
input4:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret


variante:
mov bx,offset endf
mov variantetable,bx
mov varianteblock,0
mov cx,variantetablesize
clc
add bx,cx
inc bx
mov varianteptrpos,bx
ret


preserve:
push bx
push cx
push dx
push di
push si
push bp
mov bp,sp
mov bx,[bp+12]
mov dx,[bx]
cmp varianteblock,255
jz preserve1
mov si,varianteptrpos
mov ax,si
mov bx,variantetable
mov [bx],dx
inc bx
inc bx
mov [bx],si
clc 
add variantetable,4
mov bx,si
mov [bx],cx
clc 
add ax,cx
mov varianteptrpos,ax
mov ax,si
jmp preserve2:
preserve1:
mov ax,0ffffh
preserve2:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
ret



concat:
push ax
push bx
push cx
push dx
push di
push si
push bp
xchg dx,di
call copystr
call len
xchg bx,di 
clc
add dx,ax
call copystr
call len
clc
add dx,ax

xchg dx,bx
xor al,al
mov [bx],al
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret

displaystring db "0000H",0,0


display:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov cl,al
mov dx,offset displaystring
mov ax,[bx]
xchg bx,dx
call debugs
call print
cmp cl,0
jnz display1:
call enterLine
display1:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret


creat:
push cx
mov ah,3ch
xor cx,cx
int 21h
jnc creat1
mov ax,0ffffh
creat1:
pop cx
ret




open:
mov ah,3dh
mov al,2
int 21h
jnc open1
mov ax,0ffffh
open1:
ret


close:
mov ah,3eh
mov al,2
int 21h
jnc close1
mov ax,0ffffh
close1:
ret

write:
mov ah,40h
int 21h
jnc write1
mov ax,0ffffh
write1:
ret







endf db " "

