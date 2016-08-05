;mover para o registo ax o endereço da variavel mensagem
mov ax,offset menssagem
;chamar rotina imprimir
call imprimir


rotina:
;chama a rotina tecla o valor ax retorna tecla precionada
call tecla
;compara al com 65 o valor da tecla A
cmp al,65
;salta para para a rotina se não for igual a 65 
jnz rotina
call som
 ;mover para ax o valor de retorno ao dos 0
mov ax,0
;chamar a rotina sair para sair ao dos
call sair
   
   

; variavel mensagem db data bytes termina $ final cadeia
menssagem db 'carregue em A para sair$'



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

som:
mov cx,1
mov ah,13h
mov al,0
mov bh,0
mov dx,0a00h
mov bl,7
mov bp,offset so
int 10h
ret

so db 7
