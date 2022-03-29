#%% Import des fonctions 
from tkinter import Button,Tk,filedialog,Entry,Label
#Biopython
import Bio
from Bio import PDB
from Bio import SeqIO
from Bio.PDB import PDBParser
from Bio.PDB import Atom

#Graphes
import plotly
import plotly.graph_objects as go
import plotly.express as px
import plotly.io as pio


#scrapping
import urllib

#Matrice
import numpy as np

#os
import os

#dataframe
import pandas as pd
#distance euclidienne
from scipy.spatial import distance
pio.renderers.default='browser'

#%% Import des variables 
global chemin 
#chemin="C:/Users/Tom/Documents/Cours/Polytech/4A/4A/S1/Progra_Script/Projet/Output"
chemin=os.getcwd()
os.chdir(chemin)
global F
F=[]


hydrophobicity_3L={"Ala":  0.310, "Arg": -1.010 ,"Asn": -0.600,"Asp": -0.770,
                   "Cys":  1.540,  "Gln": -0.220, "Glu": -0.640, "Gly":  0.000,
                   "His":  0.130,  "Ile":  1.800, 'Leu':  1.700, "Lys": -0.990,
                   "Met":  1.23, "Phe":  1.790,  "Pro":  0.720,  "Ser": -0.040,
                   "Thr":  0.260,  "Trp":  2.250,  "Tyr":  0.960,  
                   "Val":  1.220}
hydrophobicity_1L_Fauchere={"A":  0.310, "R": -1.010 ,"N": -0.600,"D": -0.770,
                   "C":  1.540, "Q": -0.220, "E": -0.640, "G":  0.000, 
                   "H":  0.130, "I":  1.800, 'L':  1.700, "K": -0.990, 
                   "M":  1.23, "F":  1.790,  "P":  0.720, "S": -0.040,
                   "T":  0.260, "W":  2.250,  "Y":  0.960, "V":  1.220,
                   "X":0}

hydrophobicity_1L_Kyte={"A": 1.800, "R": -4.500, "N": -3.500, "D": -3.500,  
                        "C": 2.500, "Q": -3.500, "E": -3.500, "G": -0.400,  
                        "H": -3.200, "I": 4.500, "L": 3.800, "K": -3.900,
                        "M": 1.900, "F":  2.800, "P": -1.600, "S": -0.800,  
                        "T": -0.700,  "W": -0.900, "Y": -1.300,  "V":  4.200,
                        "X":0}

dic_Aa_rate={"A": 8.25, "Q":3.93, "L" :9.65, "S": 6.64 , "R": 5.53, "E": 6.72, 
             "K": 5.80, "T": 5.35, "N": 4.06, "G": 7.07, "M": 2.41, "W": 1.10,
             "D": 5.46, "H": 2.27, "F": 3.86, "Y": 2.92, "C": 1.38, "I": 5.91,
             "P": 4.73, "V": 6.86}

regroup={"ALA": "Apo", "GLN":"Pol_non_charge", "LEU" :"Apo", 
         "SER": "Pol_non_charge", "ARG": "Pol_pls", "GLU": "Pol_neg", "LYS": "Pol_pls",
         "THR": "Pol_non_charge", "ASN": "Pol_non_charge", "GLY": "Apo", 
         "MET": "Apo", "TRP": "Pol_non_charge", "ASP": "Pol_neg", "HIS": "Pol_pls",
         "PHE": "Apo", "TYR": "Pol_non_charge", "CYS": "Apo", "ILE": "Apo", 
         "PRO": "Apo", "VAL": "Apo"}
B_fact={"Apo": 0.00, "Pol_neg": 500, "Pol_non_charge": 750, "Pol_pls": 999 }
Aa_3L=str(regroup.keys())

#%% Fonctions 
def parcourir() : 
    """Function to search the PBD file on directory"""
    Fichier = filedialog.askopenfilename(initialdir = chemin,
                                         title = "Choix du fichier")
    F.append(Fichier)
    return F

def pdb_search(code):
    """Function to search the PBD file on internet and read all the lines"""
    u=urllib.request.urlopen("http://files.rcsb.org/view/"+code.upper()+".pdb")
    #recherche sur internet du fichier spécifié 
    pdblines=u.readlines()#lecture de toutes les lignes 
    u.close()
    cdc=''
    for ligne in pdblines:
        cdc+=ligne.decode("utf8")#recodage 
    return cdc
 
def write_file(cdc:str):
    """ Write a transitory PDB file"""
    fpdb = open("transitory_file.pdb","w")
    fpdb.write(str(cdc))
    fpdb.close()
    
def file_del(): 
    """ Suppressing the transitory file """
    os.remove("transitory_file.pdb")
    print("Supressing done")
    
def get_Aa(target:str): #https://bioinformatics.stackexchange.com/questions/14101/extract-residue-sequence-from-pdb-file-in-biopython-but-open-to-recommendation
    """Function allowing to recover the Aa of the sequence
    Input : path of pdb file
    Output : Aa sequence
    
    >> get_Aa(C:/Users/.../1CRN.pdb")
        TTCCPSIVARSNFNVCRLPGTPEAICATYTGCIIIPGATCPGDYAN
        
    """
    for record in SeqIO.parse(target, "pdb-atom"):
        return(record.seq)

def Aa_rate(seq:str):
    """
    

    Parameters
    ----------
    seq : str
        Sequence of Amino Acid.

    Returns
    -------
    rate : dict
        Rate of Aa in the protein compared to mean rate.
        
    Example
    -------
    >> Aa_rate("TTCCPSIVARSNFNVCRLPGTPEAICATYTGCIIIPGATCPGDYAN")
        {'A': 10.869565217391305, 'Q': 0.0,...,'V': 4.3478260869565215}

    """
    rate={}
    Aa=dic_Aa_rate.keys()
    for i in Aa:
        #print(seq.count(i))
        rate[i] = (seq.count(i)/len(seq)*100)
    return rate

def viz_rate(seq:str):
    """
    Procedure to create the graph of the Aa rate 

    Parameters
    ----------
    seq : str
        Sequence of Amino Acid.

    Returns
    -------
    Graph object
        Barplot of the rate of Aa in the protein compared to mean rate.
 

    """
    dic_rate=Aa_rate(seq) #on appelle la fonction précédente 
    data_items = dic_Aa_rate.items()#récupère tous les clées et les valeurs du dico 
    data_list = list(data_items)#On liste les items 
    df=pd.DataFrame(data_list,columns=['AA','Expacy mean rate'])#transformation en dataframe
    df.insert(1,"AA Protein",dic_rate.values())#insertion des rate des AA de la protéine recherché
    fig = go.Figure(data=[
                        go.Bar(name='Research protein Aa rate',x=df['AA'],y=df["AA Protein"]),#création des barres
                        go.Bar(name='Mean rate',x=df["AA"],y=df["Expacy mean rate"])
                        ])
  # Change the bar mode
    fig.update_layout(barmode='group',
                    height=800,
                    width=800,
                    xaxis_title='Amino Acid',
                    yaxis_title='rate',
                    title="Aa rate comparaison")#on 

    fig.show()

def exp_meth_resol(file:str):
    """
    Function to recovered the experimental determination method and the resolution of protein

    Parameters
    ----------
    file : str
        Path of the file.

    Returns
    -------
    meth : str
        Method used to determined the structure.
    res : float
        Resolution of the structure in Ä.
    
    Example
    -------
    >> exp_meth_resol(C:/Users/.../1CRN.pdb")
        ('x-ray diffraction', 1.5)

    """
    
    head=Bio.PDB.parse_pdb_header(file)
    meth=head['structure_method']
    res=head['resolution']
    return meth, res

def hydrophobicity_calc(AA_chain:str,window:int=9,scale:str="Fau"): 
    """
    Function to calculate the hybrophobicity of a protein 

    Parameters
    ----------
    AA_chain : str
        Sequence of Aa.
    window : int, optional
        The length of the sliding window. The default is 9.
    scale : str, optional
        Hydrophobicity scale 
            Fau = Fauchere
            Kyt = Kyte. The default is "Fau".

    Returns
    -------
    hydro : list
        list of hydrophbicity calculate.
    
    Example
    -------
    >>> hydrophobicity_calc("TACTGW")
        [2.31, 2.18, 2.025, 1.255, 1.125, 1.125]

    """
    hydro=[]
    for i in range(len(AA_chain)):
        if i>len(AA_chain)-window : #si il reste moins de caractère que la taille de la fenètre => eviter out of range
            #hydro_Aa=0#on reset hydro à 0 
            #for win in range(i,len(AA_chain)): #on parcourt les index de i a la fin de la liste
                #hydro_Aa+=hydrophobicity_1L[AA_chain[win]]#ajout a hydro des valeur d'hydrophobicité des Aa dans la fenètre
            #hydro.append((1/(window-win))*hydro_Aa)#calcul moyenne
            #print(len(AA_chain)-i)
            break
        else : #idem mais avec fenetre =7 
            hydro_Aa=0
            for win in range(i,i+window):
                if scale=="Fau": 
                  hydro_Aa+=hydrophobicity_1L_Fauchere[AA_chain[win]]
                elif scale == "Kyt": 
                  hydro_Aa+=hydrophobicity_1L_Kyte[AA_chain[win]]

            hydro.append((1/(window))*hydro_Aa)
            #print(window)
    return hydro

def viz_hydro(AA_chain:str,window:int=9,hydro_scale:str="Fau"):
    """
    Procedure to create a graph object of the hydrophobicity

    Parameters
    ----------
    AA_chain : str
        Sequence of Aa.
    window : int, optional
        The length of the sliding window. The default is 9.
    scale : str, optional
        Hydrophobicity scale 
            Fau = Fauchere
            Kyt = Kyte. The default is "Fau".

    Returns
    -------
    Graph object of hydrophobicity.

    """
    print(hydro_scale)
    x=list(range(len(AA_chain)))#nombre acides aminées sous forme liste
    y=hydrophobicity_calc(AA_chain,window,hydro_scale)#liste des valeurs d'hydrophbicité avec une fenètre de 7 par défaut
    fig=go.Figure()#création graph object de type figure
    fig.add_trace(go.Scatter(y = y,
                             x = x,
                             name = "Hydrophobicity",
                             line_shape='spline'))
    fig.update_layout(title="Hydrophobicity with {} scale, windows = {} ".format(hydro_scale,window),
                  xaxis_title="Number of Amino Acid",
                  yaxis_title="Hydrophobicity")
    fig.show()
    
def output_file(target:str,file:str,Sequence_Aa:str): 
  """
    Create an output file with all the informations

    Parameters
    ----------
    target : str
        Name of the protein.
    file : str
        Path.
    Sequence_Aa : str
        Aa sequence.

    Returns
    -------
    None.

    """
  #Variables : 
  met,resol=exp_meth_resol(file)
  Seq=""
  bond=disulfide_bridge(file)
  
  for i in range(0,len(Sequence_Aa),80):
    Seq+=Sequence_Aa[i:i+80]+"\n"
  
  #Write in a txt file
  f = open("{}_output_file.txt".format(target),"w")
  f.write("Amino acid sequence: \n"+str(Seq)+"\n\n")
  f.write("Experimental method to determine the structure: {}\nResolution: {} Ä\n".format(met,resol))
  f.write("disulfide bound determination\n")
  if len(bond)==0: 
    f.write("Any disulfide bridge\n")
  else:
    for tripl in bond :
      f.write("bond between CYS {} and CYS {}, distance : {:.2f}\n".format(tripl[0],tripl[1],tripl[2])) 
  f.close()
  
def output_fasta(file:str,Sequence_Aa:str): 
    """
    Create a file with the Fasta sequence

    Parameters
    ----------
    file : str
        Path.
    Sequence_Aa : str
        Aa sequence.

    Returns
    -------
    None.

    """
    head=Bio.PDB.parse_pdb_header(file)
    name=head["idcode"]
    mol=head["compound"]["1"]["molecule"]
    orga=head["source"]["1"]["organism_scientific"]
    taxid=head["source"]["1"]["organism_taxid"]

    Seq=""
    for i in range(0,len(Sequence_Aa),80):
        Seq+=Sequence_Aa[i:i+80]+"\n"


    with open(name+"_FASTA.txt","w") as fasta:
        fasta.write(">{}|{}|{}|{}\n{}".format(name,mol,orga,taxid,str(Seq)))
        fasta.close()

def disulfide_bridge(file:str):
    """
    Function to have the CYS bond 

    Parameters
    ----------
    file : str
        path.

    Returns
    -------
    bond : list
        list of list with the first CYS, the second CYS, the distance between them.
    
    Example
    -------
    >>> disulfide_bridge("C:/Users/.../1CRN.pdb")
        [[2, 39, 2.0041065216064453], [2, 40, 2.0041065216064453], [2, 41, 2.0041065216064453]...]

    """
    parser=PDB.PDBParser()
    structure=parser.get_structure("search",file)
    res = [r for r in structure.get_residues()]        # You don’t need the extensive list traversal you were doing before because there are many get_*() methods

    bond=[]
    for idx in range(len(res)):
        if "CYS" in str(res[idx]) : 
            for idx_plus in range(idx+1,len(res)):
                if "CYS" in str(res[idx_plus]): 
                    cys1=res[idx]["SG"].get_coord()
                    cys2=res[idx_plus]["SG"].get_coord()
                if distance.euclidean(cys1,cys2) <= 3 : 
                    bond.append([idx,idx_plus,distance.euclidean(cys1,cys2)]) #https://www.delftstack.com/fr/howto/numpy/calculate-euclidean-distance/#utilisez-la-fonction-distance.euclidean-pour-trouver-la-distance-euclidienne-entre-deux-points
    return bond

def set_Bfact(file:str): 
    """
    Procedure to modify the B-factor on a PDB file

    Parameters
    ----------
    file : str
        path.

    Returns
    -------
    None.

    """
    with open(file) as transit : 
        with open("B-fact_modif.pdb","w") as bf : 
            ligne=transit.readline()
        while ligne != "": 
            if "ATOM" not in ligne[:6] : 
                bf.write(ligne)
            else: 
                val=B_fact[regroup[ligne[17:20]]]
                bf.write(ligne[:60]+" "+str(val)+ligne[66:])
            ligne = transit.readline()
        bf.close()
    transit.close()
  
def contact_matrix(file:str):
    """
    Function to calculate the contact matrix of the protein

    Parameters
    ----------
    file : str
        path.

    Returns
    -------
    matrix : numpy matrix 
        contact matrix.
        
    Example
    -------
    >>> contact_matrix("C:/Users/.../1CRN.pdb")
        [[ 0.          3.79388022  6.70386267 ... 11.54701996 12.14432621 11.80957031]
         ...
         [11.80957031  9.13319016  6.14764452 ...  5.7914362   3.80866051 0. ]]

    """
    parser=PDB.PDBParser()
    structure=parser.get_structure("search",file)
    res = [r for r in structure.get_residues()]        # You don’t need the extensive list traversal you were doing before because there are many get_*() methods
    matrix=np.zeros((len(res),len(res)))

    for row in range(len(res)):
        for col in range(len(res)):
            if str(res[col]).split()[1] in Aa_3L and str(res[row]).split()[1] in Aa_3L:
                  res1=res[row]["CA"].get_coord()
                  res2=res[col]["CA"].get_coord()
                  matrix[row,col] = distance.euclidean(res1,res2) #https://www.delftstack.com/fr/howto/numpy/calculate-euclidean-distance/#utilisez-la-fonction-distance.euclidean-pour-trouver-la-distance-euclidienne-entre-deux-points
    return matrix

def heatmap(matrix): 
    """
    Create the Heatmap graph

    Parameters
    ----------
    matrix : numpy matrix
        Contact matrix.

    Returns
    -------
    None.

    """
    fig = go.Figure(data=go.Heatmap(
                    z=matrix))
    fig.update_layout(title="Heatmap of the protein")
    #légende distance Ä
    fig.show()

#%% tk function
def I_have(): 
    global Button_tk_parcourir,Button_tk_continue
    
    for widget in app.winfo_children():
       widget.destroy()
    
    Button_tk_parcourir=Button(app,text="Parcourir",command=parcourir)
    Button_tk_continue=Button(app,text="Continu",command=action_have)
    Button_tk_back=Button(app,text="Go main menu", command=back_home,bg="#DC0202")
    
    Button_tk_parcourir.grid(row=0, column=0)
    Button_tk_continue.grid(row=1, column=0)
    Button_tk_back.grid(row=1,column=1)
    

    
def action_have(): 
    global Button_tk_FASTA,Button_tk_Graph,Button_tk_info,Button_tk_output
    global Button_tk_compo_rate,Button_tk_B_factor,Button_tk_finish,Aa
    Aa=get_Aa(F[-1])
    print(F)
    for widget in app.winfo_children():
       widget.destroy()
    
    Button_tk_Graph = Button(app, text="Show hydrophobicity graph in your browser", command=viz_hydro_tk)
    Button_tk_info = Button(app, text="Download the informations of proteine", command= info_tk_Have)#pt dissulfure en + méthode
    Button_tk_compo_rate = Button(app, text="Show the rate of Aa on proteine in your browser", command= viz_rate_tk)
    Button_tk_Heatmap= Button(app, text="Show the Heatmap of the proteine in your browser", command= viz_heatmap_tk_have)
    Button_tk_FASTA = Button(app, text="Download the FASTA sequence", command=output_Fasta_Have)
    Button_tk_B_factor=Button(app, text="Download the pdb file with modified B-Factor", command= B_factor_tk_Have)
    Button_tk_finish = Button(app, text="Finish", command=app.destroy)
    Button_tk_back=Button(app,text="Go main menu", command=back_home,bg="#DC0202")
    
    Button_tk_Graph.grid(row=0, column=0)
    Button_tk_compo_rate.grid(row=1, column=0)
    Button_tk_Heatmap.grid(row=2, column=0)
    
    Button_tk_FASTA.grid(row=3, column=0)
    Button_tk_info.grid(row=4, column=0)
    Button_tk_B_factor.grid(row=5, column=0)    
    Button_tk_finish.grid(row=6, column=0)
    Button_tk_back.grid(row=6,column=1)

def I_Dont_Have():
    global Phrase, Entree,Valid
    for widget in app.winfo_children():
       widget.destroy()
    
    Phrase=Label(app, text="Enter the PDBID of the protein.\nMake sure to be online")
    Phrase.grid(row=0, column=0)
    Entree = Entry(app)
    Entree.grid(row=1, column=0)
    
    Valid=Button(app, text="Validation of entry", command=Action_Dont_Have)
    Valid.grid(row=2, column=0)
    Button_tk_back=Button(app,text="Go main menu", command=back_home,bg="#DC0202")
    Button_tk_back.grid(row=2,column=1)

    
def Action_Dont_Have():
    global Button_tk_FASTA_Dont_Have,Button_tk_Graph_Dont_Have
    global Button_tk_info_Dont_Have,Button_tk_output_Dont_Have
    global Button_tk_compo_rate_Dont_Have,Button_tk_B_factor_Dont_Have,Aa,target
    global Button_tk_finish_Dont_Have,Button_tk_Heatmap_Dont_Have
    
    target = str(Entree.get())
    cdc=pdb_search(target)
    write_file(cdc)
    
    Aa=get_Aa("transitory_file.pdb")
    
    for widget in app.winfo_children():
       widget.destroy()
    

    Button_tk_compo_rate_Dont_Have = Button(app, text="Show the rate of Aa on proteine in your browser", command= viz_rate_tk)
    Button_tk_Graph_Dont_Have = Button(app, text="Show hydrophobicity graph in your browser", command=viz_hydro_tk)
    Button_tk_Heatmap_Dont_Have=Button(app, text="Show Heatmap on your browser", command= viz_heatmap_tk)
    
    Button_tk_FASTA_Dont_Have = Button(app, text="Download the FASTA sequence", command=output_Fasta)
    Button_tk_info_Dont_Have = Button(app, text="Download the informations of proteine", command= info_tk)#pt dissulfure en + méthode
    Button_tk_B_factor_Dont_Have=Button(app, text="Download the pdb file with modified B-Factor", command=B_factor_tk)
    Button_tk_finish_Dont_Have = Button(app, text="Finish", command=finish_tk)
    Button_tk_back=Button(app,text="Go main menu", command=back_home,bg="#DC0202")    
    
    Button_tk_compo_rate_Dont_Have.grid(row=1, column=0)
    Button_tk_Graph_Dont_Have.grid(row=0, column=0)
    Button_tk_Heatmap_Dont_Have.grid(row=2, column=0) 
    Button_tk_FASTA_Dont_Have.grid(row=3, column=0)
    Button_tk_info_Dont_Have.grid(row=4, column=0)
    Button_tk_B_factor_Dont_Have.grid(row=5, column=0)
    Button_tk_finish_Dont_Have.grid(row=6, column=0)
    Button_tk_back.grid(row=6,column=1)

def viz_hydro_tk(): 
    viz_hydro(Aa)
    #Button_tk_Graph_Dont_Have.destroy()

def viz_rate_tk(): 
    viz_rate(Aa)
    #Button_tk_compo_rate_Dont_Have.destroy()

def viz_heatmap_tk():
    heatmap(contact_matrix("transitory_file.pdb"))
    #Button_tk_Heatmap_Dont_Have.destroy()
    
def viz_heatmap_tk_have():
    heatmap(contact_matrix(F[-1]))

def output_Fasta():
    output_fasta("transitory_file.pdb",Aa)
    #Button_tk_FASTA_Dont_Have.destroy()
    
def info_tk():
    bond=disulfide_bridge("transitory_file.pdb")
    output_file(target,"transitory_file.pdb",Aa,bond)
    #Button_tk_info_Dont_Have.destroy()

def B_factor_tk():
    set_Bfact("transitory_file.pdb")
    #Button_tk_B_factor_Dont_Have.destroy()
    
def finish_tk(): 
    file_del()
    app.destroy()

def output_Fasta_Have():
    output_fasta(F[-1],Aa)
    #Button_tk_FASTA_Dont_Have.destroy()

def B_factor_tk_Have():
    set_Bfact(F[-1])
    #Button_tk_B_factor_Dont_Have.destroy()

def info_tk_Have():
    bond=disulfide_bridge(F[-1])
    output_file(F[-1].split('/')[-1],F[-1],Aa,bond)
    
def back_home(): 
    global Button_tk_back_I_Dont_Have,Button_tk_back_I_have
    for widget in app.winfo_children():
       widget.destroy()
    Button_tk_back_I_have = Button(app, text="I have the file in my directory", command=I_have)
    Button_tk_back_I_Dont_Have = Button(app, text="I don't have the file in my directory", command=I_Dont_Have)
    Button_tk_back_I_have.grid(row=0, column=0)
    Button_tk_back_I_Dont_Have.grid(row=1, column=0)
    
    try:
        file_del()
    except:
        print("Any transitory file")
        


    


####%% Programme principale 

app =Tk()

app.title('Projet Python')
#app.geometry("800x600")
#app.attributes("-fullscreen", True)
app.config(background="white")


global Button_tk_I_have,Button_tk_I_Dont_Have
#cnv=Canvas(app,width=400, height=400, bg='white')
#cnv.pack()

Button_tk_I_have = Button(app, text="I have the file in my directory", command=I_have)
Button_tk_I_have.grid(row=0, column=0)
Button_tk_I_Dont_Have = Button(app, text="I don't have the file in my directory", command=I_Dont_Have)
Button_tk_I_Dont_Have.grid(row=1, column=0)



app.mainloop()

#Entrée ou on veut enregistrer le fichier => dire si rien d'écrit on place les fichier dans le même dossier que le fichier python
#Exception : 
    #si pas le bon code pdb / bon fichier 
    # 
    # 
    #
    #
    #
    #
    #      
#pop up confirmer que le fichier a bien été crée 