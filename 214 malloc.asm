mov cx,50
call malloc
mov si,offset addresss
mov cs:[si],ax
mov di,ax
mov cx,26
mov al,'a'

dos:
mov cs:[di],al
inc al
inc di
dec cx
jnz dos

mov al,'$'
mov cs:[di],al


mov ax,cs:[si]
mov dx,ax
mov ah,9
int 21h



mov cx,50
call malloc
mov si,offset addresss2
mov cs:[si],ax
mov di,ax
mov cx,26

mov al,'A'

dos2:
mov cs:[di],al
inc al
inc di
dec cx
jnz dos2



mov al,'$'
mov cs:[di],al


mov ax,cs:[si]
mov dx,ax
mov ah,9
int 21h
mov ah,0
int 21h


malloc:
push bx
push cx
push dx
push bp
push si
push di
jmp malloc1
malloc2 dw 0,0
malloc1:
mov ax,malloc2
cmp ax,0
jnz malloc3
mov ax,offset endf
mov si,malloc2
mov cs:[si],ax
malloc3:

mov si,malloc2
mov di,cs:[si]
inc cx
mov cs:[di],cx
inc cx
add di,2
mov bp,di
add bp,cx
mov al,0
mov cs:[bp],al
inc bp
mov cs:[si],bp
mov ax,di
pop di
pop si
pop bp
pop dx
pop cx 
pop bx
ret


addresss dw 0,0
addresss2 dw 0,0

endf db 0
