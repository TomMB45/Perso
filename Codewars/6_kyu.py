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

