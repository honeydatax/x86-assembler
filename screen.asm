jmp start
c1 resw 1
addrs resw 1
start:
push word 0
call screen

mov word c1,255
mov word addrs,offset endf


rotina:
mov BX,addrs
mov AX,c1
mov CS:[BX],al
inc addrs
dec c1
CMP c1,0
jnz rotina

push ds
mov BX,268
mov AX,0
mov DS,AX
mov AX,0000
mov DS:[BX],AX
inc bx
inc bx
mov AX,0f000h
mov DS:[BX],AX
pop ds



push offset endf
call print


mov AX,0
int 16h


call exit


proc screen(word value)
mov AX,value
mov ah,0
int 10h
pop DX
pop BX
add sp,2
push BX
push dx
endproc


proc exit
int 20h
endproc


proc print(word adrres)
mov DX,adrres
mov ah,9
int 21h
pop DX
pop BX
add sp,2
push BX
push dx
endproc



endf dB " "
