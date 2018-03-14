JMP STACK
f1 resw 1
p1 resd 1
address1 resd 1
address2 resd 1
address3 resd 1
address4 resd 1
address5 resd 1
address6 resd 1
address7 resd 1
address8 resd 1
address9 resd 1
address10 resd 1
address11 resd 1
address12 resd 1
address13 resd 1
address14 resd 1
address15 resd 1
address16 resd 1
number0 resd 1
number1 resd 1
number2 resd 1
number3 resd 1
ty resb 1
ttx resb 1
tty resb 1
MAIN:                
          call startmem
                          
                          
                          
                          
                          
                          
                          
          mov ax,0                
          mov ds,ax
                          
                          
          mov al,75h
          call fillscreen
                          
          mov ax,0                
                          
                          
                          
          call creatstring
          mov cs:address16,eax
          mov esi,eax
          dec esi                
          mov al,1                
          mov ds:[esi],al
                          
          mov al,75h
                          
                          
                          
                          
          mov al,0                
          mov cs:x,al
          mov al,2                
          mov cs:y,al
          mov al,75h
          mov cs:color,al
                          
                          
                          
                          
          mov esi,cs:address16
          mov al,'0'
          mov ds:[esi],al
          mov edi,0
          call creatnode
          mov cs:address1,eax
          mov edi,eax
          mov cs:address2,eax
                          
                          
          mov dh,'1'
          FOR1:                
                                    
                    mov esi,cs:address16
                    mov al,dh
                    mov ds:[esi],al
                    mov edi,cs:address2
                    call creatnode
                    mov cs:address2,eax
                    mov cs:address3,eax
                                    
                    mov dl,'A'
                    FOR2:                
                              mov esi,cs:address16
                              mov al,dl
                              mov ds:[esi],al
                              mov edi,cs:address3
                              call creatchild
                              mov cs:address3,eax
                              inc dl                
                              cmp dl,'K'
                              JNZ FOR2                
                                    
                                    
                                    
                    inc dh                
                    cmp dh,'7'
                    JNZ FOR1                
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
          mov si,offset file1
          call creat16
                          
          mov cs:f1,ax
                          
                          
                          
          mov esi,cs:address1
          call fprinttree
                          
                          
          mov di,cs:f1
          call close16
                          
                          
                          
                          
                          
                          
          JMP EXITDO
                          
          EXITDO:                
                          
                          
          JMP EXIT                
                          
                          
          text10 db 20,"<html>                                                                              "
          text11 db 20,"<head>                                                                              "
          text12 db 20,"<title>                                                                              "
          text13 db 20,"im love marina.                                                               "
          text14 db 20,"</title>                                                                              "
          text15 db 20,"</head>                                                                             "
          text16 db 20,"<body>                                                                              "
          text17 db 20,"im love marina.                                                               "
          text18 db 20,"</body>                                                                             "
          text19 db 20,"</html>                                                                              "
                          
          text21 db  3,"im ",0
          text22 db  5,"love ",0
          text23 db  7,"marina. ",0
          text2  db "                                                                                                 "
          text3  db "                                                                                                 "
          text4  db "                                                                                                 "
          text5  db "                                                                                                 "
          text6  db "                                                                                                 "
          text7  db "                                                                                                 "
          text8  db "                                                                                                 "
          text9  db "                                                                                                 "
          file1   db  "tree.txt",0                                           
                          
                          
          ;lib start
                          
          rand dw 0
          randomize db  " "
                          
                          
                          
                          
          variantetablesize equ 256*4
                          
          varianteblock resb 1
          variantetable resw 1
          varianteptrpos resw 1
                          
          x     db 0     
          y     db 0
          w    db 0
          h     db 0
          color db 07h
          sstring dd 0
          z db 0                
                          
                          
          EXIT:                
          xor ah,ah
          int 21h                
          int 20h                
          RET                
                
                
STR32:                
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          mov ax,0                
          mov ds,ax
          mov eax,ds:[esi]
          mov ebp,1000000000
          STR321:                
                    xor edx,edx
                    xor ecx,ecx
                    mov ebx,ebp
                    clc                 
                    div ebx                
                    mov esi,edx
                    mov ah,'0'
                    clc                
                    add al,ah
                    mov ds:[edi],al
                    inc edi                
                    mov eax,ebp
                    xor edx,edx
                    xor ecx,ecx
                    mov ebx,10
                    clc                
                    div ebx                
                    mov ebp,eax
                    mov eax,esi
                    cmp ebp,0
                    JNZ STR321
                          
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
                
                
                
                
                
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
          mov ebx,cs:clsscreen
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
          mov al,cs:x
          mov bl,cs:y
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
          mov al,cs:x
          mov bl,cs:y
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
          mov cs:y,al
          mov cs:x,dl
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
          mov ax,sp
          mov bx,500
          clc                
          sub ax,bx
          mov di,ax
          mov ax,cs
          mov bx,1000h
          clc                 
          add ax,bx
          mov ds,ax
          mov si,0ffffh
          STACK64:                
                    mov al,cs:[si]
                    mov ds:[si],al
                    dec si                
                    cmp si,di
                    JNZ STACK64
          mov ax,ds
          mov ss,ax
          mov bx,offset endf
          mov cs:variantetable,bx
          mov cs:varianteblock,0
          mov cx,cs:variantetablesize
          clc                
          add bx,cx
          inc bx                
          mov cs:varianteptrpos,bx
          mov ax,cs
          mov ds,ax
          JMP MAIN                
          RET                
                
                
CREAT16:                
          push ds                
          push cx                
          push dx                
          push cs                
          pop ds                
          mov dx,si
          xor cx,cx
          mov ah,3ch
          int 21h                
          pop dx                 
          pop cx                
          pop ds                
          RET                
                
                
                
                
CLOSE16:                
          push ds                
          push bx                
          push cs                
          pop ds                
          mov bx,di
          mov ah,3eh
          int 21h                
          pop bx                
          pop ds                
          RET                
                
                
WRITE16:                
          push ds                
          push bx                
          push dx                
                          
          mov dx,si
          mov bx,di
          mov ah,40h
          int 21h                
          pop dx                 
          pop bx                
          pop ds                
          RET                
                
                
READ16:                
          push ds                
          push bx                
                          
                          
          mov dx,si
          mov bx,di
          mov ah,3fh
          int 21h                
          pop dx                 
          pop bx                
          pop ds                
          RET                
                
                
OPEN16:                
          push ds                
          push cx                
          push dx                
          push cs                
          pop ds                
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
          pop ds                
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
                
                
STARTMEM:
          push eax                
          push ebx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          push ds                
          push es                
          JMP STARTMEM2
          startmemadd resd 1
          startmemadd2 resd 1
          STARTMEM2:
          xor ax,ax
          mov ds,ax
          mov eax,100h
          mov ebx,120000h 
          clc                
          add eax,ebx
          mov ds:[ebx],eax
          pop es                
          pop ds                
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop ebx                
          pop eax                
          RET                
                
                
RESERVES:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          JMP RESERVES2
          reservemem resd 1
          reservemem2 resd 1
          RESERVES2:
          xor ax,ax
          mov ds,ax
          mov ebx,120000h 
          mov eax,ds:[ebx]
          mov edx,eax
          clc                
          add edx,ecx
          add edx,4
          mov ds:[ebx],edx
          mov ebx,eax
          mov ds:[ebx],ecx
          add eax,4
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
                          
          RET                
                
TWINDOWS:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          JMP TTWINDOWS2
          ttwindowsx resd 1
          ttwindowsy resd 1
          ttwindowsw resd 1
          ttwindowsh resd 1
          TTWINDOWS2:
          xor eax,eax
          mov ds,ax
          mov al,cs:h
          mov cs:ttwindowsh,eax
          xor eax,eax
          mov al,cs:x
          mov cs:ttwindowsx,eax
          xor eax,eax
          mov al,cs:y
          mov cs:ttwindowsy,eax
          TTWINDOWS4:
                    xor eax,eax
                    mov al,cs:w
                    mov cs:ttwindowsw,eax
                    TTWINDOWS5:
                              mov eax,cs:ttwindowsy
                              mov ebx,cs:ttwindowsh
                              clc                 
                              add eax,ebx
                              mov ebx,160
                              xor edx,edx
                              xor ecx,ecx
                              clc                
                              mul ebx                
                              mov ebx,cs:ttwindowsx
                              clc                
                              add eax,ebx
                              clc                
                              add eax,ebx
                              mov ebx,cs:ttwindowsw
                              clc                
                              add eax,ebx
                              clc                
                              add eax,ebx
                              mov ebx,cs:clsscreen
                              clc                
                              add eax,ebx
                              mov ebx,eax
                              mov al,32
                              mov ah,cs:color
                              mov ds:[ebx],ax
                              mov ecx,cs:ttwindowsw
                              dec ecx                
                              mov cs:ttwindowsw,ecx
                              cmp ecx,0ffffffffh
                              JNZ TTWINDOWS5
                                    
                    mov ecx,cs:ttwindowsh
                    dec ecx                
                    mov cs:ttwindowsh,ecx
                    cmp ecx,0ffffffffh
                    JNZ TTWINDOWS4
                          
                          
                          
                          
                          
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
                          
          RET                
                
                
                
OTWINDOWS:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          JMP OTTWINDOWS2
          ottwindowsx resd 1
          ottwindowsy resd 1
          ottwindowsw resd 1
          ottwindowsh resd 1
          ottwindowsc resd 1
          OTTWINDOWS2:
          xor ax,ax
          mov eax,cs:x
          push eax                
          mov al,cs:color
          push ax                
          mov eax,cs:[si]
          mov cs:x,eax
          mov al,cs:[si+4]
          mov cs:color,al
          call twindows
          pop ax                
          mov cs:color,al
          pop eax                
          mov cs:x,eax
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
                          
          RET                
                
SETX:                
          mov cs:[si],al
          RET                
                
SETY:                
          mov cs:[si+1],al
          RET                
                
SETW:                
          mov cs:[si+2],al
          RET                
                
SETH:                
          mov cs:[si+3],al
          RET                
                
SETCOLOR:
          mov cs:[si+4],al
          RET                
                
                
SETTEXT:                
          mov cs:[si+5],edi
          RET                
                
                
                
PRESERVE:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          mov bp,sp
          mov bx,[bp+12]
          mov dx,[bx]
          cmp varianteblock,255
          JZ PRESERVE1
          mov si,varianteptrpos
          mov ax,si
          mov bx,variantetable
          mov [bx],dx
          inc bx                
          inc bx                
          mov [bx],si
          clc                 
          add variantetable,4
          mov bx,si
          mov [bx],cx
          clc                 
          add ax,cx
          mov varianteptrpos,ax
          mov ax,si
          JMP PRESERVE2:
          PRESERVE1:
          mov ax,0ffffh
          PRESERVE2:
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          RET                
                
CLS:                
                          
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          JMP CLS1                
          clsscreen resd 1
          CLS1:                
          mov eax,cs:clsscreen 
          cmp eax,0
          JNZ CLS2                
          mov ecx,80*25*2+32
          call reserves
          mov cs:clsscreen,eax
          CLS2:                
          mov eax,cs:clsscreen
          mov edi,eax
          mov al,32
          mov ecx,80*25
          mov edx,2
          call fill32
          inc edi                
          mov al,70h
          call fill32
                          
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          pop eax                
          RET                
                
PRINT32W:
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          cmp ecx,0
          JZ PRINT32W13
          mov al,cs:x
          mov bl,cs:y
          and ax,0ffh
          and bx,0ffh
          call gotoxy
          mov edi,eax
          cmp ecx,255
          JB PRINT32W12
          mov ebx,255
          PRINT32W12:
          mov edx,2
          call copymem32 
          mov al,cs:x
          mov bl,cs:y
          and ax,0ffh
          and bx,0ffh
          mov si,bx
          clc                
          add ax,cx
          cmp ax,80
          JB PRINT32W8
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
          JB PRINT32W8
          mov ax,24
          PRINT32W8:
          PRINT32W13:
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          pop eax                
          RET                
                
TWPRINT:                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          JMP TWPRINT1
          twprintx resb 1
          twprinty resb 1
          twprintw resb 1
          twprinth resb 1
          twprintcolor resb 1
          twprintdx resb 1
          twprintdy resb 1
          TWPRINT1:
          mov al,cs:x
          push ax                
          mov al,cs:y
          push ax                
          mov al,cs:w
          push ax                
          mov al,cs:color
          push ax                
          mov eax,cs:sstring
          push eax                
                          
                          
                          
          mov ax,cs
          call mem32
          mov ebx,eax
                          
                          
          mov si,offset x
          mov ax,cs
          call mem32
                          
                          
                          
          mov esi,ebx
          mov edi,eax
          mov ecx,9
          mov edx,1
          call copymem32
                          
          mov al,cs:x
          mov cs:twprintx,al
                          
          mov al,cs:x
          mov ah,cs:w
          clc                
          add al,ah
          mov cs:twprintdx,al
                          
          mov al,cs:y
          mov ah,cs:h
          clc                
          add al,ah
          mov cs:twprintdy,al
          mov bx,offset sstring
          mov esi,cs:[bx]
          mov ebx,esi
          dec ebx                
          push ds                
          xor ax,ax
          mov ds,ax
          mov al,ds:[ebx]
          pop ds                
          xor bh,bh
          mov bl,al
                          
          TWPRINT3:
                                    
                    mov ecx,1
                                    
                    call print32w
                    inc esi                
                    dec bx                
                    mov al,cs:x
                    inc al                
                    mov ah,cs:twprintdx
                    mov cs:x,al
                    cmp al,ah
                    JBE TWPRINT4
                    mov al,cs:twprintx
                    mov cs:x,al
                    mov al,cs:y
                    inc al                
                    mov cs:y,al
                    TWPRINT4:
                    mov al,cs:y
                    mov ah,cs:twprintdy
                    cmp al,ah
                    JBE TWPRINT5
                    xor bx,bx
                    TWPRINT5:
                    cmp bx,0                
                    JNZ TWPRINT3
                          
          pop eax                
          mov cs:sstring,eax
          pop ax                
          mov cs:color,al
          pop ax                
          mov cs:w,al
          pop ax                
          mov cs:y,al
          pop ax                
          mov cs:x,al
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
RND:                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          mov ax,cs:rand
          cmp ax,0                
          JNZ RND1                
          mov ax,offset randomize
          mov cs:rand,ax
          RND1:                
          mov bx,cs:rand
          mov eax,cs:[bx]
          inc bx                
          inc bx                
          inc bx                
          inc bx                
          mov cs:rand,bx
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
RANDTIMER:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          mov ax,40h
          mov ds,ax
          mov bx,6ch
          mov al,ds:[bx]
          mov ah,1                
          mov cs:rand,ax
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
                
RANDN:                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ebx,eax
          mov eax,0ffffffffh
          xor edx,edx
          xor ecx,ecx
          clc                
          idiv ebx                
          mov edx,eax
                          
          call rnd                
                          
          mov ebx,edx
          xor edx,edx
          xor ecx,ecx
          clc                
          idiv ebx                
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
CREATSTACK:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          mov eax,8
          clc                
          add ecx,eax
          call reserves
          mov ebx,eax
          xor ax,ax
          mov ds,ax
          mov eax,0
          mov ds:[ebx],eax
          clc                
          add ebx,4
          mov eax,ebx
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
PUSHSTACK32:
          push eax                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ebp,eax
          xor ax,ax
          mov ds,ax
          mov edi,esi
          clc                 
          sub esi,4
          mov eax,ds:[esi]
          inc eax                
          mov ds:[esi],eax
          clc                
                          
          mov ebx,4
          mov ecx,0
          mov edx,0
          clc                
          mul ebx                
          add esi,eax
                          
                          
          mov ds:[esi],ebp
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          pop eax                
          RET                
                
                
POPSTACK32:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ebp,eax
          xor ax,ax
          mov ds,ax
          mov edi,esi
          clc                 
          sub esi,4
          mov eax,ds:[esi]
          cmp eax,0
          JZ POPSTACK325
          dec eax                
          mov ds:[esi],eax
          clc                
          add esi,4
          mov ebx,4
          mov ecx,0
          mov edx,0
          clc                
          mul ebx                
          add esi,eax
                          
                          
          mov eax,ds:[esi]
                          
          POPSTACK325:
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
TIMER:                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,40h
          mov ds,ax
          mov bx,6ch
          mov eax,ds:[bx]
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
                
                
                
SLEEP:                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          mov ecx,eax
          mov ebx,eax
          call timer
          clc                
          add ebx,eax
          mov ecx,ebx
          JO SLEEP5
          SLEEP1:                
                    call timer
                    cmp eax,ecx
                    JB SLEEP1
          JMP SLEEP6
          SLEEP5:                
          call timer
          cmp eax,ecx
          JA SLEEP5
JMP SLEEP1
SLEEP6:                
                
pop es                
pop ds                
pop ebp                
pop esi                
pop edi                
pop edx                
pop ecx                
pop ebx                
RET                
                
                
TWINDOWS32:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          JMP TWINDOWS321
          twindows32x dd 0,0,0,0,0,0,0,0,0
          twindows32xx dd 0,0,0,0,0,0,0,0,0
          TWINDOWS321:
                          
          push esi                
                          
                          
                          
                          
          mov si,offset twindows32x
          mov ax,cs
          call mem32
          mov edi,eax
                          
          pop esi                
                          
          mov ecx,9
          mov edx,1
          call copymem32
                          
          mov si,offset twindows32x
                          
          call otwindows
                          
                          
                          
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
TWPRINT32:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          JMP TWPRINT321
          twprint32x dd 0,0,0,0,0,0,0,0,0
          twprint32xx dd 0,0,0,0,0,0,0,0,0
          TWPRINT321:
                          
          push esi                
                          
          mov si,offset twprint32x
          mov ax,cs
          call mem32
          mov edi,eax
                          
          pop esi                
                          
          mov ecx,9
          mov edx,1
          call copymem32
                          
          mov si,offset twprint32x
                          
                          
          call twprint
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
                
                
OTWINDOWS32:
          call twindows32
          call twprint32
          RET                
                
                
REFRESH32:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov edi,0b8000h
          mov esi,cs:clsscreen
          mov edx,1
          mov ecx,80*25*2
          call copymem32
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
                
                
                
DRAWWINS32:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          push esi                
          push edi                
          push ecx                
          call cls                
          mov ax,0                
          mov ds,ax
          pop ecx                
          pop edi                
          pop esi                
          mov ebx,esi
          dec ebx                
          mov cl,ds:[ebx]
          inc ebx                
          DRAWWINS321:
                    mov esi,ds:[ebx]
                    call otwindows32
                    clc                
                    add ebx,4
                    dec cl                
                    cmp cl,0                
                    JNZ DRAWWINS321
                          
          call refresh32
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
MOVETOP:                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          push ax                
          dec esi                
          mov ax,0                
          mov ds,ax
          mov cl,ds:[esi]
          dec cl                
          inc esi                
          pop ax                
          push ax                
          push cx                
                          
          and eax,0ffh
          mov ebx,4
          xor ecx,ecx
          xor edx,edx
          clc                
          mul ebx                
          clc                
          add esi,eax
          mov edi,esi
          clc                
          add esi,4
          mov ebx,ds:[edi]
          pop dx                
          pop cx                
                          
          MOVETOP1:
                    mov eax,ds:[esi]
                    mov ds:[edi],eax
                    clc                
                    add edi,4
                    clc                
                    add esi,4
                    inc cl                
                    cmp cl,dl
                    JNZ MOVETOP1
                          
                          
          mov ds:[edi],ebx
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
MOVEBACK:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          push ax                
          dec esi                
          mov ax,0                
          mov ds,ax
          mov cl,ds:[esi]
          dec cl                
          inc esi                
          pop ax                
          push ax                
          push cx                
                          
          and eax,0ffh
          mov ebx,4
          xor ecx,ecx
          xor edx,edx
          clc                
          mul ebx                
          clc                
          add esi,eax
          mov edi,esi
          clc                
          sub esi,4
          mov ebx,ds:[esi]
          pop dx                
          pop cx                
                          
          MOVEBACK1:
                    mov eax,ds:[esi]
                    mov ds:[edi],eax
                    clc                
                    sub edi,4
                    clc                
                    sub esi,4
                    dec cl                
                    cmp cl,0                
                    JNZ MOVEBACK1
                          
                          
          mov ds:[edi],ebx
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
SETX32:                
          push ds                
          push ax                
          xor ax,ax
          mov ds,ax
          pop ax                
          mov ds:[esi],al
          pop ds                
          RET                
                
SETY32:                
          push ds                
          push ax                
          xor ax,ax
          mov ds,ax
          pop ax                
          mov ds:[esi+1],al
          pop ds                
          RET                
                
SETW32:                
          push ds                
          push ax                
          xor ax,ax
          mov ds,ax
          pop ax                
          mov ds:[esi+2],al
          pop ds                
          RET                
                
SETH32:                
          push ds                
          push ax                
          xor ax,ax
          mov ds,ax
          pop ax                
          mov ds:[esi+3],al
          pop ds                
          RET                
                
SETCOLOR32:
          push ds                
          push ax                
          xor ax,ax
          mov ds,ax
          pop ax                
          mov ds:[esi+4],al
          pop ds                
          RET                
                
                
SETTEXT32:
          push ds                
          push ax                
          xor ax,ax
          mov ds,ax
          pop ax                
          mov ds:[esi+5],edi
          pop ds                
          RET                
                
                
                
CREATLIST:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          mov ecx,260*4
          call reserves
          mov esi,eax
          mov al,0                
          mov ds:[esi],al
          inc esi                
          mov eax,esi
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
CREATWINDOW:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          mov ecx,260
          call reserves
          mov esi,eax
          mov al,0                
          mov ds:[esi],al
          inc esi                
          mov edx,esi
                          
          mov ecx,24
          call reserves
                          
          mov esi,eax
          mov edi,edx
          call settext32
                          
          mov eax,esi
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
ADDWINDOW:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
                          
          mov ax,0                
          mov ds,ax
                          
          dec esi                
          mov cl,ds:[esi]
          inc cl                
          mov ds:[esi],cl
          dec cl                
          inc esi                
          and ecx,0ffh
          mov eax,ecx
          mov ebx,4
          xor ecx,ecx
          xor edx,edx
          clc                
          mul ebx                
          clc                
          add esi,eax
                          
                          
          call creatwindow
          mov ds:[esi],eax
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
GETINDEX:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          and ecx,0ffh
          mov eax,ecx
          mov ebx,4
          xor ecx,ecx
          xor edx,edx
          clc                
          mul ebx                
          clc                
          add esi,eax
          mov eax,ds:[esi]
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
GETSTRINGINDEX:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          and ecx,0ffh
          mov eax,ecx
          mov ebx,4
          xor ecx,ecx
          xor edx,edx
          clc                
          mul ebx                
          clc                
          add esi,eax
          mov eax,ds:[esi]
          mov esi,eax
          mov eax,ds:[esi+5]
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
hhex1 db 16
hhex db "0123456789ABCDEF.$",0
                
HEX:                
          push ax                
          push bx                
          push dx                
          push esi                
          push edi                
          push ds                
                          
          inc edi                
          push ax                
          xor ax,ax
          mov ds,ax
          pop ax                
          xor ah,ah
          mov dx,ax
          and ax,0fh
          mov si,offset hhex
          clc                
          add si,ax 
          mov al,cs:[si]
          mov ds:[edi],al
          dec edi                
          mov ax,dx
          and ax,0f0h
          shr ax,4                
          mov si,offset hhex
          clc                
          add si,ax 
          mov al,cs:[si]
          mov ds:[edi],al
                          
          pop ds                
          pop edi                
          pop esi                
          pop dx                
          pop bx                
          pop ax                
          RET                
                
                
SETSTRINGINDEXSIZE:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          push dx                
          mov ax,0                
          mov ds,ax
                          
          and ecx,0ffh
          mov eax,ecx
          mov ebx,4
          xor ecx,ecx
          xor edx,edx
          clc                
          mul ebx                
          clc                
          add esi,eax
          mov eax,ds:[esi]
          mov esi,eax
          mov edi,ds:[esi+5]
          dec edi                
          pop dx                
          mov ds:[edi],dl
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
TIMES:                
          push ax                
          mov ah,2                
          int 1ah                
          pop ax                
          RET                
                
                
DATES:                
          push ax                
          mov ah,4                
          int 1ah                
          pop ax                
          RET                
                
                
SETLABEL:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
          push esi                
                          
          mov esi,edi
          call getstringindex
          mov edi,eax
          pop esi                
          dec esi                
          mov cl,ds:[esi]
          dec edi                
                          
                          
          and ecx,0ffh
          inc ecx                
          mov edx,1
          call copymem32
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
                
GETCHAR:                
          xor ax,ax
          int 16h                
          RET                
                
INPUTBOX:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          mov ebp,esi
                          
          call drawwins32
                          
          call getstringindex
          mov edx,eax
          mov edi,edx
          dec edi                
          mov cl,ds:[edi]
          mov ch,ds:[edi]
          inc edi                
          INPUTBOX1:
                    call getchar
                    cmp al,13
                    JNZ INPUTBOX2
                    xor cl,cl
                    JMP INPUTBOX5
                    INPUTBOX2:
                    cmp cl,ch
                    JZ INPUTBOX3
                    cmp al,8                
                    JNZ INPUTBOX3
                    dec edi                
                    inc cl                
                    mov ah,32
                    mov ds:[edi],ah
                    JMP INPUTBOX4
                    INPUTBOX3:
                    cmp cl,0                
                    JZ INPUTBOX1
          mov ds:[edi],al
          dec cl                
          inc edi                
          INPUTBOX4:
                          
          mov esi,ebp
          call drawwins32
                          
          JMP INPUTBOX1
INPUTBOX5:
                
mov esi,ebp
call drawwins32
                
pop es                
pop ds                
pop ebp                
pop esi                
pop edi                
pop edx                
pop ecx                
pop ebx                
RET                
                
NUMBERBOX:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          mov ebp,esi
                          
          call drawwins32
                          
          call getstringindex
          mov edx,eax
          mov edi,edx
          dec edi                
          mov cl,ds:[edi]
          mov ch,ds:[edi]
          inc edi                
          NUMBERBOX1:
                    call getchar
                    cmp al,13
                    JNZ NUMBERBOX2
                    xor cl,cl
                    JMP NUMBERBOX5
                    NUMBERBOX2:
                    cmp cl,ch
                    JZ NUMBERBOX3
                    cmp al,8                
                    JNZ NUMBERBOX3
                    cmp cl,ch
                    JZ NUMBERBOX1
          dec edi                
          inc cl                
          mov ah,'0'
          mov ds:[edi],ah
          JMP NUMBERBOX4
          NUMBERBOX3:
          cmp cl,0                
          JZ NUMBERBOX1
cmp al,'0'
JB NUMBERBOX1
cmp al,'9'
JA NUMBERBOX1
mov ds:[edi],al
dec cl                
inc edi                
NUMBERBOX4:
                
mov esi,ebp
call drawwins32
                
JMP NUMBERBOX1
NUMBERBOX5:
                
mov esi,ebp
call drawwins32
                
pop es                
pop ds                
pop ebp                
pop esi                
pop edi                
pop edx                
pop ecx                
pop ebx                
RET                
                
CLONELIST:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          mov edx,esi
                          
          mov ecx,260*4
          call reserves
                          
          mov edi,eax
                          
          mov esi,edx
                          
          dec esi                
                          
          dec ecx                
          mov edx,1
          call copymem32
                          
          mov eax,edi
          inc eax                
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
VAL32:                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          mov edi,0
          mov ds,di
          mov ebp,1000000000
          mov ebx,esi
          VAL321:                
                    mov al,ds:[esi]
                    mov ah,'0'
                    clc                
                    sub al,ah
                    and eax,0ffh
                    mov ebx,ebp
                    xor edx,edx
                    xor ecx,ecx
                    clc                
                    mul ebx                
                    clc                
                    add eax,edi
                    mov edi,eax
                    mov eax,ebp
                    mov ebx,10
                    xor edx,edx
                    xor ecx,ecx
                    clc                
                    div ebx                
                    mov ebp,eax
                    inc esi                
                    cmp ebp,0
                    JNZ VAL321
          mov eax,edi
                          
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
                
                
                
CREATSTRING:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          mov ecx,260
          call reserves
          mov esi,eax
                          
          mov al,255
          mov ds:[esi],al
          inc esi                
          mov eax,esi
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
                
DATETIMESTRING:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
                          
          mov ax,0                
          mov ds,ax
                          
          dec edi                
          mov al,19
          mov ds:[edi],al
          inc edi                
                          
          call dates
                          
                          
                          
                          
          push cx                
          push  cx                
          push dx                
          push dx                
                          
          pop ax                
          mov al,ah
          call hex                
                          
          inc edi                
          inc edi                
          mov al,'\'
          mov ds:[edi],al
          inc edi                
                          
          pop ax                
          call hex                
                          
                          
          inc edi                
          inc edi                
          mov al,'\'
          mov ds:[edi],al
          inc edi                
                          
          pop ax                
          mov al,ah
                          
          call hex                
                          
          inc edi                
          inc edi                
                          
          pop ax                
                          
          call hex                
                          
          inc edi                
          inc edi                
          mov al,' '
          mov ds:[edi],al
          inc edi                
                          
                          
                          
                          
          ;times                
                          
          call times
                          
                          
                          
          push dx                
          push  cx                
          push cx                
                          
                          
                          
          pop ax                
          mov al,ah
          call hex                
                          
          inc edi                
          inc edi                
          mov al,':'
          mov ds:[edi],al
          inc edi                
                          
          pop ax                
          call hex                
                          
                          
          inc edi                
          inc edi                
          mov al,':'
          mov ds:[edi],al
          inc edi                
                          
                          
          pop ax                
          mov al,ah
                          
          call hex                
                          
          inc edi                
          inc edi                
          mov al,' '
          mov ds:[edi],al
          inc edi                
                          
                          
          ;----------
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
FILLSCREEN:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov bx,ax
          mov ax,0                
          mov ds,ax
                          
          mov esi,0b8000h
          mov ah,bl
          mov al,32
          mov ecx,80*25
                          
          FILLSCREEN1:
                    mov ds:[esi],ax
                    inc esi                
                    inc esi                
                    dec ecx                
                    cmp ecx,0
                    JNZ FILLSCREEN1
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
GGOTOXY:                
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
                
                
                
PPRINT32:
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          cmp ecx,0
          JZ PPRINT3213
          mov al,cs:x
          mov bl,cs:y
          and ax,0ffh
          and bx,0ffh
          call ggotoxy
          mov edi,eax
          cmp ecx,255
          JB PPRINT3212
          mov ebx,255
          PPRINT3212:
          mov edx,2
          call copymem32 
          mov al,cs:x
          mov bl,cs:y
          mov al,0                
          inc bl                
          mov cs:y,bl
          mov cs:x,al
          PPRINT3213:
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          pop eax                
          RET                
                
PRINTLIST:
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
                          
          mov edi,esi
          push cx                
          mov ax,0                
          mov ds,ax
          dec edi                
          mov bp,ds:[edi]
          inc edi                
          mov al,cl
          and ax,0ffh
          mov bx,4                
          mov cx,0                
          mov dx,0                
          mul bx                
          and eax,0ffffh
          clc                
          add edi,eax
          mov dx,bp
          pop cx                
          mov dh,ch
          mov bl,cl
          PRINTLIST1:
                    mov esi,ds:[edi]
                    dec esi                
                    mov cl,ds:[esi]
                    inc esi                
                    and ecx,0ffh
                    call pprint32
                    clc                
                    add edi,4
                    inc bl                
                    cmp bl,dl
                    JZ PRINTLIST10
                    dec dh                
                    cmp dh,0                
                    JNZ PRINTLIST1
          PRINTLIST10:
                          
                          
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          pop eax                
          RET                
                
ADDITEM:                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          push ds                
                          
          mov ebp,esi
                          
          mov ax,0                
          mov ds,ax
          dec edi                
          mov cl,ds:[edi]
          inc cl                
          mov ds:[edi],cl
          inc edi                
          dec cl                
          mov al,cl
          clc                
          and eax,0ffh
          mov bl,4                
          clc                
          and ebx,0ffh
          mov ecx,0
          mov edx,0
          clc                
          mul ebx                
          clc                
          add edi,eax
                          
                          
                          
          call creatstring
          mov ebx,eax
          push eax                
          mov ds:[edi],eax
          mov esi,ebp
          mov ebp,eax
          mov edi,ebx
          dec edi                
          dec esi                
          mov cl,ds:[esi]
          clc                
          and ecx,0ffh
          inc ecx                
          mov edx,1
          call copymem32
          pop eax                
                          
          pop ds                
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          RET                
                
CONCAT32:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          dec esi                
          dec edi                
          mov dl,ds:[esi]
          mov cl,ds:[edi]
          clc                
          and edx,0ffh
          clc                
          and ecx,0ffh
          mov ebp,ecx
          clc                
          add ecx,edx 
          cmp ecx,255
          JB CONCAT1
          clc                
          sub ecx,255
          mov edx,ecx
          clc                
          and edx,0ffh
          mov cl,255
          CONCAT1:                
          mov ds:[edi],cl
          inc edi                
          inc esi                
          clc                
          and ecx,0ffh
          clc                
          add edi,ebp
          mov cl,dl
          clc                
          and ecx,0ffh
          mov edx,1
          call copymem32
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
CREATNODE:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
                          
          push esi                
                          
          mov ax,0                
          mov ds,ax
                          
          mov ecx,4*4
          call reserves
          mov ebx,eax
                          
                          
          cmp edi,0
          JZ CREATNODE1
          clc                
          add edi,8
          mov ds:[edi],ebx
          CREATNODE1:
                          
          call creatstring 
          mov edi,eax
                          
          mov ds:[ebx],edi
                          
          mov eax,0
          clc                
          add ebx,4
          mov ds:[ebx],eax
                          
          clc                
          add ebx,4
          mov ds:[ebx],eax
                          
          clc                
          add ebx,4
          mov ds:[ebx],eax
                          
          pop esi                
                          
          dec esi                
          dec edi                
          mov cl,ds:[esi]
          clc                
          and ecx,0ffh
          inc ecx                
          mov edx,1
          call copymem32
                          
          clc                
          sub ebx,12
                          
          mov eax,ebx
                          
                          
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
CREATCHILD:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
                          
          push esi                
                          
          mov ax,0                
          mov ds,ax
                          
          mov ecx,4*4
          call reserves
          mov ebx,eax
                          
                          
          cmp edi,0
          JZ CREATCHILD1
          clc                
          add edi,12
          mov ds:[edi],ebx
          CREATCHILD1:
                          
          call creatstring 
          mov edi,eax
                          
          mov ds:[ebx],edi
                          
          mov eax,0
          clc                
          add ebx,4
          mov ds:[ebx],eax
                          
          clc                
          add ebx,4
          mov ds:[ebx],eax
                          
          clc                
          add ebx,4
          mov ds:[ebx],eax
                          
          pop esi                
                          
          dec esi                
          dec edi                
          mov cl,ds:[esi]
          clc                
          and ecx,0ffh
          inc ecx                
          mov edx,1
          call copymem32
                          
          clc                
          sub ebx,12
                          
          mov eax,ebx
                          
                          
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
                
                
                
                
                
PRINTSTRONGLIST:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          mov edi,esi
                          
          PRINTSTRONGLIST4:
                    mov esi,ds:[edi]
                    dec esi                
                    mov cl,ds:[esi]
                    clc                
                    and ecx,0ffh
                    inc esi                
                    call pprint32
                                    
                    clc                
                    add edi,8
                                    
                    mov esi,edi
                    mov edi,ds:[esi]
                                    
                    cmp edi,0
                    JNZ PRINTSTRONGLIST4
                          
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
PRINTNODECHILD:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          mov edi,esi
                          
          PRINTNODECHILD4:
                    mov esi,ds:[edi]
                    dec esi                
                    mov cl,ds:[esi]
                    clc                
                    and ecx,0ffh
                    inc esi                
                    call pprint32
                                    
                    clc                
                    add edi,12
                    mov ebx,ds:[edi]
                    push edi                
                    mov edi,ebx
                    cmp edi,0
                    JZ PRINTNODECHILD8
                    mov al,1                
                    mov cs:x,al
                    mov esi,ds:[edi]
                                    
                    dec esi                
                    mov cl,ds:[esi]
                    clc                
                    and ecx,0ffh
                    inc esi                
                    call pprint32
                    PRINTNODECHILD8:
                                    
                                    
                    pop edi                
                                    
                                    
                    clc                
                    sub edi,4
                                    
                    mov esi,edi
                    mov edi,ds:[esi]
                                    
                    cmp edi,0
                    JNZ PRINTNODECHILD4
                          
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
PRINTNNODE:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          mov edi,esi
                          
                          
          mov esi,ds:[edi]
          dec esi                
          mov cl,ds:[esi]
          clc                
          and ecx,0ffh
          inc esi                
          call pprint32
                          
                          
                          
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
PRINTTREE:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          JMP PRINTTREE10
          printtree101 resd 1
          printtree102 resd 1
          PRINTTREE10:
                          
          push esi                
                          
          mov ax,0                
          mov ds,ax
                          
          mov esi,cs:printtree101
          cmp esi,0
          JNZ PRINTTREE9
          mov ecx,8000*4
          call creatstack
          mov cs:printtree101,eax
          PRINTTREE9:
          mov eax,0
          mov cs:printtree102,eax
                          
          pop esi                
          mov edi,esi
                          
          PRINTTREE1:
                    mov al,cs:printtree102
                    mov cs:x,al
                    mov esi,edi
                    call printnnode
                    mov edi,ds:[esi+12]
                    cmp edi,0
                    JZ PRINTTREE3
                    mov eax,esi
                    mov esi,cs:printtree101
                    call pushstack32
                    mov eax,cs:printtree102
                    inc eax                
                    mov cs:printtree102,eax
                    JMP PRINTTREE1
          PRINTTREE3:
          mov edi,ds:[esi+8]
          cmp edi,0
          JNZ PRINTTREE1
mov eax,cs:printtree102
cmp eax,0
JZ PRINTTREE8
mov eax,cs:printtree102
dec eax                
mov cs:printtree102,eax
mov esi,cs:printtree101
call popstack32
mov esi,eax
JMP PRINTTREE3
PRINTTREE4:
          mov eax,cs:printtree102
          cmp eax,0
          JNZ PRINTTREE3
PRINTTREE8:
                
pop es                
pop ds                
pop ebp                
pop esi                
pop edi                
pop edx                
pop ecx                
pop ebx                
RET                
                
                
                
MULTLINETREE:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          JMP MULTLINETREE10
          multlinetree101 resd 1
          multlinetree102 resd 1
          multlinetree200 db 32," press a key to go to next page.                           "
          multlinetree201 resd 1
          multlinetree202 resb 1
          multlinetree203 resb 1
          MULTLINETREE10:
                          
          push esi                
          mov cs:multlinetree202,al
                          
                          
          mov ax,offset multlinetree200
          inc ax                
          mov si,ax
          mov ax,cs
          call mem32
                          
          mov cs:multlinetree201,eax
                          
                          
          mov ax,0                
          mov ds,ax
                          
          mov esi,cs:multlinetree101
          cmp esi,0
          JNZ MULTLINETREE9
          mov ecx,8000*4
          call creatstack
          mov cs:multlinetree101,eax
          MULTLINETREE9:
          mov eax,0
          mov cs:multlinetree102,eax
                          
          pop esi                
          mov edi,esi
          mov al,0                
          mov cs:multlinetree203,al
          mov al,cs:multlinetree202
          call fillscreen
          mov al,cs:multlinetree202
          mov cs:color,al
          mov al,0                
          mov cs:x,al
          mov cs:y,al
          MULTLINETREE1:
                    mov al,cs:multlinetree203
                    cmp al,22
                    JNZ MULTLINETREE01
                    mov al,0                
                    mov cs:multlinetree203,al
                                    
                    push esi                
                    push edi                
                    mov al,23
                    mov cs:y,al
                    mov esi,cs:multlinetree201
                    dec esi                
                    mov cl,ds:[esi]
                    clc                
                    and ecx,0ffh
                    inc esi                
                    call pprint32
                    pop edi                
                    pop esi                
                                    
                    call getkey
                    mov al,cs:multlinetree202
                    call fillscreen
                                    
                    mov al,cs:multlinetree202
                    mov cs:color,al
                    mov al,0                
                    mov cs:x,al
                    mov cs:y,al
                                    
                    MULTLINETREE01:
                    mov al,cs:multlinetree203
                    inc al                
                    mov cs:multlinetree203,al
                                    
                    mov al,cs:multlinetree102
                    mov cs:x,al
                    mov esi,edi
                    call printnnode
                    mov edi,ds:[esi+12]
                    cmp edi,0
                    JZ MULTLINETREE3
                    mov eax,esi
                    mov esi,cs:multlinetree101
                    call pushstack32
                    mov eax,cs:multlinetree102
                    inc eax                
                    mov cs:multlinetree102,eax
                    JMP MULTLINETREE1
          MULTLINETREE3:
          mov edi,ds:[esi+8]
          cmp edi,0
          JNZ MULTLINETREE1
mov eax,cs:multlinetree102
cmp eax,0
JZ MULTLINETREE8
mov eax,cs:multlinetree102
dec eax                
mov cs:multlinetree102,eax
mov esi,cs:multlinetree101
call popstack32
mov esi,eax
JMP MULTLINETREE3
MULTLINETREE4:
          mov eax,cs:multlinetree102
          cmp eax,0
          JNZ MULTLINETREE3
MULTLINETREE8:
                
pop es                
pop ds                
pop ebp                
pop esi                
pop edi                
pop edx                
pop ecx                
pop ebx                
RET                
                
                
FPPRINT32:
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
                          
          JMP FPPRINT3214
          fpprint3215 db 13,10
          fpprint3216 db 32,32
          FPPRINT3214:
          cmp ecx,0
          JZ FPPRINT3213
          push ecx                
          push edi                
          push esi                
          mov cl,cs:x
          and cx,0ffh
          cmp cx,0                
          JZ FPPRINT3218
          push ds                
          mov ax,cs:fprinttreef1
          mov di,ax
          FPPRINT3217:
                    push cx                
                    mov si,offset fpprint3216
                                    
                    mov ax,cs
                    mov ds,ax
                    mov cx,1                
                    call write16
                    pop cx                
                                    
                    dec cx                
                    cmp cx,0                
                    JNZ FPPRINT3217
          pop ds                
          FPPRINT3218:
          pop esi                
          pop edi                
          pop ecx                
          mov ax,cs:fprinttreef1
          mov di,ax
          call write32
                          
          mov ax,cs:fprinttreef1
          mov di,ax
          mov si,offset fpprint3215
          push ds                
          mov ax,cs
          mov ds,ax
          mov cx,2                
          call write16
          pop ds                
                          
                          
          FPPRINT3212:
                                    
                    FPPRINT3213:
                    pop ebp                
                    pop edi                
                    pop esi                
                    pop edx                
                    pop ecx                 
                    pop ebx                
                    pop eax                
                    RET                
                
                
                
FPRINTNNODE:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,0                
          mov ds,ax
                          
          mov edi,esi
                          
                          
          mov esi,ds:[edi]
          dec esi                
          mov cl,ds:[esi]
          clc                
          and ecx,0ffh
          inc esi                
          call fpprint32
                          
                          
                          
                          
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
FPRINTTREE:
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          JMP FPRINTTREE10
          fprinttree101 resd 1
          fprinttree102 resd 1
          fprinttreef1 resw 1
          FPRINTTREE10:
                          
          push esi                
                          
          mov cs:fprinttreef1,ax
                          
          mov ax,0                
          mov ds,ax
                          
                          
          mov esi,cs:fprinttree101
          cmp esi,0
          JNZ FPRINTTREE9
          mov ecx,8000*4
          call creatstack
          mov cs:fprinttree101,eax
          FPRINTTREE9:
          mov eax,0
          mov cs:fprinttree102,eax
                          
          pop esi                
          mov edi,esi
                          
          FPRINTTREE1:
                    mov al,cs:fprinttree102
                    mov cs:x,al
                    mov esi,edi
                    call fprintnnode
                    mov edi,ds:[esi+12]
                    cmp edi,0
                    JZ FPRINTTREE3
                    mov eax,esi
                    mov esi,cs:fprinttree101
                    call pushstack32
                    mov eax,cs:fprinttree102
                    inc eax                
                    mov cs:fprinttree102,eax
                    JMP FPRINTTREE1
          FPRINTTREE3:
          mov edi,ds:[esi+8]
          cmp edi,0
          JNZ FPRINTTREE1
mov eax,cs:fprinttree102
cmp eax,0
JZ FPRINTTREE8
mov eax,cs:fprinttree102
dec eax                
mov cs:fprinttree102,eax
mov esi,cs:fprinttree101
call popstack32
mov esi,eax
JMP FPRINTTREE3
FPRINTTREE4:
          mov eax,cs:fprinttree102
          cmp eax,0
          JNZ FPRINTTREE3
FPRINTTREE8:
                
pop es                
pop ds                
pop ebp                
pop esi                
pop edi                
pop edx                
pop ecx                
pop ebx                
RET                
                
                
                
                
                
                
                
                
RET                
RET                
RET                
RET                
RET                
                
RET                
RET                
RET                
RET                
RET                
                
endf   db " "
                
                
                
                
                
                
                
                
