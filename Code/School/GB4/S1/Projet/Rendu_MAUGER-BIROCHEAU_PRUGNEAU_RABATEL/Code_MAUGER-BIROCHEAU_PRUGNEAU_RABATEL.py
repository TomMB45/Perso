#%% Import des fonctions 
from tkinter import Button,Tk,filedialog,Entry,Label,messagebox
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
from urllib.error import HTTPError

#Matrice
import numpy as np

#os
import os
import os.path as pth

import re 

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
F=[] #List of path, global var

regex=re.compile("[1-9].{3}")#regular expression of a valid PDBID


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
                                         title = "Choose a file") 
    F.append(Fichier)
    return F

def pdb_search(code):
    """Function to search the PBD file on internet and read all the lines"""
    try:
        u=urllib.request.urlopen("http://files.rcsb.org/view/"+code.upper()+".pdb") #internet research 
    #recherche sur internet du fichier spécifié 
    except urllib.error.HTTPError as err: #Error404 handling
        return err 
    else :
        pdblines=u.readlines()
        u.close()
        cdc=''
        for ligne in pdblines:
            cdc+=ligne.decode("utf8") 
        return cdc
 
def write_file(cdc:str):
    """Write a transitory PDB file"""
    fpdb = open("transitory_file.pdb","w")
    fpdb.write(str(cdc))#write on a file the output of pdb_search function
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
    for record in SeqIO.parse(target, "pdb-atom"): #Parse the file to get the amino acid sequence
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
    dic_rate=Aa_rate(seq) 
    data_items = dic_Aa_rate.items()
    data_list = list(data_items) #list the items of the dict
    df=pd.DataFrame(data_list,columns=['AA','Expacy mean rate'])#transformation into a dataframe
    df.insert(1,"AA Protein",dic_rate.values())#insertion of the AA rate of the desired protein
    fig = go.Figure(data=[
                        go.Bar(name='Research protein Aa rate',x=df['AA'],y=df["AA Protein"]),#création des barres
                        go.Bar(name='Mean rate',x=df["AA"],y=df["Expacy mean rate"])
                        ])#Create the barplot with plotly, 2 go.Bar one for the rate of the protein, the other for expacy mean rate 
  # Change the bar mode
    fig.update_layout(barmode='group',
                    height=800,
                    width=800,
                    xaxis_title='Amino Acid',
                    yaxis_title='rate',
                    title="Aa rate comparaison")

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
    
    head=Bio.PDB.parse_pdb_header(file)#using a parser to create a dict with all of the main informations of the protein 
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
        if i>len(AA_chain)-window : #if there are less characters than the size of the window => avoid out of range
            break
        else : 
            hydro_Aa=0
            for win in range(i,i+window):#sliding window 
                if scale=="Fau": 
                  hydro_Aa+=hydrophobicity_1L_Fauchere[AA_chain[win]]#assign for each amino acid its value in the right scale of hydrophobicity 
                elif scale == "Kyt": 
                  hydro_Aa+=hydrophobicity_1L_Kyte[AA_chain[win]]

            hydro.append((1/(window))*hydro_Aa) #calculate the mean value of hydrophobicity on the window
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
    x=list(range(len(AA_chain)))#creation of the x-bar
    y=hydrophobicity_calc(AA_chain,window,hydro_scale)
    fig=go.Figure()#Creating of a graph object with plotly package 
    fig.add_trace(go.Scatter(y = y,
                             x = x,
                             name = "Hydrophobicity",
                             line_shape='spline'))#Line_shape = 'spline' => smoothes the curve
    fig.update_layout(title="Hydrophobicity with {} scale, windows = {} ".format(hydro_scale,window),
                  xaxis_title="Number of Amino Acid",
                  yaxis_title="Hydrophobicity")
    fig.show()
    
def from_sslist_to_list(bond:list): 
    """
    Collapse the list of bond in a unique list

    Parameters
    ----------
    bond : list
        list of dissulfide bridge.

    Returns
    -------
    liste_modif : list
        collapse list.

    """
    liste_modif=[]
    for i in bond : 
        liste_modif.append(i[0])
        liste_modif.append(i[1])
    return liste_modif
        
def cys_free(seq:str,bond:list):
    """
    Determine the CYS not involved in dissulfide bridges

    Parameters
    ----------
    seq : str
        Amino-acid sequence.
    bond : list
        list of dissulfide bridge.

    Returns
    -------
    cys_not_bond : list
        Position of CYS not involved in dissulfide bridges.

    """
    cys_not_bond=[]
    bond_idx=from_sslist_to_list(bond)
    for index, aa in enumerate(seq) : 
        if aa=="C" and index not in bond_idx :
            cys_not_bond.append(index+1)
    return cys_not_bond 

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
  length=len(Sequence_Aa)
  free=cys_free(Sequence_Aa,bond)
  
  for i in range(0,len(Sequence_Aa),80):#writing the sequence in standard 80 Aa format per line
    Seq+=Sequence_Aa[i:i+80]+"\n"
  
  #Write in a txt file
  f = open("{}_output_file.txt".format(target),"w")
  f.write("Amino acid sequence: \n"+str(Seq)+"\nThe lenght of the sequence is : "+str(length) + "\n\n")
  f.write("Experimental method to determine the structure: {}\nResolution: {} Ä\n\n".format(met,resol))
  f.write("Disulfide bound determination\n")
  if len(bond)==0: 
    f.write("Any disulfide bridge\nFree CYS is :")
    for free_cys in free : 
        f.write("CYS {}, ".format(free_cys))
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


    with open(name+"_FASTA.fasta","w") as fasta:
        fasta.write(">{}|{}|{}|{}\n{}".format(name,mol,orga,taxid,str(Seq)))
        fasta.close()

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
        head=Bio.PDB.parse_pdb_header(file)
        name=head["idcode"]
        with open("{}_B_fact_modif.pdb".format(name),"w") as bf : 
            ligne=transit.readline()
            while ligne != "": 
                if "ATOM" not in ligne[:6] : #while ATOM is not on the 1st col of the file we write all the line 
                    bf.write(ligne)
                else: 
                    val=B_fact[regroup[ligne[17:20]]]#recovery of the B-factor value of the selected amino acid 
                    bf.write(ligne[:60]+" "+str(val)+ligne[66:])#write the B-factor modified in the right position of eatch line 
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
    structure=parser.get_structure("search",file)#parse the file to get the structure of the protein 
    res = [r for r in structure.get_residues()]#for loop to get the residues of the sequence 
    matrix=np.zeros((len(res),len(res)))#create a matrix of 0 of size equal to the length of the sequence

    for row in range(len(res)):
        for col in range(len(res)):
            if str(res[col]).split()[1] in Aa_3L and str(res[row]).split()[1] in Aa_3L: #verification that the residue read is an Aa and not an external molecule Ex IPTG or H2O
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
                    z=matrix)) #create a heatmap graph object with the contact matrix
    fig.update_layout(title="Heatmap of the protein")
    #légende distance Ä
    fig.show()

#%% tk function
def initial_window():
    global Button_tk_I_have,Button_tk_I_Dont_Have
    path = str(Entree_path.get())
    if path=="":#if nothing is entered we save in the current folder
        path=os.getcwd()
    elif pth.isdir(path)==False:#if the path doesn't exist pop-up to advertise the user
        path=os.getcwd()
        messagebox.showinfo("Invalid path","The files will be saved in the current folder")
    os.chdir(path)
    for widget in app.winfo_children():#destroy all of the old widget
       widget.destroy()
    
    Button_tk_I_have = Button(app, text="I have the file in my directory", command=I_have)# tkinter click button => performs an action at the time of the click 
    Button_tk_I_have.grid(row=0, column=0)#positioning the button on a grid 
    Button_tk_I_Dont_Have = Button(app, text="I don't have the file in my directory", command=I_Dont_Have)
    Button_tk_I_Dont_Have.grid(row=1, column=0)
    

def I_have(): 
    global Button_tk_parcourir,Button_tk_continue
    
    for widget in app.winfo_children():
       widget.destroy()
    
    Button_tk_parcourir=Button(app,text="Browse",command=parcourir)
    Button_tk_continue=Button(app,text="Continu",command=action_have)
    Button_tk_back=Button(app,text="Go main menu", command=back_home,bg="#DC0202")
    
    Button_tk_parcourir.grid(row=0, column=0)
    Button_tk_continue.grid(row=1, column=0)
    Button_tk_back.grid(row=1,column=1)
    

    
def action_have(): 
    global Button_tk_FASTA,Button_tk_Graph,Button_tk_info,Button_tk_output
    global Button_tk_compo_rate,Button_tk_B_factor,Button_tk_finish,Aa
    if F[-1].split('/')[-1].split('.')[-1] == "pdb":#verification if the file chosing is a pdb file => we get the name of the file from the path then from that we get its extension
        Aa=get_Aa(F[-1])
        for widget in app.winfo_children():
           widget.destroy()
        
        Button_tk_Graph = Button(app, text="Show hydrophobicity graph(Faucher method) in your browser", command=viz_hydro_tk)
        Button_tk_Graph_Kyt_Dont_Have = Button(app, text="Show hydrophobicity graph(Kyte method) in your browser", command=viz_hydro_tk_kyte)
        Button_tk_info = Button(app, text="Download the informations of protein", command= info_tk_Have)
        Button_tk_compo_rate = Button(app, text="Show the rate of Aa on protein in your browser", command= viz_rate_tk)
        Button_tk_Heatmap= Button(app, text="Show the Heatmap of the protein in your browser", command= viz_heatmap_tk_have)
        Button_tk_FASTA = Button(app, text="Download the FASTA sequence", command=output_Fasta_Have)
        Button_tk_B_factor=Button(app, text="Download the pdb file with modified B-Factor", command= B_factor_tk_Have)
        Button_tk_finish = Button(app, text="Finish", command=app.destroy)
        Button_tk_back=Button(app,text="Go main menu", command=back_home,bg="#DC0202")
        
        Button_tk_Graph.grid(row=0, column=0)
        Button_tk_Graph_Kyt_Dont_Have.grid(row=1,column=0)
        Button_tk_compo_rate.grid(row=2, column=0)
        Button_tk_Heatmap.grid(row=3, column=0)
        
        Button_tk_FASTA.grid(row=4, column=0)
        Button_tk_info.grid(row=5, column=0)
        Button_tk_B_factor.grid(row=6, column=0)    
        Button_tk_finish.grid(row=7, column=0)
        Button_tk_back.grid(row=7,column=1)
    else : 
        messagebox.showinfo("Error","You must choose a pdb file")
        I_have()

def I_Dont_Have():
    global Phrase, Entree,Valid
    for widget in app.winfo_children():
       widget.destroy()
    
    Phrase=Label(app, text="Enter a valid PDBID of the protein.\nMake sure to be online")
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
    if len(target)!=4 : #if the length is diffrent from 4 thats not a PDBID
        messagebox.showinfo("Error","You must enter a valid PDBID with length 4")
        I_Dont_Have()

    if regex.match(target) : #if the code enter match with the regular expression of a PDBID do the research on internet => avoid unnecessary searches for invalid codes 
        cdc=pdb_search(target)
        write_file(cdc)
        
        Aa=get_Aa("transitory_file.pdb")
        
        for widget in app.winfo_children():
           widget.destroy()
        

        Button_tk_compo_rate_Dont_Have = Button(app, text="Show the rate of Aa on protein in your browser", command= viz_rate_tk)
        Button_tk_Graph_Dont_Have = Button(app, text="Show hydrophobicity graph(Faucher method) in your browser", command=viz_hydro_tk)
        Button_tk_Graph_Kyt_Dont_Have = Button(app, text="Show hydrophobicity graph(Kyte method) in your browser", command=viz_hydro_tk_kyte)
        Button_tk_Heatmap_Dont_Have=Button(app, text="Show Heatmap on your browser", command= viz_heatmap_tk)
        
        Button_tk_FASTA_Dont_Have = Button(app, text="Download the FASTA sequence", command=output_Fasta)
        Button_tk_info_Dont_Have = Button(app, text="Download the informations of protein", command= info_tk)
        Button_tk_B_factor_Dont_Have=Button(app, text="Download the pdb file with modified B-Factor", command=B_factor_tk)
        Button_tk_finish_Dont_Have = Button(app, text="Finish", command=finish_tk)
        Button_tk_back=Button(app,text="Go main menu", command=back_home,bg="#DC0202")    
        
        Button_tk_compo_rate_Dont_Have.grid(row=2, column=0)
        Button_tk_Graph_Dont_Have.grid(row=0, column=0)
        Button_tk_Graph_Kyt_Dont_Have.grid(row=1,column=0)
        Button_tk_Heatmap_Dont_Have.grid(row=3, column=0) 
        Button_tk_FASTA_Dont_Have.grid(row=4, column=0)
        Button_tk_info_Dont_Have.grid(row=5, column=0)
        Button_tk_B_factor_Dont_Have.grid(row=6, column=0)
        Button_tk_finish_Dont_Have.grid(row=7, column=0)
        Button_tk_back.grid(row=7,column=1)

    else : 
        messagebox.showinfo("Error","You must enter a valid PDBID")
        I_Dont_Have()
        
######the following functions are repeats of the previously coded functions but without arguments because the execution of tkinter commands does not work with arguments
def viz_hydro_tk(): 
    viz_hydro(Aa)

def viz_hydro_tk_kyte():
    viz_hydro(Aa,hydro_scale="Kyt")

def viz_rate_tk(): 
    viz_rate(Aa)

def viz_heatmap_tk():
    heatmap(contact_matrix("transitory_file.pdb"))
    
def viz_heatmap_tk_have():
    heatmap(contact_matrix(F[-1]))

def output_Fasta():
    output_fasta("transitory_file.pdb",Aa)
    messagebox.showinfo("Finish","File has been donwload")    
    
def info_tk():
    output_file(target,"transitory_file.pdb",Aa)
    messagebox.showinfo("Finish","File has been donwload")

def B_factor_tk():
    set_Bfact("transitory_file.pdb")
    messagebox.showinfo("Finish","File has been donwload")
    
def finish_tk(): 
    file_del()
    app.destroy()

def output_Fasta_Have():
    output_fasta(F[-1],Aa)
    messagebox.showinfo("Finish","File has been donwload")

def B_factor_tk_Have():
    set_Bfact(F[-1])
    messagebox.showinfo("Finish","File has been donwload")

def info_tk_Have():
    output_file(F[-1].split('/')[-1].split(".")[0],F[-1],Aa)#we get the name of the file from the path then from that we get its PDBID
    messagebox.showinfo("Finish","File has been donwload")
    
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
        

#%% Programme principale 

app =Tk()

app.title('Projet Python')
app.config(background="white")

global path_req,Entree_path,Valid_path
path_req=Label(app, text="Enter the path where the output files should be saved")
path_req.grid(row=0, column=0)
Expl=Label(app, text="If no entry the files will be saved in the same folder as the python file")
Entree_path = Entry(app,width=55)

Entree_path.grid(row=1, column=0)
Expl.grid(row=2,column=0)

Valid_path=Button(app, text="Validation", command=initial_window)
Valid_path.grid(row=3, column=0)


app.mainloop()