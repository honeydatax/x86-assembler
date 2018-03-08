jmp init                
cchar resb 1
char1 resb 1
char2 resb 1
init:                
          mov cchar,'Z'
          mov char1,2
                          
          ffor:                
                    mov al,cchar
                    call printf
                    mov al,char1
                    sub cchar,al
                    cmp cchar,'A'-1
          JA FFOR                
                          
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
