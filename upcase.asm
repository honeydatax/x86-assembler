section .text
 global _start       ;must be declared for using gcc
_start:                     ;tell linker entry point
mov rbx,msg
call UPPERSTR

 mov rdx, len    ;message length
 mov rcx, msg    ;message to write
 mov rbx, 1     ;file descriptor (stdout)
 mov rax, 4     ;system call number (sys_write)
 int 0x80        ;call kernel
 mov rax, 1     ;system call number (sys_exit)
 int 0x80        ;call kernel

str64:
          push rax                
          push rbx                
          push rcx                
          push rdx                
          push rdi                
          push rsi                
          push rbp                
          mov rsi,rbx
          mov rdi,rdx
          mov rax,[rsi]
          mov rbp, 1000000000000000000
          STR321:                
                    xor rdx,rdx
                    xor rcx,rcx
                    mov rbx,rbp
                    clc                 
                    div rbx                
                    mov rsi,rdx
                    mov ah,'0'
                    clc                
                    add al,ah
                    mov [rdi],al
                    inc rdi                
                    mov rax,rbp
                    xor rdx,rdx
                    xor rcx,rcx
                    mov rbx,10
                    clc                
                    div rbx                
                    mov rbp,rax
                    mov rax,rsi
                    cmp rbp,0
                    JNZ STR321

          pop rbp                
          pop rsi                
          pop rdi                
          pop rdx                
          pop rcx                
          pop rbx                
          pop rax                
ret

           UPPERSTR:
          push rax                
          push rbx                
          push rcx                
          push rdx                
          UPPERSTR1:
                    mov al,[rbx]
                    cmp al,0                
                    JZ UPPERSTR2
                    cmp al,'a'
                    JB UPPERSTR3
                    cmp al,'z'
                    JA UPPERSTR3
                    mov ah,'a'-'A'
                    sub al,ah
                    mov [rbx],al
                    UPPERSTR3:
                    inc rbx                
                    dec rcx                
                    cmp rcx,0                
                    JNZ UPPERSTR1
          UPPERSTR2:
          mov rax,rcx
          pop rdx                
          pop rcx                
          pop rbx                
          pop rax                
          RET                
                
                
                
                     

                
                
                

section .data

endf db " "

number dq 987654321,0
msg db 'this is a string._________________________________',0xa,0,0 ;our dear string
len equ $ - msg ;length of our dear string



