###############################
############ 3 kyu ############
###############################
# In this kata you will have to calculate fib(n) where:

# fib(0) := 0
# fib(1) := 1
# fin(n + 2) := fib(n + 1) + fib(n)
# Write an algorithm that can handle n up to 2000000.

# Your algorithm must output the exact integer answer, to full precision. Also, it must correctly handle negative numbers as input.

# HINT I: Can you rearrange the equation fib(n + 2) = fib(n + 1) + fib(n) to find fib(n) if you already know fib(n + 1) and fib(n + 2)? Use this to reason what value fib has to have for negative values.
#With internet help !!!!!
def fib(n) : 
    bin_of_n = bin(abs(n))[2:]
    f = [0, 1] 
    for b in bin_of_n:
        f2i1 = f[1]**2 + f[0]**2 
        f2i = f[0]*(2*f[1]-f[0]) 
        if b == '0':
            f[0], f[1] = f2i, f2i1  
        else:
            f[0], f[1] = f2i1, f2i1+f2i  
    if n>0 or (n<0 and n%2!=0): 
        return f[0]
    return f[0]*-1

# The purpose of this kata is to write a program that can do some algebra. Write a function expand that takes in an expression with a single, one character variable, and expands it. The expression is in the form (ax+b)^n where a and b are integers which may be positive or negative, x is any single character variable, and n is a natural number. If a = 1, no coefficient will be placed in front of the variable. If a = -1, a "-" will be placed in front of the variable.
# The expanded form should be returned as a string in the form ax^b+cx^d+ex^f... where a, c, and e are the coefficients of the term, x is the original one character variable that was passed in the original expression and b, d, and f, are the powers that x is being raised to in each term and are in decreasing order. If the coefficient of a term is zero, the term should not be included. If the coefficient of a term is one, the coefficient should not be included. If the coefficient of a term is -1, only the "-" should be included. If the power of the term is 0, only the coefficient should be included. If the power of the term is 1, the caret and power should be excluded.
# Examples:
# expand("(x+1)^2")      # returns "x^2+2x+1"
# expand("(p-1)^3")      # returns "p^3-3p^2+3p-1"
# expand("(2f+4)^6")     # returns "64f^6+768f^5+3840f^4+10240f^3+15360f^2+12288f+4096"
# expand("(-2a-4)^0")    # returns "1"
# expand("(-12t+43)^2")  # returns "144t^2-1032t+1849"
# expand("(r+0)^203")    # returns "r^203"
# expand("(-x-1)^2")     # returns "x^2+2x+1"

import re 
import math
def init_re(expr): 
    ##Regexp
    exp_par = re.compile("\(.*\)")
    exp_power=re.compile("\^.*")
    exp_op=re.compile(".[+|-].")
        
    ##Research regex 
    par= re.findall(exp_par,expr)
    power=re.findall(exp_power,expr)
    par = par[0][1:-1]
    power=power[0][1:]
    return par, power

def decomp(par): 
    i = len(par) -1
    while par[i].isalpha() == False and par[i]!='-' and par[i]!='+': 
        i-=1
    b = int(par[i:])
    ope = par[i]
    a_exp = par[:i]
    x=a_exp[-1]
    a=a_exp[:-1]
    return a,x,ope,b

def calc(expr,power,a,b,ope,x):
    ##Cas particulier
    res=''
    if a == '' : 
        a=1
        res=res+x+"^{}".format(power)
    if a == '-': 
        a = -1
        if power % 2 != 0 : 
            res=res+"-"+x+"^{}".format(power)
        else : 
            res=res+x+"^{}".format(power)
    if a != 1 and a != -1 : 
        a=int(a)
        res=res+str(a**power)+x+"^{}".format(power)


    if power == 2 :
        if b == 0 : 
            return res + str(2*a)+x
        return res +"+"+ str(2*a*b)+x +"+"+ str(b**2) 

    ##Boucle
    for i in range(power-1,0,-1): 
        a=int(a) 
        C = math.comb(power,power-i)
        tmp=C*(a**i)*b**(power-i)
        if tmp>0: 
            res+="+"+str(tmp)
        else : 
            res+=str(tmp)
        if i != 1 : 
            res=res+x+"^"+str(i)
        else : 
            res=res+x
    
    tmp=b**power
    if tmp>0 : 
        res+="+"+str(b**power)
    else :
        res+=str(b**power)
    return res

def expand(expr):
    par,power=init_re(expr)
    a,x,ope,b=decomp(par)
    if power == '0' : 
        return '1' 
    if power == '1' :
        return par 
    else : 
        power=int(power)
        res =  calc(expr,power,a,b,ope,x)
        res ='+'.join(res.split("--"))
        res ='-'.join(res.split("+-"))
        res ='-'.join(res.split("-+"))
        res ='+'.join(res.split("++"))
        return res
        
            
# Test 
print(expand("(x+1)^0") =="1" and expand("(x+1)^1")== "x+1"and expand("(x+1)^2")== "x^2+2x+1" and expand("(x-1)^0")== "1" and expand("(x-1)^1")== "x-1" and expand("(x-1)^2")== "x^2-2x+1" and expand("(5m+3)^4")== "625m^4+1500m^3+1350m^2+540m+81" and expand("(2x-3)^3")== "8x^3-36x^2+54x-27" and expand("(7x-7)^0")== "1" and expand("(-5m+3)^4")== "625m^4-1500m^3+1350m^2-540m+81" and expand("(-2k-3)^3")== "-8k^3-36k^2-54k-27" and expand("(-7x-7)^0")== "1" and expand("(e-8)^4")=='e^4-32e^3+384e^2-2048e+4096' and expand("(-v-16)^2") == "v^2+32v+256")

        
            
#Test
#print(expand("(x+1)^0") =="1" and expand("(x+1)^1")== "x+1"and expand("(x+1)^2")== "x^2+2x+1" and expand("(x-1)^0")== "1" and expand("(x-1)^1")== "x-1" and expand("(x-1)^2")== "x^2-2x+1" and expand("(5m+3)^4")== "625m^4+1500m^3+1350m^2+540m+81" and expand("(2x-3)^3")== "8x^3-36x^2+54x-27" and expand("(7x-7)^0")== "1" and expand("(-5m+3)^4")== "625m^4-1500m^3+1350m^2-540m+81" and expand("(-2k-3)^3")== "-8k^3-36k^2-54k-27" and expand("(-7x-7)^0")== "1")

# DESCRIPTION:
# Write a function that will solve a 9x9 Sudoku puzzle. The function will take one argument consisting of the 2D puzzle array, with the value 0 representing an unknown square.

# The Sudokus tested against your function will be "easy" (i.e. determinable; there will be no need to assume and test possibilities on unknowns) and can be solved with a brute-force approach.

# For Sudoku rules, see the Wikipedia article.

def findNextCellToFill(grid, i, j):
        for x in range(i,9):
                for y in range(j,9):
                        if grid[x][y] == 0:
                                return x,y
        for x in range(0,9):
                for y in range(0,9):
                        if grid[x][y] == 0:
                                return x,y
        return -1,-1

def isValid(grid, i, j, e):
        rowOk = all([e != grid[i][x] for x in range(9)])
        if rowOk:
                columnOk = all([e != grid[x][j] for x in range(9)])
                if columnOk:
                        # finding the top left x,y co-ordinates of the section containing the i,j cell
                        secTopX, secTopY = 3 *(i//3), 3 *(j//3) #floored quotient should be used here. 
                        for x in range(secTopX, secTopX+3):
                                for y in range(secTopY, secTopY+3):
                                        if grid[x][y] == e:
                                                return False
                        return True
        return False

def solveSudoku(grid, i=0, j=0):
        i,j = findNextCellToFill(grid, i, j)
        if i == -1:
                return True
        for e in range(1,10):
                if isValid(grid,i,j,e):
                        grid[i][j] = e
                        if solveSudoku(grid, i, j):
                                return True
                        # Undo the current cell for backtracking
                        grid[i][j] = 0
        return False

def sudoku(puzzle):
    output = solveSudoku(puzzle)
    if output == False : 
        return False
    else : 
        return puzzle
