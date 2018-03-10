jmp main                
files resw 1
counter resw 0
counter2 resw 0
MAIN:                
                          
          mov dx,offset file
          call creat
          mov files,ax
                          
          mov bx,offset text2
          call len                
                          
          mov cx,ax
          mov bx,files
          mov dx,offset text2
          call write
                          
                          
          call close
                          
                          
                          
          mov dx,offset file
          call open
          mov files,ax
          cmp ax,0ffffh
          JZ EXIT                
                          
          xor dx,dx
          xor cx,cx
          mov al,2                
          mov bx,files
          call filepoint
          mov counter,ax
          mov counter2,dx
          call close
                          
                          
          mov bx,offset counter2
          mov al,1                
          call display
                          
          mov bx,offset text1
          call print
                          
                          
          mov bx,offset counter
          mov al,0                
          call display
                          
                          
                          
          EXIT:                
          int 20h                
          RET                
                
file db "marina.txt",0,0
text2 db "im love marina.",13,10,0
text1 db ":",0
                
variantetablesize equ 256*4
                
varianteblock resb 1
variantetable resw 1
varianteptrpos resw 1
                
                
PRINTF:                
          push ax                
          push bx                
          xor bh,bh
          mov bl,70h
          mov ah,0eh
          int 10h                
          pop bx                
          pop ax                
          RET                
                
                
GETCHAR:                
          xor ax,ax
          int 16h                
          RET                
                
                
GETSTR:                
          push ax                
          push bx                
          push cx                
          push dx                
          mov dx,cx
          GETSTR1:                
                    call getchar
                    cmp al,7                
                    JNZ GETSTR2
                    inc cx                
                    dec bx                
                    cmp cx,dx
                    JB GETSTR2
                    inc bx                
                    mov cx,dx
                    GETSTR2:                
                    cmp al,13
                    JZ GETSTR3
                    mov [bx],al
                    call printf
                    inc bx                
                    dec cx                
                    cmp cx,0                
                    JA GETSTR1 
          GETSTR3:                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
                
                
CPRINT:                
          push ax                
          push bx                
          push cx                
          push dx                
          CPRINT1:                
                    mov al,[bx]
                    call printf
                    inc bx                
                    dec cx                
                    cmp cx,0                
                    JNZ CPRINT1
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
                
getStrings:
push ax                
push bx                
push cx                
push dx                
push cx                
push bx                
push dx                
push ax                
mov bx,offset cf
mov cx,2                
call cprint
pop cx                
pop bx                
call cprint
pop bx                
pop cx                
call getstr
mov bx,offset cf
mov cx,2                
call cprint
pop dx                
pop cx                
pop bx                
pop ax                
RET                
cf db 13,10,32,"."
                
ENTERLINE:
          push bx                
          push cx                
          mov bx,offset cf
          mov cx,2                
          call cprint
          pop cx                
          pop bx                
          RET                
                
FILLCHAR:
          push ax                
          push bx                
          push cx                
          FILLCHAR1:
                    mov [bx],al
                    inc bx                
                    dec cx                
                    JNZ FILLCHAR1
          pop cx                
          pop bx                
          pop ax                
          RET                
                
COPYSTR:                
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov cx,255
          mov si,bx
          mov di,dx
          COPYSTR1:
                    mov al,[si]
                    cmp al,0                
                    JZ COPYSTR2
                    mov [di],al
                    inc di                
                    inc si                
                    dec cx                
                    JNZ COPYSTR1
          COPYSTR2:
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
COPYMEM:                
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov si,bx
          mov di,dx
          COPYMEM1:
                    mov al,[si]
                    mov [di],al
                    inc di                
                    inc si                
                    dec cx                
                    JNZ COPYMEM1
          COPYMEM2:
                    pop si                
                    pop di                
                    pop dx                
                    pop cx                
                    pop bx                
                    pop ax                
                    RET                
                
                
PRINT:                
          push ax                
          push bx                
          push cx                
          push dx                
          mov cx,255
          PRINT1:                
                    mov al,[bx]
                    cmp al,0                
                    JZ PRINT2
                    call printf
                    inc bx                
                    dec cx                
                    cmp cx,0                
                    JNZ PRINT1
          PRINT2:                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
LEN:                
          push bx                
          push cx                
          push dx                
          mov cx,0                
          LEN1:                
                    mov al,[bx]
                    cmp al,0                
                    JZ LEN2                
                    inc bx                
                    inc cx                
                    cmp cx,0                
                    JNZ LEN1                
          LEN2:                
          mov ax,cx
          pop dx                
          pop cx                
          pop bx                
          RET                
                
COMPSTR:                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov cx,0                
          mov si,bx
          mov di,dx
          COMPSTR1:
                    mov al,[si]
                    mov ah,[di]
                    cmp al,0                
                    JZ COMPSTR2
                    cmp ah,0                
                    JZ COMPSTR2
                    cmp al,ah
                    JNZ COMPSTR2
                    inc di                
                    inc si                
                    inc cx                
                    cmp cx,0                
                    JNZ COMPSTR1
          COMPSTR2:
          mov ax,cx
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          RET                
                
                
COMPSTRING:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov cx,0                
          mov si,bx
          mov di,dx
          COMPSTRING1:
                    mov al,[si]
                    mov ah,[di]
                    cmp al,0                
                    JZ COMPSTRING2
                    cmp ah,0                
                    JZ COMPSTRING2
                    cmp al,ah
                    JNZ COMPSTRING2
                    inc di                
                    inc si                
                    inc cx                
                    cmp cx,0                
                    JNZ COMPSTRING1
          COMPSTRING2:
          cmp al,ah
          JZ COMPSTRING3
          JB COMPSTRING4
          mov ax,1                
          jmp compString5
          COMPSTRING3:
          mov ax,0                
          jmp compString5
          COMPSTRING4:
          mov ax,2                
          COMPSTRING5:
                    pop si                
                    pop di                
                    pop dx                
                    pop cx                
                    pop bx                
                    RET                
                
LOWERSTRING:
          push ax                
          push bx                
          push cx                
          push dx                
          mov cx,0                
          LOWERSTRING1:
                    mov al,[bx]
                    cmp al,0                
                    JZ LOWERSTRING2
                    cmp al,'A'
                    JB LOWERSTRING3
                    cmp al,'Z'
                    JA LOWERSTRING3
                    mov ah,'a'-'A'
                    add al,ah
                    mov [bx],al
                    LOWERSTRING3:
                    inc bx                
                    inc cx                
                    cmp cx,255
                    JNZ LOWERSTRING1
          LOWERSTRING2:
          mov ax,cx
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
LOWERSTR:
          push ax                
          push bx                
          push cx                
          push dx                
          LOWERSTR1:
                    mov al,[bx]
                    cmp al,0                
                    JZ LOWERSTR2
                    cmp al,'A'
                    JB LOWERSTR3
                    cmp al,'Z'
                    JA LOWERSTR3
                    mov ah,'a'-'A'
                    add al,ah
                    mov [bx],al
                    LOWERSTR3:
                    inc bx                
                    dec cx                
                    cmp cx,0                
                    JNZ LOWERSTR1
          LOWERSTR2:
          mov ax,cx
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
UPPERSTR:
          push ax                
          push bx                
          push cx                
          push dx                
          UPPERSTR1:
                    mov al,[bx]
                    cmp al,0                
                    JZ UPPERSTR2
                    cmp al,'a'
                    JB UPPERSTR3
                    cmp al,'z'
                    JA UPPERSTR3
                    mov ah,'a'-'A'
                    sub al,ah
                    mov [bx],al
                    UPPERSTR3:
                    inc bx                
                    dec cx                
                    cmp cx,0                
                    JNZ UPPERSTR1
          UPPERSTR2:
          mov ax,cx
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
UPPERSTRING:
          push ax                
          push bx                
          push cx                
          push dx                
          mov cx,0                
          UPPERSTRING1:
                    mov al,[bx]
                    cmp al,0                
                    JZ UPPERSTRING2
                    cmp al,'a'
                    JB UPPERSTRING3
                    cmp al,'z'
                    JA UPPERSTRING3
                    mov ah,'a'-'A'
                    sub al,ah
                    mov [bx],al
                    UPPERSTRING3:
                    inc bx                
                    inc cx                
                    cmp cx,255
                    JNZ UPPERSTRING1
          UPPERSTRING2:
          mov ax,cx
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
                
FINDCHAR:
          push bx                
          push cx                
          push dx                
          mov cx,0                
          mov ah,al
          FINDCHAR1:
                    mov al,[bx]
                    cmp al,0                
                    JZ FINDCHAR2
                    cmp al,ah
                    JZ FINDCHAR3
                    inc bx                
                    inc cx                
                    cmp cx,255
                    JNZ FINDCHAR1
          FINDCHAR2:
          mov cx,0ffffh
          FINDCHAR3:
          mov ax,cx
          pop dx                
          pop cx                
          pop bx                
          RET                
                
FINDCHARSTR:
          push bx                
          push cx                
          push dx                
          mov dx,0                
          mov ah,al
          FINDCHARSTR1:
                    mov al,[bx]
                    cmp al,0                
                    JZ FINDCHARSTR2
                    cmp al,ah
                    JZ FINDCHARSTR3
                    inc bx                
                    inc dx                
                    dec cx                
                    cmp cx,0                
                    JNZ FINDCHARSTR1
          FINDCHARSTR2:
          mov cx,0ffffh
          FINDCHARSTR3:
          mov ax,dx
          pop dx                
          pop cx                
          pop bx                
          RET                
                
                
ASC:                
          mov al,[bx]
          RET                
                
                
LEFT:                
          clc                
          add ax,bx
          RET                
                
RIGTH:                
          push dx                
          mov dx,ax
          call len                
          clc                
          sub ax,dx
          pop dx                
          RET                
                
FINDSTRING:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov si,dx
          xor ax,ax
          mov al,[si]
          mov di,ax
          mov si,bx
          mov bx,dx
          call len 
          cmp ax,0                
          JNZ FINDSTRING9
          mov ax,0ffffh
          jmp  findstring8
          FINDSTRING9:
          mov bx,si
          mov si,ax
          FINDSTRING1:
                    mov ax,di
                    call findchar
                    cmp ax,0ffffh
                    JZ FINDSTRING8
                    clc                 
                    add bx,ax
                    call compStr
                    cmp si,ax
                    JZ FINDSTRING10
                    inc bx                
                    jmp findstring1
                    FINDSTRING10:
                    mov ax,bx
                    FINDSTRING8:
                    pop si                
                    pop di                
                    pop dx                
                    pop cx                
                    pop bx                
                                    
                    RET                
                
                
FINDPOS:                
          call findstring
          cmp ax,0ffffh
          JZ FINDPOS1
          sub ax,bx
          FINDPOS1:
          RET                
                
COMPSIZE:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          mov dx,0                
          COMPSIZE1:
                    mov al,[si]
                    mov ah,[di]
                    cmp al,0                
                    JZ COMPSIZE2
                    cmp ah,0                
                    JZ COMPSIZE2
                    cmp al,ah
                    JNZ COMPSIZE2
                    inc di                
                    inc si                
                    inc dx                
                    dec bp                
                    dec cx                
                    cmp bp,0                
                    JZ COMPSIZE2
                    cmp cx,0                
                    JNZ COMPSIZE1
          COMPSIZE2:
          mov ax,dx
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          RET                
                
COMPSTRINGSIZE:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          mov dx,0                
          COMPSTRINGSIZE1:
                    mov al,[si]
                    mov ah,[di]
                    cmp al,0                
                    JZ COMPSTRINGSIZE2
                    cmp ah,0                
                    JZ COMPSTRINGSIZE2
                    cmp al,ah
                    JNZ COMPSTRINGSIZE2
                    inc di                
                    inc si                
                    dec cx                
                    dec bp                
                    cmp bp,0                
                    JZ COMPSTRINGSIZE2
                    cmp cx,0                
                    JNZ COMPSTRINGSIZE1
          COMPSTRINGSIZE2:
          cmp al,ah
          JZ COMPSTRINGSIZE3
          JB COMPSTRINGSIZE4
          mov ax,1                
          jmp compStringsize5
          COMPSTRINGSIZE3:
          mov ax,0                
          jmp compStringsize5
          COMPSTRINGSIZE4:
          mov ax,2                
          COMPSTRINGSIZE5:
                    pop bp                
                    pop si                
                    pop di                
                    pop dx                
                    pop cx                
                    pop bx                
                    RET                
                
FINDPTSIZE:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          mov al,[di]
          mov bl,al
          FINDPTSIZE1:
                    mov al,bl
                    xchg bx,si
                    call findcharstr
                    cmp ax,0ffffh
                    JZ FINDPTSIZE8
                    xchg bx,si
                    clc                 
                    add si,ax
                    clc                 
                    sub cx,ax
                    call compSize
                    cmp bp,ax
                    JZ FINDPTSIZE10
                    inc si                
                    dec cx                
                    cmp cx,0fff0h
                    JA FINDPTSIZE11
                    cmp cx,0                
                    JZ FINDPTSIZE1
          FINDPTSIZE11:
          mov si,0ffffh
          FINDPTSIZE10:
          mov ax,si
          FINDPTSIZE8:
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
                          
          RET                
                
                
FINDPOSIZE:
          call findptsize
          cmp ax,0ffffh
          JZ FINDPOSIZE1
          sub ax,si
          FINDPOSIZE1:
          RET                
                
hhex db "0123456789ABCDEF.$",0
                
HEX:                
          push ax                
          push bx                
          push dx                
          push si                
          push di                
          inc bx                
          xor ah,ah
          mov dx,ax
          and ax,0fh
          mov si,offset hhex
          clc                
          add si,ax 
          mov al,cs:[si]
          mov [bx],al
          dec bx                
          mov ax,dx
          and ax,0f0h
          shr ax,4                
          mov si,offset hhex
          clc                
          add si,ax 
          mov al,cs:[si]
          mov [bx],al
                          
          pop di                
          pop si                
          pop dx                
          pop bx                
          pop ax                
          RET                
                
                
                
debugs:                
push ax                
push bx                
push cx                
push dx                
inc bx                
inc bx                
mov dx,ax
and ax,0ffh
call hex                
dec bx                
dec bx                
mov ax,dx
and ax,0ff00h
shr ax,8                
call hex                
pop dx                
pop cx                
pop bx                
pop ax                
RET                
                
                
MOVEFORD:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
                          
          clc                
          add di,cx
          clc                
          add si,cx
          MOVEFORD1:
                    mov al,[si]
                    mov [di],al
                    dec si                
                    dec di                
                    dec cx                
                    cmp cx,0                
                    JNZ MOVEFORD1
                          
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
                          
          RET                
                
MOVEBACK:
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
                          
          MOVEBACK1:
                    mov al,[si]
                    mov [di],al
                    inc si                
                    inc di                
                    dec cx                
                    cmp cx,0                
                    JNZ MOVEBACK1
                          
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
GOTOXY:                
          push ax                
          push bx                
          push dx                
          mov ah,2                
          mov bh,0                
          int 10h                
          pop dx                
          pop bx                
          pop ax                
          RET                 
                
                
                
GETXY:                
          push ax                
          push bx                
          push cx                
          mov ah,3                
          mov bh,0                
          int 10h                
          pop cx                
          pop bx                
          pop ax                
          RET                 
                
                
INPUT:                
          jmp input2
          inputpos     resw 1
          inputsize    resw 1
          inputptr     resw 1
          inputptrpos  resw 1
          inputcounter resw 1
          INPUT2:                
                    push ax                
                    push bx                
                    push cx                
                    push dx                
                    push di                
                    push si                
                    push bp                
                    mov inputptr,bx
                    mov inputptrpos,bx
                    call getxy
                    mov inputpos,dx
                    mov inputsize,cx
                    clc                 
                    add bx,cx
                    mov inputcounter,bx
                    INPUT3:                
                              call getchar
                              cmp al,13
                              JZ INPUT4
                              cmp al,8                
                              JZ INPUT8
                              cmp al,32
                              JB INPUT3
                    INPUT8:                
                    cmp al,8                
                    JNZ INPUT5
                    mov dx,inputptrpos
                    mov cx,inputptr
                    cmp dx,cx
                    JZ INPUT3
          dec inputptrpos
          mov al,32
          mov bx,inputptrpos
          mov [bx],al
          jmp input22
          INPUT5:                 
          mov dx,inputptrpos
          mov cx,inputcounter
          cmp dx,cx
          JZ INPUT3
mov bx,inputptrpos
mov [bx],al
inc bx                
INPUT22:                
          mov inputptrpos,bx
          mov dx,inputpos
          call gotoxy
          mov cx,inputsize
          mov bx,inputptr
          call cprint 
          jmp input3
          INPUT4:                
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
                
VARIANTE:
          mov bx,offset endf
          mov variantetable,bx
          mov varianteblock,0
          mov cx,variantetablesize
          clc                
          add bx,cx
          inc bx                
          mov varianteptrpos,bx
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
                
                
                
CONCAT:                
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          xchg dx,di
          call copystr
          call len                
          xchg bx,di 
          clc                
          add dx,ax
          call copystr
          call len                
          clc                
          add dx,ax
                          
          xchg dx,bx
          xor al,al
          mov [bx],al
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET                
                
displaystring db "0000H",0,0
                
                
DISPLAY:                
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          mov cl,al
          mov dx,offset displaystring
          mov ax,[bx]
          xchg bx,dx
          call debugs
          call print
          cmp cl,0                
          JNZ DISPLAY1:
                    call enterLine
                    DISPLAY1:
                              pop bp                
                              pop si                
                              pop di                
                              pop dx                
                              pop cx                
                              pop bx                
                              pop ax                
                              RET                
                
                
CREAT:                
          push cx                
          mov ah,3ch
          xor cx,cx
          int 21h                
          jnc creat1
          mov ax,0ffffh
          CREAT1:                
                    pop cx                
                    RET                
                
                
                
                
OPEN:                
          mov ah,3dh
          mov al,2                
          int 21h                
          jnc open1
          mov ax,0ffffh
          OPEN1:                
                    RET                
                
                
CLOSE:                
          mov ah,3eh
          mov al,2                
          int 21h                
          jnc close1
          mov ax,0ffffh
          CLOSE1:                
                    RET                
                
WRITE:                
          mov ah,40h
          int 21h                
          jnc write1
          mov ax,0ffffh
          WRITE1:                
                    RET                
                
                
FILEPOINT:
          mov ah,42h
          int 21h                
          RET                
                
                
                
                
                
endf db " "
                
