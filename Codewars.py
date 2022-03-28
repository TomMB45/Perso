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


###############################
############ 5 kyu ############
###############################
# What is an anagram? Well, two words are anagrams of each other if they both contain the same letters. For example:
# 'abba' & 'baab' == true
# 'abba' & 'bbaa' == true
# 'abba' & 'abbba' == false
# 'abba' & 'abca' == false
# Write a function that will find all the anagrams of a word from a list. You will be given two inputs a word and an array with words. You should return an array of all the anagrams or an empty array if there are none. For example:
# anagrams('abba', ['aabb', 'abcd', 'bbaa', 'dada']) => ['aabb', 'bbaa']
# anagrams('racer', ['crazer', 'carer', 'racar', 'caers', 'racer']) => ['carer', 'racer']
# anagrams('laser', ['lazing', 'lazy',  'lacer']) => []
def anagrams(word, words):
    res=[]
    for i in words : 
        verif=0
        for j in word : 
            if word.count(j) == i.count(j): 
                verif+=1
        if verif==len(i) : 
            res.append(i)
    return res

# Complete the function/method so that it takes a PascalCase string and returns the string in snake_case notation. Lowercase characters can be numbers. If the method gets a number as input, it should return a string.
# Examples
# "TestController"  -->  "test_controller"
# "MoviesAndBooks"  -->  "movies_and_books"
# "App7Test"        -->  "app7_test"
# 1                 -->  "1"
import re
def to_underscore(string):    
    return "_".join([i.lower() for i in re.findall('[A-Z|0-9][a-z|0-9]*', str(string))] )  

# Move the first letter of each word to the end of it, then add "ay" to the end of the word. Leave punctuation marks untouched.
# Examples
# pig_it('Pig latin is cool') # igPay atinlay siay oolcay
# pig_it('Hello world !')     # elloHay orldway !
def pig_it(text):
    return " ".join([i[1:] + i[0] + 'ay' if i.isalpha()!=False else i for i in text.split()  ] )



###############################
############ 6 kyu ############
###############################
# The number 89 is the first integer with more than one digit that fulfills the property partially introduced in the title of this kata. What's the use of saying "Eureka"? Because this sum gives the same number.
# In effect: 89 = 8^1 + 9^2
# The next number in having this property is 135.
# See this property again: 135 = 1^1 + 3^2 + 5^3
# We need a function to collect these numbers, that may receive two integers a, b that defines the range [a, b] (inclusive) and outputs a list of the sorted numbers in the range that fulfills the property described above.
# Let's see some cases:
# sum_dig_pow(1, 10) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
# sum_dig_pow(1, 100) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 89]
# If there are no numbers of this kind in the range [a, b] the function should output an empty list.
# sum_dig_pow(90, 100) == []
def sum_dig_pow(a, b): # range(a, b + 1) will be studied by the function
    lst = []
    for i in range(a,b+1): 
        cdc = list(str(i))
        res=0
        for j in range(len(cdc)) : 
            res += int(cdc[j])**(j+1)
        if i == res : 
            lst.append(i)
    return lst

# Write a function that takes an integer as input, and returns the number of bits that are equal to one in the binary representation of that number. You can guarantee that input is non-negative.
# Example: The binary representation of 1234 is 10011010010, so the function should return 5 in this case
def count_bits(n):
    return (bin(n)).count("1")

# Write a function that takes an array of numbers (integers for the tests) and a target number. It should find two different items in the array that, when added together, give the target value. The indices of these items should then be returned in a tuple / list (depending on your language) like so: (index1, index2).
# For the purposes of this kata, some tests may have multiple answers; any valid solutions will be accepted.
# The input will always be valid (numbers will be an array of length 2 or greater, and all of the items will be numbers; target will always be the sum of two different items from that array).
def two_sum(numbers, target):
    #Time Out : return [[i,j] for i in range(len(numbers)) for j in range(i+1,len(numbers)) if numbers[i]+numbers[j]==target][0]
    for i in range(len(numbers)): 
        for j in range(i+1,len(numbers)): 
            if numbers[i]+numbers[j] == target : 
                return [i,j]

# Complete the solution so that the function will break up camel casing, using a space between words.
# Example
# "camelCasing"  =>  "camel Casing"
# "identifier"   =>  "identifier"
# ""             =>  ""
def solution(s):
    return "".join([l if l.isupper()==False else " {}".format(l) for l in s])

# In this task, you need to restore a string from a list of its copies.
# You will receive an array of strings. All of them are supposed to be the same as the original but, unfortunately, they were corrupted which means some of the characters were replaced with asterisks ("*").
# You have to restore the original string based on non-corrupted information you have. If in some cases it is not possible to determine what the original character was, use "#" character as a special marker for that.
# If the array is empty, then return an empty string.
# Examples:
# input = [
#   "a*cde",
#   "*bcde",
#   "abc*e"
# ]
# result = "abcde"

# input = [
#   "a*c**",
#   "**cd*",
#   "a*cd*"
# ]
# result = "a#cd#"

def assemble(arr):
    if len(arr) == 0 : 
        return ''
    L_final = list(arr[0])
    for mot in arr : 
        for idx_lettre in range(len(mot)) : 
            if mot[idx_lettre] != "*" : 
                L_final[idx_lettre] = mot[idx_lettre] 
            if mot[idx_lettre] != "*" and L_final[idx_lettre] == "*" :
                L_final[idx_lettre] = mot[idx_lettre] 
    for lettre in range(len(L_final)) :
        if L_final[lettre] == "*" : 
            L_final[lettre] = "#"
    return "".join(L_final) 

