extern main
export _start
_start:
	mov ax,0xffff
	mov sp,ax
	mov ax,cs
	mov ss,ax
	mov ax,0x1000
	push ax
	mov ax,0x100
	push ax
	call main
	retf
	mov ax,0
	int 0x20

