#%%
import Bio
from Bio import SeqIO
from Bio.SeqIO import PdbIO
import Bio.PDB as b 
import Bio.PDB.PDBList as p
import Bio.PDB.Chain as ch
import os 
import plotly
import plotly.graph_objects as go
import urllib


#%%
os.chdir('C:/Users/Tom/Documents/Cours/Polytech/4A/4A/S1/Progra_Script/Projet')

#%% 
hydrophobicity_3L={"Ala":  0.310, "Arg": -1.010 ,"Asn": -0.600,"Asp": -0.770,
                   "Cys":  1.540,  "Gln": -0.220, "Glu": -0.640, "Gly":  0.000,
                   "His":  0.130,  "Ile":  1.800, 'Leu':  1.700, "Lys": -0.990,
                   "Met":  1.23, "Phe":  1.790,  "Pro":  0.720,  "Ser": -0.040,
                   "Thr":  0.260,  "Trp":  2.250,  "Tyr":  0.960,  "Val":  1.220}
hydrophobicity_1L={"A":  0.310, "R": -1.010 ,"N": -0.600,"D": -0.770,
                   "C":  1.540, "Q": -0.220, "E": -0.640, "G":  0.000, 
                   "H":  0.130, "I":  1.800, 'L':  1.700, "K": -0.990, 
                   "M":  1.23, "F":  1.790,  "P":  0.720, "S": -0.040,
                   "T":  0.260, "W":  2.250,  "Y":  0.960, "V":  1.220}
#%%
#Ici on réleccharge le fichier pdb sur internet

def recherche_pdb(code):
    u=urllib.request.urlopen("http://files.rcsb.org/view/"+code.upper()+".pdb")
    pdblines=u.readlines()
    u.close()
    cdc=''
    for ligne in pdblines:
        cdc+=ligne.decode("utf8")
    return cdc
        
def write_file(cdc):
    """
    """
    f = open("transitory_file.pdb","w")
    f.write(str(cdc))
    f.close()
    
def file_del(): 
    """
    """
    os.remove("transitory_file.pdb")
    print("done")
    
cdc=recherche_pdb("1CRN")
write_file(cdc)



#%%
def load_PDB(fichier):
    L=[]
    f = open(fichier)
    cdc=f.readline()
    while cdc!="": 
        L.append(cdc)
        cdc=f.readline()
    return L


#%%
def info(data, request):
    Info=[]
    request=request.upper()
    for i in data :
        if request in  i:
            Info.append(i)
    return Info
### si mauvaise request
### info => description, longueur de la protéine, etc…), la méthode expérimentale utilisée avec la résolution éventuellement associée

#%%
def nettoyage(liste) : 
    """Fontion qui prend en argument une liste de chaine de caractère et qui renvoie une chaine de caractère concaténé sans les \n ainsi que les espaces(si espaces crée plusieurs lignes)"""
    data_net=[]
    if len(liste) == 0 :
        return False
    else : 
        for cdc in liste :
            cdc.strip()             #supprime tout les \n 
            cdc.split()             #supprime les espaces
            cdc.upper()
            if cdc[-1]=="\n":
                data_net.append(cdc[:-1])
            else:
                data_net.append(cdc)
        return data_net 

#%%
def atome(data): 
    liste_atome=[]
    for ligne in data :
        if ligne[:4]=="ATOM": 
            liste_atome.append(ligne)
    return liste_atome

#%%
def carbone_alpha(data): 
    liste_Ca=[]
    for ligne in data : 
        if "CA" in ligne and "ATOM   " in ligne : 
            liste_Ca.append(ligne)
    return liste_Ca

#%%
def nombre_Aa(data):
    resultat=data[-1].split()
    return resultat[3]

#%%
def code3L(data):
    numero=0
    index=0
    code3L=""
    for index in range(len(data)):
        data[index]=data[index].split()
        #if 
        #print("step",type(data[index][1]))
    for ligne in data: 
        if numero!=ligne[4]: 
            numero=ligne[4]
            code3L+=ligne[3] + "-"
    return code3L[:-1]


#%%

#%%
def get_Aa(target): #https://bioinformatics.stackexchange.com/questions/14101/extract-residue-sequence-from-pdb-file-in-biopython-but-open-to-recommendation
    for record in SeqIO.parse(target, "pdb-atom"):
        return(record.seq)
    
def get_Aa_from_scraper(data):
    stru=b.PDBParser(data)
    return stru.get_structure('1CRN','1CRN.pbd')
    
#%%
data=recherche_pdb('1CRN')
# print(data)
# print(get_Aa_from_scraper(data))


#scrap 
#create file txt
#use file in get_AA
#delete file 
print(get_Aa("1CRN - Copie.txt"))


    
#%%
def code3L_To_code1L(code): 
    code_1L=""
    liste=code.split("-")
    for lettre in liste : 
        code_1L+=b.Polypeptide.three_to_one(lettre)
    return code_1L

#%%
def hydrophobicity_calc(AA_chain,window=7): 
    """ Function to calculate the hybrophobicity of a protein 
    Input: AA chain 
    Return : 
    Exemple : 
        >>>
    """ 
    hydro=[]
    for i in range(len(AA_chain)):
        if i>len(AA_chain)-window : 
            hydro_Aa=0
            for w in range(i,len(AA_chain)):
                hydro_Aa+=hydrophobicity_1L[AA_chain[w]]
            hydro.append((1/(window-w))*hydro_Aa)
        else : 
            hydro_Aa=0
            for w in range(i,i+window):
                hydro_Aa+=hydrophobicity_1L[AA_chain[w]]
            hydro.append((1/window)*hydro_Aa)
    return hydro

def viz(AA_chain):
    x=list(range(len(AA_chain)))
    y=hydrophobicity_calc(AA_chain)
    fig=go.Figure()
    fig.add_trace(go.Scatter(y = y,
                             x = x,
                             name = "Hydrophobicity",
                             line_shape='spline'))
    fig.update_layout(title="Hydrophobicity, windows = 7 ",
                  xaxis_title="Number of Amino Acid",
                  yaxis_title="Hydrophobicity")
    fig.show()
            
print(hydrophobicity_calc("TTCCPSIVARSNFNVCRLPGTPEAICATYTGCIIIPGATCPGDYAN"))

#%%
# data=load_PDB("1CRN.pdb")
# #print(data)
# information=info(data,"header")
# data_net=nettoyage(data)
# atom=atome(data)
# code_3L=code3L(atom)
# # print(code_3L)
# code_1L=code3L_To_code1L(code_3L)
from Bio.PDB.parse_pdb_header import parse_pdb_header
def exp_meth(file):
    head=parse_pdb_header(file)
    meth=head['structure_method']
    res=head['resolution']
    return meth, res

print(exp_meth("1CRN.pdb"))

#%%
data=load_PDB("1CRN.pdb")
Aa=get_Aa("1CRN.pdb")

data=nettoyage(data)
#print(data)
atom=atome(data)
C_a = carbone_alpha(atom)
nb=nombre_Aa(atom)
#print(nb)
code_3L=code3L(atom)
code_1L=code3L_To_code1L(code_3L)
#print(code_1L)
