###############################
############ 4 kyu ############
###############################
# Your task in order to complete this Kata is to write a function which formats a duration, given as a number of seconds, in a human-friendly way.
# The function must accept a non-negative integer. If it is zero, it just returns "now". Otherwise, the duration is expressed as a combination of years, days, hours, minutes and seconds.
# It is much easier to understand with an example:
# * For seconds = 62, your function should return 
#     "1 minute and 2 seconds"
# * For seconds = 3662, your function should return
#     "1 hour, 1 minute and 2 seconds"
# For the purpose of this Kata, a year is 365 days and a day is 24 hours.
# Note that spaces are important.
# Detailed rules
# The resulting expression is made of components like 4 seconds, 1 year, etc. In general, a positive integer and one of the valid units of time, separated by a space. The unit of time is used in plural if the integer is greater than 1.
# The components are separated by a comma and a space (", "). Except the last component, which is separated by " and ", just like it would be written in English.
# A more significant units of time will occur before than a least significant one. Therefore, 1 second and 1 year is not correct, but 1 year and 1 second is.
# Different components have different unit of times. So there is not repeated units like in 5 seconds and 1 second.
# A component will not appear at all if its value happens to be zero. Hence, 1 minute and 0 seconds is not valid, but it should be just 1 minute.
# A unit of time must be used "as much as possible". It means that the function should not return 61 seconds, but 1 minute and 1 second instead. Formally, the duration specified by of a component must not be greater than any valid more significant unit of time.
def format_duration(seconds):
    #y,d,h,m=60*60*24*365.25,60*60*24,60*60,60
    l=[0,0,0,0,0]
    l_time=[60*60*24*365,60*60*24,60*60,60]
    l_str_time=["year","day","hour","minute","second"]
    res = ""
    sol=""
    if seconds==0 : 
        return 'now'
    
    for i in range(len(l)-1) : 
        l[i]=seconds//l_time[i]
        seconds-=l[i]*l_time[i]
    l[-1]=int(seconds)
    
    for i in range(len(l)) : 
        if l[i]!=0 : 
            if l[i]==1 and sum(l[i+1:])>0: 
                res+="1 " + l_str_time[i] +", "
            if l[i]==1 and sum(l[i+1:])==0 :
                res+="1 " + l_str_time[i]
            if l[i]>1 and sum(l[i+1:])==0 : 
                res += "{} {}s".format(int(l[i]),l_str_time[i])
            if l[i]>1 and sum(l[i+1:])>0 : 
                res += "{} {}s, ".format(int(l[i]),l_str_time[i])
    res=res.split(',')
    if len(res)>2 : 
        sol = ",".join(res[:-1]) + " and" + res[-1]
    if len(res)==2 : 
        sol = " and".join(res)
    if len(res)==1 : 
        sol = res[0]
    return sol

# Write a function that takes a positive integer and returns the next smaller positive integer containing the same digits.
# For example:
# next_smaller(21) == 12
# next_smaller(531) == 513
# next_smaller(2071) == 2017
# Return -1 (for Haskell: return Nothing, for Rust: return None), when there is no smaller number that contains the same digits. Also return -1 when the next smaller number with the same digits would require the leading digit to be zero.
# next_smaller(9) == -1
# next_smaller(135) == -1
# next_smaller(1027) == -1  # 0721 is out since we don't write numbers with leading zeros
# some tests will include very large numbers.
# test data only employs positive integers.
from itertools import permutations

def next_smaller(n):
    str_n=str(n)
    L_comb=list(permutations(str_n,len(str_n)))
    L=[]
    mini=0
    for i in L_comb : 
        if i[0]=='0': 
            pass
        else : 
            L.append(int(''.join(i)))
    for i in L : 
        if i != n and i < n and i > mini : 
            mini=i
    if mini==0: 
        return -1
    else : 
        return mini

####Test 2 
import itertools as it
def next_smaller(n):
    str_n=str(n)
    L_comb=[int("".join(i)) for i in it.permutations(str_n,len(str_n)) if int("".join(i)) < n and i[0]!='0']
    mini=0
    print(L_comb)
    for i in L_comb : 
        if i != n and i < n and i > mini : 
            mini=i
    if mini==0: 
        return -1
    else : 
        return mini
