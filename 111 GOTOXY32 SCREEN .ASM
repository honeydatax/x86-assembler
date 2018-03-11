JMP MAIN                
sourcetext resd 1
destenytext resd 1
MAIN:                
                          
          mov si,offset text1+1
          mov ax,cs
          call mem32
                          
          mov esi,eax
          mov ecx,1
          mov edx,2
                          
                          
          FOR1:                
                    mov ax,cx
                    mov bx,cx
                    call gotoxy
                    mov edi,eax
                    call copymem32
                                    
                    inc cx                
                    cmp ecx,16
                    JB FOR1                
                          
                          
                          
          EXITDO:                
                                    
                                    
                    EXIT:                
                              int 20h                
                              xor ah,ah
                              int 21h                
                              RET                
                
                
                
text1    db   15,"im love marina.",0
                
                
                
                
x     db 0     
y     db 0
color dw 07h
                
PRINT:                
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          push es                
          mov ax,cs
          mov es,ax
          xchg dx,bp 
          mov bx,bp
          mov cl,cs:[bx]
          inc bp                
          and cx,0ffh 
          mov bx,offset x
          mov dx,cs:[bx]
          mov bx,offset color
          mov al,cs:[bx]
          mov bl,al
          mov bh,0                
          mov al,0                
          mov ah,13h
          int 10h                
          pop es                
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
FILL32:                
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          push ds                
          mov bp,0                
          mov ds,bp
          cmp edx,0
          JNZ FILL3211
          inc edx                
          FILL3211:
          FILL321:                
                    mov ds:[edi],al
                    clc                
                    add edi,edx
                    dec ecx                
                    JNZ FILL321:
                    pop ds                
                    pop ebp                
                    pop edi                
                    pop esi                
                    pop edx                
                    pop ecx                 
                    pop ebx                
                    pop eax                
                    RET                
                
                
                
                
COPYMEM32:
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          push ds                
          mov bp,0                
          mov ds,bp
          cmp edx,0
          JNZ COPYMEM3211
          inc edx                
          COPYMEM3211:
          cmp ecx,0
          JZ COPYMEM326
          COPYMEM321:
                    mov al,ds:[esi]
                    mov ds:[edi],al
                    clc                
                    add edi,edx
                    inc esi                
                    dec ecx                
                    JNZ COPYMEM321:
                    COPYMEM326:
                    pop ds                
                    pop ebp                
                    pop edi                
                    pop esi                
                    pop edx                
                    pop ecx                 
                    pop ebx                
                    pop eax                
                    RET                
                
                
                
MEM32:                
          push esi                
                          
          and eax,0ffffh
          clc                
          shl eax,4
          and esi,0ffffh
          clc                 
          add eax,esi
                          
          pop esi                
          RET                
                
                
                
GOTOXY:                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          mov si,ax
          mov di,bx
          and si,0fffh
          and di,0fffh
          xor cx,cx
          xor dx,dx
          mov ax,si
          mov bx,2                
          clc                
          mul bx                
          mov si,ax
          mov ax,di
          mov bx,160
          clc                
          mul bx                
          mov bx,si
          clc                
          add ax,bx
          and eax,0ffffh
          mov ebx,0b8000h
          clc                
          add eax,ebx
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          RET                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
endf   db " "
                
                
                
                
                
                
                
                
                
                
