JMP STACK
xx resw 1
yy resw 1
address1 resd 1
address2 resd 1
c1             resd 1
f1              resw 1
MAIN:                
                          
                          
          mov byte x,0
          mov byte y,0
                          
                          
          mov si,offset file1
          call open16
                          
                          
          mov di,ax
          mov f1,ax
          mov esi,130000h
          mov ecx,160000
          call read32
                          
          mov di,f1
          call close16
                          
          mov ecx,80*26
          mov esi,130000h
          call print32
                          
                          
          EXITDO:                
                                    
                                    
                    EXIT:                
                              int 20h                
                              xor ah,ah
                              int 21h                
                              RET                
                
text1    db   15,"im love marina.",0
file1     db    "output.bin",0
                
                
x     db 0     
y     db 0
color dw 07h
                
READ32:                
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
          JMP READ321
          read32addrs1 resd 1
          read32addrs2 resd 1
          read32counter1 resd 1
          read32counter2 resd 1
          read32counter3 resd 1
          read32output     resd 1
          read32f1             resw 1
          read32seg1        resw 1
          read32seg2        resw 1
          read32size         resd 1
                          
          READ321:                
                          
          mov cs:read32addrs1,esi
          mov cs:read32counter1,ecx
          mov cs:read32f1,di
          mov cs:read32seg2,0
          mov eax,ecx
          cmp eax,0
          JZ READ325
                          
          xor edx,edx
          xor ecx,ecx
          mov ebx,0ffffh
          clc                
          div ebx                
          mov cs:read32counter3,eax
          mov cs:read32output,edx
          mov ax,cs
          mov bx,2000h
          clc                
          add ax,bx
          mov cs:read32seg1,ax
          mov si,0                
          call mem32
          mov cs:read32addrs2,eax
          mov eax,0
          mov cs:read32counter2,eax
          mov eax,0ffffh
          mov cs:read32size,eax
          mov eax,cs:read32counter3
          cmp eax,0
          JZ READ323
          READ322:                
                    mov ax,cs:read32seg1
                    mov ds,ax
                    mov si,0                
                    mov di,cs:read32f1
                    mov cx,0ffffh
                    call read16
                                    
                    mov ax,cs:read32seg2
                    mov ds,ax
                    mov ecx,cs:read32size
                    mov esi,cs:read32addrs2
                    mov edi,cs:read32addrs1
                    mov edx,1
                    call copymem32
                                    
                                    
                    mov eax,cs:read32addrs1
                    mov ebx,cs:read32size 
                    clc                
                    add eax,ebx
                    mov cs:read32addrs1,eax
                    mov eax,cs:read32counter3
                    dec eax                
                    mov cs:read32counter3,eax
                    cmp eax,0
                    JNZ READ322
                          
          READ323:                
          cmp cs:read32output ,0
          JZ READ325
          mov ax,cs:read32seg1
          mov ds,ax
          mov si,0                
          mov di,cs:read32f1
          mov ecx,cs:read32output
          call read16
          mov ax,cs:read32seg2
          mov ds,ax
          mov cx,cs:read32output
          mov esi,cs:read32addrs2
          mov edi,cs:read32addrs1
          mov edx,1
          call copymem32
                          
                          
          READ324:                
                    READ325:                
                    pop ds                
                    pop ebp                
                    pop edi                
                    pop esi                
                    pop edx                
                    pop ecx                 
                    pop ebx                
                    pop eax                
                    RET                
                
                
                
                
WRITE32:                
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
          JMP WRITE321
          write32addrs1 resd 1
          write32addrs2 resd 1
          write32counter1 resd 1
          write32counter2 resd 1
          write32counter3 resd 1
          write32output     resd 1
          write32f1             resw 1
          write32seg1        resw 1
          write32seg2        resw 1
          write32size         resd 1
                          
          WRITE321:
                          
          mov cs:write32addrs1,esi
          mov cs:write32counter1,ecx
          mov cs:write32f1,di
          mov ax,0                
          mov cs:write32seg2,ax
          mov eax,ecx
          cmp eax,0
          JZ WRITE325
                          
          xor edx,edx
          xor ecx,ecx
          mov ebx,0ffffh
          clc                
          div ebx                
          mov cs:write32counter3,eax
          mov cs:write32output,edx
          mov ax,cs
          mov bx,2000h
          clc                
          add ax,bx
          mov cs:write32seg1,ax
          mov si,0                
          call mem32
          mov cs:write32addrs2,eax
          mov eax,0
          mov cs:write32counter2,eax
          mov eax,0ffffh
          mov cs:write32size,eax
          mov eax,cs:write32counter3
          cmp eax,0
          JZ WRITE323
          WRITE322:
                                    
                    mov ax,cs:write32seg2
                    mov ds,ax
                    mov ecx,cs:write32size
                    mov esi,cs:write32addrs1
                    mov edi,cs:write32addrs2
                    mov edx,1
                    call copymem32
                    mov ax,cs:write32seg1
                    mov ds,ax
                    mov si,0                
                    mov di,cs:write32f1
                    mov cx,0ffffh
                    call write16
                    mov eax,cs:write32addrs1
                    mov ebx,cs:write32size 
                    clc                
                    add eax,ebx
                    mov cs:write32addrs1,eax
                    mov eax,cs:write32counter3
                    dec eax                
                    mov cs:write32counter3,eax
                    cmp eax,0
                    JNZ WRITE322
                          
          WRITE323:
          cmp cs:write32output ,0
          JZ WRITE325
          mov ax,cs:write32seg2
          mov ds,ax
          mov ecx,cs:write32output
          mov esi,cs:write32addrs1
          mov edi,cs:write32addrs2
          mov edx,1
          call copymem32
          mov ax,cs:write32seg1
          mov ds,ax
          mov si,0                
          mov di,cs:write32f1
          mov cx,cs:write32output
          call write16
                          
          WRITE324:
                    WRITE325:
                    pop ds                
                    pop ebp                
                    pop edi                
                    pop esi                
                    pop edx                
                    pop ecx                 
                    pop ebx                
                    pop eax                
                    RET                
                
                
                
                
FILLSTRINGS:
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
          cmp ecx,0
          JZ FILLSTRINGS1
          cmp eax,0
          JZ FILLSTRINGS1
          mov edx,eax
          mov ebx,eax
          FILLSTRINGS2:
                    mov al,ds:[esi]
                    mov ds:[edi],al
                    inc esi                
                    inc edi                
                    dec edx                
                    cmp edx,0
                    JNZ FILLSTRINGS3
                    mov edx,ebx
                    sub esi,ebx
                    FILLSTRINGS3:
                    dec ecx                
                    cmp ecx,0
                    JNZ FILLSTRINGS2
          FILLSTRINGS1:
          pop ds                
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          pop eax                
          RET                
                
                
                
                
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
          cmp ax,2                
          JZ  DRAWBITMAP10
          cmp ax,4                
          JZ  DRAWBITMAP10
          cmp ax,8                
          JZ  DRAWBITMAP10
          cmp ax,16
          JZ  DRAWBITMAP10
          cmp ax,32
          JZ  DRAWBITMAP10
          cmp ax,64
          JZ  DRAWBITMAP10
          cmp ax,128
          JZ  DRAWBITMAP10
          cmp ax,256
          JZ  DRAWBITMAP10
          JMP DRAWBITMAP11:
          DRAWBITMAP10:
          mov cs:drawbitmapbit,0
          DRAWBITMAP11:
          mov si,22
          mov ax,ds:[si]
          mov drawbitmaph,ax
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
                    cmp bh,0                
                    JZ DRAWBITMAP92
                    inc si                
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
                
                
SAVE13:                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          push ds                
          push es                
          JMP SAVE139
          save13bit resb 1
          save13w   resw 1
          save13h   resw 1
          save13xcopy resw 1
          save13x   resw 1
          save13y   resw 1
          save13line resw 1
          save13start resw 1
          save13point resw 1
          save13return resw 1
          save13si resw 1
          save1313size resw 1
          SAVE139:                
          mov cs:save13si,si
          mov cs:save13x,ax
          mov si,0                
          mov al,ds:[si]
          cmp al,'B'
          JNZ SAVE1312
          inc si                
          mov al,ds:[si]
          cmp al,'M'
          JNZ SAVE1312
          inc si                
          mov eax,ds:[si]
          cmp eax,63*1024
          JA SAVE1312
          mov bx,16
          clc                
          add si,bx
          mov eax,ds:[si]
          cmp eax,319
          JA SAVE1312
          inc si                
          inc si                
          inc si                
          inc si                
          mov eax,ds:[si]
          cmp eax,199
          JA SAVE1312
          inc si                
          inc si                
          inc si                
          inc si                
          mov ax,ds:[si]
          cmp ax,1                
          JNZ SAVE1312
          inc si                
          inc si                
          mov ax,ds:[si]
          cmp ax,24
          JNZ SAVE1312
          inc si                
          inc si                
          mov eax,ds:[si]
          cmp eax,0
          JNZ SAVE1312
          inc si                
          inc si                
          inc si                
          inc si                
          mov eax,ds:[si]
          cmp eax,63*1024
          JA SAVE1312
          mov cs:save13bit,1
          mov si,18
          mov ax,ds:[si]
          mov cs:save13w,ax
          mov si,22
          mov ax,ds:[si]
          mov cs:save13h,ax
          mov ax,cs:save13h
          mov bx,cs:save13w
          xor dx,dx
          xor cx,cx
          clc                
          mul bx                
          mov bx,6                
          clc                
          add ax,bx
          mov cs:save1313size,ax
          mov si,10
          mov ax,ds:[si]
          mov cs:save13start,ax
          mov di,0                
          mov al,'X'
          mov es:[di],al
          inc di                
          mov al,'Y'
          mov es:[di],al
          inc di                
          mov ax,cs:save13w
          mov es:[di],ax
          inc di                
          inc di                
          mov ax,cs:save13h
          mov es:[di],ax
          mov si,cs:save13start
          mov di,cs:save1313size
                          
                          
          SAVE1391:
                    mov ax,cs:save13w
                    mov cs:save13xcopy,ax 
                    SAVE1390:
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
                              dec di                
                              dec cs:save13xcopy
                              cmp cs:save13xcopy,0
                              JNZ SAVE1390
                    clc                
                    SAVE1392:
                              dec cs:save13h
                              cmp cs:save13h,0
                              JNZ SAVE1391
                                    
                                    
                    mov si,cs:save13si
                    push ds                
                    mov ax,cs:save13x
                    mov ds,ax
                    call creat16
                    JC SAVE13125
                    mov di,ax
                    mov ax,es
                    mov ds,ax
                    mov si,0                
                    mov cx,cs:save1313size
                    call write16
                    pop ds                 
                    call close16
                    JMP SAVE1313
                    SAVE13125:
                    pop es                
                    pop ds                
                    SAVE1312:
                    mov ax,0ffffh
                    SAVE1313:
                    pop es                
                    pop ds                
                    pop bp                
                    pop si                
                    pop di                
                    pop dx                
                    pop cx                
                    pop bx                
                    RET                
                
                
                
                
                
                
                
                
                
                
                
endf   db " "
                
                
                
                
                
                
                
                
                
