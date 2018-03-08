jmp init                
cchar resb 1
char1 resb 1
char2 resb 1
init:                
          mov cchar,'0'
          mov char2,13
          mov char1,10
          ffor:                
                    mov al,cchar
                    call printf
                    mov al,char2
                    call printf
                    mov al,char1
                    call printf
                    inc cchar
                    cmp cchar,'9'+1
          JB FFOR                
                          
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
