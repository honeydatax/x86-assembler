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
push word 1h
call fillb


push dword c2
call getmem
pop add2



push dword add2
push dword c2
push word 2h
call fillb



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
add sp,2*2+4
push bx
push dx
endproc 


proc reset
push DS
mov AX,0
mov DS,ax
mov ebx,11fffah
mov eax,12000h
mov DS:[ebx],eax

pop ds
endproc

proc getmem(dword size)
push DS
mov AX,0
mov DS,ax
mov ebx,11fffah
mov eax,DS:[ebx]
mov edx,size
CLC
add edx,eax
mov DS:[ebx],edx

pop ds

pop dx
pop bx
add sp,2
push eax
push bx
push dx

endproc
