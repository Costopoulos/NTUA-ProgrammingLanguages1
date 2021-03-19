#!/usr/bin/env python
import sys
with open(sys.argv[1], 'r') as file:
    myinput = file.read()
for x in range(len(myinput)):   
    if(myinput[x]== "\n"): 
        M = x
        break
N = int((len(myinput)+1) /(M+1))
X=[]
A=[]
for x in range(len(myinput)):   
    if(myinput[x]== "S"): 
        S = x
    if(myinput[x]== "X"): 
        X.append(x)
    if(myinput[x]=="W"):
        W = x
    if(myinput[x]=="A"):
        A.append(x)
    if(myinput[x]== "T"): 
         T = x
            
def move_up (x):
    if((x-(M+1)>=0)):
        if((x-(M+1)>=0) and (myinput[x]!="X") and (myinput[x]!="\n") and (myinput[x-M-1]!="X") and (myinput[x-M-1]!="W") ) :
            return x-(M+1)
        else:
            return -1
    else:
        return -1

def move_down (x):
    if((x+(M+1)<=(len(myinput)-1))):
        if((myinput[x]!="X") and (myinput[x]!="\n") and (myinput[x+M+1]!="X") and (myinput[x+M+1]!="W") ) :
            return x+(M+1)
        else:
            return -1
    else:
            return -1

def move_right (x):
    if((x%(M+1)!= M-1)):
        if((myinput[x+1]!="\n") and (myinput[x+1]!="X") and (myinput[x]!="X") and (myinput[x+1]!="W") ) :
            return x+1
        else:
            return -1
    else:
            return -1    
    
def move_left (x):
    if((x % (M+1))!=0):
        if( (myinput[x]!="X") and (myinput[x-1]!="X") and (myinput[x-1]!="\n") and (myinput[x-1]!="W") ) :
            return x-1
        else:
            return -1
    else:
            return -1
        
vir = [0]*(len(myinput))
def move_virus(x, y):
    
    if(vir[x]==0 or y<vir[x] ):
        vir[x]=y
        if (move_down(x)!= -1):
            if (myinput[x+M+1]!="A"):
                z=y+2
                move_virus(x+M+1, z)
            else:
                z=y+2
                for i in A :
                    if (i!=(x+M+1)):
                        move_virus(i, z+5)
                        move_virus(x+M+1, z)
    #if(vir[x]==0 ):
        if(move_left(x)!=-1):
            if(myinput[x-1]!="A"):
                z=y+2
                move_virus(x-1, z)
            else:
                z=y+2
                for i in A :
                    if (i!=(x-1)):
                        move_virus(i, z+5)
                        move_virus(x-1, z)

   
        if(move_right(x)!=-1):
            if(myinput[x+1]!="A"):
                z=y+2
                move_virus(x+1,z)
            else:
                z=y+2
                for i in A :
                    if (i!=(x+1)):
                        move_virus(i, z+5)
                        move_virus(x+1, z)
        
        if (move_up(x)!= -1):
            if (myinput[x-(M+1)]!="A"):
                z=y+2
                move_virus(x-M-1, z)
            else:
                z=y+2
                for i in A :
                    if (i!=(x-M-1)):
                        move_virus(i, z+5)
                        move_virus(x-M-1, z)
            
    return vir

move_virus(W,0)

path=["None"]*len(myinput)
visited = [0]*(len(myinput))

listd = [S]

n = 1
while len(listd) != 0:
    listdtemp = listd
    listd = []
    
    for x in listdtemp:
       
        L = [move_down(x),move_left(x),move_right(x),move_up(x)]
        D = ["D","L","R","U"]
        for i in range(4):
            if L[i] != -1:
                if (visited[L[i]] == 0  and n < vir[L[i]]): 
                    visited[L[i]] = n
                    visited[S]=-1
                    path[L[i]] = D[i]
                    listd.append(L[i])
                    #print(L[i])
                    
                    
    n += 1
  

if(visited[T] == 0):
    print("IMPOSSIBLE")
else:
    print(visited[T])
    way = ""
    x = T
    while x != S:
        way = path[x] + way
        if path[x] == "D": x = x-M-1
        elif path[x] == "L": x = x+1
        elif path[x] == "R": x = x-1
        elif path[x] == "U": x = x+M+1
    print(way)        