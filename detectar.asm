;mover cx o contador de numeros 
mov cx,0
;lista numeros
mov ax,offset numeros
rotina:
; move para bx o endereç da variavel mesagem2
mov bx,offset mensagem2
;guarda no stack point o index da lista numero
push ax
call teste
;converte valor de uma variavel numa cadeia de representação de um numero
call numero
; endereço da cadeia de texto de representação do numero mais o carater nova linha
mov ax,offset menssagem
;chama a rotina imprimir no ecra
call imprimir
; tira do stack point o endereço do index do numero na lista
pop ax
inc ax
inc cx
;conta 8 numeros na lista
cmp cx,8
jnz rotina


 ;mover para ax o valor de retorno ao dos 0
mov ax,0
;chamar a rotina sair para sair ao dos
call sair
   
   

; variavel mensagem db data bytes termina $ final cadeia
menssagem db 13,10,'-'
mensagem2  db '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
numeros db -123,100,-12,50,-13,10,-60,90,-34,67,-56,45


;rotina imprimir no ecra ax mensagem cadeia
imprimir:
push cx
push bx
push ax
     push dx
     mov dx, ax
     mov    ah, 9
     int    21h

     pop dx
pop ax
pop bx
pop cx

     ret


cor:
push ax
push bx
push dx
push cx
push bp
mov dh,cl
mov dl,ch
mov bp,ax
mov ch,0
mov cl,bl
mov bl,bh
mov bh,0
mov ah,13h
mov al,1
int 10h
pop bp
pop cx
pop dx
pop bx
pop ax
ret

sair:
;rotina sair para o dos ax saida
mov  ah, 4ch
   int  21h
ret

teste:
push ax
push bx
push cx
push dx
push bp
push si
push di

push ax
mov bp,ax
mov al,[bp]
mov ah,128
and al,ah
dec bx
cmp al,0
jz test1
pop ax
call negativo
mov al,'-'
mov [bx],al
jmp test2
test1:
mov al,'+'
mov [bx],al
pop ax
test2:
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
ret

negativo:
push ax
push bx
push cx
push dx
push bp

mov bp,ax
mov al, [bp]
neg al
inc al
mov  [bp],al
pop bp
pop dx
pop cx
pop bx
pop ax
ret 

;rotina numero converte um numero numa cadeia de texto da sua representação
numero:
;guarda todos os registos para os reverter e os proteger
push ax
push bx
push cx
push dx
push bp
push si
push di
; enche a representação da cadeia o carater fim de cadeia
mov bp,ax
xor cx,cx
push bx
numero1:
mov al,'$'
mov [bx],al
inc bx
inc cx
cmp cx,4
jnz numero1
pop bx
;divide o numero por 100 nas centenas
numero2:
xor cx,cx
xor dx,dx
xor ax,ax
mov al,[bp]
mov cx,100
clc
idiv cx
xor cx,cx
mov cl,'0'
clc
add ax,cx
mov [bx],al
xor ax,ax
mov al,dl
inc bx
;divide o numero por 10 nas dezenas
numero3:
xor cx,cx
xor dx,dx
mov cx,10
clc
idiv cx
xor cx,cx
mov cl,'0'
clc
add ax,cx
mov [bx],al
xor ax,ax
mov al,dl
inc bx
;divide o numero por 1 nas unidades
numero4:
xor cx,cx
xor dx,dx
mov cx,1
clc
idiv cx
xor cx,cx
mov cl,'0'
clc
add ax,cx
mov [bx],al
numero5:
pop di
pop si
pop bp
pop dx
pop cx
pop bx
pop ax
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
