### Ex 1 : 
   ##1 
def tri_inser_nn_recu(L): 
    L_trie=[L[0]]
    for idx in range(1,len(L)):
        key=L[idx]
        i=0
        while i < len(L_trie) and key>=L_trie[i] : 
            i+=1
        L_trie.insert(i,key)
        
    return L_trie

def tri_inser_vrai_nn_recu(L): 
    for j in range(1,len(L)):
        key=L[j]
        i = j-1
        while i >= 0 and L[i]>key :
            L[i+1]= L[i]
            i-=1
        L[i+1]= key
    return L

#print(tri_inser_nn_recu([1,3,7,8,10,2,11,3]))
print(tri_inser_vrai_nn_recu([1,3,7,8,10,2,11,3]))

    ##2 insertion récursive
def inserer(L,element): 
    if L==[] : 
        L=[element]
    elif element<L[0] :
        L = [element] + L
    else : 
        #print(L)
        L = [L[0]]+inserer(L[1:],element) #suppression du premier element a chaque fois
    return L

#print(inserer([2,3,4,5,6,7,8], 9))


    ## 3
def tri_insert_recu(Lnn,Ltri):
    
    if Lnn==[]:
        return Ltri
    

    else : 
        return(tri_insert_recu(Lnn[1:],inserer(Ltri,Lnn[0])))

print(tri_insert_recu([1,3,7,8,10,2,11,3],[]))



##5 compléexité égale 

#Ex 2 : 
    ##1 
def fusionner(L1,L2):
    L_merge=[]
    while L1 != [] and L2!=[]: 
        key = min(L1[0],L2[0])
        
        if key in L1 : 
            mini=L1.pop(0)
            L_merge+=[mini]
    
        else : 
            mini=L2.pop(0)
            L_merge+=[mini]
            
    return L_merge+L1+L2

print(fusionner([1,2,3,5,6.3],[1.2,2.5,6]))

def fusionner_rec(L1,L2): 
    if L1 == [] :
        return L2
    elif L2 == []:
        return L1 
    else : 
        if L1[0]<=L2[0]:
            return ([L1[0]]+fusionner_rec(L1[1:],L2))
        else : 
            return ([L2[0]]+fusionner_rec(L1,L2[1:]))
print(fusionner_rec([1,2,3,5,6.3],[1.2,2.5,6]))


def triFusion(L:list): 
    #if len(L)==1 : 
        #return fusion_rec(L1,L2)
    else : 
        L1,L2 = L[:int(len(L)/2)], L[int(len(L)/2):]
        triFusion(L1)
        triFusion(L2)
        return L1,L2



        
            


        