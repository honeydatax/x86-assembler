jmp main
counter resd 1
counter2 resd 1
counter3 resd 1
main:


mov dword counter,1
mov dword counter2,10
mov dword counter3,1

for1:
mov bx,offset counter
mov dx,offset text1
call phoneformat


mov bx,offset text1
call print 


xor edx,edx
xor ecx,ecx
mov eax,counter
mov ebx,counter2

mul ebx


inc counter3
mov ebx,counter3
clc
add eax,ebx

mov counter,eax


cmp counter,1000000000
jb for1



;-------------------------------
exit:
int 20h
ret


text1     db "0.000.000.000.",13,10,0


;fcb file control block 
fcbl     db 0,0,0,0,0,0,0,0,0
fcb      db 0
fcbname  db "MARINA  "
fcbext   db "TXT"
fcbblock dw 0
fcbrecsz dw 1
fcba1    db 0
fcbb1    dw 0,0,0,0,0,0,0,0
fcbflsz1 dw 0
fcbflsz0 dw 0
fcbdate  dw 0
fcbtime  dw 0
fcblll   dd 0,0,0,0,0,0,0,0,0,0,0,0,0,0
;fcb file control block 



;-------------------------------
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


filepoint:
mov ah,42h
int 21h
ret

read:
mov ah,3fh
int 21h
ret

filesize:
mov ah,23h
int 21h
ret


cript:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov cx,0
cript1:
mov al,[bx]
cmp al,0
jz cript2:
not al
mov [bx],al
inc bx
dec cx
cmp cx,0
jnz cript1
cript2:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret



criptb:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov cx,0
criptb1:
mov al,[bx]
cmp al,0
jz criptb2:
inc al
mov [bx],al
inc bx
dec cx
cmp cx,0
jnz criptb1
criptb2:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret



criptc:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov cx,0
criptc1:
mov al,[bx]
cmp al,0
jz criptc2:
dec al
mov [bx],al
inc bx
dec cx
cmp cx,0
jnz criptc1
criptc2:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret

key:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov bx,di
jmp key3
keycounter1 resw 1
keycounter2 resw 1
keycounter3 resw 1
key3:
mov keycounter1,di
mov keycounter2,dx
key1:
mov al,[si]
mov ah,[di]
clc
add al,ah
mov [si],al
inc si
inc di
dec dx
cmp dx,0
jnz key2
mov dx,keycounter2
mov di,keycounter1
key2:
dec cx
cmp cx,0
jnz key1
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret

unkey:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov bx,di
jmp unkey3
unkeycounter1 resw 1
unkeycounter2 resw 1
unkeycounter3 resw 1
unkey3:
mov unkeycounter1,di
mov unkeycounter2,dx
unkey1:
mov al,[si]
mov ah,[di]
clc
sub al,ah
mov [si],al
inc si
inc di
dec dx
cmp dx,0
jnz unkey2
mov dx,unkeycounter2
mov di,unkeycounter1
unkey2:
dec cx
cmp cx,0
jnz unkey1
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret

ltrimstring:
push bx
push cx
push dx
push di
push si
push bp
mov cx,0
ltrimstring1:
mov al,[bx]
cmp al,32
jnz ltrimstring2
inc bx
dec cx
cmp cx,0
jnz ltrimstring1
ltrimstring2:
mov ax,bx
pop bp
pop si
pop di
pop dx
pop cx
pop bx
ret


rtrimstring:
push ax
push bx
push cx
push dx
push di
push si
push bp
call len
mov cx,ax
cmp ax,256
jb rtrimstring10
mov cx,0
rtrimstring10:
dec cx
clc 
add bx,cx
rtrimstring1:
mov al,[bx]
cmp al,32
jnz rtrimstring2
mov al,0
mov [bx],al
dec bx
dec cx
cmp cx,0
jnz rtrimstring1
rtrimstring2:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret


str32:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov si,bx
mov di,dx
mov eax,[si]
mov ebp,1000000000
str321:
xor edx,edx
xor ecx,ecx
mov ebx,ebp
clc 
div ebx
mov esi,edx
mov ah,'0'
clc
add al,ah
mov [di],al
inc di
mov eax,ebp
xor edx,edx
xor ecx,ecx
mov ebx,10
clc
div ebx
mov ebp,eax
mov eax,esi
cmp ebp,0
jnz str321

pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret


zero32:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov cx,9
zero321:
mov al,[bx]
cmp al,'0'
jnz zero322
mov al,32
mov [bx],al
inc bx
dec cx
cmp cx,0
jnz zero321
zero322:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret


trimstring:
call rtrimstring
call ltrimstring
ret


moveltrim:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov bp,bx
call ltrimstring
mov bx,ax
mov si,ax
mov di,bp
call len
inc ax
mov cx,ax
call moveback
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret

stringreverse:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov si,bx
mov di,dx
call len
mov cx,ax
clc
add di,cx
mov al,0
mov [di],al
dec di
stringreverse1:
mov al,[si]
mov [di],al
dec di
inc si
loop stringreverse1

pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret



string:
push ax
push bx
push cx
push dx
push di
push si
push bp
string1:
mov [bx],al
inc bx
loop string1
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret



spaces:
push ax
mov al,' '
call string
pop ax
ret


endstring:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov al,0
clc
add bx,cx
mov [bx],al

pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret



null:
push ax
call asc
cmp al,0
jz null1 
clc
jmp null3:
null1:
stc
jmp null3:
null3:
pop ax
ret

checkcounter:
cmp cx,0
jz checkcounter1 
clc
jmp checkcounter3:
checkcounter1:
stc
jmp checkcounter3:
checkcounter3:
ret


printlist:
push ax
push bx
push cx
push dx
push di
push si
push bp
printlist1:
call asc
cmp al,1
jz printlist2
call print 
xchg bx,dx
call print 
xchg bx,dx
call len
clc
add bx,ax
inc bx
jmp printlist1
printlist2:
pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret

strformat:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov si,bx
mov di,dx
mov al,2
push ax
mov eax,[si]
mov ebp,1000000000
strformat1:
xor edx,edx
xor ecx,ecx
mov ebx,ebp
clc 
div ebx
mov esi,edx
mov ah,'0'
clc
add al,ah
mov [di],al
inc di
pop ax
inc al
cmp al,3
jnz strformat3
mov ah,27h
mov [di],ah
inc di
mov al,0
strformat3:
push ax
mov eax,ebp
xor edx,edx
xor ecx,ecx
mov ebx,10
clc
div ebx
mov ebp,eax
mov eax,esi
cmp ebp,0
jnz strformat1
pop ax

pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret

phoneformat:
push ax
push bx
push cx
push dx
push di
push si
push bp
mov si,bx
mov di,dx
mov al,2
push ax
mov eax,[si]
mov ebp,1000000000
phoneformat1:
xor edx,edx
xor ecx,ecx
mov ebx,ebp
clc 
div ebx
mov esi,edx
mov ah,'0'
clc
add al,ah
mov [di],al
inc di
pop ax
inc al
cmp al,3
jnz phoneformat3
mov ah,32
mov [di],ah
inc di
mov al,0
phoneformat3:
push ax
mov eax,ebp
xor edx,edx
xor ecx,ecx
mov ebx,10
clc
div ebx
mov ebp,eax
mov eax,esi
cmp ebp,0
jnz phoneformat1
pop ax

pop bp
pop si
pop di
pop dx
pop cx
pop bx
pop ax
ret





endf db " "

