JMP STACK
xx resw 1
yy resw 1
MAIN:                
                          
          mov byte x,10
          mov byte y,10
                          
                          
          call graphics
                          
          mov esi,130000h
          call creatpallet
                          
          mov al,255
          mov edi,0a0000h
          mov ecx,320*200
          mov edx,1
          call fill32
                          
                          
          mov ax,cs
          mov bx,2000h
          clc                 
          add ax,bx
                          
          push ds                
          mov ds,ax
          mov di,0                
          mov si,offset file1
          mov ax,cs
          call loadbitmap
          pop ds                
          cmp ax,0ffffh
          JZ ERROR1:
          push ds                
          push es                
                          
          mov ax,cs
          mov bx,2000h
          clc                 
          add ax,bx
          mov ds,ax
          mov ax,0a000h
          mov es,ax
          mov ax,0                
          mov bx,0                
          call drawbitmap
          pop es                
          pop ds                
          cmp ax,0ffffh
          JZ ERROR1:
                          
                          
                          
          call getkey
          call text
          JMP ESCERROR
          ERROR1:                
          call text
          mov dx,offset text1
          call print 
          ESCERROR:
                          
          EXITDO:                
                                    
                                    
                    EXIT:                
                              int 20h                
                              xor ah,ah
                              int 21h                
                              RET                
                
                
file1    db   "128.bmp",0
text1    db  18,"error open a files.",0
                
                
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
          clc                
          int 21h                
          JNC OPEN163
          mov ax,0ffffh
          OPEN163:                
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
          shr bl,2                
          clc                
          shl al,3                
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
                
                
LOADBITMAP:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          push ds                
          mov ds,ax
          call open16
          pop ds                
          cmp ax,0ffffh
          JZ LOADBITMAP1
          xchg si,di
          mov dx,si
          mov di,ax
          mov cx,1024*63
          call read16
          call close16
          mov si,dx
          mov al,ds:[si]
          cmp al,'B'
          JNZ LOADBITMAP2
          inc si                
          mov al,ds:[si]
          cmp al,'M'
          JNZ LOADBITMAP2
          inc si                
          mov eax,ds:[si]
          cmp eax,63*1024
          JA LOADBITMAP2
          mov bx,16
          clc                
          add si,bx
          mov eax,ds:[si]
          cmp eax,319
          JA LOADBITMAP2
          inc si                
          inc si                
          inc si                
          inc si                
          mov eax,ds:[si]
          cmp eax,199
          JA LOADBITMAP2
          inc si                
          inc si                
          inc si                
          inc si                
          mov ax,ds:[si]
          cmp ax,1                
          JNZ LOADBITMAP2
          inc si                
          inc si                
          mov ax,ds:[si]
          cmp ax,24
          JNZ LOADBITMAP2
          inc si                
          inc si                
          mov eax,ds:[si]
          cmp eax,0
          JNZ LOADBITMAP2
          inc si                
          inc si                
          inc si                
          inc si                
          mov eax,ds:[si]
          cmp eax,63*1024
          JA LOADBITMAP2
          JMP LOADBITMAP1
          LOADBITMAP2:
          mov ax,0ffffh
          LOADBITMAP1:
                          
                          
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          RET                
                
                
DRAWBITMAP:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          JMP DRAWBITMAP9
          drawbitmapbit resb 1
          drawbitmapw   resw 1
          drawbitmaph   resw 1
          drawbitmapxcopy resw 1
          drawbitmapx   resw 1
          drawbitmapy   resw 1
          drawbitmapline resw 1
          drawbitmapstart resw 1
          drawbitmappoint resw 1
          drawbitmapreturn resw 1
          DRAWBITMAP9:
          mov cs:drawbitmapx,ax
          mov cs:drawbitmapy,bx
          mov si,0                
          mov al,ds:[si]
          cmp al,'B'
          JNZ DRAWBITMAP12
          inc si                
          mov al,ds:[si]
          cmp al,'M'
          JNZ DRAWBITMAP12
          inc si                
          mov eax,ds:[si]
          cmp eax,63*1024
          JA DRAWBITMAP12
          mov bx,16
          clc                
          add si,bx
          mov eax,ds:[si]
          cmp eax,319
          JA DRAWBITMAP12
          inc si                
          inc si                
          inc si                
          inc si                
          mov eax,ds:[si]
          cmp eax,199
          JA DRAWBITMAP12
          inc si                
          inc si                
          inc si                
          inc si                
          mov ax,ds:[si]
          cmp ax,1                
          JNZ DRAWBITMAP12
          inc si                
          inc si                
          mov ax,ds:[si]
          cmp ax,24
          JNZ DRAWBITMAP12
          inc si                
          inc si                
          mov eax,ds:[si]
          cmp eax,0
          JNZ DRAWBITMAP12
          inc si                
          inc si                
          inc si                
          inc si                
          mov eax,ds:[si]
          cmp eax,63*1024
          JA DRAWBITMAP12
          mov cs:drawbitmapbit,1
          mov si,18
          mov ax,ds:[si]
          mov cs:drawbitmapw,ax
          DRAWBITMAP11:
                    mov si,22
                    mov ax,ds:[si]
                    mov cs:drawbitmaph,ax
                    mov si,10
                    mov ax,ds:[si]
                    mov cs:drawbitmapstart,ax
                    mov ax,cs:drawbitmapy
                    mov bx,cs:drawbitmaph
                    clc                
                    add ax,bx
                    xor dx,dx
                    xor cx,cx
                    mov bx,320
                    clc                
                    mul bx                
                    mov bx,cs:drawbitmapx
                    clc                
                    add ax,bx
                    mov cs:drawbitmappoint,ax
                    mov ax,320
                    mov bx,cs:drawbitmapw
                    clc                
                    add ax,bx 
                    mov cs:drawbitmapreturn,ax
                                    
                    mov si,cs:drawbitmapstart
                    mov di,cs:drawbitmappoint
                    mov bh,cs:drawbitmapbit
                    mov dx,cs:drawbitmapreturn
                                    
                                    
                    DRAWBITMAP91:
                              mov ax,cs:drawbitmapw
                              mov cs:drawbitmapxcopy,ax 
                              DRAWBITMAP90:
                                        mov al,ds:[si]
                                        inc si                
                                        mov ah,ds:[si]
                                        inc si                
                                        mov bl,ds:[si]
                                        inc si                
                                        and al,11000000b
                                        and ah,11100000b
                                        and bl,11100000b
                                        shr ah,2                
                                        shr bl,5                
                                        or al,ah                
                                        or al,bl                
                                        mov es:[di],al
                                        inc di                
                                        dec cs:drawbitmapxcopy
                                        cmp cs:drawbitmapxcopy,0
                                        JNZ DRAWBITMAP90
                              clc                
                              sub di,dx
                              DRAWBITMAP92:
                                        dec cs:drawbitmaph
                                        cmp cs:drawbitmaph,0
                                        JNZ DRAWBITMAP91
                                              
                                              
                              JMP DRAWBITMAP13
                              DRAWBITMAP12:
                              mov ax,0ffffh
                              DRAWBITMAP13:
                              pop bp                
                              pop si                
                              pop di                
                              pop dx                
                              pop cx                
                              pop bx                
                              RET                
                
                
                
                
                
                
                
                
                
                
                
                
endf   db " "
                
                
                
                
                
                
                
                
                
                
