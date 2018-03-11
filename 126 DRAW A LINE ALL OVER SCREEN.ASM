JMP STACK
seg2 resw 1
address1 resd 1
MAIN:                
                          
          call graphics
                          
          push ds                
                          
          mov ax,0a000h
          mov ds,ax
          mov ax,0                
          mov bx,0                
          mov dx,319
          mov bp,199
          mov cx,15
                          
          call box                
                          
          pop ds                
                          
                          
          call getkey
                          
          call text
                          
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
                
                
GRAPHICS:
          push ax                
          mov ax,13h
          int 10h                
          pop ax                
          RET                
                
TEXT:                
          push ax                
          mov ax,3                
          int 10h                
          pop ax                
          RET                
                
                
GETKEY:                
          mov ax,0                
          int 16h                
          RET                
                
                
SETPALETE:
          push eax                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          mov eax,esi
          mov ebx,256*3
          clc                
          add eax,ebx
          mov edi,eax
          mov dx,03c8h
          mov al,0                
          out dx,al
          inc dx                
          SETPALETE2:
                    mov al,ds:[esi]
                    out dx,al
                    inc esi                
                    cmp esi,edi
                    JB SETPALETE2
          pop esi                 
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          pop eax                
          RET                
                
                
                
GETRGB:                
          mov bl,al
          mov ah,al
          and bl,11000000b
          and al,00000111b
          and ah,00111000b
          clc                
          shr bl,6                
          clc                
          shr ah,3                
          RET                
                
STORERGB:
          mov ds:[edi],al
          inc edi                
          mov ds:[edi],ah
          inc edi                
          mov ds:[edi],bl
          inc edi                
          RET                
                
                
CREATPALLET:
          push ax                
          push bx                
          push cx                
          push dx                
          mov edi,esi
          mov cx,0                
          CREATPALLET1:
                    mov al,cl
                    call getrgb
                    call storergb
                    inc cx                
                    cmp cx,256
                    JB CREATPALLET1
          call setpalete
          mov edi,esi
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
FILL:                
          push bp                
          push cx                
          push ax                
          @MFILL1:                
                    mov ds:[bp],al
                    inc bp                
                    cmp bp,cx
                    JNZ @MFILL1
          pop ax                
          pop cx                
          pop bp                
          RET                
                
                
                
                
LINE:                
          push bp                
          push dx                
          push cx                
          push bx                
          push ax                
          push ds                
                          
          and ax,511
          and bx,255
          and dx,511
          clc                
          sub dx,ax
          and dx,511
          push cx                
          push dx                
          push ax                
          mov ax,320
          xor dx,dx
          xor cx,cx
          clc                
          imul bx                
          clc                
          pop bx                
          xor dx,dx
          xor cx,cx
          add ax,bx
          mov bp,ax
          pop cx                
          add cx,bp
          pop ax                
          mov dx,0a000h
          mov ds,dx
          call fill
                          
          pop ds                
          pop ax                
          pop bx                
          pop cx                
          pop dx                
          pop bp                
          RET                
                
                
                
                
BOX:                
          push si                
          push di                
          push ds                
          push bp                
          push dx                
          push cx                
          push bx                
          push ax                
          and ax,511
          and bx,255
          and dx,511
          and bp,255
          cmp ax,dx
          JB @BOX1                
          xchg ax,dx
          @BOX1:                
          cmp bx,bp
          JB @BOX2                
          xchg bx,bp
          @BOX2:                
          mov si,bp
          mov bp,offset boxxx1
          mov cs:[bp],ax
          mov bp,offset boxxx2
          mov cs:[bp],dx
          mov bp,offset boxyy1
          mov cs:[bp],bx
          mov bp,offset boxyy2
          mov cs:[bp],si
          mov bp,offset boxcolor
          mov cs:[bp],cl
                          
                          
                          
          mov bp,offset boxyy1
          mov ax,cs:[bp]
          mov bx,320
          xor dx,dx
          clc                
          imul bx                
          mov bp,offset boxxx1
          mov bx,cs:[bp]
          clc                
          add ax,bx
                          
          mov bp,offset boxstart
          mov cs:[bp],ax
                          
          mov bp,offset boxxx1
          mov bx,cs:[bp]
          mov bp,offset boxxx2
          mov ax,cs:[bp]
                          
          sub ax,bx
          mov bp,offset boxxxx
          mov cs:[bp],ax
          mov bx,ax
          mov ax,320
          sub ax,bx
          mov bp,offset boxxxxx
          mov cs:[bp],ax
                          
                          
          mov bp,offset boxyy1
          mov bx,cs:[bp]
          mov bp,offset boxyy2
          mov ax,cs:[bp]
                          
          sub ax,bx
          mov bp,offset boxyyy
          mov cs:[bp],ax
                          
          ;push start -------------------
                          
          mov bp,offset boxstart
          mov ax,cs:[bp] 
          push ax                
                          
          mov bp,offset boxcolor
          mov ax,cs:[bp] 
          push ax                
                          
          mov bp,offset boxyyy
          mov ax,cs:[bp] 
          push ax                
                          
                          
          mov bp,offset boxxxx
          mov ax,cs:[bp] 
          push ax                
                          
          mov bp,offset boxxxxx
          mov ax,cs:[bp] 
          mov dx,ax
                          
          pop si                
          pop bx                
          pop ax                
          pop bp                
                          
                          
                          
                          
          @BOXLOOP1:
                    mov cx,si
                    @BOXLOOP2:
                              mov ds:[bp],al
                              inc bp                
                              dec cx                
                              JNZ @BOXLOOP2
                    clc                
                    add bp,dx
                    dec bx                
                    JNZ @BOXLOOP1
                          
                          
                          
                          
                          
                          
          pop ax                
          pop bx                
          pop cx                
          pop dx                
          pop bp                
          pop ds                
          pop di                
          pop si                
          RET                
                
                
boxxx1     dw      0
boxxx2     dw      0
boxyy1     dw      0
boxyy2     dw      0
boxxxx     dw      0  
boxyyy     dw      0  
boxxxxx    dw      0  
boxyyyy    dw      0  
boxstart   dw      0  
boxcolor   dw      0  
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
endf   db " "
                
                
                
                
                
                
                
                
                
                
