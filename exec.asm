FXN4BH --- demonstrate use of the PC-DOS 2.0 EXEC function call 4BH
;
cr       equ       0dh       ;ASCII carriage return
lf       equ       0ah       ;ASCII line feed
                             ;
cseg     segment   para public 'CODE'
                             ;
         assume    cs:cseg,ds:data,ss:stack
                             ;
demo     proc      far
                             ;at entry DS & ES = PSP
         push      ds        ;Save address for final
         xor       ax,ax     ;FAR RET to PC-DOS on stack
         push      ax
                             ;save copy of SS:SP for use
                             ;after return from overlay
         mov       cs:STK_SEG,ss
         mov       cs:STK_PTR,sp
                             ;
                             ;Reserve 1000H bytes for
                             ;this loader and release
                             ;the rest of memory for
                             ;use by the overlayed program.
         mov       bx,100h   ;ES=segment of PSP of loader
         mov       ah,4ah    ;BX=paragraphs to reserve
         int       21h
                             ;make the messages in data
                             ;segment addressable
         mov       ax,seg DATA
         mov       ds,ax
         mov       es,ax
                             ;jump if memory
                             ;de-allocation failed
         jc        ALLOC_ERR
                             ;print memory successfully
                             ;released
         mov       dx,offset MSG2
         mov       ah,9
         int       21h
                             ;
                             ;now load and execute
                             ;the overlaid program.
         mov       dx,offset PGM_NAME
         mov       bx,offset PAR_BLK
         mov       al,0
         mov       ah,4bh
         int       21h
                             ;restore stack pointers
                             ;to state before EXEC call
         mov       ss,cs:STK_SEG
         mov       sp,cs:STK_PTR
                             ;Make data segment
                             ;addressable again
         mov       ax,seg DATA
         mov       ds,ax
                             ;print message that loader
                             ;successfully regained control
         mov       dx,offset MSG3
         mov       ah,9
         int       21h
                             ;now exit to PC-DOS
         ret

alloc_err:                   ;come here if memory
                             ;cannot be released
         mov       dx,offset MSG1
         mov       ah,9
         int       21h       ;print error message and
         ret                 ;exit to PC-DOS
                             ;
demo     endp
                             ;
                             ;these two variables must
                             ;reside in Code Segment so
                             ;that they are addressable
                             ;after return from overlay.
stk_seg  dw        0         ;original SS contents
stk_ptr  dw        0         ;original SP contents
                             ;
cseg     ends

                             ;declare a stack area
                             ;for use by this loader
stack    segment   para stack 'STACK'
                             ;allow 64 bytes in this case
         db        64 dup (?)
stack    ends

                             ;declare data segment to
                             ;contain variables and tables
data     segment   para public 'DATA'
;
msg1     db        cr,lf
         db        'Unable to release memory.'
         db        cr,lf,'$'
msg2     db        cr,lf
         db        'Memory above loader released.'
         db        cr,lf,'Now loading CHKDSK.COM.'
         db        cr,lf,'$'
msg3     db        cr,lf
         db        'Loader regained control from CHKDSK,'
         db        cr,lf
         db        'now making final exit to PC-DOS.'
         db        cr,lf,'$'
;
                             ;drive, path, and name of program
                             ;to be loaded and executed.
pgm_name db        '\CHKDSK.COM',0
;
par_blk  dw        ENVIR     ;segment address of
                             ;environment descriptor
                             ;
                             ;full address of command line
                             ;to be passed at offset 80H
         dw        offset CMD_LINE     ;in overlaid
         dw        seg CMD_LINE        ;program's PSP
                             ;
                             ;full address of default
                             ;File Control Block to be
                             ;passed at offset 5CH in
         dw        offset FCB1         ;overlaid
         dw        seg FCB1            ;program's PSP
                             ;
                             ;full address of default
                             ;File Control Block to be
                             ;passed at offset 6CH in
         dw        offset FCB2         ;overlaid
         dw        seg FCB2            ;program's PSP
;
                             ;actual command line tail
                             ;to be passed to overlay
cmd_line db        4,' *.*',cr,0
;
                             ;first default FCB to
fcb1     db        0         ;be passed to overlay
         db        11 dup ('?')
         db        25 dup (0)

                             ;second default FCB to
fcb2     db        0         ;be passed to overlay
         db        11 dup (' ')
         db        25 dup (0)
;
data     ends

                             ;declare separate data
                             ;segment to contain
                             ;environment descriptor
envir    segment   para 'ENVIR'
                             ;
                             ;Search path used by PC-DOS
                             ;to look for commands or
                             ;batch files not found in
         db        'PATH=',0 ;the current directory
                             ;
                             ;Search path used by PC-DOS
                             ;to locate COMMAND.COM
         db        'COMSPEC=A:\COMMAND.COM',0
         db        0         ;extra 0 byte designates
                             ;end of environment
envir    ends

         end       demo
