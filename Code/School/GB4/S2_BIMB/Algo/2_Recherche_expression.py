from time import time 
from random import choice 
import matplotlib.pyplot as plt 

#Ex1 : 
    #1
alphabet = ['A','T','C','G']
base = len(alphabet)
codage = {'A':0,'T':1,'C':2,'G':3}

    #2
def Rabin_Karp(Texte,Pattern,base,q):
    n = len(Texte)
    m = len(Pattern)
    h = base**(m-1)% q
    p = 0 
    ts = 0 
    nb_passage_rapide=0
    nb_passage_lent=0
    for i in range(m) : 
        p = (base*p+codage[Pattern[i]])%q
        ts = (base*ts+codage[Pattern[i]])%q
    if p == ts : 
        #if lettre_a_lettre(Pattern,Texte[:m]):
        nb_passage_rapide+=1
        if Pattern[:] == Texte[:m] :
            nb_passage_lent+=1
            #print("Pattern présent à la position 0")
            #return 0,nb_passage

    for s in range(1,n-(m)): 
        ts = (base * (ts - codage[Texte[s-1]]*h ) + codage[Texte[s-1+m]]) %q
        if p == ts : 
            #if lettre_a_lettre(Pattern,Texte[s:s+m]):
            nb_passage_rapide+=1
            if Pattern[:] == Texte[s:s+m] : 
                nb_passage_lent+=1
                #print("Pattern présent à la position {}".format(s))
                #return s,nb_passage
    return nb_passage_rapide,nb_passage_lent


#print(Rabin_Karp("ATGGGGATGCCCGGATGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGATGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCTTTTTCCCCCCCCCCCCCCCCC","ATG",base,10))

def test_Brute_force(T,P): 
    n= len(T)
    m = len(P)
    for s in range(n-m) : 
        if P[:] == T[s:s+m]:
        #if lettre_a_lettre(P,T[s:s+m]):
            #print("Le motif est présent à la position {}".format(s))
            return s
#print(test_Brute_force("ATGGGGATGCCCGGATGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGATGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCTTTTTCCCCCCCCCCCCCCCCC","ATG"))

#%%
#########################
###### Tests perso ######
#########################

def lettre_a_lettre(P,cdc):
    for i in range(len(P)) : 
        if cdc[i]!=P[i]:
            return False
        else : 
            return True
#print(lettre_a_lettre('AGG','ATG'))


def liste_cara(n:int): 
    cdc = ""
    for i in range(n): 
        cdc+=choice(alphabet)
    return cdc 

def comparaison(): 
    x=[]
    BF=[]
    RK=[]
    for i in range(10,300000,5000): 
        x.append(i)
        start=time()
        test_Brute_force(liste_cara(i),liste_cara(i//10))
        finish=time()
        BF.append(finish-start)

        start=time()
        Rabin_Karp(liste_cara(i),liste_cara(i//10),base,10000000000000)
        finish=time()
        RK.append(finish-start)
    return x,BF,RK

def graph(): 
    x,BF,RK=comparaison()
    plt.plot(x,BF,label="Force Brute")
    
    plt.plot(x,RK,label="Rabin_Karp")
    
    plt.legend()
    #plt.savefig('Comparaison.png')
    plt.show()
#print(graph())

#######################
###### Fin tests ######
#######################

#%%
L_recherche = liste_cara(5000000)
L_expression = liste_cara(10)

#%%
    #3
def importance_q(): 
    Q = []
    RAPIDE = []
    LENT = []
    #t = []
    
    mini = 1
    maxi = 51
    pas = 1
    for q in range(mini,maxi,pas): 
        Q.append(q)
        #start=time()
        nb_rapide,nb_lent=Rabin_Karp(L_recherche,L_expression,4,q)
        #a,nb=Rabin_Karp(liste_cara(5000),liste_cara(2),4,i)
        #a,nb=Rabin_Karp(liste_cara(5000),"ATC",4,i)
        #end=time()
        RAPIDE.append(nb_rapide)
        LENT.append(nb_lent)
        #t.append(end-start)
        #print("il reste {:.0f} tests".format((maxi-q)/pas))

    plt.plot(Q,RAPIDE,label="Nombre de passage dans la comparaison rapide")
    plt.plot(Q,LENT,label="Nombre de passage dans la comparaison lente\n(lettre à lettre)")
    #plt.plot(Q,t,label="Temps d'execution")
    plt.legend()
    #plt.savefig('Temps_fct_q_1_25.png')
    #plt.savefig('Importance_q_1_101.png')
    plt.show()

print(importance_q())

#%% 
#Ex2: 
    #1
    #Voir Word
    #2
delta = {
    0 : {'A':1,"T":0,"C":0,"G":0},
    1 : {'A':2,"T":0,"C":0,"G":0},
    2 : {"A":3,"T":0,"C":0,"G":0},
    3 : {"A":3,"T":4,"C":0,"G":0}, 
    4 : {"A":1,"T":0,"C":0,"G":0}, 
    }
    
    #3 
def automate (T,delta,m) :
    n = len(T)
    q = 0 
    resultat=[]
    for i in range (n) : 
        q = delta[q][T[i]]
        if q == len(m) :
            print("le motif apparait avec le décallage {}".format(i-len(m)+1))
            resultat.append( i )
    return resultat 

    #4
#print(automate("GAAATTTTCGGGATAAT",delta,"AAAT"))

    #5
def suffixe(suffixe,mot) :
    return suffixe == mot[len(mot)-len(suffixe):]

    #6
def Creation_automate(Pattern, Sigma) : 
    p = len(Pattern)
    d={}
    for q in range(p+1):
        d[q] = {}
        for a in Sigma :
            k = min(p,q+1)
            while not suffixe(Pattern[:k],Pattern[:q]+a) :
                k-=1 
            d[q][a] = k 
    return d

#print(Creation_automate("AAAT", ["A","T","C","G"]))

    #7
def Nb_occurence(Pattern,texte) : 
    return len(automate(texte, Creation_automate(Pattern,list(set(texte))), Pattern))
print(Nb_occurence("ATGGGGATTTT", "ATGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGATGGGGATTTTAGG"))

#%%
#Ex 3 : 
    #1 
def calculFonctionPrefixe(Pattern):
    pi = {1:0}
    #pi=[0]
    k = 0 
    for i in range(1,len(Pattern) ) :
        while (k>0) and Pattern[k] != Pattern[i] : 
            k = pi[k-1]
        if Pattern[k] == Pattern[i] : 
            k+=1
        pi[i+1] = k 
    return pi 

#print(calculFonctionPrefixe("SNNS"))
#print(calculFonctionPrefixe("azerty").values()  ) 

    #2
def KMP(Texte, Pattern) : 
    PI = calculFonctionPrefixe(Pattern)
    q,resultat = 0,0
    for i in range(len(Texte)) : 
        while q>0 and Pattern[q]!=Texte[i]:
            q = PI[q]
        if Pattern[q]==Texte[i] : 
            q += 1 
        if q == len(Pattern) : 
            #print("hit en position {}".format(i-m+1))
            resultat += 1 
            q = PI[q]
    return resultat
print(KMP("ATGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGATGGGGATTTTAGG","ATGGGGATTTT") )#== Nb_occurence("ATGGGGATTTT", "ATGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGATGGGGATTTTAGG"))
            