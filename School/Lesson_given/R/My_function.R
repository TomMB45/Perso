########## Récupéré le nom des colonnes significatives(p-value < indice significativité) d'aprés un tableau type tableStack  
col_significatives<- function(DataBase,
                              nom_Tableau_Table_Stack,
                              indice_significativité=0.05,## Valeur par défaut 
                              indice=FALSE, 
                              nb_début_vars_TableStack=1)
  {
  nonvide=nom_Tableau_Table_Stack$`P value`[which((nom_Tableau_Table_Stack$`P value`=="")==FALSE)]
  ##On recherche les lignes non vide du table stack pour la colonne 'P Value' 
  nonvide = as.double(replace(nonvide,
                    which(nonvide=="< 0.001"),
                    0) )
  #remplacer les valeurs < 0.001(caractére) par 0 (int)
  
  indices<-which(nonvide<=indice_significativité) ##Récup des indices des colonnes significatives 
  if (indice==TRUE){
    return (indices)}
  # récup des indices des lignes avec pvalue <= indice de significativité 
  col_sign<-colnames(DataBase[indices+(nb_début_vars_TableStack-1)]) ###Question : ca serais pas tt plutot que DB
  # on récup les noms des colonnes des indices sélectionner.
  if(indice==FALSE){
    return (col_sign)}#Si on cherche les noms alors on renvoie les noms des colonnes significatives
}

drop_level_0_and_unassociate<-function(DataBase,var_expl) #supprime les levels égale à 0 garder que les variables indépendantes de la variable expl
  {
  for(i in c(1:ncol(DataBase))){DataBase[,i]<-droplevels(DataBase[,i])}
  i<-3  #Enlever la variable explicative et la variable de découpage de la bdd 
  n<-ncol(DataBase)
  while(i!=n){ ##On teste l'égalite entre deux itérateur => éviter pb quand on supprime ligne "du out of range"
    ##On teste si au moins une des modalité/level n'a pas été observé avec la variable explicative
    if (any(colSums(table(DataBase[[i]],DataBase[[var_expl]]))==0)){
      DataBase[[i]]<-NULL #suppression de la colonne liée é la variable expl
      n<-n-1  #Diminuer de 1 si on supprime une colonne 
      next}
    i<-i+1
    next}
  return(DataBase)
}

###Fonction qui renvoie soit l'indice soit le nom des colonnes ayant 50 % de Na  
index_ou_names_nb_na_sup_50_pourcent<-function(DataBase,index=FALSE){
  colonne_supr<-c()
  for(i in c(1:ncol(DataBase))){
    if ((sum(is.na(DataBase[i]))/nrow(DataBase))>=0.5){
      colonne_supr<-c(colonne_supr,i)
      #ajout dans une "liste" le nom de la variable supprimé
      next}
  }
  if(index==TRUE){return(colonne_supr)}
  else{return(colnames(DataBase[colonne_supr]))}
}

#Fonction qui supprime d'une base de donnée les variables dont les noms sont entrée 
#noms doit étre de forme : c("name1","name2",...)
drop_nb_na_sup_50_pourcent<-function(DataBase,names){
  for (i in names){DataBase$i<-NULL}
  return (DataBase)
}

