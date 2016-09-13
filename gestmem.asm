jmp start
add1 resd 1
add2 resd 1
c1 resd 1
c2 resd 1
start:
mov c1,0f0000h
mov c2,0f0000h

call reset

push dword c1
call getmem
pop add1



push dword add1
push dword c1
call clear


push dword c2
call getmem
pop add2



push dword add2
push dword c2
call clear



push dword add1
call free 

push dword add2
call free 


int 20h


proc fillb(dword address,dword count ,word value)
push ds
mov ax,0
mov ds,ax
mov ax,value
mov ebx,address
mov ecx,count
fill1:
mov ds:[ebx],al
inc ebx
dec ecx
cmp ecx,0
jnz fill1


pop ds
pop dx
pop bx
add sp,2*4+2
push bx
push dx
endproc 


proc reset
push DS
mov AX,0
mov DS,ax
mov ebx,11fffah
mov eax,120000h
mov DS:[ebx],eax

pop ds
endproc

proc getmem(dword size)
push DS
mov AX,0
mov DS,ax
mov ebx,11fffah
mov eax,DS:[ebx]
mov esi,6
mov edx,size
CLC
add edx,esi
mov DS:[eax],edx
CLC
add edx,eax
CLC

mov DS:[ebx],edx
inc eax
inc eax
inc eax
inc eax
mov BL,'M'
inc eax

pop ds

pop dx
pop bx
add sp,4
push eax
push bx
push dx

endproc

proc free(dword address)
push DS
mov AX,0
mov DS,ax

mov ebx,address
dec ebx
mov al,'F'
mov DS:[ebx],al
pop ds

pop dx
pop bx
add sp,4
push eax
push bx
push dx
endproc

proc clear(dword address,dword count)

push dword address
push dword count
push word 0h
call fillb

pop dx
pop bx
add sp,2*4
push bx
push dx
endproc
