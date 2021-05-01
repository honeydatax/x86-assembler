jmp head
error resb 1
c1 resw 1
ad1 resd 1
ad2 resd 1
ad3 resd 1
ad4 resd 1
ad5 resd 1
srce resw 1
values resw 1
xx resw 1
yy resw 1
nn resw 1
Px resw 1
py resb 1
xxx resw 1
ppack dB "90           $", 0
ppack2 dB "                      ", 0
ppack3 dB ".                       ", 0


NOP
NOP 

head:
;function to get a 64kb SS stack segment
call sp64k
init:
;return from sp64k 

;call main subrotine
call main
;exit
call exit

proc main
mov xx,1
mov yy,0
mov c1,5
mov px ,0
mov py,0

call cls




push cs
push offset ppack 
call a32
pop dword ad1



push cs
push offset ppack2
call a32
pop dword ad2


push word xx
push word yy
push word 61h
push word c1
call paint



push word xx
push word yy
push dword ad1
push word c1
call print

inc yy
inc yy
inc yy


push dword ad1
push word c1
call rnum
pop word c1


push word xx
push word yy
push word 61h
push word c1
call paint



push word xx
push word yy
push dword ad1
push word c1
call print


endproc



call exit 


proc exit


int 20h
ret
endproc


proc fillw(dword adress,dword counter,word value)

push DS
XOR AX,AX
mov DS,ax

mov esi,adress
mov ecx,counter
mov AX ,value
rotina:
mov DS:[esi],AX
inc esi
inc esi
dec ecx
CMP ecx,0 
jnz rotina

pop ds


endproc



proc step(dword adress,dword source ,dword counter,word st)

push DS
XOR AX,AX
mov DS,ax
mov edi,source
mov esi,adress
mov ecx,counter
mov BX,st
shl ebx,16
shr ebx,16
steprotina:
mov al,DS:[edi]
mov DS:[esi],al
inc edi
CLC 
add esi,ebx
dec ecx
CMP ecx,0 
jnz steprotina
pop ds

pop DX
pop BX
add sp,4*3+2
push BX
push dx




endproc



proc copy(dword adress, dword counter,word source,word st)

push DS
XOR AX,AX
mov DS,ax

mov esi,adress
mov ecx,counter
mov BX,st
shl ebx,16
shr ebx,16
mov ax,source
copyrotina:
mov DS:[esi],al

CLC 
add esi,ebx
dec ecx
CMP ecx,0 
jnz copyrotina

pop ds


endproc

proc gotoxy(word x,word y)

push DS
mov AX,y
mov BX,160
XOR DX,DX
XOR CX,CX
CLC
imul bx
mov BX,x
CLC
add BX,BX
CLC
add AX,BX
mov ebx,0b8000h
CLC 
shl eax,16
CLC
shr eax,16
CLC 
add eax ,ebx


pop ds


endproc


proc print(word x,word y, dword adress,word counter)

push word x
push word y
call gotoxy
add sp,2*2

mov ebx,eax

mov AX,counter
shl eax,16
shr eax,16


push  ebx
push dword adress
push eax
push word 2
call step
pop DX
pop bx
add sp,3*2+4
push BX
push dx
endproc


proc a32(word seg,word offs)
mov AX,seg
mov BX,offs
shl eax,16
shr eax,12
shl ebx,16
shr ebx,16
CLC 
add eax,ebx
pop DX
pop BX
add sp,4
push eax
push BX
push dx
endproc

proc sp64k
mov AX,CS
mov BX,1000h
add AX,BX
mov ss,ax
mov AX,0FFFfh
mov sp,AX
inc AX
push ax
jmp init
endproc

proc creat(word fname,word attr)
push ds
mov AX,CS
mov DS,AX
mov cX, attr
mov DX,fname

        mov ah,3ch
int 21h
jnc createrror
mov error,1
jmp createrrors:
createrror:
mov error,0
createrrors:
pop ds
endproc

proc open(word fname,word attr)

push ds
mov AX,CS
mov DS,AX
mov aX, attr
mov DX,fname

        mov ah,3dh
int 21h

jnc openerror
mov error,1
jmp openerrors:
openerror:
mov error,0
openerrors:
pop ds

endproc

proc close(word fhandler)
mov BX,fhandler
        mov ah,3eh
int 21h
endproc

proc read(word fhandler,word counter)
push ds

mov AX,ss
mov dX,1000h


CLC
add DX,ax
push DX
pop DS
XOR DX,DX
mov CX,counter
mov BX,fhandler
        mov ah,3fh
int 21h
pop ds
endproc

proc write(word fhandler,word counter)
push ds

mov AX,ss
mov dX,1000h


CLC
add DX,ax
push DX
pop DS
XOR DX,DX
mov CX,counter
mov BX,fhandler
        mov ah,40h
int 21h

pop ds
endproc


proc diskarea
mov AX,ss
mov dX,1000h
CLC
add AX,dx
push AX
push word 0
call a32
add sp,2*2
endproc



proc into32(word value)
;convert a 16 bits var into a 32 bits var
mov ax,value
CLC 
shl eax,16
shr eax,16
endproc



proc CLS


push dword 0b8000h
push dword 80*25
push word 07020h
call fillw
add sp,2*4+2

endproc

proc jmp32(dword addrs)
mov AX,cs
mov eBX,addrs
shl eax,16
shr eax,12
CLC 
sub ebx,eax
mov eax,ebx
endproc

proc jmpseg32(dword address,word offs)
mov AX,offs
shl eax,16
shr eax,16
mov ebx,address
CLC
add eax,ebx


endproc


proc clock

        push ds
        mov ax,40h
        mov ds,ax
        mov si,6ch
        mov eax,ds:[si]

        pop ds
endproc

proc check
        in al,60h
mov ah,al
AnD ah,127
CMP al,127
jb check1
XOR al,al
check1:
and al,127
pop BX
push AX
push BX
endproc    


proc ssleep(word ttime)

call clock
mov eBX,eAX
ssleepr1:
call clock
CMP eBX,eax
jz ssleepr1
mov AX,ttime
shl eax,16
shr eax,16
clc
add eBX,eAX
CMP eBX,0
jnz ssleepr2
inc ebx
ssleepr2:
call clock
CMP eBX,eax
jb ssleepr2
ssleepr3:
call clock
CMP eBX,eax
ja ssleepr3
pop DX
pop BX
add sp,2
push BX
push dx
endproc

proc cursor(word x,word y)
mov ax,x
mov dl,al
mov AX,y
mov dh,al
XOR BH,BH
mov ah,2
int 10h

pop DX
pop BX
clc
add sp,4
push BX
push dx

endproc

proc nibble(dword addrs,word value)
push DS
mov ebx,addrs
mov DX,value
mov cl,DL
and DL,0fh
and cl,0f0h
shr cl,4
XOR dh,dh
XOR ch,ch
XOR AX,AX
mov DS,ax
mov ax,offset nnible
CLC
add DX,AX
CLC 
add CX,AX
mov si,cX
mov al,CS:[si]
mov si,dx
mov ah,CS:[si]
mov DS:[ebx],ax
pop ds
pop DX
pop BX
CLC 
add sp,6
push BX
push dx

endproc


nnible dB "01234567890ABCDEF",0,0,0,0


proc STR(word value ,dword addres)
push ds
push word 0
pop ds
mov AX,value
mov esi,addres
       xor cx,cx
        xor dx,dx
        mov bx,10000
        clc
        idiv bx
        add al,30h
        mov ds:[esi],al
        inc esi
        mov ax,dx
        
        
        xor cx,cx
        xor dx,dx
        mov bx,1000
        clc
        idiv bx
        add al,30h
        mov ds:[esi],al
        inc esi
        mov ax,dx

        
        xor cx,cx
        xor dx,dx
        mov bx,100
        clc
        idiv bx
        add al,30h
        mov ds:[esi],al
        inc esi
        mov ax,dx

        xor cx,cx
        xor dx,dx
        mov bx,10
        clc
        idiv bx
        add al,30h
        mov ds:[esi],al
        inc esi
        mov ax,dx
        
        add al,30h
        mov ds:[esi],al
pop ds
pop DX
pop BX
CLC
add sp,6
push BX
push dx
endproc        

proc inputs(word x,word y,dword address,word counter)
push DS






mov AX,0
mov ds,ax


mov AX,x
mov dX,y


push AX
push dX
call cursor


mov edi,address
mov BX,counter
mov AX,x
mov dX,y

push AX
push dX
push edi
push BX
call print

mov CX,0
mov esi,address

input1:
mov ah,0
int 16h

CMP al,13
jz input2

CMP al,8
jnz input4
CMP CX,0
jz input4
dec CX
dec esi
mov al,32
mov DS:[esi],al
jmp input6

input4:

CMP al,32
JB input1

CMP cx,counter
jz input1

CMP CX,counter
ja input1




mov DS:[esi],al
inc CX
inc esi

input6:

push CX
push esi
mov AX,x
mov dX,y
clc
add AX,cx

push AX
push dX
call cursor

mov AX,x
mov dX,y
mov BX,counter
mov edi,address

push AX
push dX
push edi
push BX
call print


pop esi
POp CX

jmp input1
input2:


pop ds
pop DX
pop BX
clc
add sp,3*2+4
push BX
push dx
endproc

proc paint(word x,word y,word color,word counter)
push DS
XOR AX,AX
mov DS,ax

mov AX,x
mov BX,y

push AX
push bx
call gotoxy
add sp,2*2
mov esi,eax



mov cX,counter
mov dX,color

paint1:
inc esi
mov ds:[esi],dl
inc esi
dec cx
CMP CX,0
jnz paint1

pop ds
pop DX
pop BX
clc
add sp,4*2
push BX
push dx

endproc



ddebug dB "0000"
dddebug resd 1


proc rstring(dword source ,dword str2,dword count)
push ds
mov AX,0
mov DS,ax
mov esi,source
mov edi,str2
mov ecx,count
CLC 
add edi,ecx
dec edi

CMP ecx,0
jz rstring2

rstring1:
mov al,DS:[esi]
mov DS:[edi],al


inc esi
dec edi
dec ecx
CMP CX,0
jnz rstring1

rstring2:


pop ds


pop DX
pop BX
clc
add sp,4*3
push BX
push dx
endproc






proc debug(word value)
push DS
push eAX
push eBX
push eCX
push eDX
push esi
push edi

push CS
push offset ddebug
call a32
pop dddebug


push dddebug
mov di,value
push di
call nibble


push word 0
push word 24
push dddebug
push word 2
call print

pop edi
pop esi
pop edx
pop ecx
pop ebx
pop eax

pop ds
pop DX
pop BX
add sp,2
push BX
push dx
endproc 


proc rchar(dword source,dword count, word  from , word to)
push DS
mov AX,0
mov DS,ax

mov esi,source
mov ecx,count
mov AX,from
mov BX,to


CMP CX,0
jz rchar2


rchar1:
mov ah,ds:[esi]
CMP ah,al
jnz rchar3
mov DS:[esi],bl
rchar3:
inc esi
dec ecx
CMP CX,0
jnz rchar1

rchar2:

pop ds
pop DX
pop BX
add sp,2*4+2*2
push BX
push dx
endproc


proc rnum(dword source,word count)
push DS
XOR AX,AX
mov DS,AX
mov esi,source
mov BX,0
mov CX,count


CMP CX,0
jz rnum2


rnum1:
mov al,DS:[esi]
CMP al,'0'
jb rnum2
CMP al,'9'
ja rnum2
inc esi
inc BX
dec CX
CMP CX,0
jnz rnum1

rnum2:
mov ax,bx

pop ds
pop DX
pop BX
add sp,4+2
push ax
push BX
push dx
endproc




endf dB 90h









