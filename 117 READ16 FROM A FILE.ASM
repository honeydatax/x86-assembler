JMP STACK
MAIN:                
                          
          mov al,10
          mov y,al                
          mov x,al                
                          
                          
          mov si,offset file1
          call open16
          JC EXITDO
          mov di,ax
          mov cx,15
          mov si,offset endf+1
          call read16
          call close16
                          
          mov byte endf,15
                          
          mov dx,offset endf
          call print
                          
                          
          EXITDO:                
                          
                          
          EXIT:                
                    int 20h                
                    xor ah,ah
                    int 21h                
                    RET                
                
                
file1    db   "marina.txt",0
                
                
                
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
                    JNZ FILL321
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
                    JNZ COPYMEM321
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
                
                
PRINT32:                
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          cmp ecx,0
          JZ PRINT3213
          mov al,x                
          mov bl,y                
          and ax,0ffh
          and bx,0ffh
          call gotoxy
          mov edi,eax
          cmp ecx,255
          JB PRINT3212
          mov ebx,255
          PRINT3212:
          mov edx,2
          call copymem32 
          mov al,x                
          mov bl,y                
          and ax,0ffh
          and bx,0ffh
          mov si,bx
          clc                
          add ax,cx
          cmp ax,80
          JB PRINT328
          mov bx,80
          sub ax,bx
          xor dx,dx
          xor cx,cx
          mov bx,80
          clc                
          div bx                
          clc                
          add ax,si
          cmp ax,24
          JB PRINT328
          mov ax,24
          PRINT328:
          mov y,ax                
          mov x,dx 
          PRINT3213:
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          pop eax                
          RET                
                
SCROLLUP:
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          push ds                
          mov ax,0                
          mov ds,ax
          mov edi,0b8000h
          mov esi,0b8000h+160  
          mov ecx,80*24*2
          mov edx,1
          call copymem32
          pop ds                
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          pop eax                
          RET                
                
STACK:                
          mov ax,cs
          mov bx,1000h
          clc                 
          add ax,bx
          mov ss,ax
          JMP MAIN                
          RET                
                
                
CREAT16:                
          push cx                
          push dx                
          mov dx,si
          xor cx,cx
          mov ah,3ch
          int 21h                
          pop dx                 
          pop cx                
          RET                
                
                
                
                
CLOSE16:                
          push bx                
          mov bx,di
          mov ah,3eh
          int 21h                
          pop bx                
          RET                
                
                
WRITE16:                
          push bx                
          push dx                
          mov dx,si
          mov bx,di
          mov ah,40h
          int 21h                
          pop dx                 
          pop bx                
          RET                
                
                
READ16:                
          push bx                
          push dx                
          mov dx,si
          mov bx,di
          mov ah,3fh
          int 21h                
          pop dx                 
          pop bx                
          RET                
                
                
OPEN16:                
          push cx                
          push dx                
          mov dx,si
          mov al,2                
          mov ah,3dh
          int 21h                
          pop dx                 
          pop cx                
          RET                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
endf   db " "
                
                
                
                
                
                
                
                
                
                
