import sys

with open(sys.argv[1],"rt") as file:
    string = file.read()
my_input = string.split()
times = int(my_input[0])

def P(x,y,z):
    first_stack = x.copy()
    second_stack = y.copy()
    second_stack.append(x[len(x)-1])
    first_stack.pop(len(first_stack)-1) #pop is a python function that removes an element from a list
    return (first_stack,second_stack,(z+'p'))
    
def C(x,y,z):
    copl_first_stack = []
    for j in x:
        if j == 'U': copl_first_stack.append('A')
        elif j == 'A': copl_first_stack.append('U')
        elif j == 'C': copl_first_stack.append('G')
        elif j == 'G': copl_first_stack.append('C')
    return (copl_first_stack,y,(z+'c'))

def R(x,y,z):
    second_stack = y.copy()
    second_stack.reverse()
    return (x,second_stack,(z+'r'))

for x in range(times):
    each_input = []
    finish = False
    output = ""
    for i in range(len(my_input[x+1])): 
        each_input.append(my_input[x+1][i])
    L = [(each_input,[],"")]
    while finish == False:
        Ltemp = L
        L = []
        for (x,y,z) in Ltemp:
                length = len(y)
            
                if z != "" and z[len(z)-1] == 'p':
                    L.append(C(x,y,z))
                if (x[len(x)-1] not in y) or (y != [] and y[length-1] == x[len(x)-1]):
                    (a,b,c) = P(x,y,z)
                    if a == []:
                        finish = True
                        output = c
                        break
                    L.append((a,b,c))
                if z != "" and z[len(z)-1] != 'r' and length > 1:
                    L.append(R(x,y,z))
    print(output)        