;mover para o registo ax o endereço da variavel mensagem
mov ax,offset menssagem
;chamar rotina imprimir
call imprimir
;mover para ax o valor de retorno ao dos 0
mov ax,0
;chamar a rotina sair para sair ao dos
call sair
   
   

; variavel mensagem db data bytes termina $ final cadeia
menssagem db 'http://playstores.esy.es',7,'$'



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

