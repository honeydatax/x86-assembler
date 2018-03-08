jmp init                
cchar resb 1
char1 resb 1
char2 resb 1
init:                
          mov cchar,255
                          
          ffor:                
                    mov al,cchar
                    call printf
                    dec cchar
                    cmp cchar,255
          JNZ FFOR                
                          
          call exit
                          
          exit:                
                    int 20h                
                    RET                
                
printf:                
                          
          xor bh,bh
          mov bl,70
          mov ah,0eh
          int 10h                
          RET                
