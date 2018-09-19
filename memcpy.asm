section .text

 global _start       ;must be declared for using gcc
_start:                     ;tell linker entry point



mov rbx,msg
mov rdx,msg2
mov rcx,len
call COPYMEM
mov rax,msg2
    mov rdx, len    ;message length
 mov rcx, msg2    ;message to write
call printf
call exits
                
COPYMEM:                
          push rax                
          push rbx                
          push rcx                
          push rdx                
          push rdi                
          push rsi                
          mov rsi,rbx
          mov rdi,rdx
          COPYMEM1:
                    mov al,[rsi]
                    mov [rdi],al
                    inc rdi                
                    inc rsi                
                    dec rcx                
                    JNZ COPYMEM1
          COPYMEM2:
                    pop rsi                
                    pop rdi                
                    pop rdx                
                    pop rcx                
                    pop rbx                
                    pop rax                
                    RET                
                
                
   
   printf:

 mov rbx, 1     ;file descriptor (stdout)
 mov rax, 4     ;system call number (sys_write)
 int 0x80        ;call kernel
   ret
   
   
exits:       
 mov rax, 1     ;system call number (sys_exit)
 int 0x80        ;call kernel
                


section .data



msg db '.....................................................',0 ;our dear string
len equ $ - msg ;length of our dear q
msg2 db 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',0 ;our dear string
len2 equ $ - msg2 ;length of our dear q