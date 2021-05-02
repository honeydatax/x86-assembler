
push dword 120000h
push dword 0f0000h
push word 0h
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