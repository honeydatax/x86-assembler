mov bx,offset endf
                
ffor:                
          mov al,[bx]
          call printf
          inc bx                
          cmp bx,offset endf+26
JB FFOR                
                
                
exit:                
          int 20h                
          RET                
                
printf:                
          push ax                
          push bx                
          xor bh,bh
          mov bl,70h
          mov ah,0eh
          int 10h                
          pop bx                
          pop ax                
          RET                
                
                
endf db "ABCDEFGHIJKLMNOPQRSTUVWXYZ$."
