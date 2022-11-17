# -*- coding: utf-8 -*-
"""
Created on Fri Jan  7 22:20:57 2022

@author: Tom
"""
def from_sslist_to_list(liste): 
    liste_modif=[]
    for i in liste : 
        liste_modif.append(i[0])
        liste_modif.append(i[1])
    return liste_modif
        
        
def cys(seq,bond):
    cys_not_bond=[]
    bond_idx=from_sslist_to_list(bond)
    for index, aa in enumerate(seq) : 
        print(index,aa)
        if aa=="C" and index not in bond_idx :
            cys_not_bond.append(index)
    return cys_not_bond 
            
bond=[]
print(cys("XCCKLCIC",bond))