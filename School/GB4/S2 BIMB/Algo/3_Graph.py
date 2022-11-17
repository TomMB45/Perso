#%% Exo 1
from math import inf 
def parcours_en_largeur(dico_adj,s_init) : 
    ## INITIALISATION
    ## Noir : 2 ; Gris : 1 ; Blanc : 0 
    couleur, d,pere={},{},{}
    for node in dico_adj.keys() : 
        couleur[node] = "Blanc"
        d[node] = inf
        pere[node] = [] 
    couleur[s_init] = "Gris" 
    d[s_init] = 0
    pere[s_init] = []
    
    File_attente=[s_init]

    while File_attente != [] :
        node = File_attente[0]
        for adj in dico_adj[node] : 
            if couleur[adj] == "Blanc" : 
                couleur[adj] = "Gris" 
                d[adj] = d[node]+1 
                pere[node].append(adj)
                File_attente += [adj] 
        File_attente = File_attente[1:]
        couleur[node] = "Noir"
    return pere ,d, couleur
        
Liste_adj = {"a":["a","b","c"] , "b" : ["b","c"], "c": ["a"]}
p,d,c = parcours_en_largeur(Liste_adj, "a")
print("Pere", p,"\nDistance",d,"\nCouleur",c)


#%% Exo 2 
#1
def PP(node,couleur,t,pere,init,fin,dico_adj,L_topo) : 
    couleur[node] = "Gris"
    t += 1
    init[node] = t
    for adj in dico_adj[node] : 
        if couleur[adj] == "Blanc" : 
            pere[adj] = node
            couleur,t,pere,init,fin,L_topo = PP(adj,couleur,t,pere,init,fin,dico_adj,L_topo)
    couleur[node] = "Noir"
    L_topo=[node]+L_topo
    t+=1
    fin[node] = t
    return couleur,t,pere,init,fin,L_topo

#2

def ParcourProf(dico_adj):
    couleur,pere,init,fin={},{},{},{}
    L_topo=[]
    for node in dico_adj.keys():
        couleur[node] = "Blanc"
        pere[node] = 0
        init[node]=inf
        fin[node]=inf
    t=0
    
    for node in dico_adj.keys():
        if couleur[node]=="Blanc":
            couleur,t,pere,init,fin,L_topo = PP(node,couleur,t,pere,init,fin,dico_adj,L_topo)
    return couleur, pere,fin,L_topo   

#3
dico = {"u":["v","x"],"v":["y"],"y" : ["x"], "x":["v"],"w":["y","z"],"z":["z"]}
c,p,f,L = ParcourProf(dico)
# print("Couleur", c,"\nPere",p,"\nfin traitement",f,"\nListe topo",L)

#4
def tri_topo(dico_adj): 
    return ParcourProf(dico_adj)[3]

dic={1:[2,3],2:[3,4],3:[5],4:[5],5:[]}
print(tri_topo(dic))

#%% Exo 3
#1
        