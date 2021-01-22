f = open('c1Binary.txt','r+')
Output = open('Ram1.mem','w+')
Output.write('// memory data file (do not edit the following line - required for mem load use)/n// instance=/pdp_11/my_ram/ram\n// format=bin addressradix=h dataradix=b version=1.0 wordsperline=1\n')
Array = ['0'*16]*2048
Lines =f.readlines()
for i in range(len(Lines)):
    # print(Lines[i])
    Array[i] = Lines[i]
for i in range(len(Array)):
    if i<len(Lines):
        Output.write('@'+str(hex(i).split('x')[-1]) +' ' + Array[i])
    else:
        Output.write('@'+str(hex(i).split('x')[-1]) +' ' + Array[i]+'\n')
