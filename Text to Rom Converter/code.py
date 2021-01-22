import numpy as np
import re

f = open('ROM.txt','r+')
Output = open('Out.txt','w+')
# Output.write('// memory data file (do not edit the following line - required for mem load use)\n// instance=/lab4/u10/ram\n// format=bin addressradix=h dataradix=b version=1.0 wordsperline=1\n')

Array = ['0'*24]*361
Lines =f.readlines()
Counter =0
for Line in Lines:
    if re.search(":", Line) == None:
        continue
    Counter+=1
    index = int(Line[0:3], 8) 
    Array[index] = str(Line[5:29])

for i in range(len(Array)):
    Output.write(str(i)+' => "'+ Array[i] + '"\n')