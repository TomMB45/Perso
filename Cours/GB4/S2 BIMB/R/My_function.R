########## Récupéré le nom des colonnes significatives(p-value < indice significativité) d'après un tableau type tableStack  
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
  #remplacer les valeurs < 0.001(caractère) par 0 (int)
  
  indices<-which(nonvide<=indice_significativité) ##Récup des indices des colonnes significatives 
  if (indice==TRUE){
    return (indices+(nb_début_vars_TableStack-1))}
  # récup des indices des lignes avec pvalue <= indice de significativité 
  col_sign<-colnames(DataBase[indices+(nb_début_vars_TableStack-1)]) ###Question : ça serait pas tt plutot que DB
  # on récup les noms des colonnes des indices sélectionner.
  if(indice==FALSE){
    return (col_sign)}#Si on cherche les noms alors on renvoie les noms des colonnes significatives
}

drop_level_0_and_unassociate<-function(DataBase,var_expl) #supprime les levels égale à 0 garder que les variables indépendantes de la variable expl
  {
  for(i in c(1:ncol(DataBase))){
    if(is.factor(DataBase[,i])==TRUE){
      DataBase[,i]<-droplevels(DataBase[,i])
      next}
    }
  i<-2  #Enlever la variable explicative et la variable de découpage de la bdd 
  n<-ncol(DataBase)
  while(i!=n){ ##On teste l'égalite entre deux itérateur => éviter pb quand on supprime ligne "du out of range"
    ##On teste si au moins une des modalité/level n'a pas été observé avec la variable explicative
    if (any(colSums(table(DataBase[[i]],DataBase[[var_expl]]))==0)){
      DataBase[[i]]<-NULL #suppression de la colonne liée à la variable expl
      n<-n-1  #Diminuer de 1 si on supprime une colonne 
      next}
    i<-i+1
    next}
  return(DataBase)
}

###Fonction qui renvoie soit l'indice soit le nom des colonnes ayant 20 % de Na  
index_ou_names_nb_na_sup_certain_pourcent<-function(DataBase,index=FALSE,pourcentage_limite=0.2){
  colonne_supr<-c()
  for(i in c(1:ncol(DataBase))){
    if ((sum(is.na(DataBase[i]))/nrow(DataBase))>=0.2){
      colonne_supr<-c(colonne_supr,i)
      #ajout dans une "liste" le nom de la variable supprimé
      next}
  }
  if(index==TRUE){return(colonne_supr)}
  else{return(colnames(DataBase[colonne_supr]))}
}

#Fonction qui supprime d'une base de donnée les variables dont les noms sont entrée 
#noms doit être de forme : c("name1","name2",...)
drop_nb_na_sup_50_pourcent<-function(DataBase,names){
  for (i in names){DataBase$i<-NULL}
  return (DataBase)
}

col_modalité_inf_pourcentage<-function(bdd,var_expl){
  while(i!=n){ ##On teste l'égalite entre deux itérateur => éviter pb quand on supprime ligne "du out of range"
    ##On teste si au moins une des modalité/level n'a pas été observé avec la variable explicative
    if (any(colSums(table(bdd[[i]],bdd[[var_expl]]))==0)){
      bdd[[i]]<-NULL #suppression de la colonne liée à la variable expl
      n<-n-1  #Diminuer de 1 si on supprime une colonne 
      next}
    i<-i+1
    next}
  return(bdd)
  
  
}

accuracy<-function(pred,expected_var,percent=0.5)
  #pred=> prediction of the model
  #expected_var => bdd$_var
  {
  conf_matrix<-table(pred>=percent,expected_var)
  Accuracy<-c( round(((conf_matrix[1]+conf_matrix[4])/length(pred))*100,1) )
  Spécificité<-c( round(conf_matrix[4]/(conf_matrix[4]+conf_matrix[2])*100,1) )
  Sensibilité<-c( round(conf_matrix[1]/(conf_matrix[1]+conf_matrix[3])*100,1) )
  df<-data.frame(Accuracy,Spécificité,Sensibilité)
  return(df)

}

bestxgb<- function (nround_init=1,nround_final=50,pas=1){
  
  bst_nround<-0
  bst_accuracy<-0
  all_data<-c()
  range_test<-seq(from = nround_init, to = nround_final, by = pas)
  
  for (index_n_round in range_test){ 
    
    model <- xgboost(data = dtrain,
                     nround = index_n_round,
                     objective = "binary:logistic",
                     verbose=0)
    pred_i <- predict(model, dtest)
    accu_mod<-accuracy(pred_i,test_labels)
    all_data<-c(all_data,accu_mod$Accuracy)
    
    
    if (accu_mod$Accuracy > bst_accuracy){
      
      bst_accuracy<-accu_mod$Accuracy
      bst_nround<-index_n_round
      next
      
    } #end if
    rm(model,pred_i,accu_mod)
    next
  } #end for
  
  plot(range_test, all_data, type="b")
  bst<-(data.frame(bst_accuracy,bst_nround))
  return(bst)
  
} #end function

