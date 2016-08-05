;mover para o registo bp o endereço da variavel mensagem
mov ax,offset menssagem

mov bx,ax

inc bx
inc bx
rotina:
push ax
call imprimir
mov cl,[bx]
inc cl
mov [bx],cl
pop ax
cmp cl,'9'
jnz rotina

 ;mover para ax o valor de retorno ao dos 0
mov ax,0
;chamar a rotina sair para sair ao dos
call sair
   
   

; variavel mensagem db data bytes termina $ final cadeia
menssagem db 13,10, '0$'



;rotina imprimir no ecra ax mensagem cadeia
imprimir:
     push dx
     mov dx, ax
     mov    ah, 9
     int    21h
     pop dx
     ret
sair:


;rotina sair para o dos ax saida
mov  ah, 4ch
   int  21h
ret

; rotina tecla tira uma tecla do ecra chama int 16h da bios
tecla:
mov ah,0
int 16h
ret

; rotina de entrada de cadeia do teclado
entrada:
push dx
push bp
push ax
mov dx,ax
mov ah,0ah
int 21h
pop bp
inc bp
mov ah,0
mov al,[bp]
clc
add ax,bp
mov bp,ax
inc bp
mov al,'$'
mov [bp],al
pop bp
pop dx
ret


som:
push cx
push dx
push bx
push bp
mov cx,1
mov ah,13h
mov al,0
mov bh,0
mov dx,0a00h
mov bl,7
mov bp,offset so
int 10h
pop bp
pop bx
pop dx
pop cx
ret

so db 7
