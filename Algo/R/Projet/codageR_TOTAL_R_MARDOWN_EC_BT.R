## Installer une liste de packages rapidement


# list.of.packages=c("multcomp","nlme","nnet","rms","OptimalCutpoints","plotROC","pROC","prognosticROC","prodlim","psy","randomForest","rapport","relsurv",
#                    "lava","MASS","rmeta","rocc","ROCR","rpart","sas7bdat","sensitivity","shape","sp","splines","sROC","SuppDists",
#                    "survival","svSocket","timeSeries","tis","tools","urca","utils","VGAM","waterfall","xtable","magrittr","survMisc","flextable",
#                    "tidyverse","purrr","corrr","plyr","dplyr","tidyselect","ranger","officer","rmarkdown","survBootOutliers","mgcv",
#                    "VennDiagram","cowplot","data.table","questionr","survminer","DataCombine")
# new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
# if(length(new.packages)) install.packages(new.packages)


##########################################################################################################################################################


######_______Voir les Fonctions

# numcol<-function(x)# X est le nom de la table                                                     
# {
#   z<-"o"
#   y <- readline(cat("Quelle variable cherchez vous?\nIndiquez son nom: "))
#   if (!is.na(match(y,dimnames(x)[[2]]))) print(match(y,dimnames(x)[[2]]))
#   else print("Votre variable ne figure pas dans la table ou est mal orthographi?e")
#   while (z=="o")
#   {z<-readline(cat("Une autre variable ?\nsi oui tapez : o\nsi non tapez: n "));
#   if (z=="o")
#   {y <- readline(cat("Quelle variable cherchez vous ?\nIndiquez son nom: "))
#   if (!is.na(match(y,dimnames(x)[[2]]))) print(match(y,dimnames(x)[[2]]))
#   else print("Votre variable ne figure pas dans la table ou est mal orthographi?e")}}
#   rm(x,y,z)
# }
######_______FIN

######_______Voir les Fonctions
voir<-function(...)
  
{
  nbr<-list(...)
  if (length(nbr)>1) stop("Un seul nom de fichier !!")
  if (length(nbr)==1)
  {a<-(nbr)[[1]]
  print(noquote(paste("Votre fichier contient: ",length(a[,1])," observations",sep="")))
  print(a[1:5,])}
  if (length(nbr)==0)
  {print("charge:nomfichier-sans chemin ni extension")
    print("numcol:nomtable")
    print("voirfactor:nomfichier")
    print("enfactor:nomfichier, Num col à factoriser, type= s (contr.sum) ou h (contr.helmert)")
    print("mod:nomfichier, Num col (QUANTI) 'c(1,5,7:8)' pour lesquelles on souhaite voir le MODE")
    print(":nomtab, Num col 1, Num col 2, exclude=F sans NULL- par d?faut=AVEC")
    print("oddra: nomtab, Num col Maladie, Num col Facteur de Risque")
    print("orman: = sans argument")
    print("inverse: un texte")
    print("histoquanti: nomtab ou nomtab[c(Num col)]")
    print("plotquali: nomtab ou nomtab[c(Num col)]")
    print("secteurquali: nomtab ou nomtab[c(Num col)]")
    print("chi2tab: nomtab, Num cols 'c(1,3,4:6)' QUALI a tester entre elles 2 ? 2")
    print("studenttab: nomtab, Num cols (QUALI) c(2,5), Num des cols (QUANTI) c(1,3,4:6)")
    print(": nomtab, Num cols 'c(1,3,4:6)' QUANTI a tester entre elles 2 ? 2")
    print("hillstab: nomtab, Num cols QUANTI 'c(1,3,4:6)' a inclure dans le diagramme")
    print("fdrtab: nomtab, Num cols QUANTI 'c(1,3,4:6)', 0.1 pour 10%")
    print("orcoef: nomvar")
    print("sortiequali: nomtab, Num cols 'c(1,3,4:6)' QUALI pour voir nombre et freq")
    print("sortiequanti: nomtab, Num cols 'c(1,3,4:6)' QUANTI pour voir moy quartiles et Etype")
    print("sortiequalibi: nomtab,Num cols binaire,Num cols 'c(1,3,4:6)' QUALI pour voir nombre et freq")
    print("sortiequantibi: nomtab,Num cols binaire,Num cols 'c(1,3,4:6)' QUANTI pour voir moy quartiles et Etype")
    print("dichoto: nomtab,Num col binaire MALADIE,Num col binaire FACTEUR RISQUE")
    print("multidichoto: nomtab,Num col 'c(1,3,4:6)' binaire MALADIE,Num col (1 seul) binaire FACTEUR RISQUE")
    print("tabcols: nomtab")}
}
######_______FIN

######_______Factorise les colonnes du fichier

enfactor<-function(...,type=c("h","s"))
{
  nbr<-list(...)
  if (length(nbr)!=2) stop("Vous devez taper un nom de fichier et une ou plusieurs colonnes c(1,3,5:7)")
  x<-nbr[[1]]
  y<-nbr[[2]]
  if (is.data.frame(x)==FALSE) stop("Cette fonction est disponible uniquement sur des fichiers comportants plusieurs colonnes")
  if (missing(type)) {for (i in y) x[,i]<-as.factor(x[,i])} else
  {
    if (!type=="h") {if (!type=="s") stop("type doit ?tre s pour 'contr.sum' ou h pour 'contr.helmert' !!!")}
    if (!type=="s") {if (!type=="h") stop("type doit ?tre s pour 'contr.sum' ou h pour 'contr.helmert' !!!")}
    if (type=="h") {for (i in y) x[,i]<-as.factor((x)[,i])
    t<-length(table(x[,i]));contrasts(x[,i])<-contr.helmert(t)}
    if (type=="s") {for (i in y) {x[,i]<-as.factor((x)[,i])
    t<-length(table(x[,i]));contrasts(x[,i])<-contr.sum(t);print(noquote(names(x[i])));print(contrasts(x[,i]))}}
  }
  print(noquote("Voici les colonnes prises comme QUALITATIVES (as factor=TRUE)"))
  for (j in 1:ceiling(length(x)/4))
  {d<-NULL;for (i in (((j-1)*4)+1):(j*4))
  {if (i<=length(x)) d<-paste(d,names(x[i]),":'",is.factor(x[,i]),"' ",sep="")}
  print(noquote(d))}
  #return(x)
}
#rm(x,y,d,i)
######_______FIN

######_______charge un fichier texte au format csv en tapant seulement son nom (si fichier dans le r?pertoire R)

charge<-function(x)
{
  y<-read.csv2(paste("D:/r/",x,".csv",sep="")) # Lecture du fichier
  print(noquote(paste("Votre fichier contient: ",length(y[,1])," observations",sep=""))) #Nbre d'observ
  print(y[1:3,])# Imprime les 3 prem lignes du fichier
  
  {ANSWER <- readline("Voulez vous voir s'il y a des valeurs nulles? oui=o non=n  ")
    if (substr(ANSWER,1,1) == "o")# Sommation du nbre de Nuls dans chaque colonne
    {g<-NULL;h<-NULL;k<-0;
    for (i in 1:length(y)) 
    {h<-length(y[,i][is.na(y[,i])|is.null(y[,i])|y[,i]==""])
    {if (h>0) {g<-noquote(paste(g,names(y)[i],":",h," vide(s)  ",sep=""));k<-k+1}}
    {if (k==3){print(g);k<-0;g<-NULL}}}
    if (!is.null(g)) print(g)}
    else if (substr(ANSWER, 1, 1) == "n")
      cat("Merci\n")
    else
      cat("Votre r?ponse ne peut ?tre\nque 'o' pour oui ou 'n' pour non\n")};
  
  {ANSWER <- readline("Voulez vous voir la composition des colonnes AS.FACTEUR? oui=o non=n  ")
  if (substr(ANSWER,1,1) == "o")# Voir les diff?rentes valeurs des ?tiquettes
  {for (i in 1:length(dimnames(y)[[2]])) if (!is.null(attributes(y[,i])))
  {print(noquote(dimnames(y)[[2]][i]));print(attributes(y[,i])[[1]])}}
  else if (substr(ANSWER, 1, 1) == "n")
    cat("Merci\n")
  else
    cat("Votre r?ponse ne peut ?tre\nque 'o' pour oui ou 'n' pour non\n")};
  # Charge le fichier dans la variable
  return(y)
}
#####_______FIN

#####_______Donne un tableau des fr?quences

procfreq<-function(...,exclude=F)
  #tabfreq<-function(a,b,c,d)## a= nom table
  ## b= Num de la colonne des ordonn?es (lignes du tableau)
  ## c= Num de la colonne des abscisses (colonnes du tableau)
  ## exclude = F si on veut tabuler sans les valeurs nulles
  ## par defaut exclude = T (avec les Nulls)
{
  nbr<-list(...)
  if (length(nbr)>3) stop("Maximum 2 colonnes !!!")
  if (length(nbr)==0) stop("Vous devez indiquer la table et au moins une colonne !!!")
  if (length(nbr)==1) stop("Vous devez indiquer la table et au moins une colonne !!!")
  if (length(nbr)==2)
  {
    a<-(nbr)[[1]]
    b<-(nbr)[[2]]
    if (missing(exclude)) t<-table(a[,b],exclude=NULL,dnn=c(names(a[b])))
    else {if (!exclude==F) t<-table(a[,b],exclude=NULL,dnn=c(names(a[b])))
    else t<-table(a[,b],dnn=c(names(a[b])))}
    ordo<-NULL
    absi<-NULL
    ordo<-c(dimnames(t)[[1]],"Tot")
    absi<-c("Nbre","%")
    tt<-matrix(data=0,nc=(length(t)+1),nr=2,dimnames=list(absi,ordo))
    for(i in 1:length(t)) {tt[1,i]<-t[i]}
    tt[1,length(t)+1]<-sum(t)
    for(i in 1:length(t)) {tt[2,i]<-round(t[i]*100/sum(t),1)}
    tt[2,length(t)+1]<-100
    write.table(tt,file="D:/r/tabfreq.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=T,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel 
    print(tt)
  }
  if (length(nbr)==3)
  {
    a<-(nbr)[[1]]
    b<-(nbr)[[2]]
    c<-(nbr)[[3]]
    if (missing(exclude)) t<-table(a[,b],a[,c],exclude=NULL,dnn=c(names(a[b]),names(a[c])))
    else {if (!exclude==F) t<-table(a[,b],a[,c],exclude=NULL,dnn=c(names(a[b]),names(a[c])))
    else t<-table(a[,b],a[,c],dnn=c(names(a[b]),names(a[c])))}
    ordo<-NULL
    absi<-NULL
    for(i in 1:length(t[,1])) ordo<-c(ordo,dimnames(t)[[1]][i],"%col")
    ordo<-c(ordo,"Tot")
    for(i in 1:length(t[1,])) absi<-c(absi,dimnames(t)[[2]][i],"%lig")
    absi<-c(absi,"Tot")
    tt<-matrix(data=0,nc=((length(t[1,])+1)*2)-1,nr=((length(t[,1])+1)*2)-1,dimnames=list(ordo,absi))
    for(j in 1:length(t[,1])) {for(i in 1:length(t[1,])) 
    {tt[(j*2)-1,(i*2)-1]<-t[j,i];tt[(j*2)-1,i*2]<-round(t[j,i]*100/sum(t[j,]),1)}
      tt[(j*2)-1,(length(t[1,])*2)+1]<-sum(t[j,])}
    for(j in 1:length(t[,1])) {for(i in 1:length(t[1,])) 
    {tt[(j*2),i*2]<-round(t[j,i]*100/sum(t),1)}
      tt[(j*2),(length(t[1,])*2)+1]<-round(sum(t[j,])*100/sum(t),1)}
    for(j in 1:length(t[1,])) 
    {for(i in 1:length(t[,1])) {tt[i*2,(j*2)-1]<-round(t[i,j]*100/sum(t[,j]),1)}
      tt[(length(t[,1])*2)+1,(j*2)-1]<-sum(t[,j])}
    for(j in 1:length(t[1,])) 
    {for(i in 1:length(t[,1]))
      tt[(length(t[,1])*2)+1,(j*2)]<-round(sum(t[,j])*100/sum(t),1)}
    tt[length(tt[,1]),length(tt[1,])]<-sum(t)
    names(dimnames(tt))<-list(names(a[b]),names(a[c]))
    write.table(tt,file="D:/r/tabfreq.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=T,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel 
    print(tt)
    #dimnames(t)[[1]]<-list(dimnames(t)[[1]][2],dimnames(t)[[1]][1])
  }
}
#####_______FIN

#####_______Donne les Odd-Ratios et Risques Relatifs pour un tableau 2x2

oddra<-function(a,b,c) 	## a= nom table
  ## b= Num de la colonne variable binaire 'Maladie'
  ## c= Num de la colonne variable binaire 'Facteur risque'
{
  {if (length(table(a[,c]))!=2) stop(paste("Votre variable -",names(a[c]),"- n'est pas binaire !!")) }
  {if (length(table(a[,b]))!=2) stop(paste("Votre variable -",names(a[b]),"- n'est pas binaire !!")) }
  t<-table(a[,c],a[,b],dnn=c(names(a[c]),names(a[b])))
  #pour un tableau manuel remplacer les 4 valeurs de la 2? ligne ci dessous
  #	m-fr-		m+fr-		m-fr+		m+fr+  et d?cocher le # devant la ligne
  #t[1,1]<-10753;t[1,2]<-1372;t[2,1]<-1086;t[2,2]<-117
  or<-(t[1,1]*t[2,2])/(t[1,2]*t[2,1])
  rr<-(t[2,2]/(t[2,2]+t[2,1]))/(t[1,2]/(t[1,2]+t[1,1]))
  et1<-((t[1,1]+t[1,2])*(t[1,1]+t[2,1]))/(t[2,1]+t[2,2]+t[1,1]+t[1,2])
  et2<-((t[1,1]+t[1,2])*(t[1,2]+t[2,2]))/(t[2,1]+t[2,2]+t[1,1]+t[1,2])
  et3<-((t[2,1]+t[2,2])*(t[1,1]+t[2,1]))/(t[2,1]+t[2,2]+t[1,1]+t[1,2])
  et4<-((t[2,1]+t[2,2])*(t[1,2]+t[2,2]))/(t[2,1]+t[2,2]+t[1,1]+t[1,2])
  icrr<-(sqrt((t[2,1]/((t[2,2]+t[2,1])*t[2,2]))+(t[1,1]/((t[1,2]+t[1,1])*t[1,2]))))*1.96
  rrp<-round(exp(log(rr)+icrr),2)
  rrm<-round(exp(log(rr)-icrr),2)
  icor<-(sqrt(1/t[1,1]+1/t[1,2]+1/t[2,1]+1/t[2,2]))*1.96
  orp<-round(exp(log(or)+icor),2)
  orm<-round(exp(log(or)-icor),2)
  
  #inverse t pour replir la matrice suivant la meme moulinette que tabfreq
  #t<-table(a[,b],a[,c],dnn=c(names(a[b]),names(a[c])))
  #pour un tableau manuel remplacer les 4 valeurs ci dessous
  # m-fr-		m+fr-		m-fr+	m+fr+  et d?cocher le # devant la ligne
  #t[1,1]<-488;t[1,2]<-12;t[2,1]<-452;t[2,2]<-48
  ordo<-NULL
  absi<-NULL
  for(i in 1:length(t[,1])) ordo<-c(ordo,dimnames(t)[[1]][i],"%")
  ordo<-c(ordo,"Tot")
  for(i in 1:length(t[1,])) absi<-c(absi,dimnames(t)[[2]][i],"%")
  absi<-c(absi,"Tot")
  tt<-matrix(data=0,nc=((length(t[1,])+1)*2)-1,nr=((length(t[,1])+1)*2)-1,dimnames=list(ordo,absi))
  for(j in 1:length(t[,1])) {for(i in 1:length(t[1,])) {tt[(j*2)-1,(i*2)-1]<-t[j,i];tt[(j*2)-1,i*2]<-round(t[j,i]*100/sum(t[j,]),1)}
    tt[(j*2)-1,(length(t[1,])*2)+1]<-sum(t[j,])}
  for(j in 1:length(t[1,])) {for(i in 1:length(t[,1])) {tt[i*2,(j*2)-1]<-round(t[i,j]*100/sum(t[,j]),1)}
    tt[(length(t[,1])*2)+1,(j*2)-1]<-sum(t[,j])}
  tt[length(tt[,1]),length(tt[1,])]<-sum(t)
  names(dimnames(tt))<-list(names(a[c]),paste("Maladie:",names(a[b])))
  #print(tt)
  #print(t)
  print(noquote("v?rifiez que les variables sont bien cod?es 1 (pour=oui) ou 0 (pour=non)"))
  print(noquote("et que la MALADIE est en colonne et le FACTEUR RISQUE en ligne"))
  print(c("Odds-Ratio"=round(or,2),"  Risque Relatif"=round(rr,2)))
  print(noquote(paste("Intervalle de Confiance de l'OR: [",orm,";",orp,"]")))
  print(noquote(paste("Intervalle de Confiance du RR: [",rrm,";",rrp,"]")))
  print(noquote(paste("Les effectifs th?oriques sont :"
                      ,round(et1,1),round(et2,1),round(et3,1),round(et4,1),sep=" ")))
  {
    if ((et1)<=5) print("ATTENTION UN DES EFFECTIFS THEORIQUE EST INFERIEUR A 5 !")
    if ((et2)<=5) print("ATTENTION UN DES EFFECTIFS THEORIQUE EST INFERIEUR A 5 !")
    if ((et3)<=5) print("ATTENTION UN DES EFFECTIFS THEORIQUE EST INFERIEUR A 5 !")
    if ((et4)<=5) print("ATTENTION UN DES EFFECTIFS THEORIQUE EST INFERIEUR A 5 !")
  }
  #rm(a,b,c,t,or,rr,et1,et2,et3,et4)
}
####_____FIN

####____Calcul de l'OR et du RR sur 4 nombres rentr?s manuellement

orman<-function()
{
  rep1 <- readline("Indiquez le Nombre correspondant ? Maladie+FacRisque+: ")
  rep2 <- readline("Indiquez le Nombre correspondant ? Maladie-FacRisque+: ")
  rep3 <- readline("Indiquez le Nombre correspondant ? Maladie+FacRisque-: ")
  rep4 <- readline("Indiquez le Nombre correspondant ? Maladie-FacRisque-: ")
  t<-matrix(data=0,nc=2,nr=2,dimnames=list(c("fr-","fr+"),c("m-","m+")))
  #	m-fr-		m+fr-		m-fr+		m+fr+  et d?cocher le # devant la ligne
  t[1,1]<-as.numeric(rep4);t[1,2]<-as.numeric(rep3);t[2,1]<-as.numeric(rep2);t[2,2]<-as.numeric(rep1)
  or<-(t[1,1]*t[2,2])/(t[1,2]*t[2,1])
  rr<-(t[2,2]/(t[2,2]+t[2,1]))/(t[1,2]/(t[1,2]+t[1,1]))
  et1<-((t[1,1]+t[1,2])*(t[1,1]+t[2,1]))/(t[2,1]+t[2,2]+t[1,1]+t[1,2])
  et2<-((t[1,1]+t[1,2])*(t[1,2]+t[2,2]))/(t[2,1]+t[2,2]+t[1,1]+t[1,2])
  et3<-((t[2,1]+t[2,2])*(t[1,1]+t[2,1]))/(t[2,1]+t[2,2]+t[1,1]+t[1,2])
  et4<-((t[2,1]+t[2,2])*(t[1,2]+t[2,2]))/(t[2,1]+t[2,2]+t[1,1]+t[1,2])
  icrr<-(sqrt((t[2,1]/((t[2,2]+t[2,1])*t[2,2]))+(t[1,1]/((t[1,2]+t[1,1])*t[1,2]))))*1.96
  rrp<-round(exp(log(rr)+icrr),2)
  rrm<-round(exp(log(rr)-icrr),2)
  icor<-(sqrt(1/t[1,1]+1/t[1,2]+1/t[2,1]+1/t[2,2]))*1.96
  orp<-round(exp(log(or)+icor),2)
  orm<-round(exp(log(or)-icor),2)
  ordo<-NULL
  absi<-NULL
  for(i in 1:length(t[,1])) ordo<-c(ordo,dimnames(t)[[1]][i],"%")
  ordo<-c(ordo,"Tot")
  for(i in 1:length(t[1,])) absi<-c(absi,dimnames(t)[[2]][i],"%")
  absi<-c(absi,"Tot")
  tt<-matrix(data=0,nc=((length(t[1,])+1)*2)-1,nr=((length(t[,1])+1)*2)-1,dimnames=list(ordo,absi))
  for(j in 1:length(t[,1])) {for(i in 1:length(t[1,])) {tt[(j*2)-1,(i*2)-1]<-t[j,i];tt[(j*2)-1,i*2]<-round(t[j,i]*100/sum(t[j,]),1)}
    tt[(j*2)-1,(length(t[1,])*2)+1]<-sum(t[j,])}
  for(j in 1:length(t[1,])) {for(i in 1:length(t[,1])) {tt[i*2,(j*2)-1]<-round(t[i,j]*100/sum(t[,j]),1)}
    tt[(length(t[,1])*2)+1,(j*2)-1]<-sum(t[,j])}
  tt[length(tt[,1]),length(tt[1,])]<-sum(t)
  names(dimnames(tt))<-list("Facteur de Risque: ","Maladie: ")
  x<-rep("M1",rep1);y<-rep("E1",rep1);z<-cbind(x,y);v<-z
  x<-rep("M1",rep3);y<-rep("E0",rep3);z<-cbind(x,y);v<-rbind(v,z)
  x<-rep("M0",rep2);y<-rep("E1",rep2);z<-cbind(x,y);v<-rbind(v,z)
  x<-rep("M0",rep4);y<-rep("E0",rep4);z<-cbind(x,y);v<-rbind(v,z)
  print(tt)
  print(c("Odds-Ratio"=round(or,2),"  Risque Relatif"=round(rr,2)))
  print(noquote(paste("Intervalle de Confiance de l'OR: [",orm,";",orp,"]")))
  print(noquote(paste("Intervalle de Confiance du RR: [",rrm,";",rrp,"]")))
  print(noquote(paste("p-value: ",chisq.test(v[,1],v[,2])[[3]])))
  print(noquote(paste("Les effectifs th?oriques sont :"
                      ,round(et1,1),round(et2,1),round(et3,1),round(et4,1),sep=" ")))
  {
    if ((et1)<=5) print("ATTENTION UN DES EFFECTIFS THEORIQUE EST INFERIEUR A 5 !")
    if ((et2)<=5) print("ATTENTION UN DES EFFECTIFS THEORIQUE EST INFERIEUR A 5 !")
    if ((et3)<=5) print("ATTENTION UN DES EFFECTIFS THEORIQUE EST INFERIEUR A 5 !")
    if ((et4)<=5) print("ATTENTION UN DES EFFECTIFS THEORIQUE EST INFERIEUR A 5 !")
  }
}
####_____FIN

####____elu par cette crapule

inverse<-function(x)
{
  y<-as.factor("")
  x<-rev(unlist(strsplit(x,NULL)))
  for (i in 1:length(x)) y<-paste(y,x[i],sep="")
  return(y)
  #rm(x,y)
}
####____FIN

### Met en forme les tableaux flextable pour les sorties MARKDOWN en Word
FitFlextableToPage <- function(ft, pgwidth = 6){
  ft_out <- ft %>% autofit(add_w=0.05,add_h=0.05)
  ft_out <- width(ft_out, width = dim(ft_out)$widths*6.5/(flextable_dim(ft_out)$widths))
  ft_out= flextable::fontsize(ft_out,size = 7.5, part = "all")
  return(ft_out)
}

######## SORTIE TABLEAU POUR MARKDOWN

md_table=function(df,fit=TRUE,header=TRUE,bold.h=TRUE,text.size=7.5,bold.names=NULL,bold.row=NULL,bold.col=NULL,zebra=F){
  ft <-flextable(as.data.frame(df))
  if(zebra==T){
    ft=theme_zebra(ft)
  }
  if (header==T & bold.h==T){
    ft <- bold(ft, bold = TRUE, part = "header")
  }
  if(!is.null(bold.names)){
    for(k in bold.names){ft <- bold(ft, i=k,j=1, bold = TRUE, part = "body")}
  }
  if(!is.null(bold.row)){
    for(k in bold.row){ft <- bold(ft, i=k, bold = TRUE, part = "body")}
  }
  if(!is.null(bold.col)){
    for(k in bold.col){ft <- bold(ft, j=k, bold = TRUE, part = "body")}
  }
  ft <- align(ft, align = "left", part = "all" )
  ft <- autofit(ft,add_w=0.05,add_h=0.05)
  if(header==F){
    ft <- delete_part(x = ft, part = "header")
  }
  if (fit==TRUE){
    ft=FitFlextableToPage(ft) ## à utiliser si le tableau dépasse des marges
  }
  ft= flextable::fontsize(ft,size = text.size, part = "all")
  # ft=vline(ft, j = 1, border = fp_border(color = "black", style = "solid", width = 1), part = "all")
  return(ft)
}


#barplotquali<-function(x)
#{
##rep<-readline(cat("Quelle couleur?\nVert tapez green\nRouge tapez red\nBleu tapez blue\nGris tapez grey "))
#if (is.data.frame(x)==FALSE)
#{
#{if (is.factor(x)==TRUE)
#{#par(bg="tan");
#barplot(noquote(table(x)/length(x)),col="blue",
#main=names(noquote(x)),xlab="",ylab="Fr?quence relative",las=3)}#xlab=paste("Modalit?s de ", names(noquote(x))),
#else
#stop("Votre variable n'est pas as.factor Fonction impossible")}
#}
#else
#{
#k<-0
#kk<-0
#kkk<-0
#xx<-length(x)
#
#for(i in 1:xx) {if (is.factor(noquote(x)[,i])==TRUE) k<-k+1};
#if (k==0) stop("Aucune variable n'est QUALITATIVE (as.factor) - Utilisez la fonction histoquanti")
#kk<-ceiling(sqrt(k))
#if (kk*(kk-1)>=k) kkk<-(kk-1) else kkk<-kk
#par(mfrow=c(kkk,kk))#,bg="tan")
#for(i in 1:xx) {if (is.factor(noquote(x)[,i])==TRUE) barplot(noquote(table(x)/length(x))[,i],col="blue",
#main=names(noquote(x)[i]),xlab="",ylab="Fr?quense absolue",las=3)}#xlab=paste("Modalit?s de ", names(noquote(x)[i]))
#}
##rm(x,xx,k,kk,kkk,cc,i,j,h,rep)
#}
#####____FIN


####____diagramme de HILLS sans variable ajust?e

hillstab<-function(x,y)		## arguments de la fonct x=nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a inclure dans le diagramme par exemple(c(1,2,4:10,13:20))
{
  xx<-x[,y]
  k<-0
  v<-vector(length=(length(y)*(length(y)-1)/2))
  for(i in 1:(length(y)-1)) for(j in (i+1):length(y))
  {
    k<-k+1
    v[k]<-cor.test(xx[,i],xx[,j])[[3]]
  }
  plot(1:(length(y)*(length(y)-1)/2),1-rev(sort(v)),xlab="Nombre des produits cart?siens de toutes les corr?lations possibles 2 ? 2",ylab="1 - p-value",main="Diagramme de HILLS")
  points(1:(length(y)*(length(y)-1)/2),1-rev(sort(v)),bg="green",pch=22)
  abline(0,1/(length(y)*(length(y)-1)/2),col="red")
  #rm(x,xx,y,i,j)
}
####____FIN

####____F.D.R (False Discovery Rate)

fdrtab<-function(x,y,z)		## arguments de la fonct 
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a inclure dans le diagramme par exemple(c(1,2,4:10,13:20))
  ## z= pourcentage (0.1=10%) de r?sultats faussement positifs
{
  xx<-x[,y]
  k<-0
  v<-vector(length=(length(y)*(length(y)-1)/2))
  #voir<-vector(length=(length(y)*(length(y)-1)/2))
  for(i in 1:(length(y)-1)) for(j in (i+1):length(y))
  {
    k<-k+1
    v[k]<-cor.test(xx[,i],xx[,j])[[3]]
  }
  f<-0
  for(d in 1:length(v)) {if (sort(v)[d]<(d*z/length(v))) f<f+1 else break}
  voir<-vector(length=f)
  for(d in 1:length(v)) {if (sort(v)[d]<(d*z/length(v))) voir[d]<-round(v[d],3) else break}
  print(rev(sort(voir)))
  #rm(x,xx,y,i,j,d,f,v,voir)
}
####____FIN

####____Calcul des O.R et leur IC sur les coefficients d'une r?gression logistique

orcoef<-function(x)
{
  for (i in 2:dim(summary(x)$coefficients)[1])
  {
    nom<-(dimnames(summary(x)$coefficients)[[1]][i])
    or<-round((exp(summary(x)$coefficients[i,1])),3)
    icp<-round((exp(summary(x)$coefficients[i,1]+1.96*summary(x)$coefficients[i,2])),3)
    icm<-round((exp(summary(x)$coefficients[i,1]-1.96*summary(x)$coefficients[i,2])),3)
    print(noquote(paste("L'Odds-Ratio ajust? de ",nom,": ",or," IC: [",icm,"  ",icp,"]",sep="")))
  }
}
####____FIN

####____Graphique de Bland et Altman

bland<-function(x,a,b)	# x nom du fichier
  # y nom de la colonne clinicien num 1
  # z nom de la colonne clinicien num 2
{
  amoinsb<-(x[,a]-x[,b])
  moyab<-(x[,a]+x[,b])/2
  ordo<-noquote(paste(names(x[a]),"moins",names(x[b])))
  abs<-noquote(paste("Moyenne de",names(x[a]),"plus",names(x[b])))
  reglin<-lm(amoinsb~moyab)
  maxi<-round((mean(amoinsb)+3*sd(amoinsb)),1)
  labmaxi<-round((mean(amoinsb)+2.5*sd(amoinsb)),1)
  mini<-round((mean(amoinsb)-3*sd(amoinsb)),1)
  labmini<-round((mean(amoinsb)-2.1*sd(amoinsb)),1)
  par(bg="lightyellow3")
  plot(moyab,amoinsb,ylim=c(mini,maxi),col="red",ylab=ordo,xlab=abs,main="Diagramme de Bland et Altman")
  legend(min(moyab),labmaxi,"Plus 2 EcType")
  legend(min(moyab),labmini,"Moins 2 EcType")
  abline(reglin,lwd=2,col="red")
  abline(mean(amoinsb),0,lty=2,col="blue")
  abline(mean(amoinsb)+2*sd(amoinsb),0,lty=2,col="blue")
  abline(mean(amoinsb)-2*sd(amoinsb),0,lty=2,col="blue")
}
####____FIN

######################################################################################################################################################
####################################################################### COEFFICIENT DE CORRELATION ###################################################
######################################################################################################################################################


####____tableaux des CORRELATION de Pearson entre variables QUANTITATIVES

cortab<-function(x,y)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 ? 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],use="pairwise.complete.obs"),2));
  abs<-c("Cor_Pearson",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  k<-1;for(i in y[c(1:length(y)-1)])
  {k<-k+1}
  # for(j in y[c(k:length(y))])
  # {print(paste("p.value: variables test?es",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j])$p.value)
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortab.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/cortab.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  return(as.data.frame(tt))

}





####____FIN

####____tableaux des CORRELATION de Pearson entre variables QUANTITATIVES

cortabt<-function(x,y,nomdefichier)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 ? 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],use="pairwise.complete.obs"),2));
  abs<-c("Cor_Pearson",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  k<-1;for(i in y[c(1:length(y)-1)])
  {k<-k+1;for(j in y[c(k:length(y))])
  {print(paste("p.value: variables test?es:",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j])$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortab.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/cortab.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  ##print(noquote(tt))
}


###########################################################################
cortab_p<-function(x,y,nomdefichier)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 ? 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],use="pairwise.complete.obs"),2));
  abs<-c("Cor_Pearson",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  p2<-matrix(data="NA")
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  k<-1;for(i in y[c(1:length(y)-1)])
  {
    k<-k+1;for(j in y[c(k:length(y))])
    {
      p<-paste("p.value (",names(x[i]),"-",names(x[j]),") :",round(cor.test(x[,i],x[,j])$p.value,2))
      p2<-rbind(p2,p)
    }
  }
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  ##print(noquote(tt));
  #print(noquote(p2));
  #{
  #write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
  #write.table(p2,paste(file_pour_les_tables_resultats,"table_p_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
  #}
}


###########################################################################
cortabSPEARMAN_p<-function(x,y,nomdefichier)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 ? 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],use="pairwise.complete.obs",method="spearman"),2));
  abs<-c("Cor_Spearman",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  p2<-matrix(data="NA")
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  k<-1;for(i in y[c(1:length(y)-1)])
  {
    k<-k+1;for(j in y[c(k:length(y))])
    {
      
      
      p<-paste(
        "p.value(",names(x[i]),"-",names(x[j]),") :",
        ifelse((cor.test(x[,i],x[,j],method="spearman")$p.value)<0.0001,"<0.0001",
               round((cor.test(x[,i],x[,j],method="spearman")$p.value),5)
        ),sep="")
      
      
      print(noquote(p2))
      print("stop")
      p2<-rbind(p2,p)
      p2<-as.matrix(p2)
      p2[[1]]<-c("p-value (Spearman)")
      p2<-noquote(p2)
    }
  }
  
  #####
  # Envoyer le tableau dans MARKDOWN
  print(tt)
  ft <- flextable(as.data.frame(tt))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  #####
  
  return(ft)
  #####
  
  ##print(noquote(tt));
  #print(noquote(p2));
}



####____tableaux des CORRELATION de spearman entre variables QUANTITATIVES

cortabspearman<-function(x,y)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 a 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],method="spearman",use="pairwise.complete.obs"),2));
  abs<-c("Cor_spearman",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  k<-1;for(i in y[c(1:length(y)-1)])
  {k<-k+1;for(j in y[c(k:length(y))])
  {print(paste("p.value: variables testees:",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j],method="spearman")$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortabis.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/cortabis.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  print(tt)
  ft <- flextable(as.data.frame(tt))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  #####
  
  return(ft)
  #####
  
  ##print(noquote(tt));
}
####____FIN

cortabspearmant<-function(x,y,nomdefichier)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 a 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],method="spearman",use="pairwise.complete.obs"),2));
  abs<-c("Cor_spearman",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  k<-1;for(i in y[c(1:length(y)-1)])
  {k<-k+1;for(j in y[c(k:length(y))])
  {print(paste("p.value: variables testees:",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j],method="spearman")$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortabis.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/cortabis.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  print(tt)
  ft <- flextable(as.data.frame(tt))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  #####
  
  return(ft)
  #####
  
  ##print(noquote(tt));
  
  {write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
    #rm(x,y,k)
  }
}
######################################################################################################################################################
######################################################################################################################################################
######################################################################################################################################################
####____tableaux des CORRELATION partielle entre variables QUANTITATIVES

cortabPARTIELLE<-function(x,y)		## arguments de la fonct
  ## x= matrice des varaiables ? corr?l?er entre elles 2 ? 2
  ## y= variables d'ajustement (une seule)
{
  mod1 <- lm(x~y)$residuals        
  t<-(round(cor(mod1,mod1,use="pairwise.complete.obs"),3));
  abs<-c("Cor_Partielle",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  #k<-1;for(i in y[c(1:length(y)-1)])
  #{k<-k+1;for(j in y[c(k:length(y))])
  #{print(paste("p.value: variables test?es",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j])$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortab.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau# pour le r?cup?rer sous word
  #edit(file="D:/R/cortab.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  print(tt)
  ft <- flextable(as.data.frame(tt))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  #####
  
  return(ft)
  #####
  
  ##print(noquote(tt));
  #rm(x,y,k)
}

cortabPARTIELLEt<-function(x,y,nomdefichier)		## arguments de la fonct
  ## x= matrice des varaiables ? corr?l?er entre elles 2 ? 2
  ## y= variables d'ajustement (une seule)
{
  mod1 <- lm(x~y)$residuals
  t<-(round(cor(mod1,mod1,use="pairwise.complete.obs"),3));
  abs<-c("Cor_Partielle",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  #k<-1;for(i in y[c(1:length(y)-1)])
  #{k<-k+1;for(j in y[c(k:length(y))])
  #{print(paste("p.value: variables test?es",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j])$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortab.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau# pour le r?cup?rer sous word
  #edit(file="D:/R/cortab.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  ##print(noquote(tt));
  {write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
    #rm(x,y,k)
  }
}

###############################
#Comparaison de 2 correlations#
###############################
p_cortabPARTIELLE<-function(x,y,z,w)		## arguments de la fonct
  ## x= matrice des varaiables ? corr?l?er entre elles 2 ? 2
  ## y= variables d'ajustement (une seule)
{
  mod1 <- lm(x~y)$residuals
  w1<-(round(cor(mod1,mod1,use="pairwise.complete.obs"),3));
  mod2 <- lm(z~w)$residuals
  z1<-0.5*log((1+w1)/(1-w1))
  w2<-(round(cor(mod2,mod2,use="pairwise.complete.obs"),3));
  z2<-0.5*log((1+w2)/(1-w2))
  z3<-(z1-z2)/((1/(dim(x)[1]-3)^0.5+(1/(dim(z)[1]-3)^0.5)))
  z4<-round(1-pnorm(z3),3)
  abs<-c("Diff-cor_p-value",dimnames(z4)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(z4)[[1]]),nc=length(dimnames(z4)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(z4)[[1]])),abs)
  for (i in 1:length(dimnames(z4)[[1]])) {tt[i,1]<-dimnames(z4)[[1]][i]; tt[,i+1]<-z4[,i]}
  #k<-1;for(i in y[c(1:length(y)-1)])
  #{k<-k+1;for(j in y[c(k:length(y))])
  #{print(paste("p.value: variables test?es",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j])$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortab.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau# pour le r?cup?rer sous word
  #edit(file="D:/R/cortab.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  print(tt)
  ft <- flextable(as.data.frame(tt))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  #####
  
  return(ft)
  #####
  
  ##print(noquote(tt));
  #rm(x,y,k)
}


p_cortabPARTIELLEt<-function(x,y,z,w,nomdefichier)		## arguments de la fonct
  ## x= matrice des varaiables ? corr?l?er entre elles 2 ? 2
  ## y= variables d'ajustement (une seule)
{
  mod1 <- lm(x~y)$residuals
  w1<-(round(cor(mod1,mod1,use="pairwise.complete.obs"),3));
  mod2 <- lm(z~w)$residuals
  z1<-0.5*log((1+w1)/(1-w1))
  w2<-(round(cor(mod2,mod2,use="pairwise.complete.obs"),3));
  z2<-0.5*log((1+w2)/(1-w2))
  z3<-(z1-z2)/((1/(dim(x)[1]-3)^0.5+(1/(dim(z)[1]-3)^0.5)))
  z4<-round(1-pnorm(z3),3)
  abs<-c("Diff-cor_p-value",dimnames(z4)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(z4)[[1]]),nc=length(dimnames(z4)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(z4)[[1]])),abs)
  for (i in 1:length(dimnames(z4)[[1]])) {tt[i,1]<-dimnames(z4)[[1]][i]; tt[,i+1]<-z4[,i]}
  #k<-1;for(i in y[c(1:length(y)-1)])
  #{k<-k+1;for(j in y[c(k:length(y))])
  #{print(paste("p.value: variables test?es",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j])$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortab.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau# pour le r?cup?rer sous word
  #edit(file="D:/R/cortab.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  print(tt)
  ft <- flextable(as.data.frame(tt))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  #####
  
  return(ft)
  #####
  
  ##print(noquote(tt));
  {write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
    #rm(x,y,k)
  }
}

######################################################################################################################################################
####################################################################### SORTIE VARIABLE QUALITATIVE #################################################
######################################################################################################################################################

####_____affiche une repr?sentation en barres des variables qualitatives (BLEU)

plotquali<-function(x)
{
  #rep<-readline(cat("Quelle couleur?\nVert tapez green\nRouge tapez red\nBleu tapez blue\nGris tapez grey "))
  if (is.data.frame(x)==FALSE)
  {
    {if (is.factor(x)==TRUE)
    {#par(bg="tan");
      plot(noquote(x),col="blue",
           main=names(noquote(x)),xlab="",ylab="Fr?quense absolue",las=3)}#xlab=paste("Modalit?s de ", names(noquote(x))),
      else
        stop("Votre variable n'est pas as.factor Fonction impossible")}
  }
  else
  {
    k<-0
    kk<-0
    kkk<-0
    xx<-length(x)
    
    for(i in 1:xx) {if (is.factor(noquote(x)[,i])==TRUE) k<-k+1};
    if (k==0) stop("Aucune variable n'est QUALITATIVE (as.factor) - Utilisez la fonction histoquanti")
    kk<-ceiling(sqrt(k))
    if (kk*(kk-1)>=k) kkk<-(kk-1) else kkk<-kk
    par(mfrow=c(kkk,kk))#,bg="tan")
    for(i in 1:xx) {if (is.factor(noquote(x)[,i])==TRUE) plot(noquote(x)[,i],col="blue",
                                                              main=names(noquote(x)[i]),xlab="",ylab="Fr?quense absolue",las=3)}#xlab=paste("Modalit?s de ", names(noquote(x)[i]))
  }
  #rm(x,xx,k,kk,kkk,cc,i,j,h,rep)
}
####____FIN


plotqualit<-function(x,nomdefichier)
{
  rep<-c("blue")
  if (is.data.frame(x)==FALSE)
  {
    {if (is.factor(x)==TRUE)
    {#par(bg="tan");
      plot(noquote(x),col=rep,
           main=names(noquote(x)),xlab="",ylab="Fr?quense absolue",las=3)}#xlab=paste("Modalit?s de ", names(noquote(x))),
      else
        stop("Votre variable n'est pas as.factor Fonction impossible")}
  }
  else
  {
    k<-0
    kk<-0
    kkk<-0
    xx<-length(x)
    
    for(i in 1:xx) {if (is.factor(noquote(x)[,i])==TRUE) k<-k+1};
    if (k==0) stop("Aucune variable n'est QUALITATIVE (as.factor) - Utilisez la fonction histoquanti")
    kk<-ceiling(sqrt(k))
    if (kk*(kk-1)>=k) kkk<-(kk-1) else kkk<-kk
    par(mfrow=c(kkk,kk))#,bg="tan")
    for(i in 1:xx) {if (is.factor(noquote(x)[,i])==TRUE) plot(noquote(x)[,i],col=rep,
                                                              main=names(noquote(x)[i]),xlab="",ylab="Fr?quense absolue",las=3)}#xlab=paste("Modalit?s de ", names(noquote(x)[i]))
    savePlot(filename = paste(file_pour_les_tables_resultats,nomdefichier,sep=""),type = c("emf"),device = dev.cur(),restoreConsole = T)
  }
  #rm(x,xx,k,kk,kkk,i,rep,nomdefichier)
  rm(x,xx,k,kk,kkk,i,nomdefichier)
}
####____FIN

####_____affiche une repr?sentation en SECTEUR des variables qualitatives

secteurquali<-function(x)
{
  if (is.data.frame(x)==FALSE)
  {
    {if (is.vector(x)==TRUE)
    {{cc<-table(x)
    h<-0; for (j in 1:length(cc)) {h<-h+cc[[j]]}; etiquette<-NULL
    for (j in 1:length(cc)) {etiquette<-c(etiquette,paste(names(cc)[j],": ",round(cc[[j]]*100/h,1),"%",sep="")) };
    pie(cc,main=paste("R?partition en pourcentage"),labels=etiquette)}
    }
      else
        stop(paste("Votre variable n'est ni un vector ni une Data.frame"," ","Fonction impossible"))}
  }
  else
  {
    k<-0
    kk<-0
    kkk<-0
    xx<-length(x)
    
    for(i in 1:xx) {if (is.factor(noquote(x)[,i])==TRUE) k<-k+1};
    if (k==0) stop("Aucune variable n'est QUALITATIVE (as.factor) - Utilisez la fonction histoquanti")
    kk<-ceiling(sqrt(k))
    if (kk*(kk-1)>=k) kkk<-(kk-1) else kkk<-kk
    par(mfrow=c(kk,kkk))#,bg="tan")
    for(i in 1:xx) {if (is.factor(noquote(x)[,i])==TRUE){cc<-table(x[i])
    h<-0; for (j in 1:length(cc)) {h<-h+cc[[j]]}; etiquette<-NULL
    for (j in 1:length(cc)) {etiquette<-c(etiquette,paste(names(cc)[j],": ",round(cc[[j]]*100/h,1),"%",sep="")) };
    pie(cc,main=paste("R?partition de",dimnames(x)[[2]][i],"en pourcentage"),labels=etiquette)
    }}}
  #rm(x,xx,k,kk,kkk,h,cc,i,j)
}
####____FIN


####____Tableau des var QUALI avec Nbre et Pourcentage

sortiequali<-function(x,y)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonnes des variables QUALITATIVES
{
  g <- NULL
  k <- NULL
  
  for (i in y)
    if (sapply(x[i], data.class)[[1]] == "factor")
    {
      k <- length(table(x[i]))
      g <- c(g, "")
      
      for (j in 1:k)
        g <-
        c(g, ifelse(names(table(x[i])[j]) == "", "Vide", names(table(x[i])[j])))
    }
  tt <- matrix(data = "NA", nr = length(g), nc = 5)
  
  dimnames(tt) <-
    list(c(1:length(g)),
         c("Variable", "Modalite", "Nombre", "Frequence", "Vide"))
  j <- 0
  for (i in y)
    if (is.factor(x[, i]))
    {
      k <-
        length(table(x[i])) + 1
      h <- 0
      for (z in 1:(k - 1))
        h <- (h + table(x[i])[[z]])
      
      for (z in 1:k)
      {
        tt[j + z, 1] <-
          ifelse(z == 1, dimnames(x)[[2]][i], "")
        tt[j + z, 2] <-
          ifelse(z > 1, ifelse(names(table(x[i])[z - 1]) == "", "Vide", names(table(x[i])[z - 1])), "")
        tt[j + z, 3] <-
          ifelse(z > 1, table(x[i])[[z - 1]], "")
        tt[j + z, 4] <-
          ifelse(z > 1, paste(round(table(x[i])[[z - 1]] * 100 / h, 2), "%", sep =""), "")
        tt[j + z, 5] <-
          ifelse(z == 1, paste(length(x[i][is.na(x[i])]), " (", 100 * (round(
            length(x[i][is.na(x[i])]) / dim(x[i])[[1]], 4)), "%", ")", sep = ""), "")
      }
      j <- j + k
    }

  ###print(noquote(tt));
  return(as.data.frame(tt))
  rm(g,k,i,j,tt,z,x,y)
}
####____FIN


####____Tableau des var QUALI avec Nbre et Pourcentage Nombre de caracterees limit?s

sortiequalimit<-function(x,y)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonnes des variables QUALITATIVES
{
  g<-NULL;k<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="factor") 
  {k<-length(table(x[i])); g<-c(g,"");
  for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("Variable","Modalite","Nombre","Frequence","Vide"))
  j<-0;for (i in y) if (is.factor(x[,i])) 
  {k<-length(table(x[i]))+1;h<-0;for (z in 1:(k-1)) h<-(h+table(x[i])[[z]]);
  for (z in 1:k)
  {tt[j+z,1]<-ifelse(z==1,substr(dimnames(x)[[2]][i],1,30),"") ;tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", substr(names(table(x[i])[z-1]),1,30 )),""); tt[j+z,3]<-ifelse(z>1,table(x[i])[[z-1]],""); tt[j+z,4]<-ifelse(z>1,paste(round(table(x[i])[[z-1]]*100/h,2),"%",sep=""),"");tt[j+z,5]<-ifelse(z==1,paste(length(x[i][is.na(x[i])]),"(",100*(round(length(x[i][is.na(x[i])])/dim(x[i])[[1]],4)),"%",")",sep=""),"")};j<-j+k}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquali.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquali.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  #print(noquote(tt));
  return(as.data.frame(tt))
  rm(g,k,i,j,tt,z,x,y)
}
####____FIN

####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value) avec test de FISHER

sortiequalibiFISHERlimit<-function(x,y,w)## arguments de la fonction
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality",paste(names(table(x[,y]))[1]),paste(names(table(x[,y]))[2]),"p-FISHER" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,substr(dimnames(x)[[2]][i],1,30),"") ; tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", substr(names(table(x[i])[z-1]),1,15) ),""); tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/a,2) ,"%)",sep=""),""); tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/b,2) ,"%)",sep=""),""); tt[j+z,5]<-ifelse(z>1,"-",ifelse(fisher.test(x[,i],x[,y])[[1]]<0.0001,"<0.0001", round(fisher.test(x[,i],x[,y])[[1]],5)))}; j<-j+k}
    
    #####
    # Envoyer le tableau dans MARKDOWN
    ft <- flextable(as.data.frame(tt));
    ft <- autofit(ft);
    saveRDS(ft, file = "my_data.rds");
    #####
    
    #print(noquote(tt));
    rm(a,b,g,k,i,j,tt,z,x,y,w)
}


####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value) avec test de FISHER
sortiequalibilimit<-function(x,y,w)## arguments de la fonction
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality",paste(names(table(x[,y]))[1]),paste(names(table(x[,y]))[2]),"p-Chi2" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,substr(dimnames(x)[[2]][i],1,30),"") ; tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", substr(names(table(x[i])[z-1]),1,15) ),""); tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/a,2) ,"%)",sep=""),""); tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/b,2) ,"%)",sep=""),""); tt[j+z,5]<-ifelse(z>1,"-",ifelse(chisq.test(x[,i],x[,y],correct=T)[[3]]<0.0001,"<0.0001", round(chisq.test(x[,i],x[,y],correct=T)[[3]],5)))}; j<-j+k}
    
    #####
    # Envoyer le tableau dans MARKDOWN
    ft <- flextable(as.data.frame(tt));
    ft <- autofit(ft);
    saveRDS(ft, file = "my_data.rds");
    #####
    
    #print(noquote(tt));
    rm(a,b,g,k,i,j,tt,z,x,y,w)
}

####____FIN

####____Tableau des var QUALI avec Nbre et Pourcentage

sortiequalit<-function(x,y,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonnes des variables QUALITATIVES
{
  g<-NULL;k<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="factor")
  {k<-length(table(x[i])); g<-c(g,"");
  for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("Variable","Modalite","Nombre","Frequence","Vide"))
  j<-0;for (i in y) if (is.factor(x[,i]))
  {k<-length(table(x[i]))+1;h<-0;for (z in 1:(k-1)) h<-(h+table(x[i])[[z]]);
  for (z in 1:k)
  {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ;tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); tt[j+z,3]<-ifelse(z>1,table(x[i])[[z-1]],""); tt[j+z,4]<-ifelse(z>1,paste(round(table(x[i])[[z-1]]*100/h,2),"%",sep=""),"");   tt[j+z,5]<-ifelse(z==1,paste(length(x[i][is.na(x[i])]),"(",100*(round(length(x[i][is.na(x[i])])/dim(x[i])[[1]],2)),"%",")",sep=""),"")};j<-j+k}
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
  ;
  rm(g,k,i,j,tt,z,x,y,nomdefichier)
}

####____FIN

####____Tableau des var QUALI avec Nbre et Pourcentage

sortiequalitenglish<-function(x,y,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonnes des variables QUALITATIVES
{
  g<-NULL;k<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="factor")
  {k<-length(table(x[i])); g<-c(g,"");
  for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Unknown", names(table(x[i])[j])))}
  tt<-matrix(data="NA",nr=length(g),nc=4);
  dimnames(tt)<-list(c(1:length(g)),c("Variable","Description","No. Patients","Percent"))
  j<-0;for (i in y) if (is.factor(x[,i]))
  {k<-length(table(x[i]))+1;h<-0;for (z in 1:(k-1)) h<-(h+table(x[i])[[z]]);
  for (z in 1:k)
  {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); tt[j+z,3]<-ifelse(z>1,table(x[i])[[z-1]],""); tt[j+z,4]<-ifelse(z>1,paste(round(table(x[i])[[z-1]]*100/h,2),"%",sep=""),"")};j<-j+k}
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
  ;
  rm(g,k,i,j,tt,z,x,y,nomdefichier)
}
####____FIN

####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value)

sortiequalibi<-function(x,y,w,na.col=FALSE)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUALITATIVES
  
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p-Chi2" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/a,2) ,"%)",sep=""),""); tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/b,2) ,"%)",sep=""),""); 
    
    tt[j+z,5]<-ifelse(z>1,"-",
                      ifelse(chisq.test(x[,i],x[,y],correct=T)[[3]]<0.0001,"<0.0001****",
                             ifelse(chisq.test(x[,i],x[,y],correct=T)[[3]]<0.001,"<0.001***",
                                    ifelse(chisq.test(x[,i],x[,y],correct=T)[[3]]<0.01,paste(round(chisq.test(x[,i],x[,y],correct=T)[[3]],5),"**"), 
                                           ifelse(chisq.test(x[,i],x[,y],correct=T)[[3]]<0.05,paste(round(chisq.test(x[,i],x[,y],correct=T)[[3]],5),"*"),
                                                  ifelse(chisq.test(x[,i],x[,y],correct=T)[[3]]<0.10,paste(round(chisq.test(x[,i],x[,y],correct=T)[[3]],5),"TREND"),
                                                         round(chisq.test(x[,i],x[,y],correct=T)[[3]],5))))))
    )
    
    }
    
    ; j<-j+k}
    tt=as.data.frame(tt)
    if(na.col==TRUE){
      tt[,"Vide"]=""
      tt[,1]=as.character(tt[,1])
      vars=tt[,1][which(tt[,1]%in% colnames(x)==T)]
      for (i in vars){
        na_number=sum(is.na(x[,i]))
        phrase=paste0(na_number," (",round(na_number/nrow(x)*100,2),"%)")
        tt[which(tt[,1]==i),"Vide"]=phrase
      }
    }
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    ###print(noquote(tt));
    return(tt)
    rm(a,b,g,k,i,j,tt,z,x,y,w)
}
####____FIN

####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value)

sortiequalibit<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUALITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p-Chi2" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/a,2) ,"%)",sep=""),""); tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/b,2) ,"%)",sep=""),""); tt[j+z,5]<-ifelse(z>1,"-",ifelse(chisq.test(x[,i],x[,y],correct=T)[[3]]<0.0001,"<0.0001", round(chisq.test(x[,i],x[,y],correct=T)[[3]],5)))}; j<-j+k}
    write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word ;
    rm(a,b,g,k,i,j,tt,z,x,y,w,nomdefichier)
}
####____FIN

####____Tableau QUALI x VAR DICHOTOMIQUE pourcentage en ligne (n pourc p-value)

sortiequalibi2<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUALITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[3]]; b<-table(x[,y])[[4]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("VARIABLE","MODALITE",names(table(x[,y]))[1],names(table(x[,y]))[2],"p-Chi2" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/a,2) ,"%)",sep=""),""); tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/b,2) ,"%)",sep=""),""); tt[j+z,5]<-ifelse(z>1,"-",ifelse(chisq.test(x[,i],x[,y],correct=T)[[3]]<0.0001,"<0.0001", round(chisq.test(x[,i],x[,y],correct=T)[[3]],5)))}; j<-j+k}
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    #####
    # Envoyer le tableau dans MARKDOWN
    ft <- flextable(as.data.frame(tt));
    ft <- autofit(ft);
    saveRDS(ft, file = "my_data.rds");
    #####
    
    #print(noquote(tt));
    rm(a,b,g,k,i,j,tt,z,x,y,w)
}
####____FIN

####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value) avec test de FISHER

sortiequalibiFISHER<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUALITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p-Fisher" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/a,2) ,"%)",sep=""),""); 
    tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/b,2) ,"%)",sep=""),""); 
    
    tt[j+z,5]<-ifelse(z>1,"-",
                      ifelse(fisher.test(x[,i],x[,y])[[1]]<0.0001,"<0.0001****",
                             ifelse(fisher.test(x[,i],x[,y])[[1]]<0.001,"<0.001***",
                                    ifelse(fisher.test(x[,i],x[,y])[[1]]<0.01,paste(round(fisher.test(x[,i],x[,y])[[1]],5),"**"), 
                                           ifelse(fisher.test(x[,i],x[,y])[[1]]<0.05,paste(round(fisher.test(x[,i],x[,y])[[1]],5),"*"),
                                                  ifelse(fisher.test(x[,i],x[,y])[[1]]<0.10,paste(round(fisher.test(x[,i],x[,y])[[1]],5),"TREND"),
                                                         round(fisher.test(x[,i],x[,y])[[1]],5))))))
    )
    }; j<-j+k}
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    #####
    # Envoyer le tableau dans MARKDOWN
    return(as.data.frame(tt))

    #####
    
    #print(noquote(tt));
    rm(a,b,g,k,i,j,tt,z,x,y,w)
}

####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value) avec test de FISHER

sortiequalibiFISHERt<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUALITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p-Fisher" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/a,2) ,"%)",sep=""),""); tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/b,2) ,"%)",sep=""),""); tt[j+z,5]<-ifelse(z>1,"-",ifelse(fisher.test(x[,i],x[,y])[[1]]<0.0001,"<0.0001", round(fisher.test(x[,i],x[,y])[[1]],5)))}; j<-j+k}
    write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
    ;
    rm(a,b,g,k,i,j,tt,z,x,y,w,nomdefichier)
}
####____FIN

####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value)

sortiequalibiFISHERt_pourcent_ligne<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUALITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p-Fisher" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/ ( table(x[,i],x[,y])[z-1,1]+ table(x[,i],x[,y])[z-1,2]) ,2) ,"%)",sep=""),""); tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/( table(x[,i],x[,y])[z-1,2]+ table(x[,i],x[,y])[ z-1,1]),2) ,"%)",sep=""),""); tt[j+z,5]<-ifelse(z>1,"-",ifelse(fisher.test(x[,i],x[,y])[[1]]<0.0001,"<0.0001", round(fisher.test(x[,i],x[,y])[[1]],5)))}; j<-j+k}
    write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word ;
    #rm(a,b,g,k,i,j,tt,z,x,y,w,nomdefichier)
}
####____FIN





####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value)

sortiequalibiARTICLE<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUALITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality","OR","CI95%","p-RegLog" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ;
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),"");
      tt[j+z,3]<-ifelse(z==1,"",
                        ifelse(z==2,"1",
                               signif(exp(summary(glm(x[,y]~x[,i],family="binomial"))$coefficients[[z-1]]),2)
                        )
      );
      tt[j+z,4]<-ifelse(z==1,"",
                        ifelse(z==2,"-",
                               paste("[",signif(exp(((summary(glm(x[,y]~x[,i],family="binomial"))$coefficients[[z-1]])
                                                     -2*(summary(glm(x[,y]~x[,i],family="binomial"))$coefficients
                                                         [[length(summary(glm(x[,y]~x[,i],family="binomial"))$coefficients)*1/4+(z-1)
                                                           ]]))),2),"-",signif(exp(((summary(glm(x[,y]~x[,i],family="binomial"))$coefficients[[z-1]])
                                                                                    +2*(summary(glm(x[,y]~x[,i],family="binomial"))$coefficients
                                                                                        [[length(summary(glm(x[,y]~x[,i],family="binomial"))$coefficients)*1/4+(z-1)
                                                                                          ]]))),2),"]"))
      );
      
      tt[j+z,5]<-ifelse(z==1,"",
                        ifelse(z==2,"-",
                               signif(
                                 summary(glm(x[,y]~x[,i],family="binomial"))$coefficients
                                 [[length(summary(glm(x[,y]~x[,i],family="binomial"))$coefficients)*3/4+(z-1)]]
                                 ,2))
      )
    }; j<-j+k
    }
    
    
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    #####
    # Envoyer le tableau dans MARKDOWN
    return(as.data.frame(tt));
    #####
    
    #print(noquote(tt));
    rm(a,b,g,k,i,j,tt,z,x,y,w)
}
####____FIN






####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value)

sortiequalibiARTICLEt<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUALITATIVES
{
  if(sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {
      k<-length(table(x[i]));
      g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
    }
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality","OR","CI95%","p-RegLog" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
      
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ;
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),"");
      tt[j+z,3]<-ifelse(z==1,"",
                        ifelse(z==2,"1",
                               signif(exp(summary(glm(x[,y]~x[,i],family="binomial"))[[13]][[z-1]]),2)
                        )
      );
      tt[j+z,4]<-ifelse(z==1,"",
                        ifelse(z==2,"-",
                               paste("[",signif(exp(((summary(glm(x[,y]~x[,i],family="binomial"))[[13]][[z-1]])
                                                     -2*(summary(glm(x[,y]~x[,i],family="binomial"))[[13]]
                                                         [[length(summary(glm(x[,y]~x[,i],family="binomial"))[[13]])*1/4+(z-1)
                                                           ]]))),2),"-",signif(exp(((summary(glm(x[,y]~x[,i],family="binomial"))[[13]][[z-1]])
                                                                                    +2*(summary(glm(x[,y]~x[,i],family="binomial"))[[13]]
                                                                                        [[length(summary(glm(x[,y]~x[,i],family="binomial"))[[13]])*1/4+(z-1)
                                                                                          ]]))),2),"]"))
      );
      
      tt[j+z,5]<-ifelse(z==1,"",
                        ifelse(z==2,"-",
                               signif(
                                 summary(glm(x[,y]~x[,i],family="binomial"))[[13]]
                                 [[length(summary(glm(x[,y]~x[,i],family="binomial"))[[13]])*3/4+(z-1)]]
                                 ,2))
      )
    }; j<-j+k
    }
    {write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
      # Sauve le tableau pour le r?cup?rer sous word
      rm(a,b,g,k,i,j,tt,z,x,y,w,nomdefichier)
    }
}
####____FIN

####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value)

sortiequalibiARTICLEQUANT<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.numeric(x[,i]))
    {k<-2;
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality","OR","CI95%","p-RegLog" ))
    j<-0;for (i in w) if (is.numeric(x[,i]))
    {k<-3;
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ;
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),"");
      tt[j+z,3]<-ifelse(z==1,"",
                        ifelse(z==2,"1",
                               round(exp(summary(glm(x[,y]~x[,i],family="binomial"))[[13]][[z-1]]),4)
                        )
      );
      tt[j+z,4]<-ifelse(z==1,"",
                        ifelse(z==2,"-",
                               paste("[",round(exp(((summary(glm(x[,y]~x[,i],family="binomial"))[[13]][[z-1]])
                                                    -2*(summary(glm(x[,y]~x[,i],family="binomial"))[[13]]
                                                        [[length(summary(glm(x[,y]~x[,i],family="binomial"))[[13]])*1/4+(z-1)
                                                          ]]))),4),"-",round(exp(((summary(glm(x[,y]~x[,i],family="binomial"))[[13]][[z-1]])
                                                                                  +2*(summary(glm(x[,y]~x[,i],family="binomial"))[[13]]
                                                                                      [[length(summary(glm(x[,y]~x[,i],family="binomial"))[[13]])*1/4+(z-1)
                                                                                        ]]))),4),"]"))
      );
      tt[j+z,5]<-ifelse(z==1,"",
                        ifelse(z==2,"-",
                               round(
                                 summary(glm(x[,y]~x[,i],family="binomial"))[[13]]
                                 [[length(summary(glm(x[,y]~x[,i],family="binomial"))[[13]])*3/4+(z-1)]]
                                 ,4))
      )
    }; j<-j+k
    }
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    #####
    # Envoyer le tableau dans MARKDOWN
    return(as.data.frame(tt));
    ft <- autofit(ft);
    saveRDS(ft, file = "my_data.rds");
    #####
    
    #print(noquote(tt));
    rm(a,b,g,k,i,j,tt,z,x,y,w)
}
####____FIN

####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value)

sortiequalibiARTICLEQUANTt<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATVIES
{
  if(sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.numeric(x[,i]))
    {
      k<-2;
      g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
    }
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality","OR","CI95%","p-RegLog" ))
    j<-0;for (i in w) if (is.numeric(x[,i]))
      
    {k<-3;
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ;
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),"");
      tt[j+z,3]<-ifelse(z==1,"",
                        ifelse(z==2,"1",
                               round(exp(summary(glm(x[,y]~x[,i],family="binomial"))[[13]][[z-1]]),4)
                        )
      );
      tt[j+z,4]<-ifelse(z==1,"",
                        ifelse(z==2,"-",
                               paste("[",round(exp(((summary(glm(x[,y]~x[,i],family="binomial"))[[13]][[z-1]])
                                                    -2*(summary(glm(x[,y]~x[,i],family="binomial"))[[13]]
                                                        [[length(summary(glm(x[,y]~x[,i],family="binomial"))[[13]])*1/4+(z-1)
                                                          ]]))),4),"-",round(exp(((summary(glm(x[,y]~x[,i],family="binomial"))[[13]][[z-1]])
                                                                                  +2*(summary(glm(x[,y]~x[,i],family="binomial"))[[13]]
                                                                                      [[length(summary(glm(x[,y]~x[,i],family="binomial"))[[13]])*1/4+(z-1)
                                                                                        ]]))),4),"]"))
      );
      
      tt[j+z,5]<-ifelse(z==1,"",
                        ifelse(z==2,"-",
                               round(
                                 summary(glm(x[,y]~x[,i],family="binomial"))[[13]]
                                 [[length(summary(glm(x[,y]~x[,i],family="binomial"))[[13]])*3/4+(z-1)]]
                                 ,4))
      )
    }; j<-j+k
    }
    {write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
      # Sauve le tableau pour le r?cup?rer sous word
      rm(a,b,g,k,i,j,tt,z,x,y,w,nomdefichier)
    }
}
####____FIN






####____tableaux des CHI2 entre variables qualitatives

chi2tab<-function(x,y)		## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUALITATIVES
  ## a tester entre elles 2 ? 2 par exemple(c(4,10,13:20))
{
  if (is.data.frame(x[,y])==TRUE)
  {
    for(i in y) {if(is.factor(x[,i])==FALSE) stop(paste("la colonne Num",i,"n'est pas qualitative (=as.factor)"))}
    k<-1
    for(i in y[c(1:length(y)-1)])
    {k<-k+1;for(j in y[c(k:length(y))])
    {print(paste("VARIABLES test?es:",names(x[i]),"-",names(x[j])))
      ;print(chisq.test(x[,i],x[,j])[[3]])}}
  }
  else
    stop("Il faut au moins 2 colonnes")
  #rm(x,y)
}
####____FIN

######################################################################################################################################################
######################################################################################################################################################
######################################################################################################################################################


######################################################################################################################################################
####################################################################### SORTIE VARIABLE QUANTITATIVE #################################################
######################################################################################################################################################

######_______Donne la fr?quence la plus importante=MODE si var quanti

mod<-function(x,y)
{
  k<-0
  for(i in y) {if (is.factor(noquote(x)[,i])==FALSE) k<-k+1}
  if (k==0) stop("Aucune variable n'est QUANTITATIVE")
  for(i in y)
  {z<-noquote(paste(dimnames(table(x[,i]))[[1]][table(x[,i])==max(table(x[,i]))]))
  print(noquote(paste("Mode de '",names(x)[i],"': ",z,sep="")))}
}
######_______FIN

######_______Pour voir les colonnes Factoris?es du fichier

voirfactor<-function(x)
{
  if (is.data.frame(x)==FALSE) stop("Cette fonction est disponible uniquement sur des fichiers comportants plusieurs colonnes")
  print(noquote("Voici les colonnes prises comme QUALITATIVES (as factor=TRUE)"))
  for (j in 1:ceiling(length(x)/4))
  {d<-NULL;for (i in (((j-1)*4)+1):(j*4))
  {if (i<=length(x)) d<-paste(d,names(x[i]),":'",is.factor(x[,i]),"' ",sep="")}
  print(noquote(d))}
}
#rm(x,y,d,i)
######_______FIN

####____Affiche les histogrames des variables num?riques en bleu et l'enregistre sur le dossier sp?cifi?
####____affiche les histogrames des variables num?riques (GRIS)

histoquanti<-function(x)
{
  #rep<-readline(cat("Quelle couleur?\nVert tapez green\nRouge tapez red\nBleu tapez blue\nGris tapez grey "))
  if (is.data.frame(x)==FALSE)
  {
    #par(bg="tan");
    hist(noquote(x),col="blue",main=names(noquote(x)),xlab=names(noquote(x)),labels=TRUE)
  }
  else
  {
    k<-0
    kk<-0
    kkk<-0
    xx<-length(x)
    #sapply(x[y],data.class)[[1]]!="factor"
    #for(i in 1:xx) {if (is.factor(noquote(x)[,i])==FALSE) k<-k+1};
    for(i in 1:xx) {if (sapply(x[i],data.class)[[1]]=="numeric") k<-k+1};
    {if (k==0) stop("Aucune variable n'est QUANTITATIVE - Utilisez la fonction histoquali")}
    kk<-ceiling(sqrt(k))
    {if (kk*(kk-1)>=k) kkk<-(kk-1) else kkk<-kk}
    par(mfrow=c(kk,kkk))#,bg="tan")
    par(xpd=TRUE)
    for(i in 1:xx) {if (sapply(x[i],data.class)[[1]]=="numeric") hist(noquote(x)[,i],col="blue",
                                                                      main=names(noquote(x)[i]),xlab=names(noquote(x)[i]),labels=TRUE)}
  }
  #rm(x,xx,k,kk,kkk,rep)
  rm(x,xx,k,kk,kkk)
}
####____FIN

histoquantit<-function(x,nomdefichier)
{
  rep<-c("blue")
  if (is.data.frame(x)==FALSE)
  {
    #par(bg="tan");
    hist(noquote(x),col=rep,main=names(noquote(x)),xlab=names(noquote(x)))
  }
  else
  {
    k<-0
    kk<-0
    kkk<-0
    xx<-length(x)
    #sapply(x[y],data.class)[[1]]!="factor"
    #for(i in 1:xx) {if (is.factor(noquote(x)[,i])==FALSE) k<-k+1};
    for(i in 1:xx) {if (sapply(x[i],data.class)[[1]]=="numeric") k<-k+1};
    {if (k==0) stop("Aucune variable n'est QUANTITATIVE - Utilisez la fonction histoquali")}
    kk<-ceiling(sqrt(k))
    {if (kk*(kk-1)>=k) kkk<-(kk-1) else kkk<-kk}
    par(mfrow=c(kk,kkk))#,bg="tan")
    par(xpd=TRUE) #
    for(i in 1:xx) {if (sapply(x[i],data.class)[[1]]=="numeric") hist(noquote(x)[,i],col="blue",
                                                                      main=names(noquote(x)[i]),xlab=names(noquote(x)[i]),labels=TRUE)}
    #for(i in 1:xx) {if (sapply(x[i],data.class)[[1]]=="numeric") hist(noquote(x)[,i],col=rep,
    #main=names(noquote(x)[i]),xlab=names(noquote(x)[i]))}
    savePlot(filename = paste(file_pour_les_tables_resultats,nomdefichier,sep=""),type = c("emf"),device = dev.cur(),restoreConsole = T)
  }
  #rm(x,xx,k,kk,kkk,rep,nomdefichier)
  rm(x,xx,k,kk,kkk,nomdefichier)
}
####____FIN

####_____Affiche une repr?sentation en barres des variables qualitatives (BLEU) en bleu et l'enregistre sur le dossier sp?cifi?

####____Affiche les histogrames des variables num?riques (GRIS)

boxplotquanti<-function(x)
{
  #rep<-readline(cat("Quelle couleur?\nVert tapez green\nRouge tapez red\nBleu tapez blue\nGris tapez grey "))
  if (is.data.frame(x)==FALSE)
  {
    #par(bg="tan");
    hist(noquote(x),col="grey",main=names(noquote(x)),xlab=names(noquote(x)))
  }
  else
  {
    k<-0
    kk<-0
    kkk<-0
    xx<-length(x)
    #sapply(x[y],data.class)[[1]]!="factor"
    #for(i in 1:xx) {if (is.factor(noquote(x)[,i])==FALSE) k<-k+1};
    for(i in 1:xx) {if (sapply(x[i],data.class)[[1]]=="numeric") k<-k+1};
    {if (k==0) stop("Aucune variable n'est QUANTITATIVE - Utilisez la fonction histoquali")}
    kk<-ceiling(sqrt(k))
    {if (kk*(kk-1)>=k) kkk<-(kk-1) else kkk<-kk}
    par(mfrow=c(kk,kkk))#,bg="tan")
    for(i in 1:xx) {if (sapply(x[i],data.class)[[1]]=="numeric") boxplot(noquote(x)[,i],col="grey",
                                                                         main=names(noquote(x)[i]),xlab=names(noquote(x)[i]))}
  }
  #rm(x,xx,k,kk,kkk,rep)
  rm(x,xx,k,kk,kkk)
}
####____FIN


####____Tableau des var QUANTI avec Moy Quartiles et SD

sortiequanti<-function(x,y) ## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonnes des variables QUANTITATIVES
{
  f<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="numeric" ) f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","Vide","Moyenne","Quartiles","EcartType" ))
  j<-1;for (i in y) {if (sapply(x[,i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i];tt[j,2]<-length(x[,i][is.na(x[,i])]) ;tt[j,3]<-round(mean(x[,i],na.rm=T),2); tt[j,4]<-paste("[",round(quantile(x[,i],na.rm=T)[[1]],2),"-",round(quantile(x[,i],na.rm=T)[[2]],2),"-",round(quantile(x[,i],na.rm=T)[[3]],2),"-",round(quantile(x[,i],na.rm=T)[[4]],2),"-",round(quantile(x[,i],na.rm=T)[[5]],2),"]",sep="");tt[j,5]<-round(sd(x[,i],na.rm=T),2);j<-j+1}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquanti.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquanti.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  return(as.data.frame(tt))
  #print(noquote(tt));              
  # rm(f,i,j,tt,x,y)
}
####____FIN



sortiequantiARTICLE<-function(x,y) ## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonnes des variables QUANTITATIVES
{
  f<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="numeric" ) f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","NA","Mean (SD)","Range","IQR" ))
  j<-1;for (i in y) {if (sapply(x[,i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i];
  tt[j,2]<-length(x[,i][is.na(x[,i])]) ;
  tt[j,3]<-paste(round(mean(x[,i],na.rm=T),2)," (",round(sd(x[,i],na.rm=T),2),")",sep=""); 
  tt[j,4]<-paste("[",round(quantile(x[,i],na.rm=T)[[1]],2),"-",round(quantile(x[,i],na.rm=T)[[5]],2),"]",sep="");
  tt[j,5]<-paste("[",round(quantile(x[,i],na.rm=T)[[2]],2),"-",round(quantile(x[,i],na.rm=T)[[3]],2),"-",round(quantile(x[,i],na.rm=T)[[4]],2),"]",sep="");
  j<-j+1}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquanti.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquanti.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt));
  #####
  
  #print(noquote(tt));              
  rm(f,i,j,tt,x,y)
}
####____FIN















####____Tableau des var QUANTI avec Moy Quartiles et SD

sortiequanti_12_chiffres_signif<-function(x,y) ## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonnes des variables QUANTITATIVES
{
  f<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="numeric" ) f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","Vide","Moyenne","Quartiles","EcartType" ))
  j<-1;for (i in y) {if (sapply(x[,i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i];tt[j,2]<-length(x[,i][is.na(x[,i])]) ;tt[j,3]<-round(mean(x[,i],na.rm=T),12); tt[j,4]<-paste("[",round(quantile(x[,i],na.rm=T)[[1]],12)," / ",round(quantile(x[,i],na.rm=T)[[2]],12)," / ",round(quantile(x[,i],na.rm=T)[[3]],12)," / ",round(quantile(x[,i],na.rm=T)[[4]],12)," / ",round(quantile(x[,i],na.rm=T)[[5]],12),"]",sep="");tt[j,5]<-round(sd(x[,i],na.rm=T),12);j<-j+1}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquanti.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquanti.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt));
  #####
  
  #print(noquote(tt));              
  rm(f,i,j,tt,x,y)
}
####____FIN


####____Tableau des var QUANTI avec Moy Quartiles et SD

sortiequantit<-function(x,y,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonnes des variables QUANTITATIVES
{
  f<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","Vide","Moyenne","Quartiles","EcartType" ))
  j<-1;for (i in y) {if (sapply(x[,i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i];tt[j,2]<-paste(length(x[,i][is.na(x[,i])]),"(",100*(round(length(x[,i][is.na(x[,i])])/dim(x[,i])[[1]],2)),"%",")",sep="") ;tt[j,3]<-round(mean(x[,i],na.rm=T),2); tt[j,4]<-paste("[",round(quantile(x[,i],na.rm=T)[[1]],2),"-",round(quantile(x[,i],na.rm=T)[[2]],2),"-",round(quantile(x[,i],na.rm=T)[[3]],2),"-",round(quantile(x[,i],na.rm=T)[[4]],2),"-",round(quantile(x[,i],na.rm=T)[[5]],2),"]",sep="");tt[j,5]<-round(sd(x[,i],na.rm=T),2);j<-j+1}}
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) ;
  rm(f,i,j,tt,x,y,nomdefichier)
}
####____FIN

####____Tableau QUANTI x VAR DICHOTOMIQUE (moy quartiles p-value)

sortiequantibi<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas quantitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","NA",paste(paste(colnames(x[y]),"=",names(table(x[,y]))[1],sep=""),"\n(Moy[Med-min-max]Sd)/Nobs"),paste(paste(colnames(x[y]),"=",names(table(x[,y]))[2],sep=""),"\n(Moy[Med-min-max]Sd)/Nobs"),"T-test" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-length(x[,i][is.na(x[,i])]);
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  
  
  tt[j,5]<-ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.0001,"<0.0001****",
                  ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.001,"<0.001***",
                         ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.01,paste(round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]],3),"**"),
                                ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.05,paste(round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]],3),"*"),
                                       ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.10,paste(round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]],3),"TREND"),
                                              round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]],3)
                                              
                                       )))))
  
  
  ; j<-j+1}
  tt=as.data.frame(tt)
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquantibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquantibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  #write.table(tt,file="D:/r/tabloquantibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel 

  return(tt)
  #print(noquote(tt));
  # rm(f,i,j,tt,x,y,w)
}
####____FIN





####____Tableau QUANTI x VAR DICHOTOMIQUE (moy quartiles p-value)

sortiequantibi_12_chiffres_signif<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas quantitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","NA",paste(paste(colnames(x[y]),"=",names(table(x[,y]))[1],sep=""),"(Moy[Med-min-max]Sd)/Nobs"),paste(paste(colnames(x[y]),"=",names(table(x[,y]))[2],sep=""),"(Moy[Med-min-max]Sd)/Nobs"),"T-test" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-paste(length(x[,y][is.na(x[,y])]),"/",length(x[,i][is.na(x[,i])]));
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),12)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],12) ," / ",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),12) ," / ",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),12),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),12)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),12)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],12) ," / ",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),12) ," / ",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),12),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),12)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  tt[j,5]<-ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.0001,"<0.0001****",
                  ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.001,"<0.001***",
                         ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.01,paste(round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]],3),"**"),
                                ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.05,paste(round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]],3),"*"),
                                       ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.10,paste(round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]],3),"TREND"),
                                              round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]],3)
                                              
                                       )))))
  
  
  ; j<-j+1}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquantibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquantibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  #write.table(tt,file="D:/r/tabloquantibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel 
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt));
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w)
}
####____FIN








#



####____Tableau QUANTI x VAR DICHOTOMIQUE (moy quartiles p-value)

sortiequantibit<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA:q/Q",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),"T-test" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-paste(length(x[,y][is.na(x[,y])]),"/",length(x[,i][is.na(x[,i])]));
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  tt[j,5]<-ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T )[[3]]<0.0001,"<0.0001", round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T )[[3]],5)); j<-j+1}
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word ;
  #write.table(tt,file="D:/r/tabloquantibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  #mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  rm(f,i,j,tt,x,y,w,nomdefichier)
}
####____FIN

####____Tableau QUANTI x VAR DICHOTOMIQUE (mediane et range seulement + test de wilcoxon)

sortiequantibiMED<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","NA",paste(paste(colnames(x[y]),"=",names(table(x[,y]))[1],sep=""),"(Med[min-max]/N"),paste(paste(colnames(x[y]),"=",names(table(x[,y]))[2],sep=""),"(Med[min-max]/N"),"P-Wilcox" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-paste(length(x[,i][is.na(x[,i])]));
  tt[j,3]<-paste(round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ," [",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"]","/",sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ," [",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"]","/",sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  
  tt[j,5]<-ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.0001,"<0.0001****",
                  ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.001,"<0.001***",
                         ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.01,paste( round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],4),"**"),
                                ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.05,paste( round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],4),"*"),
                                       ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.10,paste( round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],4),"TREND"),
                                              round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],3)
                                              
                                       )))))
  
  
  
  ; j<-j+1}
  
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquantibiMED.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/tabloquantibiMED.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  #write.table(tt,file="D:/r/tabloquantibiMED.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt))
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w)
}
####____FIN






####____Tableau QUANTI x VAR DICHOTOMIQUE (mediane et range seulement + test de wilcoxon)

sortiequantibiMED_12_chiffres_signif<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","NA",paste(paste(colnames(x[y]),"=",names(table(x[,y]))[1],sep=""),"(Mediane[min-max]/Nobs"),paste(paste(colnames(x[y]),"=",names(table(x[,y]))[2],sep=""),"(Mediane[min-max]/Nobs"),"T-test" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-paste(length(x[,i][is.na(x[,i])]));
  tt[j,3]<-paste(round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],12) ," [",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),12) ," / ",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),12),"]"," /",sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],12) ," [",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),12) ," / ",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),12),"]"," /",sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  
  tt[j,5]<-ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.0001,"<0.0001****",
                  ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.001,"<0.001***",
                         ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.01,paste( round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],4),"**"),
                                ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.05,paste( round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],4),"*"),
                                       ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.10,paste( round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],4),"TREND"),
                                              round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],3)
                                              
                                       )))))
  
  
  
  ; j<-j+1}
  
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquantibiMED.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/tabloquantibiMED.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  #write.table(tt,file="D:/r/tabloquantibiMED.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt));
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w)
}
####____FIN
























####____Tableau QUANTI x VAR DICHOTOMIQUE (mediane et range seulement + test de wilcoxon)

sortiequantibiMEDt<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","NA-quant",paste(names(table(x[,y]))[1],"(Mediane[min-max]/Nobs"),paste(names(table(x[,y]))[2],"(Mediane[min-max]/Nobs"),"p-Wilcoxon" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-paste(length(x[,i][is.na(x[,i])]));
  tt[j,3]<-paste(round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ," [",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"]","/",sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ," [",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"]","/",sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  tt[j,5]<-ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.001,"<0.001", round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],3)); j<-j+1}
  
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T);
  #write.table(tt,file="D:/r/tabloquantibiMED.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  #mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  rm(f,i,j,tt,x,y,w,nomdefichier)
}
####____FIN

####____Tableau QUANTI x VAR DICHOTOMIQUE (mediane et range seulement + test de wilcoxon)

sortiequantibiMEDpairedt<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  
  dimnames(tt)<-list(c(1:length(f)),c("Variable","",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p_Wilcox_pair" ))
  
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-c("Median [range]");
  tt[j,3]<-paste(round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ," [",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ",sep="");
  tt[j,4]<-paste(round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ," [",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ",sep="");
  tt[j,5]<-ifelse(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],paired=T )[[3]]<0.001,"<0.001", round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],paired=T)[[3]],3)); j<-j+1}
  
  # write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T);
  #write.table(tt,file="D:/r/tabloquantibiMED.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  #mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  return(as.data.frame(tt))
}
####____FIN




####____Tableau QUANTI x VAR DICHOTOMIQUE (mediane et range seulement + test de wilcoxon)

sortiequantibiMEDpaired<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  
  
  tt<-matrix(data="NA",nr=length(f),nc=5);
  
  dimnames(tt)<-list(c(1:length(f)),c("Variable","NA",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1],"(Moy[Med-min-max]Sd)/Nobs"),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2],"(Moy[Med-min-max]Sd)/Nobs"),paste("Wilcox_pair","/","Mean_diff") ))
  
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-length(x[,i][is.na(x[,i])]);
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  tt[j,5]<-paste(ifelse(
    wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],paired=T )[[3]]<0.001,"<0.001",
    round(wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],paired=T)[[3]],3)),
    "/",
    round(mean((x[,i][x[,y]==names(table(x[,y]))[1]]- x[,i][x[,y]==names(table(x[,y]))[2]]),na.rm=T),3)
  ); j<-j+1}
  
  #write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T);
  #write.table(tt,file="D:/r/tabloquantibiMED.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt));
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w)
}
####____FIN



####____Tableau QUANTI x VAR DICHOTOMIQUE (mediane et range seulement + test de wilcoxon)
# avec p sans limite de nombre apr?s la virgule

sortiequantibiMEDpaired_p_complet<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  
  dimnames(tt)<-list(c(1:length(f)),c("Variable","",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p_Wilcox_pair" ))
  
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-c("Median [range]");
  tt[j,3]<-paste(round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ," [",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ",sep="");
  tt[j,4]<-paste(round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ," [",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ",sep="");
  tt[j,5]<-wilcox.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],paired=T)[[3]]
  ; j<-j+1}
  
  #write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T);
  #write.table(tt,file="D:/r/tabloquantibiMED.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt));
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w)
}
####____FIN

####____Tableau QUANTI x VAR DICHOTOMIQUE (mediane et range seulement + test de stutent)

sortiequantibiMOY<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  
  dimnames(tt)<-list(c(1:length(f)),c("Variable","",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p-Student" ))
  
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-c("Mean (sd)");
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]], na.rm=T)[[1]],2) ," (",round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,")",sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]], na.rm=T)[[1]],2) ," (",round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,")",sep="");
  tt[j,5]<-ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.001,"<0.001", round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],3)); j<-j+1}
  
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquantibiMOY.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/tabloquantibiMOY.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  #write.table(tt,file="D:/r/tabloquantibiMOY.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt))
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w)
}
####____FIN

####____Tableau QUANTI x VAR DICHOTOMIQUE (mediane et range seulement + test de stutent)

sortiequantibiMOYt<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  
  dimnames(tt)<-list(c(1:length(f)),c("Variable","",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p-Student" ))
  
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-c("Mean (sd)");
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]], na.rm=T)[[1]],2) ," (",round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,")",sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]], na.rm=T)[[1]],2) ," (",round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,")",sep="");
  tt[j,5]<-ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]]<0.001,"<0.001", round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]] )[[3]],3)); j<-j+1}
  
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) ;
  #write.table(tt,file="D:/r/tabloquantibiMOY.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  #mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  rm(f,i,j,tt,x,y,w,nomdefichier)
}
####____FIN

####____Tableau QUANTI x VAR DICHOTOMIQUE (mediane et range seulement + test de stutent)

sortiequantibipaired<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  
  dimnames(tt)<-list(c(1:length(f)),c("Variable","NA",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1],"(Moy[Med-min-max]Sd)/Nobs"),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2],"(Moy[Med-min-max]Sd)/Nobs"),paste("T_pair","/","Mean_diff") ))
  
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-length(x[,i][is.na(x[,i])]);
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  tt[j,5]<-paste(ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],paired=T )[[3]]<0.001,"<0.001", round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],paired=T)[[3]],3)),"/",round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],paired=T)[[5]],3)); j<-j+1}
  
  #write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) ;
  #write.table(tt,file="D:/r/tabloquantibiMOY.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  
  #####
  return(as.data.frame(tt));
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w,nomdefichier)
}
####____FIN

sortiequantimulti<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor") stop("Votre variable n'est pas quantitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  #dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[3],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[4],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[5],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[6],"(Moy[Mediane-min-max]Sd)/Nobs"),"p-Student" ))
  #dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[3],"(Moy[Mediane-min-max]Sd)/Nobs"),"p-Student" ))
  dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[3],"(Moy[Mediane-min-max]Sd)/Nobs")))
  #dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),"p-Student" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {
    tt[j,1]<-dimnames(x)[[2]][i] ;
    tt[j,2]<-paste(length(x[,y][is.na(x[,y])]),"/",length(x[,i][is.na(x[,i])]));
    tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
    tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
    tt[j,5]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[3]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[3]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[3]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[3]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[3]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,3]),sep="");
    #tt[j,6]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[4]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[4]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[4]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[4]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[4]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,4]),sep="");
    #tt[j,7]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[5]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[5]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[5]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[5]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[5]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,5]),sep="");
    #tt[j,8]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[6]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[6]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[6]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[6]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[6]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,6]),sep="");
    
    #tt[j,6]<-ifelse(summary(aov(x[,y]~x[,y]),na.rm = TRUE)[[1]][5][[1]][1]<0.0001,"<0.0001", round(summary(aov(x[,y]~x[,y]),na.rm = TRUE)[[1]][5][[1]][1],5))
    j<-j+1
  }
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt));
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w)
}
####____FIN

sortiequantimultit<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor") stop("Votre variable n'est pas quantitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  #dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[3],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[4],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[5],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[6],"(Moy[Mediane-min-max]Sd)/Nobs"),"p-Student" ))
  #dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[3],"(Moy[Mediane-min-max]Sd)/Nobs"),"p-Student" ))
  dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[3],"(Moy[Mediane-min-max]Sd)/Nobs")))
  #dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),"p-Student" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {
    tt[j,1]<-dimnames(x)[[2]][i] ;
    tt[j,2]<-paste(length(x[,y][is.na(x[,y])]),"/",length(x[,i][is.na(x[,i])]));
    tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
    tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
    tt[j,5]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[3]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[3]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[3]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[3]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[3]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,3]),sep="");
    #tt[j,6]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[4]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[4]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[4]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[4]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[4]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,4]),sep="");
    #tt[j,7]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[5]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[5]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[5]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[5]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[5]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,5]),sep="");
    #tt[j,8]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[6]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[6]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[6]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[6]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[6]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,6]),sep="");
    
    #tt[j,6]<-ifelse(summary(aov(x[,y]~x[,y]),na.rm = TRUE)[[1]][5][[1]][1]<0.0001,"<0.0001", round(summary(aov(x[,y]~x[,y]),na.rm = TRUE)[[1]][5][[1]][1],5))
    j<-j+1
  }
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word ;
  
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w,nomdefichier)
}
####____FIN

####____tableaux des STUDENT entre variables quali-quanti

studenttab<-function(x,y,z)	## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonnes des variables QUALITATIVES BINAIRES
  ## z= Num colonnes des variables QUANTITATIVES
  ## a tester avec y par exemple(c(4:10,13:20))
{
  for(i in y) {if (is.factor(x[,i])==FALSE) stop(paste("la colonne Num",i,"n'est pas qualitative(as.factor)"))}
  for(i in y) {if (length(levels(x[,i]))!=2) stop(paste("la colonne Num",i,"n'est pas une variable binaire"))}
  for(i in z) {if (is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  for(i in y)
  {
    for(j in z) {print(paste("VARIABLES: ",names(x[i])," - ",names(x[j])));print(t.test(x[,j]~x[,i],data=x)[[3]]);print(t.test(x[,j]~x[,i],data=x)[[5]])}
  }
  #rm(x,y,z)
}
####____FIN


######################################################################################################################################################
######################################################################################################################################################
######################################################################################################################################################















####____Tableau 2x2 VAR DICHOTOMIQUE (Freq OR p-value)

dichoto<-function(x,y,w) #x=epi, y=mldie=23(sex), w=facRisq=45(RHC)
{
  if (sapply(x[y],data.class)[[1]]!="factor" | sapply(x[w],data.class)[[1]]!="factor") stop("Vos variables ne sont pas Qualitatives")
  else if (length(names(table(x[,y])))!=2 | length(names(table(x[,w])))!=2) stop("Les variables ne sont pas binaires")
  else
  {
    {m1<-readline(cat("Indiquez le num?ro de modalit? correspondant ? Maladie+\n1=",names(table(x[,y])[1]),"\n2=",names(table(x[,y])[2])," "))};
    {m2<-readline(cat("Indiquez le num?ro de modalit? correspondant ? Facteur Risque+\n1=",names(table(x[,w])[1]),"\n2=",names(table(x[,w])[2])," "))};
    if (m1=="1") {p<-1;q<-2} else {p<-2;q<-1};
    if (m2=="1") {r<-1;s<-2} else {r<-2;s<-1};
    f<-c(names(table(x[,y])[p]), names(table(x[,y])[q]) );
    tt<-matrix(data="NA",nr=length(f),nc=4);
    dimnames(tt)<-list(f,c(names(table(x[,w])[r]), names(table(x[,w])[s]),"Odds-Ratio [IC]","p-value" ))
    a<- length(x[,y][x[,w]==names(table(x[,w])[r])]);
    b<- length(x[,y][x[,w]==names(table(x[,w])[s])])
    j<-1; for (i in 1:length(f))
    {tt[j,1]<-paste( length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[r])])," (",round(length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[r])])*100/a,1) ,"%)",sep="");
    tt[j,2]<- paste(length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[s])])," (",round(length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[s])])*100/b,1) ,"%)",sep="");
    {t<-matrix(data=0,nc=2,nr=2)
    t[1,1]<-as.numeric(length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[r])])); #rep1(m+f+);
    t[1,2]<-as.numeric(a- length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[r])]));#rep2(m-f+);
    t[2,1]<-as.numeric(length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[s])])); #rep3(m+f-);
    t[2,2]<-as.numeric(b- length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[s])])); #rep4(m-f-);
    or<-(t[1,1]*t[2,2])/(t[1,2]*t[2,1])
    icor<-sqrt(1/t[1,1]+1/t[1,2]+1/t[2,1]+1/t[2,2])*1.96
    orp<-round(exp(log(or)+icor),2)
    orm<-round(exp(log(or)-icor),2)
    or<-round(or,2)};
    tt[j,3]<-ifelse(j==1,paste( or, " [",orm, " - ",orp, "]",sep="")," ");
    aa<-ifelse(x[,y]== f[i] & x[,w]== names(table(x[,w])[s]),1,0); 
    bb<-ifelse(x[,y]== f[i] & x[,w]== names(table(x[,w])[r]),1,0)
    tt[j,4]<-ifelse(j==1,ifelse(chisq.test(aa,bb)[[3]]<0.0001 ,"<0.0001" ,round(chisq.test(aa,bb)[[3]],5) )," ");
    j<-j+1};
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tablodichotomie.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
    #edit(file="D:/R/tablodichotomie.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    #####
    # Envoyer le tableau dans MARKDOWN
    ft <- flextable(as.data.frame(tt));
    ft <- autofit(ft);
    saveRDS(ft, file = "my_data.rds");
    #####
    
    #print(noquote(tt));
    rm(f,i,j,tt,t,or,icor,orp,orm,aa,bb,a,b,x,y,w,m1,p,q,m2,r,s,rep)
  }
}
####____FIN

####____Tableau des VARIABLES(Num?ros de colonne et Noms)

tabcols<-function(x) #Nom de la table
{
  a<- length(dimnames(x)[[2]])
  sortie1<-matrix(data="NA",nr=a,nc=2)
  for (i in 1:a)
  {sortie1[i,1]<-i;sortie1[i,2]<-dimnames(x)[[2]][i]}
  o<-order(sortie1[,2]);
  sortie1<-cbind(sortie1,sortie1[,2][o],sortie1[,1][o]);
  dimnames(sortie1)<-list(c(1:a),c("Num Variable","Code Variable","Code Variable Alphab ","Num Variable Alphab"));
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nUne sortie sur R= tout autre caractere "))
  #if (rep=="o") {write.table(sortie1,file="D:/r/column.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/column.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")}else print(sortie1);
  ft <- flextable(as.data.frame(sortie1))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  # ft <- autofit(ft,add_w=0,add_h = 0)
  return(ft)
}
####____FIN

####____Tableau des VARIABLES(Num?ros de colonne et Noms) CLASS? DANS UNE TABLE

tabcolst<-function(x,nomdefichier) #Nom de la table
{
  a<- length(dimnames(x)[[2]])
  sortie1<-matrix(data="NA",nr=a,nc=2)
  for (i in 1:a)
  {sortie1[i,1]<-i;sortie1[i,2]<-dimnames(x)[[2]][i]}
  o<-order(sortie1[,2]);
  sortie1<-cbind(sortie1,sortie1[,2][o],sortie1[,1][o]);
  dimnames(sortie1)<-list(c(1:a),c("Num Variable","Code Variable","Code Variable Alphab ","Num Variable"));
  write.table(sortie1,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) ;
  rm(a,sortie1,o,i,x,nomdefichier);
}
####____FIN

####____Tableau kx2 VARS DICHOTOMIQUES (Freq OR p-value)

multidichoto<-function(x,y,w) #x=epi, y=c(mldie1,mldie2..), w=facRisq
{
  for (k in y)
  {if (sapply(x[w],data.class)[[1]]!="factor" | sapply(x[k],data.class)[[1]]!="factor") stop("Vos variables ne sont pas Qualitatives")
    else if (length(names(table(x[,w])))!=2 | length(names(table(x[,k])))!=2) stop("Les variables ne sont pas binaires")};
  {m2<-readline(cat("Indiquez le num?ro de modalit? correspondant ? Facteur Risque+\n",dimnames(x)[[2]][w],"\n1=",names(table(x[,w])[1]),"\n2=",names(table(x[,w])[2])," "))};
  if (m2=="1") {r<-1;s<-2} else {r<-2;s<-1};
  tt<-matrix(data="NA",nr=(length(y)*3),nc=6);
  dimnames(tt)<-list(1:(length(y)*3),c("VARIABLE","MODALITE",paste(dimnames(x)[[2]][w]," ",names(table(x[,w])[r]),sep=""), paste(dimnames(x)[[2]][w]," ",names(table(x[,w])[s]),sep=""),"Odds-Ratio [IC]","p-value" ));
  j<-0;
  for (k in y)
  {
    {m1<-readline(cat("Indiquez le num?ro de modalit? correspondant ? Maladie+\n",dimnames(x)[[2]][k],"\n1=",names(table(x[,k])[1]),"\n2=",names(table(x[,k])[2])," "))};
    if (m1=="1") {p<-1;q<-2} else {p<-2;q<-1};
    a<- length(x[,k][x[,w]==names(table(x[,w])[r])]);
    b<- length(x[,k][x[,w]==names(table(x[,w])[s])]);
    f<-c(names(table(x[,k])[p]), names(table(x[,k])[q]) );
    for (i in 1:3)
    {
      tt[j+i,1]<-ifelse(i==1,dimnames(x)[[2]][k]," ");
      tt[j+i,2]<-ifelse(i!=1,f[i-1]," ");
      tt[j+i,3]<-ifelse(i!=1,paste(length(x[,k][x[,k]== f[i-1] & x[,w]== names(table(x[,w])[r])])," (",round(length(x[,k][ x[,k]== f[i-1] & x[,w]== names(table(x[,w])[r])])*100/a,1) ,"%)",sep="")," ");
      tt[j+i,4]<-ifelse(i!=1,paste(length(x[,k][x[,k]== f[i-1] & x[,w]== names(table(x[,w])[s])])," (",round(length(x[,k][ x[,k]== f[i-1] & x[,w]== names(table(x[,w])[s])])*100/b,1) ,"%)",sep="")," ");
      if(i==1)
      {
        t<-matrix(data=0,nc=2,nr=2);
        t[1,1]<-as.numeric(length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[r])])); #rep1(m+f+);
        t[1,2]<-as.numeric(a- length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[r])]));#rep2(m-f+);
        t[2,1]<-as.numeric(length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[s])])); #rep3(m+f-);
        t[2,2]<-as.numeric(b- length(x[,y][ x[,y]== f[i] & x[,w]== names(table(x[,w])[s])])); #rep4(m-f-);
        or<-(t[1,1]*t[2,2])/(t[1,2]*t[2,1]);
        icor<-sqrt(1/t[1,1]+1/t[1,2]+1/t[2,1]+1/t[2,2])*1.96;
        orp<-round(exp(log(or)+icor),2);
        orm<-round(exp(log(or)-icor),2);
        or<-round(or,2);
      };# ferme if(i==1)
      tt[j+i,5]<-ifelse(i==1,paste( or, " [",orm, " - ",orp, "]",sep="")," ");
      tt[j+i,6]<-ifelse(i==1,ifelse(chisq.test(x[,k],x[,w])[[3]]<0.0001 ,"<0.0001" ,round(chisq.test(x[,k],x[,w])[[3]],5) )," ");
    };# ferme for (i in 1:3) 
    j<-j+3};# ferme for (k in y)
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/R/tablomultidichoto.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/tablomultidichoto.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  #print(noquote(tt));
  #rm(i,j,f,tt,t,or,icor,orp,orm,a,b,x,y,w,m1,p,q,m2,r,s,rep,k);
  rm(i,j,f,tt,t,or,icor,orp,orm,a,b,x,y,w,m1,p,q,m2,r,s,k)
} #fermeFonction
####____FIN


####____D?but
#####_______Donne un tableau des fr?quences

tabfreq<-function(...,exclude=F)#tabfreq<-function(a,b,c,d)## a= nom table
  ## b= Num de la colonne des ordonn?es (lignes du tableau)
  ## c= Num de la colonne des abscisses (colonnes du tableau)
  ## exclude = F si on veut tabuler sans les valeurs nulles
  ## par defaut exclude = T (avec les Nulls)
{
  nbr<-list(...)
  if (length(nbr)>3) stop("Maximum 2 colonnes !!!")
  if (length(nbr)==0) stop("Vous devez indiquer la table et au moins une colonne !!!")
  if (length(nbr)==1) stop("Vous devez indiquer la table et au moins une colonne !!!")
  if (length(nbr)==2)
  {
    a<-(nbr)[[1]]
    b<-(nbr)[[2]]
    if (missing(exclude)) t<-table(a[,b],exclude=NULL,dnn=c(names(a[b])))
    else {if (!exclude==F) t<-table(a[,b],exclude=NULL,dnn=c(names(a[b])))
    else t<-table(a[,b],dnn=c(names(a[b])))}
    ordo<-NULL
    absi<-NULL
    ordo<-"Freq"
    for(i in 1:length(t)) {ordo<-c(ordo, names(table(a[,b])[i]))}
    ordo<-c(ordo,"Tot");
    absi<-c("Nbre","Pourcent")
    tt<-matrix(data="NA",nc=(length(t)+2),nr=2,dimnames=list(c(1:2),ordo));
    tt[1,1]<-absi[1]; tt[2,1]<-absi[2]
    for(i in 1:length(t)) {tt[1,i+1]<-t[i]}
    tt[1,length(t)+2]<-sum(t)
    for(i in 1:length(t)) {tt[2,i+1]<-round(t[i]*100/sum(t),1)}
    tt[2,length(t)+2]<-100
    rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    if (rep=="o") {write.table(tt,file="D:/r/tabfreq.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
      edit(file="D:/R/tabfreq.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else 
        
        
        #####
    # Envoyer le tableau dans MARKDOWN
    ft <- flextable(as.data.frame(tt));
    ft <- autofit(ft);
    saveRDS(ft, file = "my_data.rds");
    #####
    
    #print(noquote(tt));
  }
  if (length(nbr)==3)
  {
    a<-(nbr)[[1]]
    b<-(nbr)[[2]]
    c<-(nbr)[[3]]
    if (missing(exclude)) t<-table(a[,b],a[,c],exclude=NULL,dnn=c(names(a[b]),names(a[c])))
    else {if (!exclude==F) t<-table(a[,b],a[,c],exclude=NULL,dnn=c(names(a[b]),names(a[c])))
    else t<-table(a[,b],a[,c],dnn=c(names(a[b]),names(a[c])))}
    ordo<-NULL
    absi<-NULL
    for(i in 1:length(t[,1])) ordo<-c(ordo,paste(names(a[b]),"-",dimnames(t)[[1]][i],sep=""),"%col")
    ordo<-c(ordo,"Tot")
    absi<-"Freq"
    for(i in 1:length(t[1,])) absi<-c(absi,paste(names(a[c]),"-",dimnames(t)[[2]][i],sep=""),"PcentLig")
    absi<-c(absi,"Tot")
    tt<-matrix(data="NA",nc=length(absi) ,nr=length(ordo),dimnames=list(c(1:length(ordo)),absi));
    for(i in 1:length(ordo)){tt[i,1]<-ordo[i]};
    for(j in 1:length(t[,1])) {for(i in 1:length(t[1,])) 
    {tt[(j*2)-1,(i*2)]<-t[j,i];tt[(j*2)-1,(i*2)+1]<-round(t[j,i]*100/sum(t[j,]),1)}
      tt[(j*2)-1,(length(t[1,])*2)+2]<-sum(t[j,])};
    for(j in 1:length(t[,1])) {for(i in 1:length(t[1,])) 
    {tt[(j*2),(i*2)+1]<-round(t[j,i]*100/sum(t),1)}
      tt[(j*2),(length(t[1,])*2)+2]<-round(sum(t[j,])*100/sum(t),1)};
    for(j in 1:length(t[1,])) 
    {for(i in 1:length(t[,1])) {tt[(i*2),(j*2)]<-round(t[i,j]*100/sum(t[,j]),1)}
      tt[(length(t[,1])*2)+1,(j*2)]<-sum(t[,j])}
    for(j in 1:length(t[1,])) 
    {for(i in 1:length(t[,1]))
      tt[(length(t[,1])*2)+1,(j*2)+1]<-round(sum(t[,j])*100/sum(t),1)}
    tt[length(tt[,1]),length(tt[1,])]<-sum(t);
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabfreq.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabfreq.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    #####
    # Envoyer le tableau dans MARKDOWN
    ft <- flextable(as.data.frame(tt));
    ft <- autofit(ft);
    saveRDS(ft, file = "my_data.rds");
    #####
    
    #print(noquote(tt));
  }
}
#####_______FIN

#####_______DEBUT
tabfreqcol<-function(...,exclude=F)#tabfreq<-function(a,b,c,d)## a= nom table
  ## b= Num de la colonne des ordonn?es (lignes du tableau)
  ## c= Num de la colonne des abscisses (colonnes du tableau)
  ## exclude = F si on veut tabuler sans les valeurs nulles
  ## par defaut exclude = T (avec les Nulls)
{
  nbr<-list(...)
  if (length(nbr)>3) stop("Maximum 2 colonnes !!!")
  if (length(nbr)==0) stop("Vous devez indiquer la table et au moins une colonne !!!")
  if (length(nbr)==1) stop("Vous devez indiquer la table et au moins une colonne !!!")
  if (length(nbr)==2)
  {
    a<-(nbr)[[1]]
    b<-(nbr)[[2]]
    if (missing(exclude)) t<-table(a[,b],exclude=NULL,dnn=c(names(a[b])))
    else {if (!exclude==F) t<-table(a[,b],exclude=NULL,dnn=c(names(a[b])))
    else t<-table(a[,b],dnn=c(names(a[b])))}
    ordo<-NULL
    absi<-NULL
    ordo<-"Freq"
    for(i in 1:length(t)) {ordo<-c(ordo, names(table(a[,b])[i]))}
    ordo<-c(ordo,"Tot");
    absi<-c("Nbre","Pourcent")
    tt<-matrix(data="NA",nc=(length(t)+2),nr=2,dimnames=list(c(1:2),ordo));
    tt[1,1]<-absi[1]; tt[2,1]<-absi[2]
    for(i in 1:length(t)) {tt[1,i+1]<-t[i]}
    tt[1,length(t)+2]<-sum(t)
    for(i in 1:length(t)) {tt[2,i+1]<-round(t[i]*100/sum(t),1)}
    tt[2,length(t)+2]<-100
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabfreq.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabfreq.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    #####
    # Envoyer le tableau dans MARKDOWN
    ft <- flextable(as.data.frame(tt));
    ft <- autofit(ft);
    saveRDS(ft, file = "my_data.rds");
    #####
    
    #print(noquote(tt));
  }
  if (length(nbr)==3)
  {
    a<-(nbr)[[1]]
    b<-(nbr)[[2]]
    c<-(nbr)[[3]]
    if (missing(exclude)) t<-table(a[,b],a[,c],exclude=NULL,dnn=c(names(a[b]),names(a[c])))
    else {if (!exclude==F) t<-table(a[,b],a[,c],exclude=NULL,dnn=c(names(a[b]),names(a[c])))
    else t<-table(a[,b],a[,c],dnn=c(names(a[b]),names(a[c])))}
    ordo<-NULL
    absi<-NULL
    for(i in 1:length(t[,1])) ordo<-c(ordo,paste(names(a[b]),"-",dimnames(t)[[1]][i],sep=""),"%col")
    ordo<-c(ordo,"Total")
    absi<-"Freq"
    for(i in 1:length(t[1,])) absi<-c(absi,paste(names(a[c]),"-",dimnames(t)[[2]][i],sep=""),"Pourcentage")
    absi<-c(absi,"Tot")
    tt<-matrix(data="NA",nc=length(absi) ,nr=length(ordo),dimnames=list(c(1:length(ordo)),absi));
    for(i in 1:length(ordo)){tt[i,1]<-ordo[i]};
    for(j in 1:length(t[,1])) {for(i in 1:length(t[1,]))
    {tt[(j*2)-1,(i*2)]<-t[j,i];tt[(j*2)-1,(i*2)+1]<-round(t[j,i]*100/sum(t[j,]),1)}
      tt[(j*2)-1,(length(t[1,])*2)+2]<-sum(t[j,])};
    for(j in 1:length(t[,1])) {for(i in 1:length(t[1,]))
    {tt[(j*2),(i*2)+1]<-round(t[j,i]*100/sum(t),1)}
      tt[(j*2),(length(t[1,])*2)+2]<-round(sum(t[j,])*100/sum(t),1)};
    for(j in 1:length(t[1,]))
    {for(i in 1:length(t[,1])) {tt[(i*2),(j*2)]<-round(t[i,j]*100/sum(t[,j]),1)}
      tt[(length(t[,1])*2)+1,(j*2)]<-sum(t[,j])}
    for(j in 1:length(t[1,]))
    {for(i in 1:length(t[,1]))
      tt[(length(t[,1])*2)+1,(j*2)+1]<-round(sum(t[,j])*100/sum(t),1)}
    tt[length(tt[,1]),length(tt[1,])]<-sum(t);
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabfreq.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabfreq.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    #ttcol<-dim(tt)[1]
    #mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    #print(noquote(dimnames(tt)[[2]]));
    tt<-as.matrix(tt)
    PairImpair<-NULL
    for(i in 1:(dim(tt)[1]))
    {if (i%%2==0) PairImpair[i]<-1 else PairImpair[i]<-0
    }
    tt<-cbind(tt,PairImpair)
    tt1<-tt[PairImpair==0,]
    tt1<-tt1[,c(1:((dim(tt1)[2])-1))]
    print(noquote(tt1))
  }
}
#####_______FIN

####____Survie bivari?e

surviebicox<-function(x,t,y,w)##arguments de la fonction
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES 
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("VARIABLE","MODALITE",names(table(x[,y]))[1],names(table(x[,y]))[2],"p-Cox" ))
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; 
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/a,2) ,"%)",sep=""),""); 
      tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/b,2) ,"%)",sep=""),""); 
      tt[j+z,5]<-ifelse(z>1,"-",ifelse(drop1((coxph(Surv(x[,t],x[,y])~x[,i])),.~.,test="Chisq")[2,4]<0.0001,"<0.0001", round(drop1((coxph(Surv(x[,t],x[,y])~x[,i])),.~.,test="Chisq")[2,4],5)))
    }
    ;
    j<-j+k}
  
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  #print(noquote(tt));
  rm(a,b,g,k,i,j,tt,z,x,y,w)
}
#####_______FIN

####____Survie bivari?e

surviebicox1<-function(x,t,y,w)## arguments de la fonction
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES 
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("VARIABLE","MODALITE","moy1","moy2","p-Cox" ))
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; 
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z>1,mean(w[,i])); 
      tt[j+z,4]<-ifelse(z>1,mean(w[,i])); 
      tt[j+z,5]<-ifelse(z>1,"-",ifelse(drop1((coxph(Surv(x[,t],x[,y])~x[,i])),.~.,test="Chisq")[2,4]<0.0001,"<0.0001", round(drop1((coxph(Surv(x[,t],x[,y])~x[,i])),.~.,test="Chisq")[2,4],5)))
    }
    ;
    j<-j+k}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  #print(noquote(tt));
  rm(a,b,g,k,i,j,tt,z,x,y,w)
}
#####_______FIN

####____Survie bivari?e

surviebilogrank_rho_moins_1<-function(x,t,y,w)## arguments de la fonction
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES 
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("VARIABLE","MODALITE",names(table(x[,y]))[1],names(table(x[,y]))[2],"p-Logrank" ))
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; 
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/ ( table(x[,i],x[,y])[z-1,1]+ table(x[,i],x[,y])[z-1,2]) ,2) ,"%)",sep=""),""); 
      tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/( table(x[,i],x[,y])[z-1,2]+ table(x[,i],x[,y])[ z-1,1]),2) ,"%)",sep=""),"");
      
      tt[j+z,5]<-ifelse(z>1,"-",ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i],rho=-1)[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i],rho=-1)[[1]])-1)))<0.0001,"<0.0001", round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i],rho=-1)[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i],rho=-1)[[1]])-1))),5)))
      
      
    }
    ;
    j<-j+k}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  # saveRDS(ft, file = "my_data.rds");
  #####
  
  #print(noquote(tt));
  rm(a,b,g,k,i,j,tt,z,x,y,w)
}
#####_______FIN

####____Survie bivari?e

#### fonction pour déterminer les variables à moins de deux groupe dans le surviebilogrank
surviebilogrank_selectvar=function(y,varquali,df){ # y: variable d'état en numérique 0/1 ; varquali: var. explicatives qualitatives ; df=dataframe
  var_select=c()
  for (i in varquali){
    test=as.data.frame(table(df[,y],df[,i]))
    table_test=test[which(test$Var1==1),]
    if (0 %in% test$Freq==F){
      var_select=c(var_select,i)
    }
  }
  return(var_select)
}
#####_______FIN

surviebilogrank<-function(x,t,y,w)## arguments de la fonction
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES 
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("VARIABLE","MODALITE",names(table(x[,y]))[1],names(table(x[,y]))[2],"p-Logrank" ))
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; 
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/ ( table(x[,i],x[,y])[z-1,1]+ table(x[,i],x[,y])[z-1,2]) ,2) ,"%)",sep=""),""); 
      tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/( table(x[,i],x[,y])[z-1,2]+ table(x[,i],x[,y])[ z-1,1]),2) ,"%)",sep=""),"");
      
      tt[j+z,5]<-ifelse(z>1,"-",
                        ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.0001,"<0.0001****",
                               ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.001,"<0.001***",
                                      ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.01,paste(round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5),"**"),
                                             ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.05,paste(round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5),"*"),
                                                    ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.10,paste(round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5)," TREND"),
                                                           round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5)))))))
      
    }
    ;
    j<-j+k}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #print(noquote(tt));
  return(as.data.frame(tt))
  rm(a,b,g,k,i,j,tt,z,x,y,w)
}
#####_______FIN

surviebilogrank_ordered<-function(x,t,y,w) 
{
  tt=as.data.frame(surviebilogrank(x,t,y,w))
  
  tt2=tt[order(tt[,5]),]
  var_ordered=c()
  for(i in 1:nrow(tt2)){
    if (tt2[i,5]!="-"){
      var_ordered=c(var_ordered,numcol(tt2[i,1],x))
    }
  }
  tt3=as.data.frame(surviebilogrank(x,t,y,var_ordered))
  return(as.data.frame(tt3))
}


####____Survie bivari?e

surviebilogrankt<-function(x,t,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES 
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("VARIABLE","MODALITE",names(table(x[,y]))[1],names(table(x[,y]))[2],"p-Logrank" ))
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; 
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/ ( table(x[,i],x[,y])[z-1,1]+ table(x[,i],x[,y])[z-1,2]) ,2) ,"%)",sep=""),""); 
      tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/( table(x[,i],x[,y])[z-1,2]+ table(x[,i],x[,y])[ z-1,1]),2) ,"%)",sep=""),"");
      
      tt[j+z,5]<-ifelse(z>1,"-",
                        ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.0001,"<0.0001****",
                               ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.001,"<0.001***",
                                      ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.01,paste(round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5),"**"),
                                             ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.05,paste(round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5),"*"),
                                                    ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.10,paste(round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5)," TREND"),
                                                           round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5)))))))
      
    }
    ;
    j<-j+k}
  {write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
    # Sauve le tableau pour le r?cup?rer sous word 
    rm(a,b,g,k,i,j,tt,z,x,t,y,w,nomdefichier)
  }
}
#####_______FIN

####____Survie bivari?e

coxarticle<-function(x,t,y,w)##Arguments de la fonction
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES doit ?tre binaire et qualitative
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)), c("Variable","Modality","HR","CI95%","p-Cox" ))
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; 
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z==1,"", ifelse(z==2,"1",signif(summary(coxph(Surv(x[,t],x[,y])~x[,i])) [[8]][[z-2]],2)));
      tt[j+z,4]<-ifelse(z==1,"", ifelse(z==2,"REF.",
                                        paste("[",
                                              signif(
                                                summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[8]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[8]]))*1/2+z-2)]]
                                                ,2),
                                              "-",
                                              signif(
                                                summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[8]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[8]]))*3/4+z-2)]]
                                                ,2),
                                              "]")
      ));
      
      tt[j+z,5]<-ifelse(z==1,"",
                        ifelse(z==2,"-",
                               ifelse(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]]))*4/5+z-2)]]<0.0001,"<0.0001****",
                                      ifelse(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]]))*4/5+z-2)]]<0.001,"<0.001***",
                                             ifelse(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]]))*4/5+z-2)]]<0.01,paste(signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]]))*4/5+z-2)]],3),"**"),
                                                    ifelse(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]]))*4/5+z-2)]]<0.05,paste(signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]]))*4/5+z-2)]],3),"*"),
                                                           ifelse(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]]))*4/5+z-2)]]<0.10,paste(signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]]))*4/5+z-2)]],3),"TREND"),
                                                                  signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]]))*4/5+z-2)]],3)
                                                                  
                                                           )))))))
      
      
      ;
    }
    ;
    j<-j+k}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #print(noquote(tt));
  return(as.data.frame(tt))
  rm(a,b,g,k,i,j,tt,z,x,y,w)
}
####____Survie bivari?e

coxarticlet<-function(x,t,y,w,nomdefichier)## arguments de la fonction
  
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES doit ?tre binaire et qualitative
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)), c("Variable","Modality","HR","CI95%","p-Cox" ))
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; 
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z==1,"", ifelse(z==2,"1",signif(summary(coxph(Surv(x[,t],x[,y])~x[,i])) [[8]][[z-2]],2)));
      tt[j+z,4]<-ifelse(z==1,"", ifelse(z==2,"-",
                                        paste("[",
                                              signif(
                                                summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[8]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[8]]))*1/2+z-2)]]
                                                ,2),
                                              "-",
                                              signif(
                                                summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[8]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[8]]))*3/4+z-2)]]
                                                ,2),
                                              "]")
      ));
      tt[j+z,5]<-ifelse(z==1,"", ifelse(z==2,"-",
                                        signif(
                                          summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[ (length((summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]]))*4/5+z-2)]]
                                          ,3)));
    }
    ;
    j<-j+k}
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  ;
  rm(a,b,g,k,i,j,tt,z,x,y,w,nomdefichier)
}
####____Fin
############################################################################################################
####____Survie bivari?e

coxarticleQUANT<-function(x,t,y,w)## arguments de la fonction
  #sortiequantit<-function(x,y,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonnes des variables QUANTITATIVES
{
  f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric" ) f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","Missing","N. pts","HR [95%CI]","p-Cox" ))
  j<-1;for (i in w) {if (sapply(x[i],data.class)[[1]]=="numeric")
  {
    tt[j,1]<-dimnames(x)[[2]][i];
    tt[j,2]<-length(x[i][is.na(x[i])]) ;
    tt[j,3]<-summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[4]]; 
    tt[j,4]<-paste(signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i]))[[8]][[1]],3)," [",signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i]))[[8]][[3]],3),"-",signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i]))[[8]][[4]],3),"] ");
    
    
    tt[j,5]<-ifelse(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]]<0.0001,"<0.0001****",
                    ifelse(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]]<0.001,"<0.001***",
                           ifelse(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]]<0.01,
                                  paste(signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]],2),"**",sep=""),
                                  ifelse(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]]<0.05,
                                         paste(signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]],2),"*",sep=""),
                                         ifelse(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]]<0.10,
                                                paste(signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]],2),"TREND",sep=" "),
                                                signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]],2))))));
    j<-j+1}}
  #write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) ;
  #print(noquote(tt));
  tt2=tt[order(tt[,5]),] ## ordonner les pvalues
  return(as.data.frame(tt2))
  rm(f,i,j,tt,x,y)
}
####____Fin
############################################################################################################
####____Survie bivari?e

coxarticleQUANTt<-function(x,t,y,w,nomdefichier)## arguments de la fonction
  #sortiequantit<-function(x,y,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonnes des variables QUANTITATIVES
{
  f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric" ) f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","Missing","N. pts","HR [95%CI]","p-Cox" ))
  j<-1;for (i in w) {if (sapply(x[i],data.class)[[1]]=="numeric")
  {
    tt[j,1]<-dimnames(x)[[2]][i];
    tt[j,2]<-length(x[i][is.na(x[i])]) ;
    tt[j,3]<-summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[4]]; 
    tt[j,4]<-paste(signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i]))[[8]][[1]],3)," [",signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i]))[[8]][[3]],3),"-",signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i]))[[8]][[4]],3),"] ");
    tt[j,5]<-
      signif(
        summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]],2);
    j<-j+1}}
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
  
  
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  noquote(tt);
  rm(f,i,j,tt,x,y)
}
####____Fin

############################################################################################################

####____Survie bivari?e
surviebicoxQUANT<-function(x,t,y,w)
  ## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  x[,y]<-as.factor(x[,y])
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),"Cox test" ))
  #dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1],"Min-Mediane-max[inf 95%-sup 95%]/Nobs"),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2],"Min-Mediane-max[inf 95%-sup 95%]/Nobs"),"Cox test" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-paste(length(x[,y][is.na(x[,y])]),"/",length(x[,i][is.na(x[,i])]));
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  x[,y]<-as.numeric(x[,y])
  tt[j,5]<-signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[7]][[5]],2);j<-j+1}
  #write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word ;
  #write.table(tt,file="D:/r/tabloquantibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,t,w)
}

surviebicoxQUANTt<-function(x,t,y,w,nomdefichier)
  ## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  x[,y]<-as.factor(x[,y])
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA-qual/NA-quant",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),"logrank test" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-paste(length(x[,y][is.na(x[,y])]),"/",length(x[,i][is.na(x[,i])]));
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  x[,y]<-as.numeric(x[,y])
  tt[j,5]<-signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[6]][[5]],2);j<-j+1}
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word ;
  #write.table(tt,file="D:/r/tabloquantibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel
  #mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  rm(f,i,j,tt,x,y,t,w,nomdefichier)
}
#### fin


####____Survie bivari?e

logrankarticle<-function(x,t,y,w)## 
  ## arguments de la fonction
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES doit ?tre binaire et qualitative
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)), c("Variable","Modality","HR","CI95%","p-Logrank" ))
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"");
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z==1,"",
                        survmed(
                          (survfit(Surv(x[,t],x[,y])~ x[,i])))
                        [[length(survmed(
                          (survfit(Surv(x[,t],x[,y])~ x[,i]))))*4/7+z-1]]
      );
      tt[j+z,4]<-ifelse(z==1,"",paste("[",survmed((survfit(Surv(x[,t],x[,y])~ x[,i])))
                                      [[length(survmed((survfit(Surv(x[,t],x[,y])~ x[,i]))))*5/7+z-1]],survmed((survfit(Surv(x[,t],x[,y])~ x[,i])))
                                      [[length(survmed((survfit(Surv(x[,t],x[,y])~ x[,i]))))*6/7+z-1]],"]"));
      tt[j+z,5]<-ifelse(z==1,signif(summary(coxph(Surv(x[,t],x[,y])~ x[,i])) [[9]][[ 3]],3),ifelse(z>1,"-",));
    }
    ;
    j<-j+k}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  #print(noquote(tt));
  rm(a,b,g,k,i,j,tt,z,x,y,w)
}
####____FIN

####FONCTION DE RANDOMISATION###

randobloc<- function()
{
  cat("Entrez le nombre de bras:","\n")
  nbbras<- as.integer(readline())
  noms<-vector()
  for (i in 1:nbbras)
  {
    cat("Tapez le nom du bras",i,":","\n")
    noms[i]<-readline()
  }
  cat("Quel est le nombre de patients pour chaque bras?","\n")
  n<- as.integer(readline())
  cat("Il est donc pr?vu d'inclure",n*nbbras,"patients","\n","\n","Proposez une taille de bloc:","\n")
  taillebloc<-as.integer(readline())
  while ( (taillebloc/nbbras)!= ceiling(taillebloc/nbbras) )
  {
    cat("Un bloc doit contenir des nombres de bras egaux!!","\n")
    cat("Sa taille doit etre un multiple de", nbbras, "(",nbbras,",",2*nbbras,",",3*nbbras,",",4*nbbras,",...)","\n","\n")
    cat("Proposez une taille de bloc:","\n")
    taillebloc<-as.integer(readline())
  }
  liste<- vector()
  bloc<- rep(noms, taillebloc/nbbras)
  nbblocs<- (n*nbbras)%/%taillebloc
  for (i in 1: nbblocs){ liste<- c(liste, sample(bloc,taillebloc))}
  reste<- (n*nbbras)%%taillebloc
  if (reste==0) {return(liste)}
  blocreste<- rep(noms,reste/nbbras)
  listereste<- sample(blocreste,reste)
  return(c(liste,listereste))
}
####____FIN



####____Mettre le fichier stat sur excel surexcel(stat)#

surexcel<-function(x)
{ #write.table(x,file="Q:/surexcel.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel 
  edit(file="Q:/surexcel.csv",editor= "C:/Program Files (x86)/Microsoft Office/Office14/excel.exe")}
####____FIN

surexcelt<-function(x,nomdefichier)
{
  write.table(x,paste(file_pour_les_tables_resultats,"tableau_",nomdefichier,".csv",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel 
  #write.table(x,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
  edit(file="Q:/surexcel.csv",editor= "C:/Program Files (x86)/Microsoft Office/Office14/excel.exe")
}
#####____FIN        

surexcelemmanuel<-function(x)
{write.csv(x,file="Q:/ETUDES/surexcel.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel 
  edit(file="Q:/BIOSTAT/surexcel.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")}
####____FIN

####____IC  proportion

icp<-function(){
  cat("IC% (ex: si IC95=>0.05):")
  alpha<-as.numeric(readline())
  cat("p (nb de succes):")
  x<-as.numeric(readline())
  cat("n (nombre total de cas):")
  n<-as.numeric(readline())
  p<-x/n
  q<-1-p
  ic95h<-p+qnorm(1-alpha/2)*((p*q/n)^0.5)
  ic95l<-p- qnorm(1-alpha/2)*((p*q/n)^0.5)
  cat("poucentage=", p*100,"%","\n" )
  cat("ic95l=", ic95l*100 ,"\n" )
  cat("ic95h=", ic95h*100 ,"\n" )
  rm(p,q,x,alpha,n)
}
####____FIN

#si on appelle le modele mod, il faut appeler 

odds<-function(x)
{
  oddsratio<-summary(mod)
  try<-as.data.frame(oddsratio$coefficient)
  try<-round(try,3)
  try1<-as.matrix(exp(try[,1]))
  try2<-as.matrix(exp(try[,1]-1.96*try[,2]))
  try3<-as.matrix(exp(try[,1]+1.96*try[,2]))
  try1<-round(try1,3)
  try2<-round(try2,3)
  try3<-round(try3,3)
  try4<-cbind(try1,"[",try2,"- ",try3,"]")
  dimnames(try4)[[2]]<-c("Odds ratio","["," ","IC95%","OR","]")
  try4<- as.data.frame(try4)
  try4<-try4[2:dim(try4)[[1]],]
  try5<-dimnames(try)[[1]][2:dim(try)[1]]
  tryf<-cbind(try5,try4)
  dimnames(tryf)[[2]][1]<-"Variables"
  tryf
}
####____FIN

oddsCOX<-function(x)
{
  oddsratio<-summary(mod)
  try<-as.data.frame(oddsratio$coefficients)
  try<-round(try,3)
  try1<-as.matrix(exp(try[,1]))
  try2<-as.matrix(exp(try[,1]-1.96*try[,3]))
  try3<-as.matrix(exp(try[,1]+1.96*try[,3]))
  try1<-round(try1,3)
  try2<-round(try2,3)
  try3<-round(try3,3)
  try4<-cbind(try1,"[",try2,"- ",try3,"]")
  dimnames(try4)[[2]]<-c("Hazard ratio","["," ","IC95%","OR","]")
  rownames(try4)<-rownames(try)
  try4<- as.data.frame(try4)
  try4<-try4[1:dim(try4)[[1]],]
  try4
}
####____FIN

####____Si on appelle le modele mod, il faut appeler 

oddsQUASIPOISSON<-function(x)
{ 
  oddsratio<-summary(mod)
  try<-as.data.frame(oddsratio[12])
  try<-round(try,3)
  try1<-as.matrix(exp(try[,1]))
  try2<-as.matrix(exp(try[,1]-1.96*try[,2]))
  try3<-as.matrix(exp(try[,1]+1.96*try[,2]))
  try1<-round(try1,3)
  try2<-round(try2,3)
  try3<-round(try3,3)
  try4<-cbind(try1,"[",try2,"- ",try3,"]")
  dimnames(try4)[[2]]<-c("Odds ratio","["," ","IC95%","OR","]")
  try4<- as.data.frame(try4)
  try4<-try4[2:dim(try4)[[1]],]
  try4
}
####____FIN

####____Pour une regression multinomiale ou polytomique 

odds_poly<-function(x)
{
  oddsratio<-summary(mod)
  try<-as.data.frame(oddsratio[1])
  try<-round(try,3)
  try1<-as.matrix(exp(try[,1]))
  try2<-as.matrix(exp(try[,1]-2*try[,2]))
  try3<-as.matrix(exp(try[,1]+2*try[,2]))
  try1<-round(try1,3)
  try2<-round(try2,3)
  try3<-round(try3,3)
  try4<-cbind(try1,"[",try2,"- ",try3,"]")
  dimnames(try4)[[2]]<-c("Odds ratio","["," ","IC95%","OR","]")
  try4<- as.data.frame(try4)
  try4<-try4[1: dim(as.matrix(mod[[1]]))[[1]],]
  try4
}
####____FIN





####____Tableau des VARIABLES(Num?ros de colonne et Noms)

tabcols2<-function(x) 
  #Nom de la table
{
  a<- length(dimnames(x)[[2]])
  sortie1<-matrix(data="NA",nr=a,nc=2)
  for (i in 1:a)
  {sortie1[i,1]<-i;
  sortie1[i,2]<-dimnames(x)[[2]][i]}
  sortie1<-as.data.frame(as.matrix((sortie1)))
  dimnames(sortie1)<-list(c(1:a),c("Num.","Variable"));
  #rm(a,i,x,sortie1)
}	
####____FIN

####____Survie mediane et IC95% sur un tableau

survmed<- function (x, scale = 1, digits = max(options()$digits - 4, 3),
                    print.n = getOption("survfit.print.n"), show.rmean = getOption("survfit.print.mean"),
                    ...) 
{
  print.n <- match.arg(print.n, c("none", "start", "records",
                                  "max"))
  
  omit <- x$na.action
  if (length(omit)) 
    cat("  ", naprint(omit), "\n")
  savedig <- options(digits = digits)
  on.exit(options(savedig))
  pfun <- function(nused, stime, surv, n.risk, n.event, lower, 
                   upper) {
    minmin <- function(y, xx) {
      ww <- getOption("warn")
      on.exit(options(warn = ww))
      options(warn = -1)
      if (any(!is.na(y) & y == 0.5)) {
        if (any(!is.na(y) & y < 0.5)) 
          0.5 * (min(xx[!is.na(y) & y == 0.5]) + min(xx[!is.na(y) & 
                                                          y < 0.5]))
        else 0.5 * (min(xx[!is.na(y) & y == 0.5]) + max(xx[!is.na(y) &
                                                             y == 0.5]))
      }
      else min(xx[!is.na(y) & y <= 0.5])
    }
    min.stime <- min(stime)
    min.time <- min(0, min.stime)
    n <- length(stime)
    hh <- c(ifelse((n.risk[-n] - n.event[-n]) == 0, 0, n.event[-n]/(n.risk[-n] * 
                                                                      (n.risk[-n] - n.event[-n]))), 0)
    ndead <- sum(n.event)
    dif.time <- c(diff(c(min.time, stime)), 0)
    if (is.matrix(surv)) {
      n <- nrow(surv)
      mean <- dif.time * rbind(1, surv)
      if (n == 1) 
        temp <- mean[2, , drop = FALSE]
      else temp <- (apply(mean[(n + 1):2, , drop = FALSE], 
                          2, cumsum))[n:1, , drop = FALSE]
      varmean <- c(hh %*% temp^2)
      med <- apply(surv, 2, minmin, stime)
      names(nused) <- NULL
      if (!is.null(upper)) {
        upper <- apply(upper, 2, minmin, stime)
        lower <- apply(lower, 2, minmin, stime)
        cbind(nused, ndead, apply(mean, 2, sum), sqrt(varmean), 
              med, lower, upper)
      }
      else {
        cbind(nused, ndead, apply(mean, 2, sum), sqrt(varmean), 
              med)
      }
    }
    else {
      mean <- dif.time * c(1, surv)
      varmean <- sum(rev(cumsum(rev(mean))^2)[-1] * hh)
      med <- minmin(surv, stime)
      if (!is.null(upper)) {
        upper <- minmin(upper, stime)
        lower <- minmin(lower, stime)
        c(nused, ndead, sum(mean), sqrt(varmean), med, 
          lower, upper)
      }
      else c(nused, ndead, sum(mean), sqrt(varmean), med)
    }
  }
  stime <- x$time/scale
  surv <- x$surv
  plab <- c("n", "events", "rmean", "se(rmean)", "median")
  if (!is.null(x$conf.int)) 
    plab2 <- paste(x$conf.int, c("LCL", "UCL"), sep = "")
  if (is.null(x$strata)) {
    nsubjects <- switch(print.n, none = NA, start = x$n.risk[1], 
                        records = x$n, max = max(x$n.risk))
    x1 <- pfun(nsubjects, stime, surv, x$n.risk, x$n.event, 
               x$lower, x$upper)
    if (is.matrix(x1)) {
      if (is.null(x$lower)) 
        dimnames(x1) <- list(NULL, plab)
      else dimnames(x1) <- list(NULL, c(plab, plab2))
    }
    else {
      if (is.null(x$lower)) 
        names(x1) <- plab
      else names(x1) <- c(plab, plab2)
    }
    if (show.rmean) 
      print(x1)
    #else if (is.matrix(x1))
    #print(x1[, !(colnames(x1) %in% c("rmean", "se(rmean)"))])
    #else print(x1[!(names(x1) %in% c("rmean", "se(rmean)"))])
  }
  else {
    nstrat <- length(x$strata)
    if (is.null(x$ntimes.strata)) 
      stemp <- rep(1:nstrat, x$strata)
    else stemp <- rep(1:nstrat, x$ntimes.strata)
    x1 <- NULL
    if (is.null(x$strata.all)) 
      strata.var <- x$strata
    else strata.var <- x$strata.all
    for (i in unique(stemp)) {
      who <- (stemp == i)
      nsubjects <- switch(print.n, none = NA, start = x$n.risk[who][1], 
                          records = strata.var[i], max = max(x$n.risk[who]))
      if (is.matrix(surv)) {
        temp <- pfun(nsubjects, stime[who], surv[who, 
                                                 , drop = FALSE], x$n.risk[who], x$n.event[who], 
                     x$lower[who, , drop = FALSE], x$upper[who, 
                                                           , drop = FALSE])
        x1 <- rbind(x1, temp)
      }
      else {
        temp <- pfun(nsubjects, stime[who], surv[who], 
                     x$n.risk[who], x$n.event[who], x$lower[who], 
                     x$upper[who])
        x1 <- rbind(x1, temp)
      }
    }
    temp <- names(x$strata)
    if (nrow(x1) > length(temp)) {
      nrep <- nrow(x1)/length(temp)
      temp <- rep(temp, rep(nrep, length(temp)))
    }
    if (is.null(x$lower)) 
      dimnames(x1) <- list(temp, plab)
    else dimnames(x1) <- list(temp, c(plab, plab2))
    #if (show.rmean)
    #print(x1)
    #else print(x1[, !(colnames(x1) %in% c("rmean", "se(rmean)"))])
  }
  return(x1)
}
####____FIN



####____Intergrer une table dane le fichier table cr?er au pr?alable intitule:file_pour_les_tables_resultats
#wt<- function(M,filename=NULL,row=F,col=F,path=NULL,...){
#if (!file.exists("tables")){dir.create("tables")}
#if (is.null(filename)){filename<- paste("table_",format(Sys.time(),"%Y-%m-%d_%H%M%S"),sep="")}
#if (is.null(path)){path<- c(file_pour_les_tables_resultats,sep="/")}
#write.table(M,file=paste(path,filename,".txt",sep=""),col.names=col,row.names=row,sep="\t",...)
#}
####____FIN

###____Intergrer une table dans le fichier table cr?er au pr?alable intitule:file_pour_les_tables_resultats

wt<- function(M,nomdefichier){
  write.csv2(M,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,eol="\n",na="NA",row.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  rm(M,nomdefichier)
}


wt.mat<- function(M,nomdefichier){
  write.matrix(M,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),sep=";") # Sauve le tableau pour le r?cup?rer sous word 
  rm(M,nomdefichier)
}
###FIN###




####____Survie bivari?e

surviebilogrankt<-function(x,t,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES 
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("VARIABLE","MODALITE",names(table(x[,y]))[1],names(table(x[,y]))[2],"p-Logrank" ))
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; 
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/a,2) ,"%)",sep=""),""); 
      tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/b,2) ,"%)",sep=""),""); 
      tt[j+z,5]<-ifelse(z>1,"-",ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.0001,"<0.0001", round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5)))
    }
    ;
    j<-j+k}
  
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) ;
  #write.table(tt,file="D:/r/tabloquantibiMOY.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel 
  #mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  rm(x,t,y,w,nomdefichier)
}
####____FIN




####____tableaux des CORRELATION de spearman entre variables QUANTITATIVES

cortabspearmant<-function(x,y,nomdefichier)## arguments de la fonct 
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 a 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],method="spearman" ,use="pairwise.complete.obs"),2));
  abs<-c("Correlation spearman",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  k<-1;for(i in y[c(1:length(y)-1)])
  {k<-k+1;for(j in y[c(k:length(y))])
  {print(paste("VARIABLES testees:",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j],method="spearman"))}}
  write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word ;
  #rm(a,b,g,k,i,j,tt,z,x,y,w,nomdefichier)
}
####____FIN

#############Odds _forest####

oddsforest<-function(x)
{
  oddsratio<-summary(x)
  try<-as.data.frame(oddsratio$coefficient)
  try<-round(try,3)
  try1<-as.matrix(exp(try[,1]))
  try2<-as.matrix(exp(try[,1]-2*try[,2]))
  try3<-as.matrix(exp(try[,1]+2*try[,2]))
  name1<-as.matrix(labels(summary(mod)[[12]])[[1]])
  m<-round(try1,3)
  l<-round(try2,3)
  u<-round(try3,3) 
  try4<-cbind(name1,m,"[",l,"- ",u,"]")
  dimnames(try4)[[2]]<-c("Nom variables","Odds ratio","["," ","IC95%","OR","]")
  try4<- as.matrix(try4)
  try4<-try4[2:dim(try4)[[1]],]
  a<-try4 
  nameodds<-a[,1]
  nameodds<-as.matrix(nameodds)
  print(nameodds)
  for (i in 1:( dim(nameodds)[[1]] ))
  {a[i] <- readline(cat("Remplacez le nom de la variable par le nom en 20 lettres max :"))
  while (nchar(a[i])>20) stop("Votre nom de variable est trop longue")
  }
  a[i]<- as.matrix(a[i])
  nameoddratio<-a[,1]
  m<-a[,2]
  l<-a[,4]
  u<-a[,6]
  m<-as.numeric(m)
  l<-as.numeric(l)
  lmin<-min(l)
  u<-as.numeric(u)
  umax<-max(u)
  m1<- c(NA,NA,m)
  l1<- c(NA,NA,l)
  u1<- c(NA,NA,u)
  tabletext<-cbind(c("  \n      ",NA,nameoddratio),
                   c("Odds\nratio",NA,format(m,digits=2)),
                   c("Lower\nlimit",NA,format(l,digits=2)),
                   c("Upper\nlimit",NA,format(u,digits=2)))                 
  
  par(mar=c(1,2,2,1))
  forestplot(tabletext,m1,l1,u1,zero=1,is.summary=c(TRUE,rep(FALSE,10),TRUE),clip=c(0.15,4),xlog=FALSE,xticks=NULL,graphwidth=unit(5,"inches"),
             col=meta.colors(box="magenta",line="blue",zero="red",text="black", summary="royalblue"),boxsize=0.75,font=1)
  #forestplot(tabletext,m1,l1,u1,zero=1,is.summary=c(TRUE,rep(FALSE,10),TRUE),clip=c((if (lmin>0.15) lmin else 0.15),(if (lmax<4) lmax else 4)),xlog=FALSE,xticks=NULL,graphwidth=unit(5,"inches"),
  #col=meta.colors(box="magenta",line="blue",zero="red",text="black", summary="royalblue"),boxsize=0.75,font=1)
}
#########___________FIN

#############Odds _forest####

oddsforestEC<-function(x)
{
  oddsratio<-summary(x)
  try<-as.data.frame(oddsratio$coefficient)
  try<-round(try,3)
  try1<-as.matrix(exp(try[,1]))
  try2<-as.matrix(exp(try[,1]-2*try[,2]))
  try3<-as.matrix(exp(try[,1]+2*try[,2]))
  name1<-as.matrix(labels(summary(mod)[[13]])[[1]])
  m<-round(try1,3)
  l<-round(try2,3)
  u<-round(try3,3) 
  try4<-cbind(name1,m,"[",l,"- ",u,"]")
  dimnames(try4)[[2]]<-c("Nom variables","Odds ratio","["," ","IC95%","OR","]")
  try4<- as.matrix(try4)
  try4<-try4[2:dim(try4)[[1]],]
  a<-try4 
  nameodds<-a[,1]
  nameodds<-as.matrix(nameodds)
  print(nameodds)
  for (i in 1:( dim(nameodds)[[1]] ))
  {a[i] <- readline(cat("Remplacez le nom de la variable par le nom en 20 lettres max :"))
  while (nchar(a[i])>20) stop("Votre nom de variable est trop longue")
  }
  a[i]<- as.matrix(a[i])
  nameoddratio<-a[,1]
  m<-a[,2]
  l<-a[,4]
  u<-a[,6]
  m<-as.numeric(m)
  l<-as.numeric(l)
  lmin<-min(l)
  u<-as.numeric(u)
  umax<-max(u)
  m1<- c(NA,NA,m)
  l1<- c(NA,NA,l)
  u1<- c(NA,NA,u)
  tabletext<-cbind(c("  \n      ",NA,nameoddratio),
                   c("Odds\nratio",NA,format(m,digits=2)),
                   c("Lower\nlimit",NA,format(l,digits=2)),
                   c("Upper\nlimit",NA,format(u,digits=2)))                 
  
  par(mar=c(1,2,2,1))
  forestplot(tabletext,m1,l1,u1,zero=1,is.summary=c(TRUE,rep(FALSE,10),TRUE),clip=c(0.15,4),xlog=FALSE,xticks=NULL,graphwidth=unit(5,"inches"),
             col=meta.colors(box="magenta",line="blue",zero="red",text="black", summary="royalblue"),boxsize=0.75,font=1)
  #forestplot(tabletext,m1,l1,u1,zero=1,is.summary=c(TRUE,rep(FALSE,10),TRUE),clip=c((if (lmin>0.15) lmin else 0.15),(if (lmax<4) lmax else 4)),xlog=FALSE,xticks=NULL,graphwidth=unit(5,"inches"),
  #col=meta.colors(box="magenta",line="blue",zero="red",text="black", summary="royalblue"),boxsize=0.75,font=1)
}
#########___________FIN

#########___________DEBUT
####### diagnosisI_0 meme chose quediagnisisI mais prend en compte les 0, l'odds ratio est remplac? par 999
diagnosisI_0<-function (TP, FN, FP, TN, CL = 0.95, print = TRUE, plot = FALSE) 
{
  tab <- as.table(cbind(rbind(TN, FP), rbind(FN, TP)))
  dimnames(tab) <- list(test = c("negative", "positive"), gold.standard = c("negative", 
                                                                            "positive"))
  tabmarg <- addmargins(tab)
  Conf.limit <- CL
  n <- sum(tab)
  p <- (TP + FN)/n
  Se <- TP/(TP + FN)
  Se.cl <- as.numeric(binom.wilson(TP, TP + FN, conf.level = CL)[4:5])
  Sp <- TN/(FP + TN)
  Sp.cl <-as.numeric(binom.wilson(TN, FP + TN, conf.level = CL)[4:5])
  PLR <- Se/(1 - Sp)
  PLR.inf.cl <-exp(log(PLR) - (qnorm(1 - ((1 - CL)/2), mean = 0, 
                                     sd = 1)) * sqrt((1 - Se)/((TP + FN) * Sp) + (Sp)/((FP + 
                                                                                          TN) * (1 - Sp))))
  PLR.sup.cl <-exp(log(PLR) + (qnorm(1 - ((1 - CL)/2), mean = 0, 
                                     sd = 1)) * sqrt((1 - Se)/((TP + FN) * Sp) + (Sp)/((FP + 
                                                                                          TN) * (1 - Sp))))
  NLR <- (1 - Se)/Sp
  NLR.inf.cl <-exp(log(NLR) - (qnorm(1 - ((1 - CL)/2), mean = 0, 
                                     sd = 1)) * sqrt((Se)/((TP + FN) * (1 - Se)) + (1 - Sp)/((FP + 
                                                                                                TN) * (Sp))))
  NLR.sup.cl <-exp(log(NLR) + (qnorm(1 - ((1 - CL)/2), mean = 0, 
                                     sd = 1)) * sqrt((Se)/((TP + FN) * (1 - Se)) + (1 - Sp)/((FP + 
                                                                                                TN) * (Sp))))
  accu <- (TP + TN)/n
  accu.cl <- as.numeric(binom.wilson(TP + TN, n, conf.level = CL)[4:5])
  PPV <- TP/(TP + FP)
  PPV.cl <- as.numeric(binom.wilson(TP, TP + FP, conf.level = CL)[4:5])
  NPV <- TN/(TN + FN)
  NPV.cl <- as.numeric(binom.wilson(TN, TN + FN, conf.level = CL)[4:5])
  OR <- 999
  #oddsratio(tab, conf.level = CL)
  DOR <- 999
  #OR$measure[2, 1]
  DOR.inf.cl <- 999
  #OR$measure[2, 2]
  DOR.sup.cl <- 999
  #OR$measure[2, 3]
  rm(OR)
  ER <- (FN + FP)/n
  ER.cl <-as.numeric(binom.wilson(FN + FP, n, conf.level = CL)[4:5])
  ET <- (FN/FP)
  AUC <-(Se + Sp)/2
  if (plot == TRUE) {
    plot(1 - Sp, Se, xlim = c(0, 1), ylim = c(0, 1))
    segments(0, 0, 1 - Sp, Se, col = "red")
    segments(1 - Sp, Se, 1, 1, col = "red")
    grid()
  }
  Youden <- Se + Sp - 1
  Youden.inf.cl <- Youden - qnorm(CL/2) * sqrt(((Se * (1 - 
                                                         Se))/(TP + FN) + ((Sp * (1 - Sp))/(TN + FP))))
  Youden.sup.cl <- Youden + qnorm(CL/2) * sqrt(((Se * (1 - 
                                                         Se))/(TP + FN) + ((Sp * (1 - Sp))/(FP + TN))))
  rm(tab)
  reteval <- list(tabmarg = tabmarg, n = n, p = p, Se = Se, 
                  Se.cl = Se.cl, Sp = Sp, Sp.cl = Sp.cl, PLR = PLR, PLR.inf.cl = PLR.inf.cl, 
                  PLR.sup.cl = PLR.sup.cl, NLR = NLR, NLR.inf.cl = NLR.inf.cl, 
                  NLR.sup.cl = NLR.sup.cl, accu = accu, accu.cl = accu.cl, 
                  PPV = PPV, PPV.cl = PPV.cl, NPV = NPV, NPV.cl = NPV.cl, 
                  DOR = DOR, DOR.inf.cl = DOR.inf.cl, DOR.sup.cl = DOR.sup.cl, 
                  ET = ET, ER = ER, ER.cl = ER.cl, Youden = Youden, Youden.inf.cl = Youden.inf.cl, 
                  Youden.sup.cl = Youden.sup.cl, AUC = AUC, Conf.limit = Conf.limit)
  class(reteval) <- "diag"
  if (print == TRUE) {
    print(reteval)
  }
  invisible(reteval)
}
#########___________FIN




##############################################################Test de Dunnet et Gent (? am?liorer)#################################################

#Non inferiorit? dunnett et gent
#Exemple article Dunnet
#> dunnett.non.inf()
#x (succes trt de ref):148
#y (succes trt nouveau):115
#n1 (total trt de ref):225
#n2 (total trt nouveau):167
#delta(0,1=10%):0.1
#delta= 0.1
#Khi2= 7.392783
#Khi2corr= 6.815094
#p= 0.003274
#p.corr= 0.00452

dunnett<-function(){
  cat("x (succes trt de ref):")
  x<-as.numeric(readline())
  cat("y (succes trt nouveau):")
  y<-as.numeric(readline())
  cat("n1 (total trt de ref):")
  n1<-as.numeric(readline())
  cat("n2 (total trt nouveau):")
  n2<-as.numeric(readline())
  cat("delta(saisir 0,1 pour 10%):")
  d<-as.numeric(readline())
  m<-x+y
  t<-n1+n2
  pi1<-((m+(n2*d))/t)
  pi2<-((m-(n1*d))/t)
  xb<-n1*pi1
  yb<-n2*pi2
  khi2<-round(((x-xb)^2)*((1/xb)+(1/(m-xb))+(1/(n1-xb))+(1/(n2-m+xb))),6)
  khi2corr<-round(((abs(x-xb)-0.5)^2)*((1/xb)+(1/(m-xb))+(1/(n1-xb))+(1/(n2-m+xb))),6)
  pkhi2<- round((pchisq(khi2,1,lower.tail=F)/2),6)
  pkhi2corr<- round((pchisq(khi2corr,1,lower.tail=F)/2),6)
  cat("delta=", d ,"\n" )
  cat("Khi2=", khi2,"\n")
  cat("Khi2corr=", khi2corr,"\n")
  cat("p=", pkhi2,"\n")
  cat("p.corr=", pkhi2corr,"\n")
  rm(pkhi2, pkhi2corr, khi2corr, khi2, yb, xb, pi2, pi1, t,m,d,n2,n1,y,x)
}

#######  fonction pour sectionner une certaine partie des nombres dans un tirage al?atoire de nombres suivant une loi normal

rando_normale_borne<-function(){
  cat("n(Nombre de tirages al?atoires):")
  n<-as.numeric(readline())
  cat("m(Moyenne):")
  m<-as.numeric(readline())
  cat("s(Ecart-type):")
  s<-as.numeric(readline())
  cat("min(borne min ? ne pas d?passer):")
  min<-as.numeric(readline())
  cat("max(borne max ? ne pas d?passer):")
  max<-as.numeric(readline())
  
  repeat{
    stat<-rnorm(n,m,s)
    stat<-as.matrix(stat)
    stat1<-stat
    for (i in 1:( dim(stat1)[[1]]))
    {if ((min<stat1[i]&& stat1[i]< max)) stat1[i]<-0 else stat1[i]<-1
    }
    somme<-sum(stat1)
    somme<-as.numeric(somme)
    #print(somme)
    moyenne<-mean(stat)
    moyenne<-as.numeric(moyenne)
    #print(moyenne)
    ;if(somme==0 & ((m-((m*5)/100))<= moyenne & moyenne <= (m+((m*5)/100)))){break}}
  
  print(round(stat,2))
}
#return_fonction<-round(rando_normale_borne(),2)


##################################################################################################################################################

randobloc<- function(){
  cat("Entrez le nombre de bras:","\n")
  nbbras<- as.integer(readline())
  
  noms<-vector()
  for (i in 1:nbbras){
    cat("Tapez le nom du bras",i,":","\n")
    noms[i]<-readline()
  }
  
  cat("Quel est le nombre de patients pour chaque bras?","\n")
  n<- as.integer(readline())
  
  cat("Il est donc pr?vu d'inclure",n*nbbras,"patients","\n","\n","Proposez une taille de bloc:","\n")
  
  taillebloc<-as.integer(readline())
  
  while ( (taillebloc/nbbras)!= ceiling(taillebloc/nbbras) ){
    cat("Un bloc doit contenir des nombres de bras egaux!!","\n")
    
    cat("Sa taille doit etre un multiple de", nbbras, "(",nbbras,",",2*nbbras,",",3*nbbras,",",4*nbbras,",...)","\n","\n")
    cat("Proposez une taille de bloc:","\n")
    taillebloc<-as.integer(readline())
  }
  
  
  
  liste<- vector()
  
  bloc<- rep(noms, taillebloc/nbbras)
  nbblocs<- (n*nbbras)%/%taillebloc
  
  
  for (i in 1: nbblocs){ liste<- c(liste, sample(bloc,taillebloc))}
  
  
  reste<- (n*nbbras)%%taillebloc
  if (reste==0) {return(liste)}
  blocreste<- rep(noms,reste/nbbras)
  listereste<- sample(blocreste,reste)
  
  return(c(liste,listereste))
  
}

#Matrice MTMM avec cex=2
MTMM_CEX<-function (datafile, x, color = FALSE, graph = FALSE, graphItem = FALSE) 
{
  par.old <- par("mfrow")
  k <- 1
  name <- nam <- c()
  r2 <- c()
  nn <- c()
  nbdim <- length(x)
  X <- list()
  n <- as.data.frame(matrix(nrow = 1, ncol = nbdim))
  for (i in 1:nbdim) {
    X[[i]] <- datafile[, x[[i]]]
  }
  for (i in 1:nbdim) {
    n[i] <- length(X[[i]])
  }
  nn <- c(nn, n)
  k <- 1
  for (i in 1:nbdim) {
    nameD <- as.data.frame(matrix(nrow = n[[i]], ncol = nbdim))
    nameD[i] <- names(X[[i]])
    for (j in 1:nbdim) {
      r <- as.data.frame(matrix(nrow = n[[i]], ncol = n[[j]]))
      r <- cor(X[i][[1]], X[j][[1]])
      r2[k] <- list(r)
      k <- k + 1
    }
    name <- c(name, nameD[i])
    nam <- c(nam, name[[i]])
  }
  a <- seq(from = 1, to = length(r2), by = (nbdim + 1))
  X1 <- r2[a]
  X2 <- r2[-a]
  p1 <- length(X1)
  p2 <- length(X2)
  correlation <- c()
  dimension <- c()
  mat <- c()
  V1 <- c()
  V2 <- c()
  k1 <- c()
  for (q in 1:nbdim) {
    w <- seq(from = 1, to = nn[[q]])
    k = 0
    for (i in 1:(nn[[q]] - 1)) {
      k <- w[i] + k
    }
    k1 <- c(k1, k)
  }
  for (l in 1:p1) {
    mat1 <- matrix(ncol = 1, nrow = k1[l])
    mat2 <- matrix(ncol = 1, nrow = k1[l])
    mat3 <- matrix(ncol = 1, nrow = k1[l])
    Var1 <- matrix(ncol = 1, nrow = k1[l])
    Var2 <- matrix(ncol = 1, nrow = k1[l])
    k = 1
    for (i in 1:(nn[[l]] - 1)) {
      for (j in (i + 1):nn[[l]]) {
        mat1[k, 1] <- X1[[l]][j, i]
        mat2[k, 1] <- l
        mat3[k, 1] <- l
        Var1[k, 1] <- attributes(X1[[l]])$dimnames[[1]][i]
        Var2[k, 1] <- attributes(X1[[l]])$dimnames[[1]][j]
        k = k + 1
      }
    }
    correlation <- append(correlation, mat1)
    dimension <- append(dimension, c(mat2))
    mat <- append(mat, c(mat3))
    V1 <- append(V1, c(Var1))
    V2 <- append(V2, c(Var2))
  }
  er <- cbind(dimension, mat, V1, V2)
  er <- as.data.frame(er)
  er$correlation <- correlation
  er1 <- c()
  V1 <- c()
  V2 <- c()
  for (l in 1:p2) {
    k <- 1
    mat1 <- matrix(ncol = 1, nrow = ((dim(X2[[l]])[2]) * 
                                       (dim(X2[[l]])[1])))
    Var1 <- matrix(ncol = 1, nrow = ((dim(X2[[l]])[2]) * 
                                       (dim(X2[[l]])[1])))
    Var2 <- matrix(ncol = 1, nrow = ((dim(X2[[l]])[2]) * 
                                       (dim(X2[[l]])[1])))
    for (i in 1:(dim(X2[[l]])[1])) {
      for (j in 1:(dim(X2[[l]])[2])) {
        mat1[k, 1] <- X2[[l]][i, j]
        Var1[k, 1] <- rep(attributes(X2[[l]])$dimnames[[1]][i], 
                          each = (dim(X2[[l]])[2]))[j]
        Var2[k, 1] <- attributes(X2[[l]])$dimnames[[2]][j]
        k <- k + 1
      }
    }
    er1 <- append(er1, c(mat1))
    V1 <- append(V1, c(Var1))
    V2 <- append(V2, c(Var2))
  }
  err <- cbind(V1, V2)
  err <- as.data.frame(err)
  err$correlation <- er1
  i2 <- c()
  i1 <- c()
  for (k in 1:(nrow(err))) {
    for (l in 1:p1) {
      if (err$V2[k] %in% name[[l]]) 
        i2[k] <- l
      if (err$V1[k] %in% name[[l]]) 
        i1[k] <- l
    }
  }
  err$mat <- i2
  err$dimension <- i1
  corre <- rbind(er, err)
  col <- Y <- c()
  for (i in 1:nbdim) {
    if (color == FALSE) {
      col <- rep("white", times = nbdim)
      col[i] <- c("grey")
    }
    else col <- 2:nbdim
    Y[i] <- list(col)
  }
  if (graphItem == FALSE) {
    for (i in 1:p1) {
      Dim <- subset(corre, (corre$dimension == i), drop = TRUE)
      boxplot(Dim$correlation ~ Dim$mat, col = Y[[i]], 
              main = paste("Scale", i, sep = " "), xlab = "i", 
              ylab = paste("Correlation of Items of scale i with Items of Scale", 
                           i), ylim = c(min(unlist(r2)), 1))
    }
  }
  n2 <- nrow(X[[1]])
  Score <- matrix(nrow = n2, ncol = nbdim)
  for (i in 1:nbdim) {
    k <- 1
    for (j in 1:n2) {
      Score[k, i] <- sum(X[[i]][j, ])
      k <- k + 1
    }
  }
  Scoreaj <- c()
  mat <- c()
  mat2 <- c()
  for (i in 1:nbdim) {
    Scorea <- matrix(nrow = n2, ncol = nn[[i]])
    for (j in 1:(nn[[i]])) {
      for (l in 1:n2) {
        Scorea[l, j] <- Score[l, i] - X[[i]][l, j]
      }
    }
    Scoreaj[i] <- list(Scorea)
    mat <- rep(Score[, i], each = nn[[i]])
    dim(mat) <- c(nn[[i]], n2)
    mat2[i] <- list(t(mat))
  }
  Scale <- ScaleI <- Item <- co <- c <- c()
  t <- 0
  for (i in 1:nbdim) {
    t <- t + as.numeric(nn[i])
    for (j in 1:nbdim) {
      for (k in 1:nn[[i]]) {
        if (i == j) {
          Score <- Scoreaj[[i]][, k]
          c <- c(c, cor(Score, X[[i]][, k]))
          Item <- c(Item, names(X[[i]][k]))
          ScaleI <- c(ScaleI, i)
          Scale <- c(Scale, j)
        }
        else {
          c <- c(c, cor(X[[i]], mat2[[j]][, 1])[k])
          Item <- c(Item, names(X[[i]][k]))
          ScaleI <- c(ScaleI, i)
          Scale <- c(Scale, j)
        }
      }
    }
  }
  co <- c(co, c)
  err <- as.data.frame(cbind(Item, Scale))
  err$ScaleI <- ScaleI
  err$correlation <- co
  tabl <- reshape(err, direction = "wide", timevar = "Scale", 
                  idvar = "Item", v.names = c("correlation"))
  for (i in 1:nbdim) {
    colnames(tabl)[i + 2] <- c(paste("Scale", i, sep = " "))
  }
  if (graph == TRUE & graphItem == FALSE) {
    x11()
    par(mfrow = par.old)
    for (i in 1:nbdim) {
      Dim <- subset(err, (err$Scale == i), drop = TRUE)
      boxplot(Dim$correlation ~ Dim$ScaleI, col = Y[[i]], 
              main = paste("Scale", i, sep = " "), ylim = c(min(unlist(r2)), 
                                                            1), cex.main=1.5,cex.axis = 1.5,cex.lab=1.5, xlab = "i", ylab = paste("Correlation of Items of scale i with score scale", 
                                                                                                                                  i))
    }
  }
  if (graphItem == TRUE) {
    for (i in 1:nbdim) {
      Dim <- subset(err, (err$Scale == i), drop = TRUE)
      Dim$Item <- factor(Dim$Item, levels = unique(as.character(Dim$Item)))
      with(Dim, stripchart(correlation ~ Item, vertical = TRUE, 
                           add = FALSE, main = paste("Score of Scale", i, 
                                                     sep = " "), xlab = "Item", ylab = "Correlation", 
                           ylim = c(min(unlist(r2)), 1), cex.axis = 1, las = 3, 
                           pch = 20, cex = 0.75))
      abline(h = median(Dim$correlation), col = "red")
    }
  }
  return(tabl)
}
####### corr?lation #############
cortabsign<-function(x,y,nomdefichier)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 ? 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],use="pairwise.complete.obs"),2));
  for (i in 1:length((t))) 
  {
    if(abs(t[i]>0.3)) t[i]<-t[i] else t[i]<-"~"
  }
  abs<-c("Cor_Pearson",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  k<-1;for(i in y[c(1:length(y)-1)])
  {k<-k+1;for(j in y[c(k:length(y))])
  {print(paste("p.value: variables test?es",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j])$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortab.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/cortab.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  print(tt)
  ft <- flextable(as.data.frame(tt))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  #####
  
  return(ft)
  #####
  
  #print(noquote(tt));
  #{write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
  #rm(x,y,k)
  #{write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
  #rm(x,y,k)
}
#}

################################################ Spearman ###############################################################################################

cortabspearmansign<-function(x,y,nomdefichier)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 a 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],method="spearman",use="pairwise.complete.obs"),2));
  for (i in 1:length((t))) {if(abs(t[i]>0.3)) t[i]<-t[i] else t[i]<-"~"}
  abs<-c("Cor_spearman",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  k<-1;for(i in y[c(1:length(y)-1)])
  {k<-k+1;for(j in y[c(k:length(y))])
  {print(paste("p.value: variables testees:",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j],method="spearman")$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortabis.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/cortabis.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  print(tt)
  ft <- flextable(as.data.frame(tt))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  #####
  
  return(ft)
  #####
  
  # #print(noquote(tt));
  #{write.table(tt,paste(file_pour_les_tables_resultats,"table_",nomdefichier,".txt",sep=""),append=F,quote=F#,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)
  ##rm(x,y,k)
  #}
}

##################################################TableStack_0 est comme TableStack, mais accepte les colonnes vide###################################################################################

tableStack<-function (vars, minlevel = "auto", maxlevel = "auto", count = TRUE, 
                      na.rm = FALSE, means = TRUE, medians = FALSE, sds = TRUE, 
                      decimal = 1, dataFrame = .data, total = TRUE, var.labels = TRUE, 
                      var.labels.trunc = 150, reverse = FALSE, vars.to.reverse = NULL, 
                      by = NULL, vars.to.factor = NULL, iqr = "auto", prevalence = FALSE, 
                      percent = c("column", "row", "none"), frequency = TRUE, test = TRUE, 
                      name.test = TRUE, total.column = FALSE, simulate.p.value = FALSE, 
                      sample.size = TRUE,na.col=FALSE) 
{
  nl <- as.list(1:ncol(dataFrame))
  names(nl) <- names(dataFrame)
  selected <- eval(substitute(vars), nl, parent.frame())
  by.var <- eval(substitute(by), nl, parent.frame())
  if (is.numeric(by.var)) {
    by <- dataFrame[, by.var]
  }
  if (is.character(by.var)) {
    by1 <- as.factor(rep("Total", nrow(dataFrame)))
  }
  if (is.null(by)) {
    selected.class <- NULL
    for (i in selected) {
      selected.class <- c(selected.class, class(dataFrame[, 
                                                          i]))
    }
    if (length(table(table(selected.class))) > 1) 
      warning("Without 'by', classes of all selected variables should be the same.")
  }
  selected.to.factor <- eval(substitute(vars.to.factor), nl, 
                             parent.frame())
  if (!is.character(iqr)) {
    selected.iqr <- eval(substitute(iqr), nl, parent.frame())
    intersect.selected <- intersect(selected.iqr, selected.to.factor)
    if (length(intersect.selected) != 0) {
      stop(paste(names(dataFrame)[intersect.selected], 
                 "cannot simultaneously describe IQR and be coerced factor"))
    }
    for (i in selected.iqr) {
      if (!is.integer(dataFrame[, i]) & !is.numeric(dataFrame[, 
                                                              i])) {
        stop(paste(names(dataFrame)[i], "is neither integer nor numeric, not possible to compute IQR"))
      }
    }
  }
  for (i in selected) {
    if ((class(dataFrame[, i]) == "integer" | class(dataFrame[, 
                                                              i]) == "numeric") & !is.null(by)) {
      if (any(selected.to.factor == i)) {
        dataFrame[, i] <- factor(dataFrame[, i])
      }
      else {
        dataFrame[, i] <- as.numeric(dataFrame[, i])
      }
    }
  }
  if ((reverse || suppressWarnings(!is.null(vars.to.reverse))) && 
      is.factor(dataFrame[, selected][, 1])) {
    stop("Variables must be in 'integer' class before reversing. \n        Try 'unclassDataframe' first'")
  }
  selected.dataFrame <- dataFrame[, selected, drop = FALSE]
  if (is.null(by)) {
    selected.matrix <- NULL
    for (i in selected) {
      selected.matrix <- cbind(selected.matrix, unclass(dataFrame[, 
                                                                  i]))
    }
    colnames(selected.matrix) <- names(selected.dataFrame)
    if (minlevel == "auto") {
      minlevel <- min(selected.matrix, na.rm = TRUE)
    }
    if (maxlevel == "auto") {
      maxlevel <- max(selected.matrix, na.rm = TRUE)
    }
    nlevel <- as.list(minlevel:maxlevel)
    names(nlevel) <- eval(substitute(minlevel:maxlevel), 
                          nlevel, parent.frame())
    if (suppressWarnings(!is.null(vars.to.reverse))) {
      nl1 <- as.list(1:ncol(dataFrame))
      names(nl1) <- names(dataFrame[, selected])
      which.neg <- eval(substitute(vars.to.reverse), nl1, 
                        parent.frame())
      for (i in which.neg) {
        dataFrame[, selected][, i] <- maxlevel + 1 - 
          dataFrame[, selected][, i]
        selected.matrix[, i] <- maxlevel + 1 - selected.matrix[, 
                                                               i]
      }
      reverse <- FALSE
      sign1 <- rep(1, ncol(selected.matrix))
      sign1[which.neg] <- -1
    }
    if (reverse) {
      matR1 <- cor(selected.matrix, use = "pairwise.complete.obs")
      diag(matR1) <- 0
      if (any(matR1 > 0.98)) {
        reverse <- FALSE
        temp.mat <- which(matR1 > 0.98, arr.ind = TRUE)
        warning(paste(paste(rownames(temp.mat), collapse = " and ")), 
                " are extremely correlated.", "\n", "  The command has been excuted without 'reverse'.", 
                "\n", "  Remove one of them from 'vars' if 'reverse' is required.")
      }
      else {
        score <- factanal(na.omit(selected.matrix), factors = 1, 
                          scores = "regression")$score
        sign1 <- NULL
        for (i in 1:length(selected)) {
          sign1 <- c(sign1, sign(cor(score, na.omit(selected.matrix)[, 
                                                                     i], use = "pairwise")))
        }
        which.neg <- which(sign1 < 0)
        for (i in which.neg) {
          dataFrame[, selected][, i] <- maxlevel + minlevel - 
            dataFrame[, selected][, i]
          selected.matrix[, i] <- maxlevel + minlevel - 
            selected.matrix[, i]
        }
      }
    }
    table1 <- NULL
    for (i in as.integer(selected)) {
      if (!is.factor(dataFrame[, i]) & !is.logical(dataFrame[, 
                                                             i, drop = TRUE])) {
        x <- factor(dataFrame[, i])
        levels(x) <- nlevel
        tablei <- table(x)
      }
      else {
        if (is.logical(dataFrame[, i, drop = TRUE])) {
          tablei <- table(factor(dataFrame[, i, drop = TRUE], 
                                 levels = c("FALSE", "TRUE")))
        }
        else {
          tablei <- table(dataFrame[, i])
        }
      }
      if (count) {
        tablei <- c(tablei, length(na.omit(dataFrame[, 
                                                     i])))
        names(tablei)[length(tablei)] <- "count"
      }
      if (is.numeric(selected.dataFrame[, 1, drop = TRUE]) | 
          is.logical(selected.dataFrame[, 1, drop = TRUE])) {
        if (means) {
          tablei <- c(tablei, round(mean(as.numeric(dataFrame[, 
                                                              i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "mean"
        }
        if (medians) {
          tablei <- c(tablei, round(median(as.numeric(dataFrame[, 
                                                                i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "median"
        }
        if (sds) {
          tablei <- c(tablei, round(sd(as.numeric(dataFrame[, 
                                                            i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "sd"
        }
      }
      table1 <- rbind(table1, tablei)
    }
    results <- as.table(table1)
    if (var.labels) {
      rownames(results) <- names(selected.dataFrame)
    }
    else {
      rownames(results) <- paste(selected, ":", names(selected.dataFrame))
    }
    if (is.integer(selected.dataFrame[, 1])) {
      rownames(results) <- names(nl)[selected]
      if (is.factor(dataFrame[, selected][, 1])) {
        colnames(results)[1:(ncol(results) - (count + 
                                                means + medians + sds))] <- levels(dataFrame[, 
                                                                                             selected][, 1])
      }
      else {
        colnames(results)[1:(ncol(results) - (count + 
                                                means + medians + sds))] <- names(nlevel)
      }
    }
    result0 <- results
    if (var.labels) {
      if (!is.null(attributes(dataFrame)$var.labels)) {
        results <- as.table(cbind(results, substr(attributes(dataFrame)$var.labels[selected], 
                                                  1, var.labels.trunc)))
      }
      if (!is.null(attributes(dataFrame)$var.labels)) 
        colnames(results)[ncol(results)] <- "description"
    }
    if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[, 
                                                                            1]) | is.logical(selected.dataFrame[, 1])) {
      if (reverse || (!is.null(vars.to.reverse))) {
        Reversed <- ifelse(sign1 < 0, "    x   ", "    .   ")
        results <- cbind(Reversed, results)
      }
      sumMeans <- 0
      sumN <- 0
      for (i in selected) {
        sumMeans <- sumMeans + mean(as.numeric(dataFrame[, 
                                                         i]), na.rm = TRUE) * length(na.omit(dataFrame[, 
                                                                                                       i]))
        sumN <- sumN + length(na.omit(dataFrame[, i]))
      }
      mean.of.total.scores <- weighted.mean(rowSums(selected.matrix), 
                                            w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.total.scores <- sd(rowSums(selected.matrix), 
                               na.rm = TRUE)
      mean.of.average.scores <- weighted.mean(rowMeans(selected.matrix), 
                                              w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.average.scores <- sd(rowMeans(selected.matrix), 
                                 na.rm = TRUE)
      countCol <- which(colnames(results) == "count")
      meanCol <- which(colnames(results) == "mean")
      sdCol <- which(colnames(results) == "sd")
      if (total) {
        results <- rbind(results, rep("", reverse || 
                                        suppressWarnings(!is.null(vars.to.reverse)) + 
                                        (maxlevel + 1 - minlevel) + (count + means + 
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length((rowSums(selected.dataFrame))[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.total.scores, 
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.total.scores, 
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Total score"
        results <- rbind(results, rep("", reverse || 
                                        suppressWarnings(!is.null(vars.to.reverse)) + 
                                        (maxlevel + 1 - minlevel) + (count + means + 
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length(rowSums(selected.dataFrame)[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.average.scores, 
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.average.scores, 
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Average score"
      }
    }
    results <- list(results = noquote(results))
    if (reverse || suppressWarnings(!is.null(vars.to.reverse))) 
      results <- c(results, list(items.reversed = names(selected.dataFrame)[sign1 < 
                                                                              0]))
    if (var.labels && !is.null(attributes(dataFrame)$var.labels)) {
      results <- c(results, list(item.labels = attributes(dataFrame)$var.labels[selected]))
    }
    if (total) {
      if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[, 
                                                                              1])) {
        results <- c(results, list(total.score = rowSums(selected.matrix)), 
                     list(mean.score = rowMeans(selected.matrix, 
                                                na.rm = na.rm)), list(mean.of.total.scores = mean.of.total.scores, 
                                                                      sd.of.total.scores = sd.of.total.scores, 
                                                                      mean.of.average.scores = mean.of.average.scores, 
                                                                      sd.of.average.scores = sd.of.average.scores))
      }
    }
    class(results) <- c("tableStack", "list")
    results
  }
  else {
    if (is.character(by.var)) {
      by1 <- as.factor(rep("Total", nrow(dataFrame)))
    }
    else {
      by1 <- factor(dataFrame[, by.var])
    }
    if (is.logical(dataFrame[, i])) {
      dataFrame[, i] <- as.factor(dataFrame[, i])
      levels(dataFrame[, i]) <- c("No", "Yes")
    }
    if (length(table(by1)) == 1) 
      test <- FALSE
    name.test <- ifelse(test, name.test, FALSE)
    if (is.character(iqr)) {
      if (iqr == "auto") {
        selected.iqr <- NULL
        for (i in 1:length(selected)) {
          if (class(dataFrame[, selected[i]]) == "difftime") {
            dataFrame[, selected[i]] <- as.numeric(dataFrame[, 
                                                             selected[i]])
          }
          if (is.integer(dataFrame[, selected[i]]) | 
              is.numeric(dataFrame[, selected[i]])) {
            if (length(table(by1)) > 1) {
              if (nrow(dataFrame) < 5000) {
                if (nrow(dataFrame) < 3) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
                else if (shapiro.test(lm(dataFrame[, 
                                                   selected[i]] ~ by1)$residuals)$p.value < 
                         0.01 | bartlett.test(dataFrame[, selected[i]] ~ 
                                              by1)$p.value < 0.01) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
              else {
                sampled.shapiro <- sample(lm(dataFrame[, 
                                                       selected[i]] ~ by1)$residuals, 250)
                if (shapiro.test(sampled.shapiro)$p.value < 
                    0.01 | bartlett.test(dataFrame[, selected[i]] ~ 
                                         by1)$p.value < 0.01) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
            }
          }
        }
      }
      else {
        selected.iqr <- NULL
      }
    }
    table2 <- NULL
    if (sample.size) {
      if (test) {
        if (name.test) {
          if (total.column) {
            table2 <- rbind(c(table(by1), length(by1), 
                              "", ""), c(rep("", length(table(by1)) + 
                                               1), "", ""))
            colnames(table2)[ncol(table2) - (2:0)] <- c("Total", 
                                                        "Test stat.", "P value")
          }
          else {
            table2 <- rbind(c(table(by1), "", ""), c(rep("", 
                                                         length(table(by1))), "", ""))
            colnames(table2)[ncol(table2) - (1:0)] <- c("Test stat.", 
                                                        "P value")
          }
        }
        else {
          if (total.column) {
            table2 <- rbind(c(table(by1), length(by1), 
                              ""), c(rep("", length(table(by1)) + 1), 
                                     "", ""))
            colnames(table2)[ncol(table2) - (1:0)] <- c("Total", 
                                                        "P value")
          }
          else {
            table2 <- rbind(c(table(by1), ""), c(rep("", 
                                                     length(table(by1))), ""))
            colnames(table2)[ncol(table2)] <- "P value"
          }
        }
      }
      else {
        total.column <- FALSE
        table2 <- rbind(table(by1), "")
      }
    }
    for (i in 1:length(selected)) {
      if (is.factor(dataFrame[, selected[i]]) | is.logical(dataFrame[, 
                                                                     selected[i]]) | is.character(dataFrame[, selected[i]])) {
        x0 <- table(dataFrame[, selected[i]], by1)
        if (total.column) {
          x <- addmargins(x0, margin = 2)
        }
        else {
          x <- x0
        }
        nr <- nrow(x)
        nc <- ncol(x0)
        sr <- rowSums(x0)
        if (any(sr == 0)) {
          stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one row"))
        }
        sc <- colSums(x0)
        if (any(sc == 0)) {
          stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one column"))
        }
        x.row.percent <- round(x/rowSums(x0) * 100, decimal)
        table0 <- x
        if (nrow(x) == 2 & prevalence) {
          table00 <- addmargins(x, margin = 1)
          table0 <- paste(table00[2, ], "/", table00[3, 
                                                     ], " (", round(table00[2, ]/table00[3, ] * 
                                                                      100, decimal), "%)", sep = "")
          table0 <- t(table0)
          rownames(table0) <- "  prevalence"
        }
        else {
          if (any(percent == "column")) {
            x.col.percent <- round(t(t(x)/colSums(x)) * 
                                     100, decimal)
            x.col.percent1 <- matrix(paste(x, " (", x.col.percent, 
                                           "%)", sep = ""), nrow(x), ncol(x))
            if (!frequency) {
              x.col.percent1 <- x.col.percent
            }
            table0 <- x.col.percent1
          }
          else {
            if (any(percent == "row")) {
              x.row.percent <- round(x/rowSums(x0) * 
                                       100, decimal)
              x.row.percent1 <- matrix(paste(x, " (", 
                                             x.row.percent, "%)", sep = ""), nrow(x), 
                                       ncol(x))
              if (!frequency) {
                x.row.percent1 <- x.row.percent
              }
              table0 <- x.row.percent1
            }
          }
          rownames(table0) <- paste("  ", rownames(x))
          colnames(table0) <- colnames(x)
        }
        if (test) {
          E <- outer(sr, sc, "*")/sum(x0)
          dim(E) <- NULL
          if ((sum(E < 5))/length(E) > 0.2 & nrow(dataFrame) < 
              1000) {
            test.method <- "Fisher's exact test"
            p.value <- fisher.test(x0, simulate.p.value = simulate.p.value)$p.value
          }
          else {
            test.method <- paste("Chisq. (", suppressWarnings(chisq.test(x0)$parameter), 
                                 " df) = ", suppressWarnings(round(chisq.test(x0)$statistic, 
                                                                   decimal + 1)), sep = "")
            p.value <- suppressWarnings(chisq.test(x0)$p.value)
          }
        }
      }
      if (is.numeric(dataFrame[, selected[i]])) {
        if (any(selected.iqr == selected[i])) {
          term1 <- NULL
          term2 <- NULL
          term3 <- NULL
          for (j in 1:(length(levels(by1)))) {
            term1 <- c(term1, quantile(dataFrame[by1 == 
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[3])
            term2 <- c(term2, quantile(dataFrame[by1 == 
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[2])
            term3 <- c(term3, quantile(dataFrame[by1 == 
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[4])
          }
          if (total.column) {
            term1 <- c(term1, quantile(dataFrame[, selected[i]], 
                                       na.rm = TRUE)[3])
            term2 <- c(term2, quantile(dataFrame[, selected[i]], 
                                       na.rm = TRUE)[2])
            term3 <- c(term3, quantile(dataFrame[, selected[i]], 
                                       na.rm = TRUE)[4])
          }
          term.numeric <- paste(round(term1, decimal), 
                                " (", round(term2, decimal), ",", round(term3, 
                                                                        decimal), ")", sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "  median(IQR)"
        }
        else {
          term1 <- as.vector(tapply(X = dataFrame[, selected[i]], 
                                    INDEX = list(by1), FUN = "mean", na.rm = TRUE))
          if (total.column) {
            term1 <- c(term1, mean(dataFrame[, selected[i]], 
                                   na.rm = TRUE))
          }
          term2 <- as.vector(tapply(X = dataFrame[, selected[i]], 
                                    INDEX = list(by1), FUN = "sd", na.rm = TRUE))
          if (total.column) {
            term2 <- c(term2, sd(dataFrame[, selected[i]], 
                                 na.rm = TRUE))
          }
          term.numeric <- paste(round(term1, decimal), 
                                " (", round(term2, decimal), ")", sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "  mean(SD)"
        }
        table0 <- term.numeric
        if (test) {
          if (any(as.integer(table(by1[!is.na(dataFrame[, 
                                                        selected[i]])])) < 3) | length(table(by1)) > 
              length(table(by1[!is.na(dataFrame[, selected[i]])]))) {
            test.method <- paste("Sample too small: group", 
                                 paste(which(as.integer(table(factor(by)[!is.na(dataFrame[, 
                                                                                          selected[i]])])) < 3), collapse = " "))
            p.value <- NA
          }
          else {
            if (any(selected.iqr == selected[i])) {
              if (length(levels(by1)) > 2) {
                test.method <- "Kruskal-Wallis test"
                p.value <- kruskal.test(dataFrame[, selected[i]] ~ 
                                          by1)$p.value
              }
              else {
                test.method <- "Ranksum test"
                p.value <- wilcox.test(dataFrame[, selected[i]] ~ 
                                         by1, exact = FALSE)$p.value
              }
            }
            else {
              if (length(levels(by1)) > 2) {
                test.method <- paste("ANOVA F-test (", 
                                     anova(lm(dataFrame[, selected[i]] ~ 
                                                by1))[1, 1], ", ", anova(lm(dataFrame[, 
                                                                                      selected[i]] ~ by1))[2, 1], " df) = ", 
                                     round(anova(lm(dataFrame[, selected[i]] ~ 
                                                      by1))[1, 4], decimal + 1), sep = "")
                p.value <- anova(lm(dataFrame[, selected[i]] ~ 
                                      by1))[1, 5]
              }
              else {
                test.method <- paste("t-test", paste(" (", 
                                                     t.test(dataFrame[, selected[i]] ~ by1, 
                                                            var.equal = TRUE)$parameter, " df)", 
                                                     sep = ""), "=", round(abs(t.test(dataFrame[, 
                                                                                                selected[i]] ~ by1, var.equal = TRUE)$statistic), 
                                                                           decimal + 1))
                p.value <- t.test(dataFrame[, selected[i]] ~ 
                                    by1, var.equal = TRUE)$p.value
              }
            }
          }
        }
      }
      if (test) {
        if (name.test) {
          label.row <- c(rep("", length(levels(by1)) + 
                               total.column), test.method, ifelse(p.value < 
                                                                    0.001, "< 0.001", round(p.value, decimal + 
                                                                                              2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total", 
                                     "Test stat.", "P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "Test stat.", 
                                     "P value")
          }
          table0 <- cbind(table0, "", "")
          blank.row <- rep("", length(levels(by1)) + 
                             total.column + 2)
        }
        else {
          label.row <- c(rep("", length(levels(by1)) + 
                               total.column), ifelse(p.value < 0.001, "< 0.001", 
                                                     round(p.value, decimal + 2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total", 
                                     "P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "P value")
          }
          table0 <- cbind(table0, "")
          blank.row <- rep("", length(levels(by1)) + 
                             total.column + 1)
        }
      }
      else {
        label.row <- c(rep("", length(levels(by1)) + 
                             total.column))
        label.row <- t(label.row)
        if (total.column) {
          colnames(label.row) <- c(levels(by1), "Total")
        }
        else {
          colnames(label.row) <- c(levels(by1))
        }
        blank.row <- rep("", length(levels(by1)) + total.column)
      }
      if (var.labels) {
        rownames(label.row) <- ifelse(!is.null(attributes(dataFrame)$var.labels[selected][i]), 
                                      attributes(dataFrame)$var.labels[selected[i]], 
                                      names(dataFrame)[selected][i])
        rownames(label.row) <- ifelse(rownames(label.row) == 
                                        "", names(dataFrame[selected[i]]), rownames(label.row))
      }
      else {
        rownames(label.row) <- paste(selected[i], ":", 
                                     names(dataFrame[selected[i]]))
      }
      if (!is.logical(dataFrame[, selected[i]])) {
        if (prevalence & length(levels(dataFrame[, selected[i]])) == 
            2) {
          rownames(label.row) <- paste(rownames(label.row), 
                                       "=", levels(dataFrame[, selected[i]])[2])
        }
      }
      blank.row <- t(blank.row)
      rownames(blank.row) <- ""
      table2 <- rbind(table2, label.row, table0, blank.row)
    }
    if (sample.size) {
      rownames(table2)[1:2] <- c("Total", "")
    }
    class(table2) <- c("tableStack", "table")
    # print(table2)  
    table2b<-table2
    # print(table2b)
    table2<-matrix(data=table2,nr=nrow(table2),nc=(ncol(table2)))
    colnames(table2)<-colnames(table2b)
    rownames(table2)<-rownames(table2b)
    # print(table2) 
    table2<-cbind(rownames(table2b), table2) 
    colnames(table2)[[1]]<-colnames(dataFrame)[by.var]     
  
    ###print(noquote(tt));
    table2=as.data.frame(table2)
    if(na.col==TRUE){
      table2[,"Vide"]=""
      table2[,1]=as.character(table2[,1])
      vars=table2[,1][which(table2[,1]%in% colnames(dataFrame)==T)]
      for (i in vars){
        na_number=sum(is.na(dataFrame[,i]))
        phrase=paste0(na_number," (",round(na_number/nrow(dataFrame)*100,2),"%)")
        table2[which(table2[,1]==i),"Vide"]=phrase
      }
    }
  }
  return(table2)
}




#Attention au test statistique, le Fisher est bootstrap? par exemple
tableStack_0<-function (vars, minlevel = "auto", maxlevel = "auto", count = TRUE, 
                        means = TRUE, medians = FALSE, sds = TRUE, decimal = 1, dataFrame = .data, 
                        total = TRUE, var.labels = TRUE, var.labels.trunc = 150, 
                        reverse = FALSE, vars.to.reverse = NULL, by = NULL, vars.to.factor = NULL, 
                        iqr = "auto", prevalence = FALSE, percent = c("column", "row", 
                                                                      "none"), frequency = TRUE, test = TRUE, name.test = TRUE, 
                        total.column = FALSE,na.col=FALSE) 
{
  nl <- as.list(1:ncol(dataFrame))
  names(nl) <- names(dataFrame)
  selected <- eval(substitute(vars), nl, parent.frame())
  by.var <- eval(substitute(by), nl, parent.frame())
  if (is.numeric(by.var)) {
    by <- dataFrame[, by.var]
  }
  if (is.character(by.var)) {
    by1 <- as.factor(rep("Total", nrow(dataFrame)))
  }
  if (is.null(by)) {
    selected.class <- NULL
    for (i in selected) {
      selected.class <- c(selected.class, class(dataFrame[, 
                                                          i]))
    }
    if (length(table(table(selected.class))) > 1) 
      warning("Without 'by', classes of all selected variables should be the same.")
  }
  selected.to.factor <- eval(substitute(vars.to.factor), nl, 
                             parent.frame())
  if (!is.character(iqr)) {
    selected.iqr <- eval(substitute(iqr), nl, parent.frame())
    intersect.selected <- intersect(selected.iqr, selected.to.factor)
    if (length(intersect.selected) != 0) {
      stop(paste(names(dataFrame)[intersect.selected], 
                 "cannot simultaneously describe IQR and be coerced factor"))
    }
    for (i in selected.iqr) {
      if (!is.integer(dataFrame[, i]) & !is.numeric(dataFrame[, 
                                                              i])) {
        stop(paste(names(dataFrame)[i], "is neither integer nor numeric, not possible to compute IQR"))
      }
    }
  }
  for (i in selected) {
    if ((class(dataFrame[, i]) == "integer" | class(dataFrame[, 
                                                              i]) == "numeric") & !is.null(by)) {
      if (any(selected.to.factor == i)) {
        dataFrame[, i] <- factor(dataFrame[, i])
      }
      else {
        dataFrame[, i] <- as.numeric(dataFrame[, i])
      }
    }
  }
  if ((reverse || suppressWarnings(!is.null(vars.to.reverse))) && 
      is.factor(dataFrame[, selected][, 1])) {
    stop("Variables must be in 'integer' class before reversing. \n        Try 'unclassDataframe' first'")
  }
  selected.dataFrame <- dataFrame[, selected, drop = FALSE]
  if (is.null(by)) {
    selected.matrix <- NULL
    for (i in selected) {
      selected.matrix <- cbind(selected.matrix, unclass(dataFrame[, 
                                                                  i]))
    }
    colnames(selected.matrix) <- names(selected.dataFrame)
    if (minlevel == "auto") {
      minlevel <- min(selected.matrix, na.rm = TRUE)
    }
    if (maxlevel == "auto") {
      maxlevel <- max(selected.matrix, na.rm = TRUE)
    }
    nlevel <- as.list(minlevel:maxlevel)
    names(nlevel) <- eval(substitute(minlevel:maxlevel), 
                          nlevel, parent.frame())
    if (suppressWarnings(!is.null(vars.to.reverse))) {
      nl1 <- as.list(1:ncol(dataFrame))
      names(nl1) <- names(dataFrame[, selected])
      which.neg <- eval(substitute(vars.to.reverse), nl1, 
                        parent.frame())
      for (i in which.neg) {
        dataFrame[, selected][, i] <- maxlevel + 1 - 
          dataFrame[, selected][, i]
        selected.matrix[, i] <- maxlevel + 1 - selected.matrix[, 
                                                               i]
      }
      reverse <- FALSE
      sign1 <- rep(1, ncol(selected.matrix))
      sign1[which.neg] <- -1
    }
    if (reverse) {
      matR1 <- cor(selected.matrix, use = "pairwise.complete.obs")
      diag(matR1) <- 0
      if (any(matR1 > 0.98)) {
        reverse <- FALSE
        temp.mat <- which(matR1 > 0.98, arr.ind = TRUE)
        warning(paste(paste(rownames(temp.mat), collapse = " and ")), 
                " are extremely correlated.", "\n", "  The command has been excuted without 'reverse'.", 
                "\n", "  Remove one of them from 'vars' if 'reverse' is required.")
      }
      else {
        score <- factanal(na.omit(selected.matrix), factor = 1, 
                          score = "regression")$score
        sign1 <- NULL
        for (i in 1:length(selected)) {
          sign1 <- c(sign1, sign(cor(score, na.omit(selected.matrix)[, 
                                                                     i], use = "pairwise")))
        }
        which.neg <- which(sign1 < 0)
        for (i in which.neg) {
          dataFrame[, selected][, i] <- maxlevel + minlevel - 
            dataFrame[, selected][, i]
          selected.matrix[, i] <- maxlevel + minlevel - 
            selected.matrix[, i]
        }
      }
    }
    table1 <- NULL
    for (i in as.integer(selected)) {
      if (!is.factor(dataFrame[, i])) {
        x <- factor(dataFrame[, i])
        if (!is.logical(dataFrame[, i, drop = TRUE])) {
          levels(x) <- nlevel
        }
        tablei <- table(x)
      }
      else {
        tablei <- table(dataFrame[, i])
      }
      if (count) {
        tablei <- c(tablei, length(na.omit(dataFrame[, 
                                                     i])))
        names(tablei)[length(tablei)] <- "count"
      }
      if (is.numeric(selected.dataFrame[, 1, drop = TRUE]) | 
          is.logical(selected.dataFrame[, 1, drop = TRUE])) {
        if (means) {
          tablei <- c(tablei, round(mean(as.numeric(dataFrame[, 
                                                              i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "mean"
        }
        if (medians) {
          tablei <- c(tablei, round(median(as.numeric(dataFrame[, 
                                                                i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "median"
        }
        if (sds) {
          tablei <- c(tablei, round(sd(as.numeric(dataFrame[, 
                                                            i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "sd"
        }
      }
      table1 <- rbind(table1, tablei)
    }
    results <- as.table(table1)
    if (var.labels) {
      rownames(results) <- names(selected.dataFrame)
    }
    else {
      rownames(results) <- paste(selected, ":", names(selected.dataFrame))
    }
    if (is.integer(selected.dataFrame[, 1])) {
      rownames(results) <- names(nl)[selected]
      if (is.factor(dataFrame[, selected][, 1])) {
        colnames(results)[1:(ncol(results) - (count + 
                                                means + medians + sds))] <- levels(dataFrame[, 
                                                                                             selected][, 1])
      }
      else {
        colnames(results)[1:(ncol(results) - (count + 
                                                means + medians + sds))] <- names(nlevel)
      }
    }
    result0 <- results
    if (var.labels) {
      if (!is.null(attributes(dataFrame)$var.labels)) {
        results <- as.table(cbind(results, substr(attributes(dataFrame)$var.labels[selected], 
                                                  1, var.labels.trunc)))
      }
      if (!is.null(attributes(dataFrame)$var.labels)) 
        colnames(results)[ncol(results)] <- "description"
    }
    if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[, 
                                                                            1]) | is.logical(selected.dataFrame[, 1])) {
      if (reverse || (!is.null(vars.to.reverse))) {
        Reversed <- ifelse(sign1 < 0, "    x   ", "    .   ")
        results <- cbind(Reversed, results)
      }
      sumMeans <- 0
      sumN <- 0
      for (i in selected) {
        sumMeans <- sumMeans + mean(as.numeric(dataFrame[, 
                                                         i]), na.rm = TRUE) * length(na.omit(dataFrame[, 
                                                                                                       i]))
        sumN <- sumN + length(na.omit(dataFrame[, i]))
      }
      mean.of.total.scores <- weighted.mean(rowSums(selected.matrix), 
                                            w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.total.scores <- sd(rowSums(selected.matrix), 
                               na.rm = TRUE)
      mean.of.average.scores <- weighted.mean(rowMeans(selected.matrix), 
                                              w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.average.scores <- sd(rowMeans(selected.matrix), 
                                 na.rm = TRUE)
      countCol <- which(colnames(results) == "count")
      meanCol <- which(colnames(results) == "mean")
      sdCol <- which(colnames(results) == "sd")
      if (total) {
        results <- rbind(results, rep("", reverse || 
                                        suppressWarnings(!is.null(vars.to.reverse)) + 
                                        (maxlevel + 1 - minlevel) + (count + means + 
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length((rowSums(selected.dataFrame))[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.total.scores, 
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.total.scores, 
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Total score"
        results <- rbind(results, rep("", reverse || 
                                        suppressWarnings(!is.null(vars.to.reverse)) + 
                                        (maxlevel + 1 - minlevel) + (count + means + 
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length(rowSums(selected.dataFrame)[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.average.scores, 
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.average.scores, 
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Average score"
      }
    }
    results <- list(results = noquote(results))
    if (reverse || suppressWarnings(!is.null(vars.to.reverse))) 
      results <- c(results, list(items.reversed = names(selected.dataFrame)[sign1 < 
                                                                              0]))
    if (var.labels && !is.null(attributes(dataFrame)$var.labels)) {
      results <- c(results, list(item.labels = attributes(dataFrame)$var.labels[selected]))
    }
    if (total) {
      if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[, 
                                                                              1])) {
        results <- c(results, list(total.score = rowSums(selected.matrix)), 
                     list(mean.score = rowMeans(selected.matrix)), 
                     list(mean.of.total.scores = mean.of.total.scores, 
                          sd.of.total.scores = sd.of.total.scores, 
                          mean.of.average.scores = mean.of.average.scores, 
                          sd.of.average.scores = sd.of.average.scores))
      }
    }
    class(results) <- c("tableStack", "list")
    results
  }
  else {
    if (is.character(by.var)) {
      by1 <- as.factor(rep("Total", nrow(dataFrame)))
    }
    else {
      by1 <- factor(dataFrame[, by.var])
    }
    if (is.logical(dataFrame[, i])) {
      dataFrame[, i] <- as.factor(dataFrame[, i])
      levels(dataFrame[, i]) <- c("No", "Yes")
    }
    if (length(table(by1)) == 1) 
      test <- FALSE
    name.test <- ifelse(test, name.test, FALSE)
    if (is.character(iqr)) {
      if (iqr == "auto") {
        selected.iqr <- NULL
        for (i in 1:length(selected)) {
          if (class(dataFrame[, selected[i]]) == "difftime") {
            dataFrame[, selected[i]] <- as.numeric(dataFrame[, 
                                                             selected[i]])
          }
          if (is.integer(dataFrame[, selected[i]]) | 
              is.numeric(dataFrame[, selected[i]])) {
            if (length(table(by1)) > 1) {
              if (nrow(dataFrame) < 5000) {
                if (nrow(dataFrame) < 3) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
                else if (shapiro.test(lm(dataFrame[, 
                                                   selected[i]] ~ by1)$residuals)$p.value < 
                         0.01 | shapiro.test(lm(dataFrame[, 
                                                          selected[i]] ~ by1)$residuals)$p.value < 0.01) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
              else {
                sampled.shapiro <- sample(lm(dataFrame[, 
                                                       selected[i]] ~ by1)$residuals, 250)
                if (shapiro.test(sampled.shapiro)$p.value < 
                    0.01 | shapiro.test(sampled.shapiro)$p.value < 
                    0.01 ) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
            }
          }
        }
      }
      else {
        selected.iqr <- NULL
      }
    }
    table2 <- NULL
    for (i in 1:length(selected)) {
      if (is.factor(dataFrame[, selected[i]]) | is.logical(dataFrame[, 
                                                                     selected[i]])) {
        x0 <- table(dataFrame[, selected[i]], by1)
        if (total.column) {
          x <- addmargins(x0, margin = 2)
        }
        else {
          x <- x0
        }
        nr <- nrow(x)
        nc <- ncol(x0)
        sr <- rowSums(x0)
        #if (any(sr =-1)) {
        #                  stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one row"))
        #                }
        sc <- colSums(x0)
        #                if (any(sc =-1)) {
        #                  stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one column"))
        #                }
        x.row.percent <- round(x/rowSums(x0) * 100, decimal)
        table0 <- x
        if (nrow(x) == 2 & prevalence) {
          table00 <- addmargins(x, margin = 1)
          table0 <- paste(table00[2, ], "/", table00[3, 
                                                     ], " (", round(table00[2, ]/table00[3, ] * 
                                                                      100, decimal), "%)", sep = "")
          table0 <- t(table0)
          rownames(table0) <- "  prevalence"
        }
        else {
          if (any(percent == "column")) {
            x.col.percent <- round(t(t(x)/colSums(x)) * 
                                     100, decimal)
            x.col.percent1 <- matrix(paste(x, " (", x.col.percent, 
                                           "%)", sep = ""), nrow(x), ncol(x))
            if (!frequency) {
              x.col.percent1 <- x.col.percent
            }
            table0 <- x.col.percent1
          }
          else {
            if (any(percent == "row")) {
              x.row.percent <- round(x/rowSums(x0) * 
                                       100, decimal)
              x.row.percent1 <- matrix(paste(x, " (", 
                                             x.row.percent,"%)", sep = ""), nrow(x), 
                                       ncol(x))
              if (!frequency) {
                x.row.percent1 <- x.row.percent
              }
              table0 <- x.row.percent1
            }
          }
          rownames(table0) <- paste("  ", rownames(x))
          colnames(table0) <- colnames(x)
        }
        if (test) {
          E <- outer(sr, sc, "*")/sum(x0)
          dim(E) <- NULL
          if ((sum(E < 5))/length(E) > 0.2 & nrow(dataFrame) < 
              1000) {
            test.method <- "Fisher's exact test"
            p.value <- fisher.test(x0, simulate.p.value = TRUE)$p.value
          }
          else {
            test.method <- paste("Chisq. (", suppressWarnings(chisq.test(x0)$parameter), 
                                 " df) = ", suppressWarnings(round(chisq.test(x0)$statistic, 
                                                                   decimal + 1)), sep = "")
            p.value <- suppressWarnings(chisq.test(x0)$p.value)
          }
        }
      }
      if (is.numeric(dataFrame[, selected[i]])) {
        if (any(selected.iqr == selected[i])) {
          term1 <- NULL
          term2 <- NULL
          term3 <- NULL
          for (j in 1:(length(levels(by1)))) {
            term1 <- c(term1, quantile(dataFrame[by1 == 
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[3])
            term2 <- c(term2, quantile(dataFrame[by1 == 
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[2])
            term3 <- c(term3, quantile(dataFrame[by1 == 
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[4])
          }
          if (total.column) {
            term1 <- c(term1, quantile(dataFrame[, selected[i]], 
                                       na.rm = TRUE)[3])
            term2 <- c(term2, quantile(dataFrame[, selected[i]], 
                                       na.rm = TRUE)[2])
            term3 <- c(term3, quantile(dataFrame[, selected[i]], 
                                       na.rm = TRUE)[4])
          }
          term.numeric <- paste(round(term1, decimal), 
                                " (", round(term2, decimal), ",", round(term3, 
                                                                        decimal), ")", sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "  median(IQR)"
        }
        else {
          term1 <- as.vector(tapply(X = dataFrame[, selected[i]], 
                                    INDEX = list(by1), FUN = "mean", na.rm = TRUE))
          if (total.column) {
            term1 <- c(term1, mean(dataFrame[, selected[i]], 
                                   na.rm = TRUE))
          }
          term2 <- as.vector(tapply(X = dataFrame[, selected[i]], 
                                    INDEX = list(by1), FUN = "sd", na.rm = TRUE))
          if (total.column) {
            term2 <- c(term2, sd(dataFrame[, selected[i]], 
                                 na.rm = TRUE))
          }
          term.numeric <- paste(round(term1, decimal), 
                                " (", round(term2, decimal), ")", sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "  mean(SD)"
        }
        table0 <- term.numeric
        if (test) {
          if (any(selected.iqr == selected[i])) {
            if (length(levels(by1)) > 2) {
              test.method <- "Kruskal-Wallis test"
              p.value <- kruskal.test(dataFrame[, selected[i]] ~ 
                                        by1)$p.value
            }
            else {
              test.method <- "Ranksum test"
              p.value <- wilcox.test(dataFrame[, selected[i]] ~ 
                                       by1, exact = FALSE)$p.value
            }
          }
          else {
            if (length(levels(by1)) > 2) {
              test.method <- paste("ANOVA F-test (", 
                                   anova(lm(dataFrame[, selected[i]] ~ by1))[1, 
                                                                             1], ", ", anova(lm(dataFrame[, selected[i]] ~ 
                                                                                                  by1))[2, 1], " df) = ", round(anova(lm(dataFrame[, 
                                                                                                                                                   selected[i]] ~ by1))[1, 4], decimal + 
                                                                                                                                  1), sep = "")
              p.value <- anova(lm(dataFrame[, selected[i]] ~ 
                                    by1))[1, 5]
            }
            else {
              test.method <- paste("t-test", paste(" (", 
                                                   t.test(dataFrame[, selected[i]] ~ by1, 
                                                          var.equal = TRUE)$parameter, " df)", 
                                                   sep = ""), "=", round(abs(t.test(dataFrame[, 
                                                                                              selected[i]] ~ by1, var.equal = TRUE)$statistic), 
                                                                         decimal + 1))
              p.value <- t.test(dataFrame[, selected[i]] ~ 
                                  by1, var.equal = TRUE)$p.value
            }
          }
        }
      }
      if (test) {
        if (name.test) {
          label.row <- c(rep("", length(levels(by1)) + 
                               total.column), test.method, ifelse(p.value < 
                                                                    0.001, "< 0.001", round(p.value, decimal + 
                                                                                              2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total", 
                                     "Test stat.", "  P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "Test stat.", 
                                     "  P value")
          }
          table0 <- cbind(table0, "", "")
          blank.row <- rep("", length(levels(by1)) + 
                             total.column + 2)
        }
        else {
          label.row <- c(rep("", length(levels(by1)) + 
                               total.column), ifelse(p.value < 0.001, "< 0.001", 
                                                     round(p.value, decimal + 2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total", 
                                     "  P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "  P value")
          }
          table0 <- cbind(table0, "")
          blank.row <- rep("", length(levels(by1)) + 
                             total.column + 1)
        }
      }
      else {
        label.row <- c(rep("", length(levels(by1)) + 
                             total.column))
        label.row <- t(label.row)
        if (total.column) {
          colnames(label.row) <- c(levels(by1), "Total")
        }
        else {
          colnames(label.row) <- c(levels(by1))
        }
        blank.row <- rep("", length(levels(by1)) + total.column)
      }
      if (var.labels) {
        rownames(label.row) <- ifelse(!is.null(attributes(dataFrame)$var.labels[selected][i]), 
                                      attributes(dataFrame)$var.labels[selected[i]], 
                                      names(dataFrame)[selected][i])
        rownames(label.row) <- ifelse(rownames(label.row) == 
                                        "", names(dataFrame[selected[i]]), rownames(label.row))
      }
      else {
        rownames(label.row) <- paste(selected[i], ":", 
                                     names(dataFrame[selected[i]]))
      }
      if (!is.logical(dataFrame[, selected[i]])) {
        if (prevalence & length(levels(dataFrame[, selected[i]])) == 
            2) {
          rownames(label.row) <- paste(rownames(label.row), 
                                       "=", levels(dataFrame[, selected[i]])[2])
        }
      }
      blank.row <- t(blank.row)
      rownames(blank.row) <- ""
      table2 <- rbind(table2, label.row, table0, blank.row)
    }
    class(table2) <- c("tableStack", "table")
    # print(table2)  
    table2b<-table2
    # print(table2b)
    table2<-matrix(data=table2,nr=nrow(table2),nc=(ncol(table2)))
    colnames(table2)<-colnames(table2b)
    rownames(table2)<-rownames(table2b)
    # print(table2) 
    table2<-cbind(rownames(table2b), table2) 
    colnames(table2)[[1]]<-colnames(dataFrame)[by.var]     
    ###print(noquote(tt));
    
    #####
  }
  table2=as.data.frame(table2)
  if(na.col==TRUE){
    table2[,"Vide"]=""
    table2[,1]=as.character(table2[,1])
    vars=table2[,1][which(table2[,1]%in% colnames(dataFrame)==T)]
    for (i in vars){
      na_number=sum(is.na(dataFrame[,i]))
      phrase=paste0(na_number," (",round(na_number/nrow(dataFrame)*100,2),"%)")
      table2[which(table2[,1]==i),"Vide"]=phrase
    }
  }
  return(table2)
}


#############################################TableStarck_range est comme TableStarck, mais renvoit le range au lieux de IQR############################################################################

tableStack_range<-function (vars, minlevel = "auto", maxlevel = "auto", count = TRUE, 
                            means = TRUE, medians = FALSE, sds = TRUE, decimal = 1, dataFrame = .data, 
                            total = TRUE, var.labels = TRUE, var.labels.trunc = 150, 
                            reverse = FALSE, vars.to.reverse = NULL, by = NULL, vars.to.factor = NULL, 
                            iqr = "auto", prevalence = FALSE, percent = c("column", "row", 
                                                                          "none"), frequency = TRUE, test = TRUE, name.test = TRUE, 
                            total.column = FALSE) 
{
  nl <- as.list(1:ncol(dataFrame))
  names(nl) <- names(dataFrame)
  selected <- eval(substitute(vars), nl, parent.frame())
  by.var <- eval(substitute(by), nl, parent.frame())
  if (is.numeric(by.var)) {
    by <- dataFrame[, by.var]
  }
  if (is.character(by.var)) {
    by1 <- as.factor(rep("Total", nrow(dataFrame)))
  }
  if (is.null(by)) {
    selected.class <- NULL
    for (i in selected) {
      selected.class <- c(selected.class, class(dataFrame[, 
                                                          i]))
    }
    if (length(table(table(selected.class))) > 1) 
      warning("Without 'by', classes of all selected variables should be the same.")
  }
  selected.to.factor <- eval(substitute(vars.to.factor), nl, 
                             parent.frame())
  if (!is.character(iqr)) {
    selected.iqr <- eval(substitute(iqr), nl, parent.frame())
    intersect.selected <- intersect(selected.iqr, selected.to.factor)
    if (length(intersect.selected) != 0) {
      stop(paste(names(dataFrame)[intersect.selected], 
                 "cannot simultaneously describe IQR and be coerced factor"))
    }
    for (i in selected.iqr) {
      if (!is.integer(dataFrame[, i]) & !is.numeric(dataFrame[, 
                                                              i])) {
        stop(paste(names(dataFrame)[i], "is neither integer nor numeric, not possible to compute IQR"))
      }
    }
  }
  for (i in selected) {
    if ((class(dataFrame[, i]) == "integer" | class(dataFrame[, 
                                                              i]) == "numeric") & !is.null(by)) {
      if (any(selected.to.factor == i)) {
        dataFrame[, i] <- factor(dataFrame[, i])
      }
      else {
        dataFrame[, i] <- as.numeric(dataFrame[, i])
      }
    }
  }
  if ((reverse || suppressWarnings(!is.null(vars.to.reverse))) && 
      is.factor(dataFrame[, selected][, 1])) {
    stop("Variables must be in 'integer' class before reversing. \n        Try 'unclassDataframe' first'")
  }
  selected.dataFrame <- dataFrame[, selected, drop = FALSE]
  if (is.null(by)) {
    selected.matrix <- NULL
    for (i in selected) {
      selected.matrix <- cbind(selected.matrix, unclass(dataFrame[, 
                                                                  i]))
    }
    colnames(selected.matrix) <- names(selected.dataFrame)
    if (minlevel == "auto") {
      minlevel <- min(selected.matrix, na.rm = TRUE)
    }
    if (maxlevel == "auto") {
      maxlevel <- max(selected.matrix, na.rm = TRUE)
    }
    nlevel <- as.list(minlevel:maxlevel)
    names(nlevel) <- eval(substitute(minlevel:maxlevel), 
                          nlevel, parent.frame())
    if (suppressWarnings(!is.null(vars.to.reverse))) {
      nl1 <- as.list(1:ncol(dataFrame))
      names(nl1) <- names(dataFrame[, selected])
      which.neg <- eval(substitute(vars.to.reverse), nl1, 
                        parent.frame())
      for (i in which.neg) {
        dataFrame[, selected][, i] <- maxlevel + 1 - 
          dataFrame[, selected][, i]
        selected.matrix[, i] <- maxlevel + 1 - selected.matrix[, 
                                                               i]
      }
      reverse <- FALSE
      sign1 <- rep(1, ncol(selected.matrix))
      sign1[which.neg] <- -1
    }
    if (reverse) {
      matR1 <- cor(selected.matrix, use = "pairwise.complete.obs")
      diag(matR1) <- 0
      if (any(matR1 > 0.98)) {
        reverse <- FALSE
        temp.mat <- which(matR1 > 0.98, arr.ind = TRUE)
        warning(paste(paste(rownames(temp.mat), collapse = " and ")), 
                " are extremely correlated.", "\n", "  The command has been excuted without 'reverse'.", 
                "\n", "  Remove one of them from 'vars' if 'reverse' is required.")
      }
      else {
        score <- factanal(na.omit(selected.matrix), factor = 1, 
                          score = "regression")$score
        sign1 <- NULL
        for (i in 1:length(selected)) {
          sign1 <- c(sign1, sign(cor(score, na.omit(selected.matrix)[, 
                                                                     i], use = "pairwise")))
        }
        which.neg <- which(sign1 < 0)
        for (i in which.neg) {
          dataFrame[, selected][, i] <- maxlevel + minlevel - 
            dataFrame[, selected][, i]
          selected.matrix[, i] <- maxlevel + minlevel - 
            selected.matrix[, i]
        }
      }
    }
    table1 <- NULL
    for (i in as.integer(selected)) {
      if (!is.factor(dataFrame[, i])) {
        x <- factor(dataFrame[, i])
        if (!is.logical(dataFrame[, i, drop = TRUE])) {
          levels(x) <- nlevel
        }
        tablei <- table(x)
      }
      else {
        tablei <- table(dataFrame[, i])
      }
      if (count) {
        tablei <- c(tablei, length(na.omit(dataFrame[, 
                                                     i])))
        names(tablei)[length(tablei)] <- "count"
      }
      if (is.numeric(selected.dataFrame[, 1, drop = TRUE]) | 
          is.logical(selected.dataFrame[, 1, drop = TRUE])) {
        if (means) {
          tablei <- c(tablei, round(mean(as.numeric(dataFrame[, 
                                                              i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "mean"
        }
        if (medians) {
          tablei <- c(tablei, round(median(as.numeric(dataFrame[, 
                                                                i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "median"
        }
        if (sds) {
          tablei <- c(tablei, round(sd(as.numeric(dataFrame[, 
                                                            i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "sd"
        }
      }
      table1 <- rbind(table1, tablei)
    }
    results <- as.table(table1)
    if (var.labels) {
      rownames(results) <- names(selected.dataFrame)
    }
    else {
      rownames(results) <- paste(selected, ":", names(selected.dataFrame))
    }
    if (is.integer(selected.dataFrame[, 1])) {
      rownames(results) <- names(nl)[selected]
      if (is.factor(dataFrame[, selected][, 1])) {
        colnames(results)[1:(ncol(results) - (count + 
                                                means + medians + sds))] <- levels(dataFrame[, 
                                                                                             selected][, 1])
      }
      else {
        colnames(results)[1:(ncol(results) - (count + 
                                                means + medians + sds))] <- names(nlevel)
      }
    }
    result0 <- results
    if (var.labels) {
      if (!is.null(attributes(dataFrame)$var.labels)) {
        results <- as.table(cbind(results, substr(attributes(dataFrame)$var.labels[selected], 
                                                  1, var.labels.trunc)))
      }
      if (!is.null(attributes(dataFrame)$var.labels)) 
        colnames(results)[ncol(results)] <- "description"
    }
    if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[, 
                                                                            1]) | is.logical(selected.dataFrame[, 1])) {
      if (reverse || (!is.null(vars.to.reverse))) {
        Reversed <- ifelse(sign1 < 0, "    x   ", "    .   ")
        results <- cbind(Reversed, results)
      }
      sumMeans <- 0
      sumN <- 0
      for (i in selected) {
        sumMeans <- sumMeans + mean(as.numeric(dataFrame[, 
                                                         i]), na.rm = TRUE) * length(na.omit(dataFrame[, 
                                                                                                       i]))
        sumN <- sumN + length(na.omit(dataFrame[, i]))
      }
      mean.of.total.scores <- weighted.mean(rowSums(selected.matrix), 
                                            w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.total.scores <- sd(rowSums(selected.matrix), 
                               na.rm = TRUE)
      mean.of.average.scores <- weighted.mean(rowMeans(selected.matrix), 
                                              w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.average.scores <- sd(rowMeans(selected.matrix), 
                                 na.rm = TRUE)
      countCol <- which(colnames(results) == "count")
      meanCol <- which(colnames(results) == "mean")
      sdCol <- which(colnames(results) == "sd")
      if (total) {
        results <- rbind(results, rep("", reverse || 
                                        suppressWarnings(!is.null(vars.to.reverse)) + 
                                        (maxlevel + 1 - minlevel) + (count + means + 
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length((rowSums(selected.dataFrame))[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.total.scores, 
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.total.scores, 
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Total score"
        results <- rbind(results, rep("", reverse || 
                                        suppressWarnings(!is.null(vars.to.reverse)) + 
                                        (maxlevel + 1 - minlevel) + (count + means + 
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length(rowSums(selected.dataFrame)[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.average.scores, 
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.average.scores, 
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Average score"
      }
    }
    results <- list(results = noquote(results))
    if (reverse || suppressWarnings(!is.null(vars.to.reverse))) 
      results <- c(results, list(items.reversed = names(selected.dataFrame)[sign1 < 
                                                                              0]))
    if (var.labels && !is.null(attributes(dataFrame)$var.labels)) {
      results <- c(results, list(item.labels = attributes(dataFrame)$var.labels[selected]))
    }
    if (total) {
      if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[, 
                                                                              1])) {
        results <- c(results, list(total.score = rowSums(selected.matrix)), 
                     list(mean.score = rowMeans(selected.matrix)), 
                     list(mean.of.total.scores = mean.of.total.scores, 
                          sd.of.total.scores = sd.of.total.scores, 
                          mean.of.average.scores = mean.of.average.scores, 
                          sd.of.average.scores = sd.of.average.scores))
      }
    }
    class(results) <- c("tableStack", "list")
    results
  }
  else {
    if (is.character(by.var)) {
      by1 <- as.factor(rep("Total", nrow(dataFrame)))
    }
    else {
      by1 <- factor(dataFrame[, by.var])
    }
    if (is.logical(dataFrame[, i])) {
      dataFrame[, i] <- as.factor(dataFrame[, i])
      levels(dataFrame[, i]) <- c("No", "Yes")
    }
    if (length(table(by1)) == 1) 
      test <- FALSE
    name.test <- ifelse(test, name.test, FALSE)
    if (is.character(iqr)) {
      if (iqr == "auto") {
        selected.iqr <- NULL
        for (i in 1:length(selected)) {
          if (class(dataFrame[, selected[i]]) == "difftime") {
            dataFrame[, selected[i]] <- as.numeric(dataFrame[, 
                                                             selected[i]])
          }
          if (is.integer(dataFrame[, selected[i]]) | 
              is.numeric(dataFrame[, selected[i]])) {
            if (length(table(by1)) > 1) {
              if (nrow(dataFrame) < 5000) {
                if (nrow(dataFrame) < 3) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
                else if (shapiro.test(lm(dataFrame[, 
                                                   selected[i]] ~ by1)$residuals)$p.value < 
                         0.01 | bartlett.test(dataFrame[, selected[i]] ~ 
                                              by1)$p.value < 0.01) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
              else {
                sampled.shapiro <- sample(lm(dataFrame[, 
                                                       selected[i]] ~ by1)$residuals, 250)
                if (shapiro.test(sampled.shapiro)$p.value < 
                    0.01 | bartlett.test(dataFrame[, selected[i]] ~ 
                                         by1)$p.value < 0.01) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
            }
          }
        }
      }
      else {
        selected.iqr <- NULL
      }
    }
    table2 <- NULL
    for (i in 1:length(selected)) {
      if (is.factor(dataFrame[, selected[i]]) | is.logical(dataFrame[, 
                                                                     selected[i]])) {
        x0 <- table(dataFrame[, selected[i]], by1)
        if (total.column) {
          x <- addmargins(x0, margin = 2)
        }
        else {
          x <- x0
        }
        nr <- nrow(x)
        nc <- ncol(x0)
        sr <- rowSums(x0)
        if (any(sr == 0)) {
          stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one row"))
        }
        sc <- colSums(x0)
        if (any(sc == 0)) {
          stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one column"))
        }
        x.row.percent <- round(x/rowSums(x0) * 100, decimal)
        table0 <- x
        if (nrow(x) == 2 & prevalence) {
          table00 <- addmargins(x, margin = 1)
          table0 <- paste(table00[2, ], "/", table00[3, 
                                                     ], " (", round(table00[2, ]/table00[3, ] * 
                                                                      100, decimal), "%)", sep = "")
          table0 <- t(table0)
          rownames(table0) <- "  prevalence"
        }
        else {
          if (any(percent == "column")) {
            x.col.percent <- round(t(t(x)/colSums(x)) * 
                                     100, decimal)
            x.col.percent1 <- matrix(paste(x, " (", x.col.percent, 
                                           ")", sep = ""), nrow(x), ncol(x))
            if (!frequency) {
              x.col.percent1 <- x.col.percent
            }
            table0 <- x.col.percent1
          }
          else {
            if (any(percent == "row")) {
              x.row.percent <- round(x/rowSums(x0) * 
                                       100, decimal)
              x.row.percent1 <- matrix(paste(x, " (", 
                                             x.row.percent, ")", sep = ""), nrow(x), 
                                       ncol(x))
              if (!frequency) {
                x.row.percent1 <- x.row.percent
              }
              table0 <- x.row.percent1
            }
          }
          rownames(table0) <- paste("  ", rownames(x))
          colnames(table0) <- colnames(x)
        }
        if (test) {
          E <- outer(sr, sc, "*")/sum(x0)
          dim(E) <- NULL
          if ((sum(E < 5))/length(E) > 0.2 & nrow(dataFrame) < 
              1000) {
            test.method <- "Fisher's exact test"
            p.value <- fisher.test(x0, simulate.p.value = TRUE)$p.value
          }
          else {
            test.method <- paste("Chisq. (", suppressWarnings(chisq.test(x0)$parameter), 
                                 " df) = ", suppressWarnings(round(chisq.test(x0)$statistic, 
                                                                   decimal + 1)), sep = "")
            p.value <- suppressWarnings(chisq.test(x0)$p.value)
          }
        }
      }
      if (is.numeric(dataFrame[, selected[i]])) {
        if (any(selected.iqr == selected[i])) {
          term1 <- NULL
          term2 <- NULL
          term3 <- NULL
          for (j in 1:(length(levels(by1)))) {
            term1 <- c(term1, mean(dataFrame[, selected[i]], 
                                   na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[, selected[i]], 
                                 na.rm = TRUE))
            term3 <- c(term3, quantile(dataFrame[, selected[i]], 
                                       na.rm = TRUE))
          }
          if (total.column) {
            term1 <- c(term1, mean(dataFrame[, selected[i]], 
                                   na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[, selected[i]], 
                                 na.rm = TRUE))
            term3 <- c(term3, quantile(dataFrame[, selected[i]], 
                                       na.rm = TRUE))
          }
          term.numeric <- paste(round(term1, 2), 
                                " (", round(term2, 2), ")", " [",round(term3, 
                                                                       2), "]", sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "mean (sd) [quartile]"
        }
        else {
          term1 <- as.vector(tapply(X = dataFrame[, selected[i]], 
                                    INDEX = list(by1), FUN = "mean", na.rm = TRUE))
          if (total.column) {
            term1 <- c(term1, mean(dataFrame[, selected[i]], 
                                   na.rm = TRUE))
          }
          term2 <- as.vector(tapply(X = dataFrame[, selected[i]], 
                                    INDEX = list(by1), FUN = "sd", na.rm = TRUE))
          if (total.column) {
            term2 <- c(term2, sd(dataFrame[, selected[i]], 
                                 na.rm = TRUE))
          }
          term.numeric <- paste(round(term1, decimal), 
                                " (", round(term2, decimal), ")", sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "  mean(SD)"
        }
        table0 <- term.numeric
        if (test) {
          if (any(selected.iqr == selected[i])) {
            if (length(levels(by1)) > 2) {
              test.method <- "Kruskal-Wallis test"
              p.value <- kruskal.test(dataFrame[, selected[i]] ~ 
                                        by1)$p.value
            }
            else {
              test.method <- "Ranksum test"
              p.value <- wilcox.test(dataFrame[, selected[i]] ~ 
                                       by1, exact = FALSE)$p.value
            }
          }
          else {
            if (length(levels(by1)) > 2) {
              test.method <- paste("ANOVA F-test (", 
                                   anova(lm(dataFrame[, selected[i]] ~ by1))[1, 
                                                                             1], ", ", anova(lm(dataFrame[, selected[i]] ~ 
                                                                                                  by1))[2, 1], " df) = ", round(anova(lm(dataFrame[, 
                                                                                                                                                   selected[i]] ~ by1))[1, 4], decimal + 
                                                                                                                                  1), sep = "")
              p.value <- anova(lm(dataFrame[, selected[i]] ~ 
                                    by1))[1, 5]
            }
            else {
              test.method <- paste("t-test", paste(" (", 
                                                   t.test(dataFrame[, selected[i]] ~ by1, 
                                                          var.equal = TRUE)$parameter, " df)", 
                                                   sep = ""), "=", round(abs(t.test(dataFrame[, 
                                                                                              selected[i]] ~ by1, var.equal = TRUE)$statistic), 
                                                                         decimal + 1))
              p.value <- t.test(dataFrame[, selected[i]] ~ 
                                  by1, var.equal = TRUE)$p.value
            }
          }
        }
      }
      if (test) {
        if (name.test) {
          label.row <- c(rep("", length(levels(by1)) + 
                               total.column), test.method, ifelse(p.value < 
                                                                    0.001, "< 0.001", round(p.value, decimal + 
                                                                                              2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total", 
                                     "Test stat.", "  P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "Test stat.", 
                                     "  P value")
          }
          table0 <- cbind(table0, "", "")
          blank.row <- rep("", length(levels(by1)) + 
                             total.column + 2)
        }
        else {
          label.row <- c(rep("", length(levels(by1)) + 
                               total.column), ifelse(p.value < 0.001, "< 0.001", 
                                                     round(p.value, decimal + 2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total", 
                                     "  P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "  P value")
          }
          table0 <- cbind(table0, "")
          blank.row <- rep("", length(levels(by1)) + 
                             total.column + 1)
        }
      }
      else {
        label.row <- c(rep("", length(levels(by1)) + 
                             total.column))
        label.row <- t(label.row)
        if (total.column) {
          colnames(label.row) <- c(levels(by1), "Total")
        }
        else {
          colnames(label.row) <- c(levels(by1))
        }
        blank.row <- rep("", length(levels(by1)) + total.column)
      }
      if (var.labels) {
        rownames(label.row) <- ifelse(!is.null(attributes(dataFrame)$var.labels[selected][i]), 
                                      attributes(dataFrame)$var.labels[selected[i]], 
                                      names(dataFrame)[selected][i])
        rownames(label.row) <- ifelse(rownames(label.row) == 
                                        "", names(dataFrame[selected[i]]), rownames(label.row))
      }
      else {
        rownames(label.row) <- paste(selected[i], ":", 
                                     names(dataFrame[selected[i]]))
      }
      if (!is.logical(dataFrame[, selected[i]])) {
        if (prevalence & length(levels(dataFrame[, selected[i]])) == 
            2) {
          rownames(label.row) <- paste(rownames(label.row), 
                                       "=", levels(dataFrame[, selected[i]])[2])
        }
      }
      blank.row <- t(blank.row)
      rownames(blank.row) <- ""
      table2 <- rbind(table2, label.row, table0, blank.row)
    }
    class(table2) <- c("tableStack", "table")
    
  }
  table2=as.data.frame(table2)
  if(na.col==TRUE){
    table2$Missing=""
    table2[,1]=as.character(table2[,1])
    vars=table2[,1][which(table2[,1]%in% colnames(dataFrame)==T)]
    for (i in vars){
      na_number=sum(is.na(dataFrame[,i]))
      table2[which(table2[,1]==i),"Missing"]=na_number
    }
  }
  return(table2)
}


####### tableStack QUANTITATIF

sortiequantibistack<-function(x,y,w)
{
  for (i in y)
  {
    sortiequantibi(x,i,w)
  }
}

############################################    t.test   ##################################################################################################

sortiequantibistackt<-function(x,y,w,nomdefichier)
{
  tt2<-NULL
  for (z in y)
  {
    f<-NULL;
    f<-c(f,dimnames(x)[[2]][w]);
    tt<-matrix(data="NA",nr=length(f),nc=5);
    dimnames(tt)<-list(c(1:length(f)),c(dimnames(x)[[2]][[w]],"NA-quant",paste(names(table(x[,y]))[1],"Mediane[min-max]/Nobs"),paste(names(table(x[,y]))[2],"Mediane[min-max]/Nobs"),"p-t.test" ))
    j<-1;
    tt[j,1]<-dimnames(x)[[2]][z];
    tt[j,2]<-paste(length(x[,z][is.na(x[,z])]),"/",length(x[,w][is.na(x[,w])]));
    tt[j,3]<-paste(round(mean(x[,w][x[,z]==names(table(x[,z]))[1]],na.rm=T),2)," [",round(quantile(x[,w][x[,z]==names(table(x[,z]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,w][x[,z]==names(table(x[,z]))[1]],na.rm=T),2) ,"-",round(max(x[,w][x[,z]==names(table(x[,z]))[1]],na.rm=T),2),"] ", round(sd(x[,w][x[,z]==names(table(x[,z]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,w],x[,z]))[,1]),sep="");
    tt[j,4]<-paste(round(mean(x[,w][x[,z]==names(table(x[,z]))[2]],na.rm=T),2)," [",round(quantile(x[,w][x[,z]==names(table(x[,z]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,w][x[,z]==names(table(x[,z]))[2]],na.rm=T),2) ,"-",round(max(x[,w][x[,z]==names(table(x[,z]))[2]],na.rm=T),2),"] ", round(sd(x[,w][x[,z]==names(table(x[,z]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,w],x[,z]))[,2]),sep="");
    tt[j,5]<-ifelse(t.test(x[,w][x[,z]==names(table(x[,z]))[1]], x[,w][x[,z]==names(table(x[,z]))[2]],var.equal=T )[[3]]<0.0001,"<0.0001", round(t.test(x[,w][x[,z]==names(table(x[,z]))[1]], x[,w][x[,z]==names(table(x[,z]))[2]],var.equal=T )[[3]],5));
    tt2<- rbind(tt2,tt);
  }
  write.table(tt2,paste(file_pour_les_tables_resultats,"tableStackt_",nomdefichier,dimnames(x)[[2]][w],".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word ;
}

######################################################################################################################################################

########################################## Wilcox  ##############################################################################################################

sortiequantibistackMEDt<-function(x,y,w,nomdefichier)
{
  tt2<-NULL
  for (z in y)
  {
    f<-NULL;
    f<-c(f,dimnames(x)[[2]][w]);
    tt<-matrix(data="NA",nr=length(f),nc=5);
    dimnames(tt)<-list(c(1:length(f)),c(dimnames(x)[[2]][[w]],"NA-quant","Mediane[min-max]/Nobs","Mediane[min-max]/Nobs","p-Wilcoxon" ))
    j<-1;
    tt[j,1]<-dimnames(x)[[2]][z] ;
    tt[j,2]<-paste(length(x[,w][is.na(x[,w])]));
    tt[j,3]<-paste(round(quantile(x[,w][x[,z]==names(table(x[,z]))[1]],probs=0.5,na.rm=T)[[1]],2) ," [",round(min(x[,w][x[,z]==names(table(x[,z]))[1]],na.rm=T),2) ,"-",round(max(x[,w][x[,z]==names(table(x[,z]))[1]],na.rm=T),2),"]","/",sum(as.matrix(table(x[,w],x[,z]))[,1]),sep="");
    tt[j,4]<-paste(round(quantile(x[,w][x[,z]==names(table(x[,z]))[2]],probs=0.5,na.rm=T)[[1]],2) ," [",round(min(x[,w][x[,z]==names(table(x[,z]))[2]],na.rm=T),2) ,"-",round(max(x[,w][x[,z]==names(table(x[,z]))[2]],na.rm=T),2),"]","/",sum(as.matrix(table(x[,w],x[,z]))[,2]),sep="");
    tt[j,5]<-ifelse(wilcox.test(x[,w][x[,z]==names(table(x[,z]))[1]], x[,w][x[,z]==names(table(x[,z]))[2]] )[[3]]<0.001,"<0.001", round(wilcox.test(x[,w][x[,z]==names(table(x[,z]))[1]], x[,w][x[,z]==names(table(x[,z]))[2]] )[[3]],3));
    tt2<- rbind(tt2,tt);
  }
  write.table(tt2,paste(file_pour_les_tables_resultats,"tableStackMEDt_",nomdefichier,dimnames(x)[[2]][w],".txt",sep=""),append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word ;
}

####################################FIN#################""
#############################################################
####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value)


sortiequalibi_pourcent_ligne<-function(x,y,w,nomdefichier)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUALITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p-Chi2" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ;
    tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),"");
    tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/ ( table(x[,i],x[,y])[z-1,1]+ table(x[,i],x[,y])[z-1,2]) ,2) ,"%)",sep=""),"");
    tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/( table(x[,i],x[,y])[z-1,2]+ table(x[,i],x[,y])[ z-1,1]),2) ,"%)",sep=""),"");
    
    tt[j+z,5]<-ifelse(z>1,"-",ifelse(chisq.test(x[,i],x[,y])[[3]]<0.0001,"<0.0001", round(chisq.test(x[,i],x[,y])[[3]],5)))}; j<-j+k}
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    #####
    # Envoyer le tableau dans MARKDOWN
    return(as.data.frame(tt))
    
    #print(noquote(tt));
    rm(a,b,g,k,i,j,tt,z,x,y,w)
}

####____FIN
####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value)


tableStack_colonne<-function (vars, minlevel = "auto", maxlevel = "auto", count = TRUE,
                              na.rm = FALSE, means = TRUE, medians = FALSE, sds = TRUE,
                              decimal = 1, dataFrame = .data, total = TRUE, var.labels = TRUE,
                              var.labels.trunc = 150, reverse = FALSE, vars.to.reverse = NULL,
                              by = NULL, vars.to.factor = NULL, iqr = "auto", prevalence = FALSE,
                              percent = c("column", "row", "none"), frequency = TRUE, test = TRUE,
                              name.test = TRUE, total.column = FALSE, simulate.p.value = FALSE,
                              sample.size = TRUE)
{
  nl <- as.list(1:ncol(dataFrame))
  names(nl) <- names(dataFrame)
  selected <- eval(substitute(vars), nl, parent.frame())
  by.var <- eval(substitute(by), nl, parent.frame())
  if (is.numeric(by.var)) {
    by <- dataFrame[, by.var]
  }
  if (is.character(by.var)) {
    by1 <- as.factor(rep("Total", nrow(dataFrame)))
  }
  if (is.null(by)) {
    selected.class <- NULL
    for (i in selected) {
      selected.class <- c(selected.class, class(dataFrame[,
                                                          i]))
    }
    if (length(table(table(selected.class))) > 1)
      warning("Without 'by', classes of all selected variables should be the same.")
  }
  selected.to.factor <- eval(substitute(vars.to.factor), nl,
                             parent.frame())
  if (!is.character(iqr)) {
    selected.iqr <- eval(substitute(iqr), nl, parent.frame())
    intersect.selected <- intersect(selected.iqr, selected.to.factor)
    if (length(intersect.selected) != 0) {
      stop(paste(names(dataFrame)[intersect.selected],
                 "cannot simultaneously describe IQR and be coerced factor"))
    }
    for (i in selected.iqr) {
      if (!is.integer(dataFrame[, i]) & !is.numeric(dataFrame[,
                                                              i])) {
        stop(paste(names(dataFrame)[i], "is neither integer nor numeric, not possible to compute IQR"))
      }
    }
  }
  for (i in selected) {
    if ((class(dataFrame[, i]) == "integer" | class(dataFrame[,
                                                              i]) == "numeric") & !is.null(by)) {
      if (any(selected.to.factor == i)) {
        dataFrame[, i] <- factor(dataFrame[, i])
      }
      else {
        dataFrame[, i] <- as.numeric(dataFrame[, i])
      }
    }
  }
  if ((reverse || suppressWarnings(!is.null(vars.to.reverse))) &&
      is.factor(dataFrame[, selected][, 1])) {
    stop("Variables must be in 'integer' class before reversing. \n        Try 'unclassDataframe' first'")
  }
  selected.dataFrame <- dataFrame[, selected, drop = FALSE]
  if (is.null(by)) {
    selected.matrix <- NULL
    for (i in selected) {
      selected.matrix <- cbind(selected.matrix, unclass(dataFrame[,
                                                                  i]))
    }
    colnames(selected.matrix) <- names(selected.dataFrame)
    if (minlevel == "auto") {
      minlevel <- min(selected.matrix, na.rm = TRUE)
    }
    if (maxlevel == "auto") {
      maxlevel <- max(selected.matrix, na.rm = TRUE)
    }
    nlevel <- as.list(minlevel:maxlevel)
    names(nlevel) <- eval(substitute(minlevel:maxlevel),
                          nlevel, parent.frame())
    if (suppressWarnings(!is.null(vars.to.reverse))) {
      nl1 <- as.list(1:ncol(dataFrame))
      names(nl1) <- names(dataFrame[, selected])
      which.neg <- eval(substitute(vars.to.reverse), nl1,
                        parent.frame())
      for (i in which.neg) {
        dataFrame[, selected][, i] <- maxlevel + 1 -
          dataFrame[, selected][, i]
        selected.matrix[, i] <- maxlevel + 1 - selected.matrix[,
                                                               i]
      }
      reverse <- FALSE
      sign1 <- rep(1, ncol(selected.matrix))
      sign1[which.neg] <- -1
    }
    if (reverse) {
      matR1 <- cor(selected.matrix, use = "pairwise.complete.obs")
      diag(matR1) <- 0
      if (any(matR1 > 0.98)) {
        reverse <- FALSE
        temp.mat <- which(matR1 > 0.98, arr.ind = TRUE)
        warning(paste(paste(rownames(temp.mat), collapse = " and ")),
                " are extremely correlated.", "\n", "  The command has been excuted without 'reverse'.",
                "\n", "  Remove one of them from 'vars' if 'reverse' is required.")
      }
      else {
        score <- factanal(na.omit(selected.matrix), factors = 1,
                          scores = "regression")$score
        sign1 <- NULL
        for (i in 1:length(selected)) {
          sign1 <- c(sign1, sign(cor(score, na.omit(selected.matrix)[,
                                                                     i], use = "pairwise")))
        }
        which.neg <- which(sign1 < 0)
        for (i in which.neg) {
          dataFrame[, selected][, i] <- maxlevel + minlevel -
            dataFrame[, selected][, i]
          selected.matrix[, i] <- maxlevel + minlevel -
            selected.matrix[, i]
        }
      }
    }
    table1 <- NULL
    for (i in as.integer(selected)) {
      if (!is.factor(dataFrame[, i]) & !is.logical(dataFrame[,
                                                             i, drop = TRUE])) {
        x <- factor(dataFrame[, i])
        levels(x) <- nlevel
        tablei <- table(x)
      }
      else {
        if (is.logical(dataFrame[, i, drop = TRUE])) {
          tablei <- table(factor(dataFrame[, i, drop = TRUE],
                                 levels = c("FALSE", "TRUE")))
        }
        else {
          tablei <- table(dataFrame[, i])
        }
      }
      if (count) {
        tablei <- c(tablei, length(na.omit(dataFrame[,
                                                     i])))
        names(tablei)[length(tablei)] <- "count"
      }
      if (is.numeric(selected.dataFrame[, 1, drop = TRUE]) |
          is.logical(selected.dataFrame[, 1, drop = TRUE])) {
        if (means) {
          tablei <- c(tablei, round(mean(as.numeric(dataFrame[,
                                                              i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "mean"
        }
        if (medians) {
          tablei <- c(tablei, round(median(as.numeric(dataFrame[,
                                                                i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "median"
        }
        if (sds) {
          tablei <- c(tablei, round(sd(as.numeric(dataFrame[,
                                                            i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "sd"
        }
      }
      table1 <- rbind(table1, tablei)
    }
    results <- as.table(table1)
    if (var.labels) {
      rownames(results) <- names(selected.dataFrame)
    }
    else {
      rownames(results) <- paste(selected, ":", names(selected.dataFrame))
    }
    if (is.integer(selected.dataFrame[, 1])) {
      rownames(results) <- names(nl)[selected]
      if (is.factor(dataFrame[, selected][, 1])) {
        colnames(results)[1:(ncol(results) - (count +
                                                means + medians + sds))] <- levels(dataFrame[,
                                                                                             selected][, 1])
      }
      else {
        colnames(results)[1:(ncol(results) - (count +
                                                means + medians + sds))] <- names(nlevel)
      }
    }
    result0 <- results
    if (var.labels) {
      if (!is.null(attributes(dataFrame)$var.labels)) {
        results <- as.table(cbind(results, substr(attributes(dataFrame)$var.labels[selected],
                                                  1, var.labels.trunc)))
      }
      if (!is.null(attributes(dataFrame)$var.labels))
        colnames(results)[ncol(results)] <- "description"
    }
    if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[,
                                                                            1]) | is.logical(selected.dataFrame[, 1])) {
      if (reverse || (!is.null(vars.to.reverse))) {
        Reversed <- ifelse(sign1 < 0, "    x   ", "    .   ")
        results <- cbind(Reversed, results)
      }
      sumMeans <- 0
      sumN <- 0
      for (i in selected) {
        sumMeans <- sumMeans + mean(as.numeric(dataFrame[,
                                                         i]), na.rm = TRUE) * length(na.omit(dataFrame[,
                                                                                                       i]))
        sumN <- sumN + length(na.omit(dataFrame[, i]))
      }
      mean.of.total.scores <- weighted.mean(rowSums(selected.matrix),
                                            w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.total.scores <- sd(rowSums(selected.matrix),
                               na.rm = TRUE)
      mean.of.average.scores <- weighted.mean(rowMeans(selected.matrix),
                                              w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.average.scores <- sd(rowMeans(selected.matrix),
                                 na.rm = TRUE)
      countCol <- which(colnames(results) == "count")
      meanCol <- which(colnames(results) == "mean")
      sdCol <- which(colnames(results) == "sd")
      if (total) {
        results <- rbind(results, rep("", reverse ||
                                        suppressWarnings(!is.null(vars.to.reverse)) +
                                        (maxlevel + 1 - minlevel) + (count + means +
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length((rowSums(selected.dataFrame))[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.total.scores,
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.total.scores,
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Total score"
        results <- rbind(results, rep("", reverse ||
                                        suppressWarnings(!is.null(vars.to.reverse)) +
                                        (maxlevel + 1 - minlevel) + (count + means +
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length(rowSums(selected.dataFrame)[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.average.scores,
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.average.scores,
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Average score"
      }
    }
    results <- list(results = noquote(results))
    if (reverse || suppressWarnings(!is.null(vars.to.reverse)))
      results <- c(results, list(items.reversed = names(selected.dataFrame)[sign1 <
                                                                              0]))
    if (var.labels && !is.null(attributes(dataFrame)$var.labels)) {
      results <- c(results, list(item.labels = attributes(dataFrame)$var.labels[selected]))
    }
    if (total) {
      if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[,
                                                                              1])) {
        results <- c(results, list(total.score = rowSums(selected.matrix)),
                     list(mean.score = rowMeans(selected.matrix,
                                                na.rm = na.rm)), list(mean.of.total.scores = mean.of.total.scores,
                                                                      sd.of.total.scores = sd.of.total.scores,
                                                                      mean.of.average.scores = mean.of.average.scores,
                                                                      sd.of.average.scores = sd.of.average.scores))
      }
    }
    class(results) <- c("tableStack", "list")
    results
  }
  else {
    if (is.character(by.var)) {
      by1 <- as.factor(rep("Total", nrow(dataFrame)))
    }
    else {
      by1 <- factor(dataFrame[, by.var])
    }
    if (is.logical(dataFrame[, i])) {
      dataFrame[, i] <- as.factor(dataFrame[, i])
      levels(dataFrame[, i]) <- c("No", "Yes")
    }
    if (length(table(by1)) == 1)
      test <- FALSE
    name.test <- ifelse(test, name.test, FALSE)
    if (is.character(iqr)) {
      if (iqr == "auto") {
        selected.iqr <- NULL
        for (i in 1:length(selected)) {
          if (class(dataFrame[, selected[i]]) == "difftime") {
            dataFrame[, selected[i]] <- as.numeric(dataFrame[,
                                                             selected[i]])
          }
          if (is.integer(dataFrame[, selected[i]]) |
              is.numeric(dataFrame[, selected[i]])) {
            if (length(table(by1)) > 1) {
              if (nrow(dataFrame) < 5000) {
                if (nrow(dataFrame) < 3) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
                else if (shapiro.test(lm(dataFrame[,
                                                   selected[i]] ~ by1)$residuals)$p.value <
                         0.01
                         #| bartlett.test(dataFrame[, selected[i]] ~
                         #by1)$p.value < 0.01
                ) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
              else {
                sampled.shapiro <- sample(lm(dataFrame[,
                                                       selected[i]] ~ by1)$residuals, 250)
                if (shapiro.test(sampled.shapiro)$p.value <
                    0.01
                    #| bartlett.test(dataFrame[, selected[i]] ~
                    #by1)$p.value < 0.01
                ) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
            }
          }
        }
      }
      else {
        selected.iqr <- NULL
      }
    }
    table2 <- NULL
    if (sample.size) {
      if (test) {
        if (name.test) {
          if (total.column) {
            table2 <- rbind(c(table(by1), length(by1),
                              "", ""), c(rep("", length(table(by1)) +
                                               1), "", ""))
            colnames(table2)[ncol(table2) - (2:0)] <- c("Total",
                                                        "Test stat.", "P value")
          }
          else {
            table2 <- rbind(c(table(by1), "", ""), c(rep("",
                                                         length(table(by1))), "", ""))
            colnames(table2)[ncol(table2) - (1:0)] <- c("Test stat.",
                                                        "P value")
          }
        }
        else {
          if (total.column) {
            table2 <- rbind(c(table(by1), length(by1),
                              ""), c(rep("", length(table(by1)) + 1),
                                     "", ""))
            colnames(table2)[ncol(table2) - (1:0)] <- c("Total",
                                                        "P value")
          }
          else {
            table2 <- rbind(c(table(by1), ""), c(rep("",
                                                     length(table(by1))), ""))
            colnames(table2)[ncol(table2)] <- "P value"
          }
        }
      }
      else {
        total.column <- FALSE
        table2 <- rbind(table(by1), "")
      }
    }
    for (i in 1:length(selected)) {
      if (is.factor(dataFrame[, selected[i]]) | is.logical(dataFrame[,
                                                                     selected[i]]) | is.character(dataFrame[, selected[i]])) {
        x0 <- table(dataFrame[, selected[i]], by1)
        if (total.column) {
          x <- addmargins(x0, margin = 2)
        }
        else {
          x <- x0
        }
        nr <- nrow(x)
        nc <- ncol(x0)
        sr <- rowSums(x0)
        if (any(sr == 0)) {
          stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one row"))
        }
        sc <- colSums(x0)
        if (any(sc == 0)) {
          stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one column"))
        }
        x.row.percent <- round(x/rowSums(x0) * 100, decimal)
        table0 <- x
        if (nrow(x) == 2 & prevalence) {
          table00 <- addmargins(x, margin = 1)
          table0 <- paste(table00[2, ], "/", table00[3,
                                                     ], " (", round(table00[2, ]/table00[3, ] *
                                                                      100, decimal), "%)", sep = "")
          table0 <- t(table0)
          rownames(table0) <- "  prevalence"
        }
        else {
          if (any(percent == "column")) {
            x.col.percent <- round(t(t(x)/colSums(x)) *
                                     100, decimal)
            x.col.percent1 <- matrix(paste(x, " (", x.col.percent,
                                           ")", sep = ""), nrow(x), ncol(x))
            if (!frequency) {
              x.col.percent1 <- x.col.percent
            }
            table0 <- x.col.percent1
          }
          else {
            if (any(percent == "row")) {
              x.row.percent <- round(x/rowSums(x0) *
                                       100, decimal)
              x.row.percent1 <- matrix(paste(x, " (",
                                             x.row.percent, ")", sep = ""), nrow(x),
                                       ncol(x))
              if (!frequency) {
                x.row.percent1 <- x.row.percent
              }
              table0 <- x.row.percent1
            }
          }
          rownames(table0) <- paste("  ", rownames(x))
          colnames(table0) <- colnames(x)
        }
        if (test) {
          E <- outer(sr, sc, "*")/sum(x0)
          dim(E) <- NULL
          if ((sum(E < 5))/length(E) > 0.2 & nrow(dataFrame) <
              1000) {
            test.method <- "Fisher's exact test"
            p.value <- fisher.test(x0, simulate.p.value = simulate.p.value)$p.value
          }
          else {
            test.method <- paste("Chisq. (", suppressWarnings(chisq.test(x0)$parameter),
                                 " df) = ", suppressWarnings(round(chisq.test(x0)$statistic,
                                                                   decimal + 1)), sep = "")
            p.value <- suppressWarnings(chisq.test(x0)$p.value)
          }
        }
      }
      if (is.numeric(dataFrame[, selected[i]])) {
        if (any(selected.iqr == selected[i])) {
          term1 <- NULL
          term2 <- NULL
          term3 <- NULL
          term4 <- NULL
          term5 <- NULL
          for (j in 1:(length(levels(by1)))) {
            term1 <- c(term1, mean(dataFrame[by1 ==
                                               levels(by1)[j], selected[i]], na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[by1 ==
                                             levels(by1)[j], selected[i]], na.rm = TRUE))
            term3 <- c(term3, median(dataFrame[by1 ==
                                                 levels(by1)[j], selected[i]], na.rm = TRUE))
            term4 <- c(term4, quantile(dataFrame[by1 ==
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[[1]])
            term5 <- c(term5, quantile(dataFrame[by1 ==
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[[5]])
          }
          if (total.column) {
            term1 <- c(term1, mean(dataFrame[, selected[i]],
                                   na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[, selected[i]],
                                 na.rm = TRUE))
            term3 <- c(term3, median(dataFrame[, selected[i]],
                                     na.rm = TRUE))
            term4 <- c(term4, quantile(dataFrame[, selected[i]],
                                       na.rm = TRUE)[[1]])
            term5 <- c(term5, quantile(dataFrame[, selected[i]],
                                       na.rm = TRUE)[[5]])
          }
          term.numeric <- paste(
            round(term1, decimal),
            "  (",
            signif(term2, digits = 2),
            ")   ",
            signif(term3,digits = 2),
            "   [",
            signif(term4, digits = 2),
            "-",
            signif(term5, digits = 2),
            "]",
            sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "mean (sd)  median [min-max]"
        }
        else {
          term1 <- as.vector(tapply(X = dataFrame[, selected[i]],
                                    INDEX = list(by1), FUN = "mean", na.rm = TRUE))
          if (total.column) {
            term1 <- c(term1, mean(dataFrame[, selected[i]],
                                   na.rm = TRUE))
          }
          term2 <- as.vector(tapply(X = dataFrame[, selected[i]],
                                    INDEX = list(by1), FUN = "sd", na.rm = TRUE))
          if (total.column) {
            term2 <- c(term2, sd(dataFrame[, selected[i]],
                                 na.rm = TRUE))
          }
          term.numeric <- paste(round(term1, decimal),
                                " (", round(term2, decimal), ")", sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "  mean(SD)"
        }
        table0 <- term.numeric
        if (test) {
          if (any(as.integer(table(by1[!is.na(dataFrame[,
                                                        selected[i]])])) < 3) | length(table(by1)) >
              length(table(by1[!is.na(dataFrame[, selected[i]])]))) {
            test.method <- paste("Sample too small: group",
                                 paste(which(as.integer(table(factor(by)[!is.na(dataFrame[,
                                                                                          selected[i]])])) < 3), collapse = " "))
            p.value <- NA
          }
          else {
            if (any(selected.iqr == selected[i])) {
              if (length(levels(by1)) > 2) {
                test.method <- "Kruskal-Wallis test"
                p.value <- kruskal.test(dataFrame[, selected[i]] ~
                                          by1)$p.value
              }
              else {
                test.method <- "Ranksum test"
                p.value <- wilcox.test(dataFrame[, selected[i]] ~
                                         by1, exact = FALSE)$p.value
              }
            }
            else {
              if (length(levels(by1)) > 2) {
                test.method <- paste("ANOVA F-test (",
                                     anova(lm(dataFrame[, selected[i]] ~
                                                by1))[1, 1], ", ", anova(lm(dataFrame[,
                                                                                      selected[i]] ~ by1))[2, 1], " df) = ",
                                     round(anova(lm(dataFrame[, selected[i]] ~
                                                      by1))[1, 4], decimal + 1), sep = "")
                p.value <- anova(lm(dataFrame[, selected[i]] ~
                                      by1))[1, 5]
              }
              else {
                test.method <- paste("t-test", paste(" (",
                                                     t.test(dataFrame[, selected[i]] ~ by1,
                                                            var.equal = TRUE)$parameter, " df)",
                                                     sep = ""), "=", round(abs(t.test(dataFrame[,
                                                                                                selected[i]] ~ by1, var.equal = TRUE)$statistic),
                                                                           decimal + 1))
                p.value <- t.test(dataFrame[, selected[i]] ~
                                    by1, var.equal = TRUE)$p.value
              }
            }
          }
        }
      }
      if (test) {
        if (name.test) {
          label.row <- c(rep("", length(levels(by1)) +
                               total.column), test.method, ifelse(p.value <
                                                                    0.001, "< 0.001", round(p.value, decimal +
                                                                                              2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total",
                                     "Test stat.", "P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "Test stat.",
                                     "P value")
          }
          table0 <- cbind(table0, "", "")
          blank.row <- rep("", length(levels(by1)) +
                             total.column + 2)
        }
        else {
          label.row <- c(rep("", length(levels(by1)) +
                               total.column), ifelse(p.value < 0.001, "< 0.001",
                                                     round(p.value, decimal + 2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total",
                                     "P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "P value")
          }
          table0 <- cbind(table0, "")
          blank.row <- rep("", length(levels(by1)) +
                             total.column + 1)
        }
      }
      else {
        label.row <- c(rep("", length(levels(by1)) +
                             total.column))
        label.row <- t(label.row)
        if (total.column) {
          colnames(label.row) <- c(levels(by1), "Total")
        }
        else {
          colnames(label.row) <- c(levels(by1))
        }
        blank.row <- rep("", length(levels(by1)) + total.column)
      }
      if (var.labels) {
        rownames(label.row) <- ifelse(!is.null(attributes(dataFrame)$var.labels[selected][i]),
                                      attributes(dataFrame)$var.labels[selected[i]],
                                      names(dataFrame)[selected][i])
        rownames(label.row) <- ifelse(rownames(label.row) ==
                                        "", names(dataFrame[selected[i]]), rownames(label.row))
      }
      else {
        rownames(label.row) <- paste(selected[i], ":",
                                     names(dataFrame[selected[i]]))
      }
      if (!is.logical(dataFrame[, selected[i]])) {
        if (prevalence & length(levels(dataFrame[, selected[i]])) ==
            2) {
          rownames(label.row) <- paste(rownames(label.row),
                                       "=", levels(dataFrame[, selected[i]])[2])
        }
      }
      blank.row <- t(blank.row)
      rownames(blank.row) <- ""
      table2 <- rbind(table2, label.row, table0, blank.row)
    }
    if (sample.size) {
      rownames(table2)[1:2] <- c("Total", "")
    }
    class(table2) <- c("tableStack", "table")
    t(table2)
    table2<-t(table2)
    # Envoyer le tableau dans MARKDOWN
    ft <- flextable(as.data.frame(table2));
    ft <- autofit(ft);
    saveRDS(ft, file = "my_data.rds");
    #####
  }
}


#################################################################################################
# tableStack qui sort moy(sd) et med(range)+++
tableStack_moy_med<-function (vars, minlevel = "auto", maxlevel = "auto", count = TRUE,
                              na.rm = FALSE, means = TRUE, medians = FALSE, sds = TRUE,
                              decimal = 1, dataFrame = .data, total = TRUE, var.labels = TRUE,
                              var.labels.trunc = 150, reverse = FALSE, vars.to.reverse = NULL,
                              by = NULL, vars.to.factor = NULL, iqr = "auto", prevalence = FALSE,
                              percent = c("column", "row", "none"), frequency = TRUE, test = TRUE,
                              name.test = TRUE, total.column = FALSE, simulate.p.value = FALSE,
                              sample.size = TRUE,na.col=FALSE)
{
  nl <- as.list(1:ncol(dataFrame))
  names(nl) <- names(dataFrame)
  selected <- eval(substitute(vars), nl, parent.frame())
  by.var <- eval(substitute(by), nl, parent.frame())
  if (is.numeric(by.var)) {
    by <- dataFrame[, by.var]
  }
  if (is.character(by.var)) {
    by1 <- as.factor(rep("Total", nrow(dataFrame)))
  }
  if (is.null(by)) {
    selected.class <- NULL
    for (i in selected) {
      selected.class <- c(selected.class, class(dataFrame[,
                                                          i]))
    }
    if (length(table(table(selected.class))) > 1)
      warning("Without 'by', classes of all selected variables should be the same.")
  }
  selected.to.factor <- eval(substitute(vars.to.factor), nl,
                             parent.frame())
  if (!is.character(iqr)) {
    selected.iqr <- eval(substitute(iqr), nl, parent.frame())
    intersect.selected <- intersect(selected.iqr, selected.to.factor)
    if (length(intersect.selected) != 0) {
      stop(paste(names(dataFrame)[intersect.selected],
                 "cannot simultaneously describe IQR and be coerced factor"))
    }
    for (i in selected.iqr) {
      if (!is.integer(dataFrame[, i]) & !is.numeric(dataFrame[,
                                                              i])) {
        stop(paste(names(dataFrame)[i], "is neither integer nor numeric, not possible to compute IQR"))
      }
    }
  }
  for (i in selected) {
    if ((class(dataFrame[, i]) == "integer" | class(dataFrame[,
                                                              i]) == "numeric") & !is.null(by)) {
      if (any(selected.to.factor == i)) {
        dataFrame[, i] <- factor(dataFrame[, i])
      }
      else {
        dataFrame[, i] <- as.numeric(dataFrame[, i])
      }
    }
  }
  if ((reverse || suppressWarnings(!is.null(vars.to.reverse))) &&
      is.factor(dataFrame[, selected][, 1])) {
    stop("Variables must be in 'integer' class before reversing. \n        Try 'unclassDataframe' first'")
  }
  selected.dataFrame <- dataFrame[, selected, drop = FALSE]
  if (is.null(by)) {
    selected.matrix <- NULL
    for (i in selected) {
      selected.matrix <- cbind(selected.matrix, unclass(dataFrame[,
                                                                  i]))
    }
    colnames(selected.matrix) <- names(selected.dataFrame)
    if (minlevel == "auto") {
      minlevel <- min(selected.matrix, na.rm = TRUE)
    }
    if (maxlevel == "auto") {
      maxlevel <- max(selected.matrix, na.rm = TRUE)
    }
    nlevel <- as.list(minlevel:maxlevel)
    names(nlevel) <- eval(substitute(minlevel:maxlevel),
                          nlevel, parent.frame())
    if (suppressWarnings(!is.null(vars.to.reverse))) {
      nl1 <- as.list(1:ncol(dataFrame))
      names(nl1) <- names(dataFrame[, selected])
      which.neg <- eval(substitute(vars.to.reverse), nl1,
                        parent.frame())
      for (i in which.neg) {
        dataFrame[, selected][, i] <- maxlevel + 1 -
          dataFrame[, selected][, i]
        selected.matrix[, i] <- maxlevel + 1 - selected.matrix[,
                                                               i]
      }
      reverse <- FALSE
      sign1 <- rep(1, ncol(selected.matrix))
      sign1[which.neg] <- -1
    }
    if (reverse) {
      matR1 <- cor(selected.matrix, use = "pairwise.complete.obs")
      diag(matR1) <- 0
      if (any(matR1 > 0.98)) {
        reverse <- FALSE
        temp.mat <- which(matR1 > 0.98, arr.ind = TRUE)
        warning(paste(paste(rownames(temp.mat), collapse = " and ")),
                " are extremely correlated.", "\n", "  The command has been excuted without 'reverse'.",
                "\n", "  Remove one of them from 'vars' if 'reverse' is required.")
      }
      else {
        score <- factanal(na.omit(selected.matrix), factors = 1,
                          scores = "regression")$score
        sign1 <- NULL
        for (i in 1:length(selected)) {
          sign1 <- c(sign1, sign(cor(score, na.omit(selected.matrix)[,
                                                                     i], use = "pairwise")))
        }
        which.neg <- which(sign1 < 0)
        for (i in which.neg) {
          dataFrame[, selected][, i] <- maxlevel + minlevel -
            dataFrame[, selected][, i]
          selected.matrix[, i] <- maxlevel + minlevel -
            selected.matrix[, i]
        }
      }
    }
    table1 <- NULL
    for (i in as.integer(selected)) {
      if (!is.factor(dataFrame[, i]) & !is.logical(dataFrame[,
                                                             i, drop = TRUE])) {
        x <- factor(dataFrame[, i])
        levels(x) <- nlevel
        tablei <- table(x)
      }
      else {
        if (is.logical(dataFrame[, i, drop = TRUE])) {
          tablei <- table(factor(dataFrame[, i, drop = TRUE],
                                 levels = c("FALSE", "TRUE")))
        }
        else {
          tablei <- table(dataFrame[, i])
        }
      }
      if (count) {
        tablei <- c(tablei, length(na.omit(dataFrame[,
                                                     i])))
        names(tablei)[length(tablei)] <- "count"
      }
      if (is.numeric(selected.dataFrame[, 1, drop = TRUE]) |
          is.logical(selected.dataFrame[, 1, drop = TRUE])) {
        if (means) {
          tablei <- c(tablei, round(mean(as.numeric(dataFrame[,
                                                              i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "mean"
        }
        if (medians) {
          tablei <- c(tablei, round(median(as.numeric(dataFrame[,
                                                                i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "median"
        }
        if (sds) {
          tablei <- c(tablei, round(sd(as.numeric(dataFrame[,
                                                            i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "sd"
        }
      }
      table1 <- rbind(table1, tablei)
    }
    results <- as.table(table1)
    if (var.labels) {
      rownames(results) <- names(selected.dataFrame)
    }
    else {
      rownames(results) <- paste(selected, ":", names(selected.dataFrame))
    }
    if (is.integer(selected.dataFrame[, 1])) {
      rownames(results) <- names(nl)[selected]
      if (is.factor(dataFrame[, selected][, 1])) {
        colnames(results)[1:(ncol(results) - (count +
                                                means + medians + sds))] <- levels(dataFrame[,
                                                                                             selected][, 1])
      }
      else {
        colnames(results)[1:(ncol(results) - (count +
                                                means + medians + sds))] <- names(nlevel)
      }
    }
    result0 <- results
    if (var.labels) {
      if (!is.null(attributes(dataFrame)$var.labels)) {
        results <- as.table(cbind(results, substr(attributes(dataFrame)$var.labels[selected],
                                                  1, var.labels.trunc)))
      }
      if (!is.null(attributes(dataFrame)$var.labels))
        colnames(results)[ncol(results)] <- "description"
    }
    if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[,
                                                                            1]) | is.logical(selected.dataFrame[, 1])) {
      if (reverse || (!is.null(vars.to.reverse))) {
        Reversed <- ifelse(sign1 < 0, "    x   ", "    .   ")
        results <- cbind(Reversed, results)
      }
      sumMeans <- 0
      sumN <- 0
      for (i in selected) {
        sumMeans <- sumMeans + mean(as.numeric(dataFrame[,
                                                         i]), na.rm = TRUE) * length(na.omit(dataFrame[,
                                                                                                       i]))
        sumN <- sumN + length(na.omit(dataFrame[, i]))
      }
      mean.of.total.scores <- weighted.mean(rowSums(selected.matrix),
                                            w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.total.scores <- sd(rowSums(selected.matrix),
                               na.rm = TRUE)
      mean.of.average.scores <- weighted.mean(rowMeans(selected.matrix),
                                              w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.average.scores <- sd(rowMeans(selected.matrix),
                                 na.rm = TRUE)
      countCol <- which(colnames(results) == "count")
      meanCol <- which(colnames(results) == "mean")
      sdCol <- which(colnames(results) == "sd")
      if (total) {
        results <- rbind(results, rep("", reverse ||
                                        suppressWarnings(!is.null(vars.to.reverse)) +
                                        (maxlevel + 1 - minlevel) + (count + means +
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length((rowSums(selected.dataFrame))[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.total.scores,
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.total.scores,
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Total score"
        results <- rbind(results, rep("", reverse ||
                                        suppressWarnings(!is.null(vars.to.reverse)) +
                                        (maxlevel + 1 - minlevel) + (count + means +
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length(rowSums(selected.dataFrame)[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.average.scores,
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.average.scores,
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Average score"
      }
    }
    results <- list(results = noquote(results))
    if (reverse || suppressWarnings(!is.null(vars.to.reverse)))
      results <- c(results, list(items.reversed = names(selected.dataFrame)[sign1 <
                                                                              0]))
    if (var.labels && !is.null(attributes(dataFrame)$var.labels)) {
      results <- c(results, list(item.labels = attributes(dataFrame)$var.labels[selected]))
    }
    if (total) {
      if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[,
                                                                              1])) {
        results <- c(results, list(total.score = rowSums(selected.matrix)),
                     list(mean.score = rowMeans(selected.matrix,
                                                na.rm = na.rm)), list(mean.of.total.scores = mean.of.total.scores,
                                                                      sd.of.total.scores = sd.of.total.scores,
                                                                      mean.of.average.scores = mean.of.average.scores,
                                                                      sd.of.average.scores = sd.of.average.scores))
      }
    }
    class(results) <- c("tableStack", "list")
    results
  }
  else {
    if (is.character(by.var)) {
      by1 <- as.factor(rep("Total", nrow(dataFrame)))
    }
    else {
      by1 <- factor(dataFrame[, by.var])
    }
    if (is.logical(dataFrame[, i])) {
      dataFrame[, i] <- as.factor(dataFrame[, i])
      levels(dataFrame[, i]) <- c("No", "Yes")
    }
    if (length(table(by1)) == 1)
      test <- FALSE
    name.test <- ifelse(test, name.test, FALSE)
    if (is.character(iqr)) {
      if (iqr == "auto") {
        selected.iqr <- NULL
        for (i in 1:length(selected)) {
          if (class(dataFrame[, selected[i]]) == "difftime") {
            dataFrame[, selected[i]] <- as.numeric(dataFrame[,
                                                             selected[i]])
          }
          if (is.integer(dataFrame[, selected[i]]) |
              is.numeric(dataFrame[, selected[i]])) {
            if (length(table(by1)) > 1) {
              if (nrow(dataFrame) < 5000) {
                if (nrow(dataFrame) < 3) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
                else if (shapiro.test(lm(dataFrame[,
                                                   selected[i]] ~ by1)$residuals)$p.value <
                         0.01
                         #| bartlett.test(dataFrame[, selected[i]] ~
                         #by1)$p.value < 0.01
                ) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
              else {
                sampled.shapiro <- sample(lm(dataFrame[,
                                                       selected[i]] ~ by1)$residuals, 250)
                if (shapiro.test(sampled.shapiro)$p.value <
                    0.01
                    #| bartlett.test(dataFrame[, selected[i]] ~
                    #by1)$p.value < 0.01
                ) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
            }
          }
        }
      }
      else {
        selected.iqr <- NULL
      }
    }
    table2 <- NULL
    if (sample.size) {
      if (test) {
        if (name.test) {
          if (total.column) {
            table2 <- rbind(c(table(by1), length(by1),
                              "", ""), c(rep("", length(table(by1)) +
                                               1), "", ""))
            colnames(table2)[ncol(table2) - (2:0)] <- c("Total",
                                                        "Test stat.", "P value")
          }
          else {
            table2 <- rbind(c(table(by1), "", ""), c(rep("",
                                                         length(table(by1))), "", ""))
            colnames(table2)[ncol(table2) - (1:0)] <- c("Test stat.",
                                                        "P value")
          }
        }
        else {
          if (total.column) {
            table2 <- rbind(c(table(by1), length(by1),
                              ""), c(rep("", length(table(by1)) + 1),
                                     "", ""))
            colnames(table2)[ncol(table2) - (1:0)] <- c("Total",
                                                        "P value")
          }
          else {
            table2 <- rbind(c(table(by1), ""), c(rep("",
                                                     length(table(by1))), ""))
            colnames(table2)[ncol(table2)] <- "P value"
          }
        }
      }
      else {
        total.column <- FALSE
        table2 <- rbind(table(by1), "")
      }
    }
    for (i in 1:length(selected)) {
      if (is.factor(dataFrame[, selected[i]]) | is.logical(dataFrame[,
                                                                     selected[i]]) | is.character(dataFrame[, selected[i]])) {
        x0 <- table(dataFrame[, selected[i]], by1)
        if (total.column) {
          x <- addmargins(x0, margin = 2)
        }
        else {
          x <- x0
        }
        nr <- nrow(x)
        nc <- ncol(x0)
        sr <- rowSums(x0)
        if (any(sr == 0)) {
          stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one row"))
        }
        sc <- colSums(x0)
        if (any(sc == 0)) {
          stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one column"))
        }
        x.row.percent <- round(x/rowSums(x0) * 100, decimal)
        table0 <- x
        if (nrow(x) == 2 & prevalence) {
          table00 <- addmargins(x, margin = 1)
          table0 <- paste(table00[2, ], "/", table00[3,
                                                     ], " (", round(table00[2, ]/table00[3, ] *
                                                                      100, decimal), "%)", sep = "")
          table0 <- t(table0)
          rownames(table0) <- "  prevalence"
        }
        else {
          if (any(percent == "column")) {
            x.col.percent <- round(t(t(x)/colSums(x)) *
                                     100, decimal)
            x.col.percent1 <- matrix(paste(x, " (", x.col.percent,
                                           ")", sep = ""), nrow(x), ncol(x))
            if (!frequency) {
              x.col.percent1 <- x.col.percent
            }
            table0 <- x.col.percent1
          }
          else {
            if (any(percent == "row")) {
              x.row.percent <- round(x/rowSums(x0) *
                                       100, decimal)
              x.row.percent1 <- matrix(paste(x, " (",
                                             x.row.percent, ")", sep = ""), nrow(x),
                                       ncol(x))
              if (!frequency) {
                x.row.percent1 <- x.row.percent
              }
              table0 <- x.row.percent1
            }
          }
          rownames(table0) <- paste("  ", rownames(x))
          colnames(table0) <- colnames(x)
        }
        if (test) {
          E <- outer(sr, sc, "*")/sum(x0)
          dim(E) <- NULL
          if ((sum(E < 5))/length(E) > 0.2 & nrow(dataFrame) <
              1000) {
            test.method <- "Fisher's exact test"
            p.value <- fisher.test(x0, simulate.p.value = simulate.p.value)$p.value
          }
          else {
            test.method <- paste("Chisq. (", suppressWarnings(chisq.test(x0)$parameter),
                                 " df) = ", suppressWarnings(round(chisq.test(x0)$statistic,
                                                                   decimal + 1)), sep = "")
            p.value <- suppressWarnings(chisq.test(x0)$p.value)
          }
        }
      }
      if (is.numeric(dataFrame[, selected[i]])) {
        if (any(selected.iqr == selected[i])) {
          term1 <- NULL
          term2 <- NULL
          term3 <- NULL
          term4 <- NULL
          term5 <- NULL
          for (j in 1:(length(levels(by1)))) {
            term1 <- c(term1, mean(dataFrame[by1 ==
                                               levels(by1)[j], selected[i]], na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[by1 ==
                                             levels(by1)[j], selected[i]], na.rm = TRUE))
            term3 <- c(term3, median(dataFrame[by1 ==
                                                 levels(by1)[j], selected[i]], na.rm = TRUE))
            term4 <- c(term4, quantile(dataFrame[by1 ==
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[[1]])
            term5 <- c(term5, quantile(dataFrame[by1 ==
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[[5]])
          }
          if (total.column) {
            term1 <- c(term1, mean(dataFrame[, selected[i]],
                                   na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[, selected[i]],
                                 na.rm = TRUE))
            term3 <- c(term3, median(dataFrame[, selected[i]],
                                     na.rm = TRUE))
            term4 <- c(term4, quantile(dataFrame[, selected[i]],
                                       na.rm = TRUE)[[1]])
            term5 <- c(term5, quantile(dataFrame[, selected[i]],
                                       na.rm = TRUE)[[5]])
          }
          term.numeric <- paste(
            round(term1, 2),
            "(",
            signif(term2, digits = 2),
            ")   ",
            signif(term3,digits = 2),
            "[",
            signif(term4, digits = 2),
            "-",
            signif(term5, digits = 2),
            "]",
            sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "mean(sd)  median [min-max]"
        }
        else {
          term1 <- NULL
          term2 <- NULL
          term3 <- NULL
          term4 <- NULL
          term5 <- NULL
          for (j in 1:(length(levels(by1)))) {
            term1 <- c(term1, mean(dataFrame[by1 ==
                                               levels(by1)[j], selected[i]], na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[by1 ==
                                             levels(by1)[j], selected[i]], na.rm = TRUE))
            term3 <- c(term3, median(dataFrame[by1 ==
                                                 levels(by1)[j], selected[i]], na.rm = TRUE))
            term4 <- c(term4, quantile(dataFrame[by1 ==
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[[1]])
            term5 <- c(term5, quantile(dataFrame[by1 ==
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[[5]])
          }
          if (total.column) {
            term1 <- c(term1, mean(dataFrame[, selected[i]],
                                   na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[, selected[i]],
                                 na.rm = TRUE))
            term3 <- c(term3, median(dataFrame[, selected[i]],
                                     na.rm = TRUE))
            term4 <- c(term4, quantile(dataFrame[, selected[i]],
                                       na.rm = TRUE)[[1]])
            term5 <- c(term5, quantile(dataFrame[, selected[i]],
                                       na.rm = TRUE)[[5]])
          }
          term.numeric <- paste(
            round(term1, 2),
            "(",
            signif(term2, digits = 2),
            ")   ",
            signif(term3,digits = 2),
            "[",
            signif(term4, digits = 2),
            "-",
            signif(term5, digits = 2),
            "]",
            sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "mean(sd)  median [min-max]"
        }
        table0 <- term.numeric
        if (test) {
          if (any(as.integer(table(by1[!is.na(dataFrame[,
                                                        selected[i]])])) < 3) | length(table(by1)) >
              length(table(by1[!is.na(dataFrame[, selected[i]])]))) {
            test.method <- paste("Sample too small: group",
                                 paste(which(as.integer(table(factor(by)[!is.na(dataFrame[,
                                                                                          selected[i]])])) < 3), collapse = " "))
            p.value <- NA
          }
          else {
            if (any(selected.iqr == selected[i])) {
              if (length(levels(by1)) > 2) {
                test.method <- "Kruskal-Wallis test"
                p.value <- kruskal.test(dataFrame[, selected[i]] ~
                                          by1)$p.value
              }
              else {
                test.method <- "Ranksum test"
                p.value <- wilcox.test(dataFrame[, selected[i]] ~
                                         by1, exact = FALSE)$p.value
              }
            }
            else {
              if (length(levels(by1)) > 2) {
                test.method <- paste("ANOVA F-test (",
                                     anova(lm(dataFrame[, selected[i]] ~
                                                by1))[1, 1], ", ", anova(lm(dataFrame[,
                                                                                      selected[i]] ~ by1))[2, 1], " df) = ",
                                     round(anova(lm(dataFrame[, selected[i]] ~
                                                      by1))[1, 4], decimal + 1), sep = "")
                p.value <- anova(lm(dataFrame[, selected[i]] ~
                                      by1))[1, 5]
              }
              else {
                test.method <- paste("t-test", paste(" (",
                                                     t.test(dataFrame[, selected[i]] ~ by1,
                                                            var.equal = TRUE)$parameter, " df)",
                                                     sep = ""), "=", round(abs(t.test(dataFrame[,
                                                                                                selected[i]] ~ by1, var.equal = TRUE)$statistic),
                                                                           decimal + 1))
                p.value <- t.test(dataFrame[, selected[i]] ~
                                    by1, var.equal = TRUE)$p.value
              }
            }
          }
        }
      }
      if (test) {
        if (name.test) {
          label.row <- c(rep("", length(levels(by1)) +
                               total.column), test.method, ifelse(p.value <
                                                                    0.001, "< 0.001", round(p.value, decimal +
                                                                                              2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total",
                                     "Test stat.", "P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "Test stat.",
                                     "P value")
          }
          table0 <- cbind(table0, "", "")
          blank.row <- rep("", length(levels(by1)) +
                             total.column + 2)
        }
        else {
          label.row <- c(rep("", length(levels(by1)) +
                               total.column), ifelse(p.value < 0.001, "< 0.001",
                                                     round(p.value, decimal + 2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total",
                                     "P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "P value")
          }
          table0 <- cbind(table0, "")
          blank.row <- rep("", length(levels(by1)) +
                             total.column + 1)
        }
      }
      else {
        label.row <- c(rep("", length(levels(by1)) +
                             total.column))
        label.row <- t(label.row)
        if (total.column) {
          colnames(label.row) <- c(levels(by1), "Total")
        }
        else {
          colnames(label.row) <- c(levels(by1))
        }
        blank.row <- rep("", length(levels(by1)) + total.column)
      }
      if (var.labels) {
        rownames(label.row) <- ifelse(!is.null(attributes(dataFrame)$var.labels[selected][i]),
                                      attributes(dataFrame)$var.labels[selected[i]],
                                      names(dataFrame)[selected][i])
        rownames(label.row) <- ifelse(rownames(label.row) ==
                                        "", names(dataFrame[selected[i]]), rownames(label.row))
      }
      else {
        rownames(label.row) <- paste(selected[i], ":",
                                     names(dataFrame[selected[i]]))
      }
      if (!is.logical(dataFrame[, selected[i]])) {
        if (prevalence & length(levels(dataFrame[, selected[i]])) ==
            2) {
          rownames(label.row) <- paste(rownames(label.row),
                                       "=", levels(dataFrame[, selected[i]])[2])
        }
      }
      blank.row <- t(blank.row)
      rownames(blank.row) <- ""
      table2 <- rbind(table2, label.row, table0, blank.row)
    }
    if (sample.size) {
      rownames(table2)[1:2] <- c("Total", "")
    }
    class(table2) <- c("tableStack", "table")
    table2b<-table2
    table2<-matrix(data=table2,nr=nrow(table2),nc=(ncol(table2)))
    colnames(table2)<-colnames(table2b)
    rownames(table2)<-rownames(table2b)
    table2<-cbind(rownames(table2b), table2) 
    colnames(table2)[[1]]<-colnames(dataFrame)[by.var]   
  }
  table2=as.data.frame(table2)
  if(na.col==TRUE){
    table2[,"Vide"]=""
    table2[,1]=as.character(table2[,1])
    vars=table2[,1][which(table2[,1]%in% colnames(dataFrame)==T)]
    for (i in vars){
      na_number=sum(is.na(dataFrame[,i]))
      phrase=paste0(na_number," (",round(na_number/nrow(dataFrame)*100,2),"%)")
      table2[which(table2[,1]==i),"Vide"]=phrase
    }
  }
  return(table2)
}



tableStack_moy_med_ordered<-function (vars,by,dataFrame) 
{
  tt=as.data.frame(tableStack_moy_med(vars=vars, by=by, var.labels=T, dataFrame=dataFrame,percent = c("row"),test = T))
  
  tt2=tt[order(tt[,length(colnames(tt))]),]
  var_ordered=c()
  for(i in 1:nrow(tt2)){
    if (tt2[i,length(colnames(tt2))]!=""){
      var_ordered=c(var_ordered,numcol(tt2[i,1],dataFrame))
    }
  }
  tt3=as.data.frame(tableStack_moy_med(vars=var_ordered, by=by, var.labels=T, dataFrame=dataFrame,percent = c("row"),test = T))


  #
  # # Envoyer le tableau dans MARKDOWN
  # # ft <- flextable(as.data.frame(tt3))
  # # ft= fontsize(ft,size = 8, part = "all")
  # # ft <- bold(ft, bold = TRUE, part = "header")
  # # ft <- bold(ft, j=1, bold = TRUE, part = "body")
  # # ft <- align(ft, align = "left", part = "all" )
  # # ft <- autofit(ft,add_w=0.05,add_h=0.05)
  # # ft=FitFlextableToPage(ft) ## à utiliser si le tableau dépasse des marges
  # #####
  return(tt3)
}




## arguments de la fonction
sortiequantibipaired_PROVOX<-function(x,y,w,nomdefichier)
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("VARIABLE","NA:q/Q",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1],"(Moy[Mediane-min-max]Sd)/Nobs"),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2],"(Moy[Mediane-min-max]Sd)/Nobs"),"T-test-paired" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-substr(dimnames(x)[[2]],20,60)[i] ;
  tt[j,2]<-paste(length(x[,y][is.na(x[,y])]),"/",length(x[,i][is.na(x[,i])]));
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  tt[j,5]<-ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],paired=T )[[3]]<0.001,"<0.001", round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],paired=T)[[3]],3)); j<-j+1}
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w,nomdefichier)
}

#+++++++++++++++++++++++++
# Computing of correlation matrix
#+++++++++++++++++++++++++
# Required package : corrplot

# x : matrix
# type: possible values are "lower" (default), "upper", "full" or "flatten";
#display lower or upper triangular of the matrix, full  or flatten matrix.
# graph : if TRUE, a correlogram or heatmap is plotted
# graphType : possible values are "correlogram" or "heatmap"
# col: colors to use for the correlogram
# ... : Further arguments to be passed to cor or cor.test function

# Result is a list including the following components :
# r : correlation matrix, p :  p-values
# sym : Symbolic number coding of the correlation matrix

#rquery.cormat(mydata)
#http://www.sthda.com/french/wiki/matrice-de-correlation-la-fonction-r-qui-fait-tout
rquery.cormat<-function(x,
                        type=c('lower', 'upper', 'full', 'flatten'),
                        graph=TRUE,
                        graphType=c("correlogram", "heatmap"),
                        col=NULL, ...)
{
  library(corrplot)
  # Helper functions
  #+++++++++++++++++
  # Compute the matrix of correlation p-values
  cor.pmat <- function(x, ...) {
    mat <- as.matrix(x)
    n <- ncol(mat)
    p.mat<- matrix(NA, n, n)
    diag(p.mat) <- 0
    for (i in 1:(n - 1)) {
      for (j in (i + 1):n) {
        tmp <- cor.test(mat[, i], mat[, j], ...)
        p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
      }
    }
    colnames(p.mat) <- rownames(p.mat) <- colnames(mat)
    p.mat
  }
  # Get lower triangle of the matrix
  getLower.tri<-function(mat){
    upper<-mat
    upper[upper.tri(mat)]<-""
    mat<-as.data.frame(upper)
    mat
  }
  # Get upper triangle of the matrix
  getUpper.tri<-function(mat){
    lt<-mat
    lt[lower.tri(mat)]<-""
    mat<-as.data.frame(lt)
    mat
  }
  # Get flatten matrix
  flattenCorrMatrix <- function(cormat, pmat) {
    ut <- upper.tri(cormat)
    data.frame(
      row = rownames(cormat)[row(cormat)[ut]],
      column = rownames(cormat)[col(cormat)[ut]],
      cor  =(cormat)[ut],
      p = pmat[ut]
    )
  }
  # Define color
  if (is.null(col)) {
    col <- colorRampPalette(
      c("#67001F", "#B2182B", "#D6604D", "#F4A582",
        "#FDDBC7", "#FFFFFF", "#D1E5F0", "#92C5DE",
        "#4393C3", "#2166AC", "#053061"))(200)
    col<-rev(col)
  }
  
  # Correlation matrix
  cormat<-signif(cor(x, use = "complete.obs", ...),2)
  pmat<-signif(cor.pmat(x, ...),2)
  # Reorder correlation matrix
  ord<-corrMatOrder(cormat, order="hclust")
  cormat<-cormat[ord, ord]
  pmat<-pmat[ord, ord]
  # Replace correlation coeff by symbols
  sym<-symnum(cormat, abbr.colnames=FALSE)
  # Correlogram
  if(graph & graphType[1]=="correlogram"){
    corrplot(cormat, type=ifelse(type[1]=="flatten", "lower", type[1]),
             tl.col="black", tl.srt=45,col=col,...)
  }
  else if(graphType[1]=="heatmap")
    heatmap(cormat, col=col, symm=TRUE)
  # Get lower/upper triangle
  if(type[1]=="lower"){
    cormat<-getLower.tri(cormat)
    pmat<-getLower.tri(pmat)
  }
  else if(type[1]=="upper"){
    cormat<-getUpper.tri(cormat)
    pmat<-getUpper.tri(pmat)
    sym=t(sym)
  }
  else if(type[1]=="flatten"){
    cormat<-flattenCorrMatrix(cormat, pmat)
    pmat=NULL
    sym=NULL
  }
  list(r=cormat, p=pmat, sym=sym)
}





####################################FIN#################""
#############################################################
####____SURVIEBILOGRANK AVEC % en LIGNE
surviebilogrank_pourcent_ligne<-function(x,t,y,w)## arguments de la fonction
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES 
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("VARIABLE","MODALITE",paste(names(table(x[,y]))[1],"PAS EVT"),paste(names(table(x[,y]))[2],"EVT"),"p-Logrank" ))
  
  
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; 
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/ ( table(x[,i],x[,y])[z-1,1]+ table(x[,i],x[,y])[z-1,2]) ,2) ,"%)",sep=""),""); 
      tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/( table(x[,i],x[,y])[z-1,2]+ table(x[,i],x[,y])[ z-1,1]),2) ,"%)",sep=""),"");
      
      
      
      
      tt[j+z,5]<-ifelse(z>1,"-",
                        ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.0001,"<0.0001****",
                               ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.001,"<0.001***",
                                      ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.01,paste(round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5),"**"),
                                             ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.05,paste(round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5),"*"),
                                                    ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1)))<0.10,paste(round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5)," TREND"),
                                                           round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i])[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i])[[1]])-1))),5)))))))
      
      
      
    }
    ;
    j<-j+k}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt))

  #####
  
  #print(noquote(tt));
  rm(a,b,g,k,i,j,tt,z,x,y,w)
}
#####_______FIN


####____tableaux des CORRELATION de spearman entre variables QUANTITATIVES
# Uniquement les R>0.3 ou R<-0.3
cortabspearman30<-function(x,y)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 a 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],method="spearman",use="pairwise.complete.obs"),2));
  abs<-c("Cor_spearman",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; 
  #========================================================
  #Changer 0.3 dans un autre seuil si necessaire ci dessous
  tt[,i+1]<-ifelse(t[,i]>0.3 | t[,i]<(-0.3),t[,i],"~")
  #Changer 0.3 dans un autre seuil si necessaire ci dessus
  #=======================================================
  }  
  
  k<-1;for(i in y[c(1:length(y)-1)]){
    k<-k+1;
    # for(j in y[c(k:length(y))]){
    #   print(paste("p.value: variables testees:",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j],method="spearman")$p.value)
    # }
  }
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortabis.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/cortabis.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN

  return(as.data.frame(tt))
  #####
  
  #print(noquote(tt));
}
####____FIN









####____tableaux des CORRELATION de spearman entre variables QUANTITATIVES
# Uniquement les R>0.5 ou R<-0.5
cortabspearman50<-function(x,y)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 a 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],method="spearman",use="pairwise.complete.obs"),2));
  abs<-c("Cor_spearman",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; 
  #========================================================
  #Changer 0.3 dans un autre seuil si necessaire ci dessous
  tt[,i+1]<-ifelse(t[,i]>0.5 | t[,i]<(-0.5),t[,i],"-")
  #Changer 0.3 dans un autre seuil si necessaire ci dessus
  #=======================================================
  }  
  
  k<-1;for(i in y[c(1:length(y)-1)])
  {k<-k+1;for(j in y[c(k:length(y))])
  {print(paste("p.value: variables testees:",names(x[i]),"-",names(x[j])));print(cor.test(x[,i],x[,j],method="spearman")$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortabis.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/cortabis.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  print(tt)
  ft <- flextable(as.data.frame(tt))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  #####
  
  return(ft)
  #####
  
  #print(noquote(tt));
}
####____FIN

























####____ Sortiequanti dispos? comme cela:"Variable","Nb.pts","Median","[Range]","Mean","SD"

sortiequantiSTIC<-function(x,y) ## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonnes des variables QUANTITATIVES
{
  f<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="numeric" ) f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=6);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","Nb.pts","Median","[Range]","Mean","SD" ))
  j<-1;for (i in y) {if (sapply(x[,i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i];
  tt[j,2]<-length(x[,i]) - length(x[,i][is.na(x[,i])]) ;
  tt[j,3]<-paste(round(median(x[,i],na.rm=T),0));
  tt[j,4]<-paste("[",round(quantile(x[,i],na.rm=T)[[1]],0),"-",round(quantile(x[,i],na.rm=T)[[5]],0),"]",
                 sep="");
  tt[j,5]<-paste(round(mean(x[,i],na.rm=T),0)); 
  tt[j,6]<-round(sd(x[,i],na.rm=T),0);j<-j+1}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquanti.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquanti.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  #print(noquote(tt));              
  rm(f,i,j,tt,x,y)
}
####____FIN

####____ Sortiequanti dispos? comme cela: "Variable","Nb.pts","Median","[Range]","Mean","Mean_percent"

sortiequantiSTIC_pct<-function(x,y) ## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonnes des variables QUANTITATIVES
{
  f<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="numeric" ) f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=6);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","Nb.pts","Median","[Range]","Mean","Mean_percent" ))
  j<-1;for (i in y) {if (sapply(x[,i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i];
  tt[j,2]<-length(x[,i]) - length(x[,i][is.na(x[,i])]) ;
  tt[j,3]<-paste(round(median(x[,i],na.rm=T),0));
  tt[j,4]<-paste("[",round(quantile(x[,i],na.rm=T)[[1]],0),"-",round(quantile(x[,i],na.rm=T)[[5]],0),"]",
                 sep="");
  tt[j,5]<-as.numeric(round(mean(x[,i],na.rm=T),0)); 
  tt[j,6]<-round(((as.numeric(tt[j,5])/75429)*100),2);
  j<-j+1}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquanti.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquanti.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  print(noquote(tt)[,c(1,5,6)]);
  rm(f,i,j,tt,x,y)
}


####____tableaux des CORRELATION de spearman entre variables QUANTITATIVES
# SANS afficher les p.value

cortabspearman_SANS_les_P<-function(x,y)		## arguments de la fonct
  ## x= nom variable fichier
  ## y= Num des colonnes des variables QUANTITATIVES
  ## a tester entre elles 2 a 2 par exemple(c(4:10,13:20))
{
  for(i in y) {if(is.factor(x[,i])==TRUE) stop(paste("la colonne Num",i,"n'est pas quantitative(as.factor=TRUE)"))}
  t<-(round(cor(x[,y],method="spearman",use="pairwise.complete.obs"),2));
  abs<-c("Cor_spearman",dimnames(t)[[1]]);
  tt<-matrix(data="NA",nr=length(dimnames(t)[[1]]),nc=length(dimnames(t)[[1]])+1);
  dimnames(tt)=list(c(1:length(dimnames(t)[[1]])),abs)
  for (i in 1:length(dimnames(t)[[1]])) {tt[i,1]<-dimnames(t)[[1]][i]; tt[,i+1]<-t[,i]}
  k<-1;for(i in y[c(1:length(y)-1)])
  {k<-k+1;for(j in y[c(k:length(y))])
  {(paste("p.value: variables testees:",names(x[i]),"-",names(x[j])));(cor.test(x[,i],x[,j],method="spearman")$p.value)}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/cortabis.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T)  # Sauve le tableau pour le r?cup?rer sous word
  #edit(file="D:/R/cortabis.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else 
  #####
  # Envoyer le tableau dans MARKDOWN
  print(tt)
  ft <- flextable(as.data.frame(tt))
  # ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft=FitFlextableToPage(ft)
  #####
  
  return(ft)
  #####
  
  #print(noquote(tt));
  
}
####____FIN


sortiequantiSTIC<-function(x,y) ## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonnes des variables QUANTITATIVES
{
  f<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="numeric" ) f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=6);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","Nb.pts","Median","[Range]","Mean","SD" ))
  j<-1;for (i in y) {if (sapply(x[,i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i];
  tt[j,2]<-length(x[,i]) - length(x[,i][is.na(x[,i])]) ;
  tt[j,3]<-paste(round(median(x[,i],na.rm=T),0));
  tt[j,4]<-paste("[",round(quantile(x[,i],na.rm=T)[[1]],0),"-",round(quantile(x[,i],na.rm=T)[[5]],0),"]",
                 sep="");
  tt[j,5]<-paste(round(mean(x[,i],na.rm=T),0)); 
  tt[j,6]<-round(sd(x[,i],na.rm=T),0);j<-j+1}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquanti.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquanti.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  #print(noquote(tt));              
  rm(f,i,j,tt,x,y)
}
####____FIN

sortiequantiSTIC_pct<-function(x,y) ## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonnes des variables QUANTITATIVES
{
  f<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="numeric" ) f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=6);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","Nb.pts","Median","[Range]","Mean","Mean_percent" ))
  j<-1;for (i in y) {if (sapply(x[,i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i];
  tt[j,2]<-length(x[,i]) - length(x[,i][is.na(x[,i])]) ;
  tt[j,3]<-paste(round(median(x[,i],na.rm=T),0));
  tt[j,4]<-paste("[",round(quantile(x[,i],na.rm=T)[[1]],0),"-",round(quantile(x[,i],na.rm=T)[[5]],0),"]",
                 sep="");
  tt[j,5]<-as.numeric(round(mean(x[,i],na.rm=T),0)); 
  tt[j,6]<-round(((as.numeric(tt[j,5])/75429)*100),2);
  j<-j+1}}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquanti.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquanti.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  print(noquote(tt)[,c(1,5,6)]);
  rm(f,i,j,tt,x,y)
}



####____Tableau des var QUALI avec Nbre et Pourcentage

sortiequaliReport<-function(x,y)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonnes des variables QUALITATIVES
{
  g<-NULL;k<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="factor") 
  {k<-length(table(x[i])); g<-c(g,"");
  for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("Variable","Modalite","Nombre","Frequence","Vide"))
  j<-0;for (i in y) if (is.factor(x[,i])) 
  {k<-length(table(x[i]))+1;h<-0;for (z in 1:(k-1)) h<-(h+table(x[i])[[z]]);
  for (z in 1:k)
  {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ;tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); tt[j+z,3]<-ifelse(z>1,table(x[i])[[z-1]],""); tt[j+z,4]<-ifelse(z>1,paste(round(table(x[i])[[z-1]]*100/h,2),"%",sep=""),"");tt[j+z,5]<-ifelse(z==1,paste(length(x[i][is.na(x[i])]),"(",100*(round(length(x[i][is.na(x[i])])/dim(x[i])[[1]],4)),"%",")",sep=""),"")};j<-j+k}
  
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquali.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquali.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  
  #print(noquote(tt));
  rm(g,k,i,j,tt,z,x,y)
}
####____FIN








####____Tableau QUANTI x VAR DICHOTOMIQUE (moy quartiles p-value)

sortiequantibi_<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier 
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUANTITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas quantitative ou binaire !")
  else
    f<-NULL;
  for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric") f<-c(f,dimnames(x)[[2]][i]);
  tt<-matrix(data="NA",nr=length(f),nc=5);
  dimnames(tt)<-list(c(1:length(f)),c("Variable","NA:q/Q",paste(names(table(x[,y]))[1],"(Moy[Med-min-max]Sd)/Nobs"),paste(names(table(x[,y]))[2],"(Moy[Med-min-max]Sd)/Nobs"),"T-test" ))
  j<-1;for (i in w) if (sapply(x[i],data.class)[[1]]=="numeric")
  {tt[j,1]<-dimnames(x)[[2]][i] ;
  tt[j,2]<-paste(length(x[,y][is.na(x[,y])]),"/",length(x[,i][is.na(x[,i])]));
  tt[j,3]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[1]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[1]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,1]),sep="");
  tt[j,4]<-paste(round(mean(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," [",round(quantile(x[,i][x[,y]==names(table(x[,y]))[2]],probs=0.5,na.rm=T)[[1]],2) ,"-",round(min(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2) ,"-",round(max(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2),"] ", round(sd(x[,i][x[,y]==names(table(x[,y]))[2]],na.rm=T),2)," /", sum(as.matrix(table(x[,i],x[,y]))[,2]),sep="");
  tt[j,5]<-ifelse(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]]<0.001,"<0.001", round(t.test(x[,i][x[,y]==names(table(x[,y]))[1]], x[,i][x[,y]==names(table(x[,y]))[2]],var.equal=T)[[3]],3)); j<-j+1}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquantibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquantibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  #write.table(tt,file="D:/r/tabloquantibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous excel 
  
  #####
  # Envoyer le tableau dans MARKDOWN
  ft <- flextable(as.data.frame(tt));
  ft <- autofit(ft);
  saveRDS(ft, file = "my_data.rds");
  #####
  
  #print(noquote(tt));
  rm(f,i,j,tt,x,y,w)
}
####____FIN


insert_table_report<-function(tt)## arguments de la fonction
  ## x= nom du tableau
{
  tt<-as.matrix(tt)
  ttb<-tt
  tt<-matrix(data=tt,nr=nrow(tt),nc=(ncol(tt)))
  colnames(tt)<-colnames(ttb)
  rownames(tt)<-rownames(ttb)
  tt<-cbind(rownames(ttb), tt) 
  #colnames(tt)[[1]]<-" "     
  
  tt <- as.data.frame(tt);
  ft <- flextable(as.data.frame(tt))
  ft <- autofit(ft)
  ft
  #####
  #print(noquote(tt));
  rm(tt) 
}
####____FIN

####____FIN


insert_table_report2<-function(tt)## arguments de la fonction
  ## x= nom du tableau
{
  tt<-as.matrix(tt)
  ttb<-tt
  tt<-matrix(data=tt,nr=nrow(tt),nc=(ncol(tt)))
  colnames(tt)<-colnames(ttb)
  rownames(tt)<-rownames(ttb)
  #tt<-cbind(rownames(ttb), tt) 
  #colnames(tt)[[1]]<-" "     
  
  MyFTable <- as.data.frame(tt);
  my_doc <- body_add_par( my_doc, "", style = "Normal");
  my_doc <- body_add_table( my_doc, MyFTable, style = "Style1");
  my_doc <- body_add_par( my_doc, "", style = "Normal");
  
  
  #####
  #print(noquote(tt));
  rm(tt) 
}
####____FIN


insert_table_report_no_header<-function(tt)## arguments de la fonction
  ## x= nom du tableau
{
  
  MyFTable = FlexTable(tt, add.rownames = FALSE, header.columns = FALSE,  
                       header.cell.props = cellProperties( background.color = "grey85" ), 
                       header.text.props = textProperties( color = "black", 
                                                           font.size = 8, font.weight = "bold" ), 
                       body.text.props = textProperties( font.size = 8,font.family = "Arial" )
  )
  #
  ## applies a border grid on table
  MyFTable = setFlexTableBorders(MyFTable,
                                 inner.vertical = borderNone( ),
                                 inner.horizontal = borderNone( ),
                                 outer.vertical = borderNone( ),
                                 outer.horizontal = borderNone( )
  )
  
  mydoc <- addFlexTable( mydoc, MyFTable );
  
  #####
  #print(noquote(tt));
  rm(tt) 
}
####____FIN




insert_table_report_no_row<-function(tt)## arguments de la fonction
  ## x= nom du tableau
{
  
  MyFTable = FlexTable(tt, add.rownames = FALSE,
                       header.cell.props = cellProperties( background.color = "grey85" ), 
                       header.text.props = textProperties( color = "black", 
                                                           font.size = 8, font.weight = "bold" ), 
                       body.text.props = textProperties( font.size = 8,font.family = "Arial" )
  )
  #
  ## applies a border grid on table
  MyFTable = setFlexTableBorders(MyFTable,
                                 inner.vertical = borderNone( ),
                                 inner.horizontal = borderNone( ),
                                 outer.vertical = borderNone( ),
                                 outer.horizontal = borderProperties( style = "solid", width = 2 )
  )
  
  mydoc <- addFlexTable( mydoc, MyFTable );
  
  #####
  #print(noquote(tt));
  rm(tt) 
}
####____FIN



insert_table_report_no_colname<-function(tt)## arguments de la fonction
  ## x= nom du tableau
{
  
  MyFTable = FlexTable(tt, add.rownames = TRUE, header.columns = FALSE,  
                       header.cell.props = cellProperties( background.color = "grey85" ), 
                       header.text.props = textProperties( color = "black", 
                                                           font.size = 8, font.weight = "bold" ), 
                       body.text.props = textProperties( font.size = 8,font.family = "Arial" )
  )
  #
  ## applies a border grid on table
  MyFTable = setFlexTableBorders(MyFTable,
                                 inner.vertical = borderNone( ),
                                 inner.horizontal = borderNone( ),
                                 outer.vertical = borderNone( ),
                                 outer.horizontal = borderNone( )
  )
  
  mydoc <- addFlexTable( mydoc, MyFTable );
  
  #####
  #print(noquote(tt));
  rm(tt) 
}
####____FIN



####____Tableau QUALI x VAR DICHOTOMIQUE (n pourc p-value) avec test de FISHER

sortiequalibiFISHER_pourcent_ligne<-function(x,y,w)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la variable binaire DICHOTOMIQUE
  ## W= Num colonnes des variables QUALITATIVES
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable","Modality",paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[1]),paste(dimnames(x)[[2]][[y]],names(table(x[,y]))[2]),"p-Fisher" ))
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ;
    tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),"");
    tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/ ( table(x[,i],x[,y])[z-1,1]+ table(x[,i],x[,y])[z-1,2]) ,2) ,"%)",sep=""),"");
    tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/( table(x[,i],x[,y])[z-1,2]+ table(x[,i],x[,y])[ z-1,1]),2) ,"%)",sep=""),"");
    tt[j+z,5]<-ifelse(z>1,"-",
                      ifelse(fisher.test(x[,i],x[,y])[[1]]<0.0001,"<0.0001****",
                             ifelse(fisher.test(x[,i],x[,y])[[1]]<0.001,"<0.001***",
                                    ifelse(fisher.test(x[,i],x[,y])[[1]]<0.01,paste(round(fisher.test(x[,i],x[,y])[[1]],5),"**"), 
                                           ifelse(fisher.test(x[,i],x[,y])[[1]]<0.05,paste(round(fisher.test(x[,i],x[,y])[[1]],5),"*"),
                                                  ifelse(fisher.test(x[,i],x[,y])[[1]]<0.10,paste(round(fisher.test(x[,i],x[,y])[[1]],5),"TREND"),
                                                         round(fisher.test(x[,i],x[,y])[[1]],5))))))
    )
    }; j<-j+k}
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    #####
    # Envoyer le tableau dans MARKDOWN
    return(as.data.frame(tt))

    
    #print(noquote(tt));
    rm(a,b,g,k,i,j,tt,z,x,y,w)
}



####____Survie bivari?e

surviebilogrank_rho_plus_1<-function(x,t,y,w)## arguments de la fonction
  ## x= nom variable fichier 
  ## t= OS 
  ## y= etatOS
  ## W= Num colonnes des variables QUALITATIVES 
{
  g<-NULL;
  k<-NULL;
  a<-table(x[,y])[[1]];
  b<-table(x[,y])[[2]];
  for (i in w) if (is.factor(x[,i])) 
  {
    k<-length(table(x[i]));
    g<-c(g,"");
    for (j in 1:k)
      g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))
  }
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("VARIABLE","MODALITE",names(table(x[,y]))[1],names(table(x[,y]))[2],"p-Logrank" ))
  j<-0;
  for (i in w) 
    if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1; 
    for (z in 1:k)
    {
      tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ; 
      tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),""); 
      tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/ ( table(x[,i],x[,y])[z-1,1]+ table(x[,i],x[,y])[z-1,2]) ,2) ,"%)",sep=""),""); 
      tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/( table(x[,i],x[,y])[z-1,2]+ table(x[,i],x[,y])[ z-1,1]),2) ,"%)",sep=""),"");
      tt[j+z,5]<-ifelse(z>1,"-",ifelse((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i],rho=+1)[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i],rho=+1)[[1]])-1)))<0.0001,"<0.0001", round((1-pchisq((survdiff(Surv(x[,t],x[,y])~ x[,i],rho=+1)[[5]]), (dim(survdiff(Surv(x[,t],x[,y])~ x[,i],rho=+1)[[1]])-1))),5)))
    }
    ;
    j<-j+k}
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt))
  #####
  
  #print(noquote(tt));
  rm(a,b,g,k,i,j,tt,z,x,y,w)
}
#####_______FIN





####____Tableau des var QUALI avec Nbre et Pourcentage

sortiequali_trie<-function(x,y)## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonnes des variables QUALITATIVES
{
  g<-NULL;k<-NULL;
  for (i in y) if (sapply(x[i],data.class)[[1]]=="factor") 
  {k<-length(table(x[i])); g<-c(g,"");
  for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
  tt<-matrix(data="NA",nr=length(g),nc=5);
  dimnames(tt)<-list(c(1:length(g)),c("Variable","Modalite","Nombre","Frequence","Vide"))
  j<-0;for (i in y) if (is.factor(x[,i])) 
  {k<-length(table(x[i]))+1;h<-0;for (z in 1:(k-1)) h<-(h+table(x[i])[[z]]);
  for (z in 1:k)
  {
    tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ;
    tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),"");
    tt[j+z,3]<-ifelse(z>1,table(x[i])[[z-1]],"");
    tt[j+z,4]<-ifelse(z>1,paste(round(table(x[i])[[z-1]]*100/h,2),"%",sep=""),"");
    tt[j+z,5]<-ifelse(z==1,paste(length(x[i][is.na(x[i])]),"(",100*(round(length(x[i][is.na(x[i])])/dim(x[i])[[1]],4)),"%",")",sep=""),"")};
  j<-j+k;
  
  or <- order(as.numeric(noquote(tt)[,3]),na.last = FALSE, decreasing = TRUE);
  tt<-as.matrix(tt[or,]);
  #test<-is.matrix(tt);
  #print(test);
  #print(or); 
  #print(as.matrix(tt));
  ##print(noquote(tt))
  }
  #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
  #if (rep=="o") {write.table(tt,file="D:/r/tabloquali.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word 
  #edit(file="D:/R/tabloquali.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
  #sortiequali_trie(stat,c(6))
  
  
  #####
  # Envoyer le tableau dans MARKDOWN
  return(as.data.frame(tt))
  # ft <- autofit(ft,add_w = 0.1,add_h = 0.1)
  # ft= fontsize(ft,size = 8, part = "all")
  # ft <- bold(ft, bold = TRUE, part = "header")
  # ft <- bold(ft, j=1, bold = TRUE, part = "body")
  # ft <- align(ft, align = "left", part = "all" )
  # ft=FitFlextableToPage(ft)
  # saveRDS(ft, file = "my_data.rds");
  #####
  #####
  
  
  
  
  #print(noquote(tt));
  rm(g,k,i,j,tt,z,x,y)
}
####____FIN


####____DEBUT
####____DEBUT
####____SENSIBILITE SPECIFICITE VPP VPN ETC...
sens_spec_etc<-function (dat, conf.level = 0.95) 
{
  elements <- list()
  elements <- within(elements, {
    N. <- 1 - ((1 - conf.level)/2)
    z <- qnorm(N., mean = 0, sd = 1)
    .funincrisk <- function(cdat, conf.level) {
      alpha <- 1 - conf.level
      alpha2 <- 0.5 * alpha
      x <- cdat[, 1]
      n <- cdat[, 2]
      p <- x/n
      x1 <- x == 0
      x2 <- x == n
      lb <- ub <- x
      lb[x1] <- 1
      ub[x2] <- n[x2] - 1
      lcl <- 1 - qbeta(1 - alpha2, n + 1 - x, lb)
      ucl <- 1 - qbeta(alpha2, n - ub, x + 1)
      if (any(x1)) 
        lcl[x1] <- rep(0, sum(x1))
      if (any(x2)) 
        ucl[x2] <- rep(1, sum(x2))
      rval <- data.frame(est = p, lower = lcl, upper = ucl)
      rval
    }
    a <- dat[1]
    b <- dat[3]
    c <- dat[2]
    d <- dat[4]
    M1 <- a + c
    M0 <- b + d
    N1 <- a + b
    N0 <- c + d
    total <- a + b + c + d
    tdat <- as.matrix(cbind(M1, total))
    trval <- .funincrisk(tdat, conf.level)
    tp <- trval$est
    tp.low <- trval$lower
    tp.up <- trval$upper
    tprev <- data.frame(est = tp, lower = tp.low, upper = tp.up)
    tdat <- as.matrix(cbind(N1, total))
    trval <- .funincrisk(tdat, conf.level)
    ap <- trval$est
    ap.low <- trval$lower
    ap.up <- trval$upper
    aprev <- data.frame(est = ap, lower = ap.low, upper = ap.up)
    tdat <- as.matrix(cbind(a, M1))
    trval <- .funincrisk(tdat, conf.level)
    se <- trval$est
    se.low <- trval$lower
    se.up <- trval$upper
    sensitivity <- data.frame(est = se, lower = se.low, upper = se.up)
    tdat <- as.matrix(cbind(d, M0))
    trval <- .funincrisk(tdat, conf.level)
    sp <- trval$est
    sp.low <- trval$lower
    sp.up <- trval$upper
    specificity <- data.frame(est = sp, lower = sp.low, upper = sp.up)
    tdat <- as.matrix(cbind(a, N1))
    trval <- .funincrisk(tdat, conf.level)
    ppv <- trval$est
    ppv.low <- trval$lower
    ppv.up <- trval$upper
    pv.positive <- data.frame(est = ppv, lower = ppv.low, 
                              upper = ppv.up)
    tdat <- as.matrix(cbind(d, N0))
    trval <- .funincrisk(tdat, conf.level)
    npv <- trval$est
    npv.low <- trval$lower
    npv.up <- trval$upper
    pv.negative <- data.frame(est = npv, lower = npv.low, 
                              upper = npv.up)
    lrpos <- (a/M1)/(1 - (d/M0))
    lrpos.low <- exp(log(lrpos) - z * sqrt((1 - se)/(M1 * 
                                                       se) + (sp)/(M0 * (1 - sp))))
    lrpos.up <- exp(log(lrpos) + z * sqrt((1 - se)/(M1 * 
                                                      se) + (sp)/(M0 * (1 - sp))))
    lr.positive <- data.frame(est = lrpos, lower = lrpos.low, 
                              upper = lrpos.up)
    lrneg <- (1 - (a/M1))/(d/M0)
    lrneg.low <- exp(log(lrneg) - z * sqrt((se)/(M1 * (1 - 
                                                         se)) + (1 - sp)/(M0 * (sp))))
    lrneg.up <- exp(log(lrneg) + z * sqrt((se)/(M1 * (1 - 
                                                        se)) + (1 - sp)/(M0 * (sp))))
    lr.negative <- data.frame(est = lrneg, lower = lrneg.low, 
                              upper = lrneg.up)
    tdat <- as.matrix(cbind((a + d), total))
    trval <- .funincrisk(tdat, conf.level)
    da <- trval$est
    da.low <- trval$lower
    da.up <- trval$upper
    diag.acc <- data.frame(est = da, lower = da.low, upper = da.up)
    dOR.p <- (a * d)/(b * c)
    lndOR <- log(dOR.p)
    lndOR.var <- 1/a + 1/b + 1/c + 1/d
    lndOR.se <- sqrt(1/a + 1/b + 1/c + 1/d)
    lndOR.l <- lndOR - (z * lndOR.se)
    lndOR.u <- lndOR + (z * lndOR.se)
    dOR.se <- exp(lndOR.se)
    dOR.low <- exp(lndOR.l)
    dOR.up <- exp(lndOR.u)
    diag.or <- data.frame(est = dOR.p, lower = dOR.low, upper = dOR.up)
    ndx <- 1/(se - (1 - sp))
    ndx.1 <- 1/(se.low - (1 - sp.low))
    ndx.2 <- 1/(se.up - (1 - sp.up))
    ndx.low <- min(ndx.1, ndx.2)
    ndx.up <- max(ndx.1, ndx.2)
    nnd <- data.frame(est = ndx, lower = ndx.low, upper = ndx.up)
    c.p <- se - (1 - sp)
    c.1 <- se.low - (1 - sp.low)
    c.2 <- se.up - (1 - sp.up)
    c.low <- min(c.1, c.2)
    c.up <- max(c.1, c.2)
    youden <- data.frame(est = c.p, lower = c.low, upper = c.up)
  })
  rval <- list(aprev = elements$aprev, tprev = elements$tprev, 
               se = elements$sensitivity, sp = elements$specificity, 
               diag.acc = elements$diag.acc, diag.or = elements$diag.or, 
               nnd = elements$nnd, youden = elements$youden, ppv = elements$pv.positive, 
               npv = elements$pv.negative, plr = elements$lr.positive, 
               nlr = elements$lr.negative)
  #        
  #    rval2 <- list(Apparent_prevalence = elements$aprev, True_prevalence = elements$tprev, 
  #        Sensitivity = elements$sensitivity, Specificity = elements$specificity, 
  #        Diagnostic_accuracy = elements$diag.acc, Diagnostic_odds_ratio = elements$diag.or, 
  #        Number_needed_to_diagnose = elements$nnd, Youden_index = elements$youden, Positive_predictive_value = elements$pv.positive, 
  #        Negative_predictive_value = elements$pv.negative, Positive_likelihood_ratio = elements$lr.positive, 
  #        Negative_likelihood_ratio = elements$lr.negative)
  
  
  
  r1 <- with(elements, c(a, b, N1))
  
  r2 <- with(elements, c(c, d, N0))
  
  r3 <- with(elements, c(M1, M0, M0 + M1))
  
  tab <- as.data.frame(rbind(r1, r2, r3))
  
  colnames(tab) <- c("   Outcome +", "   Outcome -", "     Total")
  rownames(tab) <- c("Test +", "Test -", "Total")
  tab <- format.data.frame(tab, digits = 3, justify = "right")
  tt<-tab
  tt<-as.matrix(tt)
  ttb<-tt
  tt<-matrix(data=tt,nr=nrow(tt),nc=(ncol(tt)))
  colnames(tt)<-colnames(ttb)
  rownames(tt)<-rownames(ttb)
  tt<-cbind(rownames(ttb), tt) 
  #colnames(tt)[[1]]<-" "     
  
  MyFTable <- as.data.frame(tt);
  my_doc <- body_add_par( my_doc, "", style = "Normal");
  my_doc <- body_add_table( my_doc, MyFTable, style = "Style1");
  my_doc <- body_add_par( my_doc, "", style = "Normal");
  
  
  #####
  #print(noquote(tt));
  rm(tt) 
  #-------------------------------------
  
  ######
  out <- list(conf.level = conf.level, elements = elements, 
              rval = rval, tab = tab)
  
  out2 <- round(as.matrix(rbind(elements$aprev,elements$tprev,elements$sensitivity,elements$specificity, elements$diag.acc, elements$diag.or, elements$nnd, elements$youden, elements$pv.positive,elements$pv.negative, elements$lr.positive,elements$lr.negative )),2)
  rownames(out2)<-c("Apparent prevalence","True prevalence","Sensitivity","Specificity","Diagnostic accuracy","Diagnostic odds ratio","Number needed to diagnose","Youden?s index","Positive predictive value","Negative predictive value","Positive likelihood ratio","Negative likelihood ratio")
  colnames(out2)<-c("Parameter","CI95%Lower", "CI95%Upper")
  
  tt<-out2
  tt<-as.matrix(tt)
  ttb<-tt
  tt<-matrix(data=tt,nr=nrow(tt),nc=(ncol(tt)))
  colnames(tt)<-colnames(ttb)
  rownames(tt)<-rownames(ttb)
  tt<-cbind(rownames(ttb), tt) 
  #colnames(tt)[[1]]<-" "     
  
  MyFTable <- as.data.frame(tt);
  my_doc <- body_add_par( my_doc, "", style = "Normal");
  my_doc <- body_add_table( my_doc, MyFTable, style = "Style1");
  my_doc <- body_add_par( my_doc, "", style = "Normal");
  
  
  #####
  #print(noquote(tt));
  rm(tt) 
  #-------------------------------------
  
  
  
  class(out) <- "epi.tests"
  return(out)
}
####____FIN
####____SENSIBILITE SPECIFICITE VPP VPN ETC...





####____FIN
####____SENSIBILITE SPECIFICITE VPP VPN ETC...


#################################################### sortiqualibipaired ou sortiequalibiMACNEMAR_pourcent_ligne ####################################################

sortiequalibiMACNEMAR_pourcent_ligne<-function(x,y,w)
  # Cette fonction permet de r?aliser le test de McNemar entre deux variables binaires dont les modalit?s sont les m?mes, pour des donn?es appari?es.
  # Les donn?es doivent ?tre mise sous forme de tableau de contingence (Avant/Apr?s) pour utiliser cette fonction.
  ## arguments de la fonction
  ## x= nom variable fichier
  ## y= Num colonne de la premi?re variable binaire DICHOTOMIQUE
  ## W= Num colonne de la deuxi?me variable binaire DICHOTOMIQUE
{
  if (sapply(x[y],data.class)[[1]]!="factor" | length(names(table(x[,y])))!=2) stop("Votre variable n'est pas qualitative ou binaire !")
  else
    g<-NULL;k<-NULL;a<-table(x[,y])[[1]]; b<-table(x[,y])[[2]];
    for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]));
    g<-c(g,"");for (j in 1:k) g<-c(g, ifelse(names(table(x[i])[j])=="","Vide", names(table(x[i])[j])))}
    tt<-matrix(data="NA",nr=length(g),nc=5);
    dimnames(tt)<-list(c(1:length(g)),c("Variable",paste(dimnames(x)[[2]][[y]]),names((table(x[,y]))[1]),names((table(x[,y]))[2]),"p-McNemar" ))                         
    j<-0;for (i in w) if (is.factor(x[,i]))
    {k<-length(table(x[i]))+1;
    for (z in 1:k)
    {tt[j+z,1]<-ifelse(z==1,dimnames(x)[[2]][i],"") ;
    tt[j+z,2]<-ifelse(z>1,ifelse(names(table(x[i])[z-1])=="","Vide", names(table(x[i])[z-1]) ),"");
    tt[j+z,3]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,1]," (", round(table(x[,i],x[,y])[z-1,1]*100/ ( table(x[,i],x[,y])[z-1,1]+ table(x[,i],x[,y])[z-1,2]) ,2) ,"%)",sep=""),"");
    tt[j+z,4]<-ifelse(z>1,paste(table(x[,i],x[,y])[z-1,2]," (", round(table(x[,i],x[,y])[z-1,2]*100/( table(x[,i],x[,y])[z-1,2]+ table(x[,i],x[,y])[ z-1,1]),2) ,"%)",sep=""),"");
    tt[j+z,5]<-ifelse(z>1,"-",
                      ifelse(mcnemar.test(table(x[,i],x[,y]))[[3]]<0.0001,"<0.0001****",
                             ifelse(mcnemar.test(table(x[,i],x[,y]))[[3]]<0.001,"<0.001***",
                                    ifelse(mcnemar.test(table(x[,i],x[,y]))[[3]]<0.01,paste(round(mcnemar.test(table(x[,i],x[,y]))[[3]],5),"**"), 
                                           ifelse(mcnemar.test(table(x[,i],x[,y]))[[3]]<0.05,paste(round(mcnemar.test(table(x[,i],x[,y]))[[3]],5),"*"),
                                                  ifelse(mcnemar.test(table(x[,i],x[,y]))[[3]]<0.10,paste(round(mcnemar.test(table(x[,i],x[,y]))[[3]],5),"TREND"),
                                                         round(mcnemar.test(table(x[,i],x[,y]))[[3]],5))))))
    )
    }; j<-j+k}
    #rep<-readline(cat("Voulez vous une sortie du tableau dans Word? Oui = o\nToute autre frappe= Non  "))
    #if (rep=="o") {write.table(tt,file="D:/r/tabloqualibi.csv",append=F,quote=F,sep=";",eol="\n",na="NA",dec=".",row.names=F,col.names=T) # Sauve le tableau pour le r?cup?rer sous word
    #edit(file="D:/R/tabloqualibi.csv",editor= "C:/Program Files/OFFICE11/WINWORD.EXE")} else mydoc <- addFlexTable( mydoc, FlexTable(tt) ); #print(noquote(tt));
    
    #####
    # Envoyer le tableau dans MARKDOWN
    return(as.data.frame(tt));
    #####
    
    #####
    #print(noquote(tt));
    rm(a,b,g,k,i,j,tt,z,x,y,w)
}

####____DEBUT
# Produire un tableau avecles analyse multivari?es
# Pr?r?quis:
# Appeller son mod?le mod
# EXEMPLE:
#mod<-coxph(Surv(OS60,etatOS60)~ACTIVITE_DPD_CUT_30+SEXE+AGE_DATE_DEBUT_FU1+TYPE_CANCER_INITIAL_2+CHIRURGIE+AU_MOINS_UNE_RC+RECIDIVE_1+strata(LOC_CANCER_INITIAL),data=stat)
#TabCOX(mod)
#tt<-round(as.matrix(summary(mod)$coefficients),5)
#insert_table_report(tt)

TabCOX<-function(x)
{
  oddsratio<-summary(mod)
  try<-as.data.frame(oddsratio$coefficients)
  try<-round(try,3)
  try1<-as.matrix(exp(try[,1]))
  try2<-as.matrix(exp(try[,1]-1.96*try[,3]))
  try3<-as.matrix(exp(try[,1]+1.96*try[,3]))
  try4<-as.matrix(try[,5])
  try1<-round(try1,2)
  try2<-round(try2,2)
  try3<-round(try3,2)
  try4<-round(try4,3)
  try5<-cbind(try1,"[",try2,"-",try3,"]",try4)
  dimnames(try5)[[2]]<-c("Hazard ratio","["," ","IC95%","OR","]","p-value")
  rownames(try5)<-rownames(try)
  try5<- as.data.frame(try5)
  try5<-try5[1:dim(try5)[[1]],]
  try5
}
####____FIN

####____DEBUT

#Idem TabCOX mais pour modele de regression logistiques

TabRegLog<-function(x)
{
  oddsratio<-summary(mod)
  try<-as.data.frame(oddsratio$coefficient)
  try<-round(try,3)
  try1<-as.matrix(exp(try[,1]))
  try2<-as.matrix(exp(try[,1]-1.96*try[,2]))
  try3<-as.matrix(exp(try[,1]+1.96*try[,2]))
  try4<-as.matrix(try[,4])
  try1<-round(try1,2)
  try2<-round(try2,2)
  try3<-round(try3,2)
  try4<-round(try4,3)
  try5<-cbind(try1,"[",try2,"-",try3,"]",try4)
  dimnames(try5)[[2]]<-c("Odds ratio","["," ","IC95%","OR","]","p-value")
  try5<- as.data.frame(try5)
  try5<-try5[2:dim(try5)[[1]],]
  try6<-dimnames(try)[[1]][2:dim(try)[1]]
  tryf<-cbind(try6,try5)
  dimnames(tryf)[[2]][1]<-"Variables"
  tryf
}
####____FIN


######## RÉCUPÉRER L'INDICE D'UNE COLONNE
numcol=function(col,data) {  #data: jeu de données  ;  #col: nom de la colonne dont on souhaite récupérer l'indice
  ind=match(col,dimnames(data)[[2]])
  return(ind)
}

######## DÉCODAGE DES VARIABLES 
decode = function(x,y) {  ## x:fichier de données  ;  y:fichier de description des variables
  for (i in 1:ncol(y)){  ## conversion des colonnes du tableau descriptif des variables en type "character"
    y[,i]=as.character(y[,i])
  }
  for (i in colnames(x)){  ## parcours des lignes du fichier de description des variables
    if (y[which(y$NOM_VARIABLE==i),"FORMAT"]=="NUMERIQUE CATEGORIELLE"& y[which(y$NOM_VARIABLE==i),"CODE"]!=""){ # si la variable est catégorielle...
      # print(y[i,"NOM_VARIABLE"])
      var_format=y[which(y$NOM_VARIABLE==i),"CODE"]  ##... et le code de la variable est stocké
      lev_lab=unlist(strsplit(var_format, "\n"))  ## division des modalités du modalité du code (ex: 0=NON / 1=OUI)
      lev_lab=lev_lab[lev_lab != ""]
      code_var=c()  ## création d'un vecteur où seront listés les codes numérique de la variable
      decode_var=c()  ## création d'un vecteur où seront listés les valeurs décodées de la variable
      for (j in lev_lab){  ## pour chaque modalité du code...
        split_lev_lab=unlist(strsplit(j,"="))  ## le code numérique et la valeur décodée sont séparés
        code_var=c(code_var,split_lev_lab[1])  ## le code numérique est stocké
        decode_var=c(decode_var,split_lev_lab[2])  ## la valeur numérique est stockée
        for (k in 1:length(code_var)){  ## boucle pour supprimer les espaces blancs inutiles dans les codes
          code_var[k]=str_trim(code_var[k], side="left")
          code_var[k]=str_trim(code_var[k], side="right")
          decode_var[k]=str_trim(decode_var[k], side="left")
          decode_var[k]=str_trim(decode_var[k], side="right")
          
        }
      }
      
      x[,i]= factor(x[,i],levels=code_var,labels=decode_var)  ## la variable est transformée en factor, avec en levels les codes numériques
    }
    else if (y[which(y$NOM_VARIABLE==i),"FORMAT"]=="NUMERIQUE CATEGORIELLE"& y[which(y$NOM_VARIABLE==i),"CODE"]=="") {
      x[,i]= as.factor(x[,i])
    }
  } 
  return(x)
}


######## TRANSITION NOMS VAR COURTS/LONGS  

nametype_var=function(d,var_d,z){ ## d: fichier de données  ;  var_d:fichier de description des variables  ; ## z:type de noms souhaité (courts/longs)
  # z <- readline("noms de variables souhaités (courts/longs): ") ## z: type de noms souhaité (courts/longs)
  for (i in 1:ncol(var_d)){   ## conversion des colonnes du tableau descriptif des variables en type "character"
    var_d[,i]=as.character(var_d[,i])
  }
  
  var_court = c()  ## création d'un vecteur où seront listés les noms courts des variables
  var_long = c()   ## création d'un vecteur où seront listés les noms longs des variables
  
  for (i in 1:nrow(var_d)){ ## parcours des lignes du fichier de description des variables
    if (var_d[i,1]!=""){  ## si la ligne n'est pas vide...
      var_court=c(var_court,var_d[i,"NOM_VARIABLE"])  ##...le nom court de la variable est stocké
      var_long=c(var_long,var_d[i,"INTITULE"])  ##...le nom long de la variable est stocké
    }
  }
  for (i in 1:ncol(d)){  ## parcours des noms de colonnes (= noms de variables) du fichier de données
    varname=colnames(d)[i]  ## le nom de la variable est stocké
    if (z=="longs"){  ## si l'on souhaite convertir les noms courts en noms longs...
      index=grep(paste0("^",varname,"$"),var_court)  ##...on récupére l'indice du nom court de la variable dans la liste des noms courts
      colnames(d)[i]=var_long[index]  ## on se sert de cet indice pour récupérer le nom long de la variable, qui remplace ensuite le nom court
    }
    else if (z=="courts"){   ## si l'on souhaite convertir les noms longs en noms courts...
      index=grep(paste0("^",varname,"$"),var_long)  ##...on récupére l'indice du nom long de la variable dans la liste des noms longs
      colnames(d)[i]=var_court[index]  ## on se sert de cet indice pour récupérer le nom court de la variable, qui remplace ensuite le nom long
    }
  }
  return(d)
}


######## Tableau des variables, de leur intitulé et de leur numéro de colonnes

tablevar=function(data,var_d){  # data: jeu de données ; var_d: fichier de description des variables  
  names=colnames(data) [which(colnames(data) %in% var_d[,1]==T)]
  intitules=c()
  colnums=c()
  for (i in names){
    intitules=c(intitules,var_d[which(var_d$NOM_VARIABLE==i),"INTITULE"])
    colnums=c(colnums,as.character(numcol(i,data)))
  }
  tt=data.frame("Num."=colnums,"NOM"=names,"INTITULE"=intitules)
  return(tt)
}


###### SUIVI MÉDIAN
suivimed=function(OS,OS_state,expby,jdd){ ##  OS: délai de survie ; OS_state: état (0/1) ; expby: variable explicative ; data: jeu de données
  OS_num=numcol(OS,jdd)
  OS_state_num=numcol(OS_state,jdd)
  
  if(expby==1){
    MED<-survfit(Surv(jdd[,OS_num],abs((jdd[,OS_state_num])-1))~1,data=jdd,type=c("kaplan-meier"))
    MED<-round(as.data.frame(quantile(MED,probs = c(0.5), conf.int = TRUE)),1)
    colnames(MED)<-c("Suivi median","IC95%_inf","IC95_sup")
  }
  else{
    expby_num=numcol(expby,jdd)
    MED<-survfit(Surv(jdd[,OS_num],abs((jdd[,OS_state_num])-1))~jdd[,expby_num],data=jdd,type=c("kaplan-meier"))
    MED<-round(as.data.frame(quantile(MED,probs = c(0.5), conf.int = TRUE)),1)
    colnames(MED)<-c("Modalite","Suivi median","IC95%_inf","IC95_sup")
    MED$Modalite=as.character(MED$Modalite)
    for (i in 1:nrow(MED)){
      lev_lab=unlist(strsplit(MED[i,"Modalite"], "="))
      MED[i,"Modalite"]=lev_lab[2]
    }
  }
  return(as.data.frame(MED))
  ft= fontsize(ft,size = 8, part = "all")
  ft <- bold(ft, bold = TRUE, part = "header")
  ft <- align(ft, align = "left", part = "all" )
  ft <- autofit(ft,add_w = 0.05,add_h = 0.05)
  return(ft)
  rm(MED,ft)
}


###### MÉDIANE DE SURVIE [IC 95%]:
surv_med=function(OS,OS_state,expby,data){ ##  OS: délai de survie ; OS_state: état (0/1) ; expby: variable explicative ; data: jeu de données
  OS_num=numcol(OS,data)
  OS_state_num=numcol(OS_state,data)
  
  if(expby==1){
    MED<-survfit(Surv(data[,OS_num],data[,OS_state_num])~1,data=data,type=c("kaplan-meier"))
    MED<-round(as.data.frame(quantile(MED,probs = c(0.5), conf.int = TRUE)),1)
    colnames(MED)<-c("Survie mediane","IC95%_inf","IC95_sup")
  }
  else{
    expby_num=numcol(expby,data)
    MED<-survfit(Surv(data[,OS_num],data[,OS_state_num])~data[,expby_num],data=data,type=c("kaplan-meier"))
    MED<-round(as.data.frame(quantile(MED,probs = c(0.5), conf.int = TRUE)),1)
    MED=cbind(row.names(MED),MED)
    colnames(MED)<-c("Modalite","Survie mediane","IC95%_inf","IC95_sup")
    MED$Modalite=as.character(MED$Modalite)
    for (i in 1:nrow(MED)){
      lev_lab=unlist(strsplit(MED[i,"Modalite"], "="))
      MED[i,"Modalite"]=lev_lab[2]
    }
  }
  return(as.data.frame(MED))
}


###### COURBE DE SURVIE
survcourbe=function(OS,OS_state,expby,data){ ##  OS: délai de survie ; OS_state: état (0/1) ; expby: variable explicative ; data: jeu de données
  OS_num=numcol(OS,data)
  OS_state_num=numcol(OS_state,data)
  
  if(expby==1){
    MED<-survfit(Surv(data[,OS_num],data[,OS_state_num])~1,data=data,type=c("kaplan-meier"))
  }
  else{
    expby_num=numcol(expby,data)
    MED<-survfit(Surv(data[,OS_num],data[,OS_state_num])~data[,expby_num],data=data,type=c("kaplan-meier"))
  }
  return(MED)
}

###### TABLE DE SURVIE

survtable=function(courbetime){
  tt<- as.data.frame(t(courbetime))
  for (i in 1:ncol(tt)){
    for (y in 1:nrow(tt)){
      tt[y,i]=as.character(tt[y,i])
      tt[y,i]=gsub("\\.00","",tt[y,i])
    }
  }
  # dimnames(courbe_time)[[2]]<-c("","","","","","","")
  tt2=cbind("name"=rownames(tt),tt)
  return(tt2)
}

###### Voir les facteurs à une seule modalité

onelevel=function(data){
  var=c()
  for (i in 1:ncol(data)){
    if(is.factor(data[,i])==T){
      if (nlevels(data[,i])==1){
        var=c(var,colnames(data)[i])
      }
    }
  }
  return(var)
}


### TableStack avec pvalues ordonnées
tableStack_ordered<-function(vars,by,dataFrame,percent = c("column", "row","none"), var.labels=T,frequency = TRUE, test = TRUE) 
{
  tt=as.data.frame(tableStack(vars=vars, by=by, var.labels=var.labels, dataFrame=dataFrame,frequency=frequency,percent = percent,test = test))
  
  tt2=tt[order(tt[,length(tt)]),]
  var_ordered=c()
  for(i in 1:nrow(tt2)){
    if (tt2[i,length(tt)]!=""){
      var_ordered=c(var_ordered,numcol(tt2[i,1],dataFrame))
    }
  }
  tt3=as.data.frame(tableStack(vars=var_ordered, by=by, var.labels=var.labels, dataFrame=dataFrame,frequency=frequency,percent = percent,test = test))
  return(tt3)
}



### TableStack_0 avec pvalues ordonnées
tableStack_0_ordered<-function(vars,by,dataFrame,percent = c("column", "row","none"), var.labels=T,frequency = TRUE, test = TRUE) 
{
  tt=as.data.frame(tableStack_0(vars=vars, by=by, var.labels=var.labels, dataFrame=dataFrame,frequency=frequency,percent = percent,test = test))
  
  tt2=tt[order(tt[,length(tt)]),]
  var_ordered=c()
  for(i in 1:nrow(tt2)){
    if (tt2[i,length(tt)]!=""){
      var_ordered=c(var_ordered,numcol(tt2[i,1],dataFrame))
    }
  }
  tt3=as.data.frame(tableStack_0(vars=var_ordered, by=by, var.labels=var.labels, dataFrame=dataFrame,frequency=frequency,percent = percent,test = test))
  return(tt3)
}

### sortiequalibi avec p-values ordonnées
sortiequalibi_ordered<-function(x,y,z) 
{
  tt=as.data.frame(sortiequalibi(x,y,z))
  
  tt2=tt[order(tt[,length(tt)]),]
  var_ordered=c()
  for(i in 1:nrow(tt2)){
    if (tt2[i,length(tt)]!="-"){
      var_ordered=c(var_ordered,numcol(tt2[i,1],x))
    }
  }
  tt3=as.data.frame(sortiequalibi(x,y,var_ordered))
  return(tt3)
}

### sortiequantibi avec p-values ordonnées
sortiequantibi_ordered<-function(x,y,z) 
{
  tt=as.data.frame(sortiequantibi(x,y,z))
  
  tt2=tt[order(tt[,length(tt)]),]
  var_ordered=c()
  for(i in 1:nrow(tt2)){
    # if (tt2[i,length(tt)]!="-"){
    var_ordered=c(var_ordered,numcol(tt2[i,1],x))
    # }
  }
  tt3=as.data.frame(sortiequantibi(x,y,var_ordered))
  return(tt3)
}

### Surviebilogrank avec les p-values ordonnées
surviebilogrank_ordered<-function(x,t,y,w){
  tt=as.data.frame(surviebilogrank(x,t,y,w))
  
  tt2=tt[order(tt[,length(tt)]),]
  var_ordered=c()
  for(i in 1:nrow(tt2)){
    if (tt2[i,length(tt)]!="-"){
    var_ordered=c(var_ordered,numcol(tt2[i,1],x))
    }
  }
  tt3=as.data.frame(surviebilogrank(x,t,y,var_ordered))
  return(tt3)
}


###### Tableau descriptif de SAS version R : version quantitatif

tabulate_quantibi=function(categ.1=NULL,categ.2=NULL,categ.3=NULL,var.quant,by,dataFrame){
  
  d=data.frame()
  
  if (!is.null(categ.1)&!is.null(categ.2)&!is.null(categ.3)) {
    categ1_mod=unique(as.character(dataFrame[,categ.1]))
    categ1_mod=sort(categ1_mod)
    dataFrame[,var.quant]=as.numeric(as.character(dataFrame[,var.quant]))
    categ1=c()
    categ2=c()
    for(i in 1:length(categ1_mod)){
      categ1=c(categ1,categ1_mod[i])
      categ2_mod=unique(as.character(dataFrame[which(dataFrame[,categ.1]==categ1_mod[i]),categ.2]))
      categ2_mod=sort(categ2_mod)
      for (j in 1:length(categ2_mod)){
        if (j!=1){
          categ1=c(categ1,"")
        }
        categ2=c(categ2,categ2_mod[j])
        categ3_mod=unique(as.character(dataFrame[which(dataFrame[,categ.2]==categ2_mod[j]),categ.3]))
        categ3_mod=sort(categ3_mod)
        for (k in 1:length(categ3_mod)){
          if(k!=1){
            categ1=c(categ1,"")
            categ2=c(categ2,"")
          }
          dataFrame_temp=dataFrame[which(dataFrame[,categ.1]==categ1_mod[i] & dataFrame[,categ.2]==categ2_mod[j] & dataFrame[,categ.3]==categ3_mod[k]),]
          dataFrame_temp=droplevels(dataFrame_temp)
          tt=sortiequantibi(dataFrame_temp,numcol(by,dataFrame_temp),numcol(var.quant,dataFrame_temp))
          tt[,1]=as.character(tt[,1])
          tt[1,1]=categ3_mod[k]
          if(i==1 & j==1 & k==1) {
            tt2=tt
            
            
          }
          else{
            tt2=rbind(tt2,tt)
          }
        }
      }
    }
    d=cbind(categ1,categ2,tt2)
    colnames(d)[1]=colnames(dataFrame)[categ.1]
    colnames(d)[2]=colnames(dataFrame)[categ.2]
    colnames(d)[3]=colnames(dataFrame)[categ.3]
    return(d)
  }
  
  else if(!is.null(categ.1)&!is.null(categ.2)&is.null(categ.3)){
    
    categ1_mod=unique(as.character(dataFrame[,categ.1]))
    categ1_mod=sort(categ1_mod)
    dataFrame[,var.quant]=as.numeric(as.character(dataFrame[,var.quant]))
    categ1=c()
    for (j in 1:length(categ1_mod)){
      categ1=c(categ1,categ1_mod[j])
      categ2_mod=unique(as.character(dataFrame[which(dataFrame[,categ.1]==categ1_mod[j]),categ.2]))
      categ2_mod=sort(categ2_mod)
      for (k in 1:length(categ2_mod)){
        if(k!=1){
          categ1=c(categ1,"")
        }
        dataFrame_temp=dataFrame[which(dataFrame[,categ.1]==categ1_mod[j] & dataFrame[,categ.2]==categ2_mod[k]),]
        dataFrame_temp=droplevels(dataFrame_temp)
        tt=sortiequantibi(dataFrame_temp,numcol(by,dataFrame_temp),numcol(var.quant,dataFrame_temp))
        tt[,1]=as.character(tt[,1])
        tt[1,1]=categ2_mod[k]
        if(j==1 & k==1) {
          tt2=tt
        }
        else{
          tt2=rbind(tt2,tt)
        }
      }
    }
    d=cbind(categ1,tt2)
    colnames(d)[1]=colnames(dataFrame)[categ.1]
    colnames(d)[2]=colnames(dataFrame)[categ.2]
    return(d)
  }
  
  else if(!is.null(categ.1)&is.null(categ.2)&is.null(categ.3)){
    
    categ1_mod=unique(as.character(dataFrame[,categ.1]))
    categ1_mod=sort(categ1_mod)
    dataFrame[,var.quant]=as.numeric(as.character(dataFrame[,var.quant]))
    for (k in 1:length(categ1_mod)){
      dataFrame_temp=dataFrame[which(dataFrame[,categ.1]==categ1_mod[k]),]
      dataFrame_temp=droplevels(dataFrame_temp)
      tt=sortiequantibi(dataFrame_temp,numcol(by,dataFrame_temp),numcol(var.quant,dataFrame_temp))
      tt[,1]=as.character(tt[,1])
      tt[1,1]=categ1_mod[k]
      if(k==1) {
        tt2=tt
      }
      else{
        tt2=rbind(tt2,tt)
      }
    }
    
    d=tt2
    colnames(d)[1]=colnames(dataFrame)[categ.1]
    return(d)
  }
}



###### Tableau descriptif de SAS version R : version qualitative

tabulate_qualibi=function(categ.1=NULL,categ.2=NULL,categ.3=NULL,var.quali,by,dataFrame){
  
  d=data.frame()
  
  if (!is.null(categ.1)&!is.null(categ.2)&!is.null(categ.3)) {
    categ1_mod=unique(as.character(dataFrame[,categ.1]))
    dataFrame[,var.quali]=as.numeric(as.character(dataFrame[,var.quali]))
    categ1=c()
    for(i in 1:length(categ1_mod)){
      categ1=c(categ1,categ1_mod[i])
      categ2_mod=unique(as.character(dataFrame[which(dataFrame[,categ.1]==categ1_mod[i]),colnames(dataFrame)[categ.2]]))
      for (j in 1:length(categ2_mod)){
        if (j!=1){
          categ1=c(categ1,"")
        }
        categ3_mod=unique(as.character(dataFrame[which(dataFrame[,categ.2]==categ2_mod[j]),colnames(dataFrame)[categ.3]]))
        for (k in 1:length(categ3_mod)){
          if(k!=1){
            categ1=c(categ1,"")
          }
        }
        dataFrame_temp=dataFrame[which(dataFrame[,categ.1]==categ1_mod[i] & dataFrame[,categ.2]==categ2_mod[j]),]
        dataFrame_temp=droplevels(dataFrame_temp)
        tt=sortiequalibi(dataFrame_temp,numcol(colnames(dataFrame)[by],dataFrame_temp),numcol(colnames(dataFrame)[var.quali],dataFrame_temp))
        tt[,1]=as.character(tt[,1])
        if(i==1 & j==1) {
          tt2=tt
        }
        else{
          tt2=rbind(tt2,tt)
        }
      }
    }
    d=cbind(categ1,tt2)
    colnames(d)[1]=colnames(dataFrame)[categ.1]
    return(d)
  }
}

#### Récupérer les variables qui feraient buguer le sortiequalibi
sortiequalibi.remove.vars=function (df,y,vars.x){
  vars_remove=c()
  ind=c()
  for (i in vars.x){ind=c(ind,numcol(i,df))}
  for (i in ind){
    if(nlevels(df[,i])<2){
      vars_remove=c(vars_remove,colnames(df[i]))
    }
    else{
      table_temp=as.data.frame(table(df[,y],df[,i]))
      table_temp[,"Var1"]=as.character(table_temp[,"Var1"])
      table_temp[,"Var2"]=as.character(table_temp[,"Var2"])
      for (j in unique(table_temp[,"Var2"])){
        table_temp2=table_temp[which(table_temp[,"Var2"]==j),]
        if(sum(table_temp2[,"Freq"])==0){
          vars_remove=c(vars_remove,colnames(df[i]))
        }
      }
      for (k in unique(table_temp[,"Var1"])){
        table_temp2=table_temp[which(table_temp[,"Var1"]==k),]
        if(sum(table_temp2[,"Freq"])==0){
          vars_remove=c(vars_remove,colnames(df[i]))
        }
      }
    }
  }
  vars_remove=unique(vars_remove)
  # tt=data.frame("variable.non.analysable"=vars_remove)
  return(vars_remove)
}

#### Retirer les variables qui feraient buguer le sortiequalibi
sortiequalibi.select.vars=function (df,y,vars.x){
  vars_remove=c()
  ind=c()
  for (i in vars.x){ind=c(ind,numcol(i,df))}
  for (i in ind){
    if(nlevels(df[,i])<2){
      vars_remove=c(vars_remove,colnames(df[i]))
    }
    else{
      table_temp=as.data.frame(table(df[,y],df[,i]))
      table_temp[,"Var1"]=as.character(table_temp[,"Var1"])
      table_temp[,"Var2"]=as.character(table_temp[,"Var2"])
      for (j in unique(table_temp[,"Var2"])){
        table_temp2=table_temp[which(table_temp[,"Var2"]==j),]
        if(sum(table_temp2[,"Freq"])==0){
          vars_remove=c(vars_remove,colnames(df[i]))
        }
      }
      for (k in unique(table_temp[,"Var1"])){
        table_temp2=table_temp[which(table_temp[,"Var1"]==k),]
        if(sum(table_temp2[,"Freq"])==0){
          vars_remove=c(vars_remove,colnames(df[i]))
        }
      }
    }
  }
  vars_select=vars.x[which(vars.x %in% vars_remove==F & vars.x!=y)]
  
  return(vars_select)
}

#### Sélectionner les variables qui feraient buguer le sortiequantibi
sortiequantibi.remove.vars=function(df,y,vars.x){
  vars_remove=c()
  ind=c()
  for (i in vars.x){ind=c(ind,numcol(i,df))}
  for (i in ind){
    for (j in levels(df[,y])){
      df_temp=df[which(df[,y]==j),]
      if(length(which(!is.na(df_temp[,i])))<2){
        vars_remove=c(vars_remove,colnames(df)[i])
      }
    }
  }
  vars_remove=unique(vars_remove)
  # tt=data.frame("variable.non.analysable"=vars_remove)
  return(vars_remove)
}
#### Retirer les variables qui feraient buguer le sortiequantibi
sortiequantibi.select.vars=function(df,y,vars.x){
  vars_remove=c()
  ind=c()
  for (i in vars.x){ind=c(ind,numcol(i,df))}
  for (i in ind){
    for (j in levels(df[,y])){
      df_temp=df[which(df[,y]==j),]
      if(length(which(!is.na(df_temp[,i])))<2){
        vars_remove=c(vars_remove,colnames(df)[i])
      }
    }
  }
      
  vars_select=vars.x[which(vars.x %in% vars_remove==F & vars.x!=y)]
  return(unique(vars_select))
}


####### Récupérer les numéros de colonnes de plusieurs variables
numcols=function(vars,df){
  index=c()
  for (i in vars){index=c(index,numcol(i,df))
  }
  return(index)
}

####### Insérer une colonne à la position que l'on souhaite
insert_col=function(newcol,pos,df){
  df=add_column(df,newcolumn=newcol, .after = numcol(pos,df))
  colnames(df)[numcol("newcolumn",df)]=deparse(substitute(newcol))
  return(df)
}


### Importer facilement plusieurs tables SAS
import_sas=function(dir){  ## dir: chemin vers le dossier qui contient les tables SAS
  liste=list.files(dir,pattern=".sas7bdat")
  table=sub(".sas7bdat","",liste)
  for (i in table){
    path=paste0(dir,"/",i,".sas7bdat")
    x=read.sas7bdat(path)
    assign(i,x,envir = .GlobalEnv)
    print(paste("La table",i,"a ete importee"))
  }
}



## Fonction pour sortir un tableau de tox avec SOC, termes et grades par bras de traitement
tableau_tox=function(dataframe,SOC,TERM,GRADE,ARM){
  ## - dataFrame: jeu de données contenant les IEs
  ## - SOC: colonne précisant les SOC
  ## - TERM: colonne précisant les termes
  ## - GRADE: colonne précisant les grades
  ## - ARM: colonne précisant le bras de traitement
  
  ### On convertit d'abord les 4 variables au bon format
  for(i in c(SOC,TERM,GRADE)){
    dataframe[,i]=as.character(dataframe[,i])
  }
  dataframe[,ARM]=as.factor(dataframe[,ARM]) ## La variable bras doit rester en facteur !!
  
  
  arms=str_sort(unique(as.character(dataframe[,ARM]))) ## Récupération du nom des bras de trt
  
  ## Création du tableau final
  df_final=c("GRADE",arms,"Total") 
  soc=c()
  terms_all=c()
  for (h in sort(unique(dataframe[,SOC]))){ ## Parcours des SOC
    soc=c(soc,h)
    df_temp=dataframe[which(dataframe[,SOC]==h),]
    terms=sort(unique(df_temp[,TERM]))
    for (i in 1:length(terms)){ ## Parcours des termes du SOC 
      if(i>1){
        soc=c(soc,"")
      }
      terms_all=c(terms_all,terms[i])
      df_temp2=df_temp[which(df_temp[,TERM]==terms[i]),]
      table_cont=as.data.frame(table(df_temp2[,GRADE],df_temp2[,ARM])) ## Récupération de la table de contingence entre les différents grades du terme et les bras de trt
      table_cont$Var1=as.character(table_cont$Var1)
      grade=unique(table_cont$Var1)
      for (j in 1:length(grade)){ ## Pour chaque grade...
        if(j>1){
          terms_all=c(terms_all,"")
          soc=c(soc,"")
        }
        line=grade[j] ## Récupération du grade
        table_cont_temp=table_cont[which(table_cont$Var1==grade[j]),]
        table_cont_temp$Var1=as.character(table_cont_temp$Var1)
        table_cont_temp$Var2=as.character(table_cont_temp$Var2)
        total=sum(table_cont_temp$Freq)
        for (k in 1:length(arms)){
          table_cont_temp2=table_cont_temp[which(table_cont_temp$Var2==arms[k]),]
          line=c(line,table_cont_temp2$Freq) ## Récupération du nb d'évènement dans chaque bras
        }
        line=c(line,total) ## Ajout du total
        df_final=rbind(df_final,line) ## Ajout de la ligne au tableau final
      }
    }
  }
  df_final=as.data.frame(df_final,col.names=c("GRADE",arms,"Total"))
  df_final=df_final[-1,]
  df_final=cbind(soc,terms_all,df_final) ## Merge des SOC et des termes avec le tableau final
  colnames(df_final)=c("System Organ Class","Term","Grade",arms,"Total")
  
  for (i in colnames(df_final)){
    df_final[,i]=as.character(df_final[,i])
  }
  
  ## Nb de tox total par bras
  total_bras1=sum(as.numeric(df_final[,arms[1]]))
  total_bras2=sum(as.numeric(df_final[,arms[2]]))
  total=total_bras1+total_bras2
  
  ## Ajout des pourcentages
  for(i in 1:nrow(df_final)){
    df_final[i,arms[1]]=paste0(df_final[i,arms[1]]," (",round(as.numeric(df_final[i,arms[1]])/total_bras1*100,2),"%)")
    df_final[i,arms[2]]=paste0(df_final[i,arms[2]]," (",round(as.numeric(df_final[i,arms[2]])/total_bras2*100,2),"%)")
    df_final[i,"Total"]=paste0(df_final[i,"Total"]," (",round(as.numeric(df_final[i,"Total"])/total*100,2),"%)")
  }
  ## Ajout de la ligne des totaux au début du tableau
  total_line=c("TOTAL","","",paste0(total_bras1," (100%)"),paste0(total_bras2," (100%)"),paste0(total," (100%)"))
  df_final=InsertRow(df_final,total_line, RowNum = 1) ## nécessite le package DataCombine
  
  return(df_final)
}




### Conversion automatique des variables date (format dd/mm/yyyy)
convert_date=function(tables){  ## tables: vecteur contenant le(s) jeu(x) de données d'intêret
  for (i in tables){
    x=get(i)
    for (j in colnames(x)){
      if(length(grep("[[:digit:]]{2}\\/[[:digit:]]{2}\\/[[:digit:]]{4}",as.character(x[,j])))>0){
        x[,j]=as.Date(x[,j],"%d/%m/%Y")
      }
    }
    assign(i,x)
  }
}




#################################################################################################
# tableStack qui sort moy(sd) et med(range)+++
tableStack_moy_med_0bis<-function (vars, minlevel = "auto", maxlevel = "auto", count = TRUE,
                              na.rm = FALSE, means = TRUE, medians = FALSE, sds = TRUE,
                              decimal = 1, dataFrame = .data, total = TRUE, var.labels = TRUE,
                              var.labels.trunc = 150, reverse = FALSE, vars.to.reverse = NULL,
                              by = NULL, vars.to.factor = NULL, iqr = "auto", prevalence = FALSE,
                              percent = c("column", "row", "none"), frequency = TRUE, test = TRUE,
                              name.test = TRUE, total.column = FALSE, simulate.p.value = FALSE,
                              sample.size = TRUE,na.col=FALSE)
{
  nl <- as.list(1:ncol(dataFrame))
  names(nl) <- names(dataFrame)
  selected <- eval(substitute(vars), nl, parent.frame())
  by.var <- eval(substitute(by), nl, parent.frame())
  if (is.numeric(by.var)) {
    by <- dataFrame[, by.var]
  }
  if (is.character(by.var)) {
    by1 <- as.factor(rep("Total", nrow(dataFrame)))
  }
  if (is.null(by)) {
    selected.class <- NULL
    for (i in selected) {
      selected.class <- c(selected.class, class(dataFrame[,
                                                          i]))
    }
    if (length(table(table(selected.class))) > 1)
      warning("Without 'by', classes of all selected variables should be the same.")
  }
  selected.to.factor <- eval(substitute(vars.to.factor), nl,
                             parent.frame())
  if (!is.character(iqr)) {
    selected.iqr <- eval(substitute(iqr), nl, parent.frame())
    intersect.selected <- intersect(selected.iqr, selected.to.factor)
    if (length(intersect.selected) != 0) {
      stop(paste(names(dataFrame)[intersect.selected],
                 "cannot simultaneously describe IQR and be coerced factor"))
    }
    for (i in selected.iqr) {
      if (!is.integer(dataFrame[, i]) & !is.numeric(dataFrame[,
                                                              i])) {
        stop(paste(names(dataFrame)[i], "is neither integer nor numeric, not possible to compute IQR"))
      }
    }
  }
  for (i in selected) {
    if ((class(dataFrame[, i]) == "integer" | class(dataFrame[,
                                                              i]) == "numeric") & !is.null(by)) {
      if (any(selected.to.factor == i)) {
        dataFrame[, i] <- factor(dataFrame[, i])
      }
      else {
        dataFrame[, i] <- as.numeric(dataFrame[, i])
      }
    }
  }
  if ((reverse || suppressWarnings(!is.null(vars.to.reverse))) &&
      is.factor(dataFrame[, selected][, 1])) {
    stop("Variables must be in 'integer' class before reversing. \n        Try 'unclassDataframe' first'")
  }
  selected.dataFrame <- dataFrame[, selected, drop = FALSE]
  if (is.null(by)) {
    selected.matrix <- NULL
    for (i in selected) {
      selected.matrix <- cbind(selected.matrix, unclass(dataFrame[,
                                                                  i]))
    }
    colnames(selected.matrix) <- names(selected.dataFrame)
    if (minlevel == "auto") {
      minlevel <- min(selected.matrix, na.rm = TRUE)
    }
    if (maxlevel == "auto") {
      maxlevel <- max(selected.matrix, na.rm = TRUE)
    }
    nlevel <- as.list(minlevel:maxlevel)
    names(nlevel) <- eval(substitute(minlevel:maxlevel),
                          nlevel, parent.frame())
    if (suppressWarnings(!is.null(vars.to.reverse))) {
      nl1 <- as.list(1:ncol(dataFrame))
      names(nl1) <- names(dataFrame[, selected])
      which.neg <- eval(substitute(vars.to.reverse), nl1,
                        parent.frame())
      for (i in which.neg) {
        dataFrame[, selected][, i] <- maxlevel + 1 -
          dataFrame[, selected][, i]
        selected.matrix[, i] <- maxlevel + 1 - selected.matrix[,
                                                               i]
      }
      reverse <- FALSE
      sign1 <- rep(1, ncol(selected.matrix))
      sign1[which.neg] <- -1
    }
    if (reverse) {
      matR1 <- cor(selected.matrix, use = "pairwise.complete.obs")
      diag(matR1) <- 0
      if (any(matR1 > 0.98)) {
        reverse <- FALSE
        temp.mat <- which(matR1 > 0.98, arr.ind = TRUE)
        warning(paste(paste(rownames(temp.mat), collapse = " and ")),
                " are extremely correlated.", "\n", "  The command has been excuted without 'reverse'.",
                "\n", "  Remove one of them from 'vars' if 'reverse' is required.")
      }
      else {
        score <- factanal(na.omit(selected.matrix), factors = 1,
                          scores = "regression")$score
        sign1 <- NULL
        for (i in 1:length(selected)) {
          sign1 <- c(sign1, sign(cor(score, na.omit(selected.matrix)[,
                                                                     i], use = "pairwise")))
        }
        which.neg <- which(sign1 < 0)
        for (i in which.neg) {
          dataFrame[, selected][, i] <- maxlevel + minlevel -
            dataFrame[, selected][, i]
          selected.matrix[, i] <- maxlevel + minlevel -
            selected.matrix[, i]
        }
      }
    }
    table1 <- NULL
    for (i in as.integer(selected)) {
      if (!is.factor(dataFrame[, i]) & !is.logical(dataFrame[,
                                                             i, drop = TRUE])) {
        x <- factor(dataFrame[, i])
        levels(x) <- nlevel
        tablei <- table(x)
      }
      else {
        if (is.logical(dataFrame[, i, drop = TRUE])) {
          tablei <- table(factor(dataFrame[, i, drop = TRUE],
                                 levels = c("FALSE", "TRUE")))
        }
        else {
          tablei <- table(dataFrame[, i])
        }
      }
      if (count) {
        tablei <- c(tablei, length(na.omit(dataFrame[,
                                                     i])))
        names(tablei)[length(tablei)] <- "count"
      }
      if (is.numeric(selected.dataFrame[, 1, drop = TRUE]) |
          is.logical(selected.dataFrame[, 1, drop = TRUE])) {
        if (means) {
          tablei <- c(tablei, round(mean(as.numeric(dataFrame[,
                                                              i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "mean"
        }
        if (medians) {
          tablei <- c(tablei, round(median(as.numeric(dataFrame[,
                                                                i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "median"
        }
        if (sds) {
          tablei <- c(tablei, round(sd(as.numeric(dataFrame[,
                                                            i]), na.rm = TRUE), digits = decimal))
          names(tablei)[length(tablei)] <- "sd"
        }
      }
      table1 <- rbind(table1, tablei)
    }
    results <- as.table(table1)
    if (var.labels) {
      rownames(results) <- names(selected.dataFrame)
    }
    else {
      rownames(results) <- paste(selected, ":", names(selected.dataFrame))
    }
    if (is.integer(selected.dataFrame[, 1])) {
      rownames(results) <- names(nl)[selected]
      if (is.factor(dataFrame[, selected][, 1])) {
        colnames(results)[1:(ncol(results) - (count +
                                                means + medians + sds))] <- levels(dataFrame[,
                                                                                             selected][, 1])
      }
      else {
        colnames(results)[1:(ncol(results) - (count +
                                                means + medians + sds))] <- names(nlevel)
      }
    }
    result0 <- results
    if (var.labels) {
      if (!is.null(attributes(dataFrame)$var.labels)) {
        results <- as.table(cbind(results, substr(attributes(dataFrame)$var.labels[selected],
                                                  1, var.labels.trunc)))
      }
      if (!is.null(attributes(dataFrame)$var.labels))
        colnames(results)[ncol(results)] <- "description"
    }
    if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[,
                                                                            1]) | is.logical(selected.dataFrame[, 1])) {
      if (reverse || (!is.null(vars.to.reverse))) {
        Reversed <- ifelse(sign1 < 0, "    x   ", "    .   ")
        results <- cbind(Reversed, results)
      }
      sumMeans <- 0
      sumN <- 0
      for (i in selected) {
        sumMeans <- sumMeans + mean(as.numeric(dataFrame[,
                                                         i]), na.rm = TRUE) * length(na.omit(dataFrame[,
                                                                                                       i]))
        sumN <- sumN + length(na.omit(dataFrame[, i]))
      }
      mean.of.total.scores <- weighted.mean(rowSums(selected.matrix),
                                            w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.total.scores <- sd(rowSums(selected.matrix),
                               na.rm = TRUE)
      mean.of.average.scores <- weighted.mean(rowMeans(selected.matrix),
                                              w = rowSums(!is.na(selected.matrix)), na.rm = TRUE)
      sd.of.average.scores <- sd(rowMeans(selected.matrix),
                                 na.rm = TRUE)
      countCol <- which(colnames(results) == "count")
      meanCol <- which(colnames(results) == "mean")
      sdCol <- which(colnames(results) == "sd")
      if (total) {
        results <- rbind(results, rep("", reverse ||
                                        suppressWarnings(!is.null(vars.to.reverse)) +
                                        (maxlevel + 1 - minlevel) + (count + means +
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length((rowSums(selected.dataFrame))[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.total.scores,
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.total.scores,
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Total score"
        results <- rbind(results, rep("", reverse ||
                                        suppressWarnings(!is.null(vars.to.reverse)) +
                                        (maxlevel + 1 - minlevel) + (count + means +
                                                                       medians + sds + var.labels)))
        results[nrow(results), countCol] <- length(rowSums(selected.dataFrame)[!is.na(rowSums(selected.dataFrame))])
        results[nrow(results), meanCol] <- round(mean.of.average.scores,
                                                 digits = decimal)
        results[nrow(results), sdCol] <- round(sd.of.average.scores,
                                               digits = decimal)
        rownames(results)[nrow(results)] <- " Average score"
      }
    }
    results <- list(results = noquote(results))
    if (reverse || suppressWarnings(!is.null(vars.to.reverse)))
      results <- c(results, list(items.reversed = names(selected.dataFrame)[sign1 <
                                                                              0]))
    if (var.labels && !is.null(attributes(dataFrame)$var.labels)) {
      results <- c(results, list(item.labels = attributes(dataFrame)$var.labels[selected]))
    }
    if (total) {
      if (is.integer(selected.dataFrame[, 1]) | is.numeric(selected.dataFrame[,
                                                                              1])) {
        results <- c(results, list(total.score = rowSums(selected.matrix)),
                     list(mean.score = rowMeans(selected.matrix,
                                                na.rm = na.rm)), list(mean.of.total.scores = mean.of.total.scores,
                                                                      sd.of.total.scores = sd.of.total.scores,
                                                                      mean.of.average.scores = mean.of.average.scores,
                                                                      sd.of.average.scores = sd.of.average.scores))
      }
    }
    class(results) <- c("tableStack", "list")
    results
  }
  else {
    if (is.character(by.var)) {
      by1 <- as.factor(rep("Total", nrow(dataFrame)))
    }
    else {
      by1 <- factor(dataFrame[, by.var])
    }
    if (is.logical(dataFrame[, i])) {
      dataFrame[, i] <- as.factor(dataFrame[, i])
      levels(dataFrame[, i]) <- c("No", "Yes")
    }
    if (length(table(by1)) == 1)
      test <- FALSE
    name.test <- ifelse(test, name.test, FALSE)
    if (is.character(iqr)) {
      if (iqr == "auto") {
        selected.iqr <- NULL
        for (i in 1:length(selected)) {
          if (class(dataFrame[, selected[i]]) == "difftime") {
            dataFrame[, selected[i]] <- as.numeric(dataFrame[,
                                                             selected[i]])
          }
          if (is.integer(dataFrame[, selected[i]]) |
              is.numeric(dataFrame[, selected[i]])) {
            if (length(table(by1)) > 1) {
              if (nrow(dataFrame) < 5000) {
                if (nrow(dataFrame) < 3) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
                else if (shapiro.test(lm(dataFrame[,
                                                   selected[i]] ~ by1)$residuals)$p.value <
                         0.01
                         #| bartlett.test(dataFrame[, selected[i]] ~
                         #by1)$p.value < 0.01
                ) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
              else {
                sampled.shapiro <- sample(lm(dataFrame[,
                                                       selected[i]] ~ by1)$residuals, 250)
                if (shapiro.test(sampled.shapiro)$p.value <
                    0.01
                    #| bartlett.test(dataFrame[, selected[i]] ~
                    #by1)$p.value < 0.01
                ) {
                  selected.iqr <- c(selected.iqr, selected[i])
                }
              }
            }
          }
        }
      }
      else {
        selected.iqr <- NULL
      }
    }
    table2 <- NULL
    if (sample.size) {
      if (test) {
        if (name.test) {
          if (total.column) {
            table2 <- rbind(c(table(by1), length(by1),
                              "", ""), c(rep("", length(table(by1)) +
                                               1), "", ""))
            colnames(table2)[ncol(table2) - (2:0)] <- c("Total",
                                                        "Test stat.", "P value")
          }
          else {
            table2 <- rbind(c(table(by1), "", ""), c(rep("",
                                                         length(table(by1))), "", ""))
            colnames(table2)[ncol(table2) - (1:0)] <- c("Test stat.",
                                                        "P value")
          }
        }
        else {
          if (total.column) {
            table2 <- rbind(c(table(by1), length(by1),
                              ""), c(rep("", length(table(by1)) + 1),
                                     "", ""))
            colnames(table2)[ncol(table2) - (1:0)] <- c("Total",
                                                        "P value")
          }
          else {
            table2 <- rbind(c(table(by1), ""), c(rep("",
                                                     length(table(by1))), ""))
            colnames(table2)[ncol(table2)] <- "P value"
          }
        }
      }
      else {
        total.column <- FALSE
        table2 <- rbind(table(by1), "")
      }
    }
    for (i in 1:length(selected)) {
      if (is.factor(dataFrame[, selected[i]]) | is.logical(dataFrame[,
                                                                     selected[i]]) | is.character(dataFrame[, selected[i]])) {
        x0 <- table(dataFrame[, selected[i]], by1)
        if (total.column) {
          x <- addmargins(x0, margin = 2)
        }
        else {
          x <- x0
        }
        nr <- nrow(x)
        nc <- ncol(x0)
        sr <- rowSums(x0)
        if (any(sr == 0)) {
          #stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one row"))
        }
        sc <- colSums(x0)
        if (any(sc == 0)) {
          #stop(paste(names(dataFrame)[selected[i]], " has zero count in at least one column"))
        }
        x.row.percent <- round(x/rowSums(x0) * 100, decimal)
        table0 <- x
        if (nrow(x) == 2 & prevalence) {
          table00 <- addmargins(x, margin = 1)
          table0 <- paste(table00[2, ], "/", table00[3,
                                                     ], " (", round(table00[2, ]/table00[3, ] *
                                                                      100, decimal), "%)", sep = "")
          table0 <- t(table0)
          rownames(table0) <- "  prevalence"
        }
        else {
          if (any(percent == "column")) {
            x.col.percent <- round(t(t(x)/colSums(x)) *
                                     100, decimal)
            x.col.percent1 <- matrix(paste(x, " (", x.col.percent,
                                           ")", sep = ""), nrow(x), ncol(x))
            if (!frequency) {
              x.col.percent1 <- x.col.percent
            }
            table0 <- x.col.percent1
          }
          else {
            if (any(percent == "row")) {
              x.row.percent <- round(x/rowSums(x0) *
                                       100, decimal)
              x.row.percent1 <- matrix(paste(x, " (",
                                             x.row.percent, ")", sep = ""), nrow(x),
                                       ncol(x))
              if (!frequency) {
                x.row.percent1 <- x.row.percent
              }
              table0 <- x.row.percent1
            }
          }
          rownames(table0) <- paste("  ", rownames(x))
          colnames(table0) <- colnames(x)
        }
        if (test) {
          E <- outer(sr, sc, "*")/sum(x0)
          dim(E) <- NULL
          if (nrow(dataFrame) <
              1000) {
            test.method <- "Fisher's exact test"
            p.value <- fisher.test(x0, simulate.p.value = simulate.p.value)$p.value
          }
          else {
            test.method <- paste("Chisq. (", suppressWarnings(chisq.test(x0)$parameter),
                                 " df) = ", suppressWarnings(round(chisq.test(x0)$statistic,
                                                                   decimal + 1)), sep = "")
            p.value <- suppressWarnings(chisq.test(x0)$p.value)
          }
        }
      }
      if (is.numeric(dataFrame[, selected[i]])) {
        if (any(selected.iqr == selected[i])) {
          term1 <- NULL
          term2 <- NULL
          term3 <- NULL
          term4 <- NULL
          term5 <- NULL
          for (j in 1:(length(levels(by1)))) {
            term1 <- c(term1, mean(dataFrame[by1 ==
                                               levels(by1)[j], selected[i]], na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[by1 ==
                                             levels(by1)[j], selected[i]], na.rm = TRUE))
            term3 <- c(term3, median(dataFrame[by1 ==
                                                 levels(by1)[j], selected[i]], na.rm = TRUE))
            term4 <- c(term4, quantile(dataFrame[by1 ==
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[[1]])
            term5 <- c(term5, quantile(dataFrame[by1 ==
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[[5]])
          }
          if (total.column) {
            term1 <- c(term1, mean(dataFrame[, selected[i]],
                                   na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[, selected[i]],
                                 na.rm = TRUE))
            term3 <- c(term3, median(dataFrame[, selected[i]],
                                     na.rm = TRUE))
            term4 <- c(term4, quantile(dataFrame[, selected[i]],
                                       na.rm = TRUE)[[1]])
            term5 <- c(term5, quantile(dataFrame[, selected[i]],
                                       na.rm = TRUE)[[5]])
          }
          term.numeric <- paste(
            round(term1, 2),
            "(",
            signif(term2, digits = 2),
            ")   ",
            signif(term3,digits = 2),
            "[",
            signif(term4, digits = 2),
            "-",
            signif(term5, digits = 2),
            "]",
            sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "mean(sd)  median [min-max]"
        }
        else {
          term1 <- NULL
          term2 <- NULL
          term3 <- NULL
          term4 <- NULL
          term5 <- NULL
          for (j in 1:(length(levels(by1)))) {
            term1 <- c(term1, mean(dataFrame[by1 ==
                                               levels(by1)[j], selected[i]], na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[by1 ==
                                             levels(by1)[j], selected[i]], na.rm = TRUE))
            term3 <- c(term3, median(dataFrame[by1 ==
                                                 levels(by1)[j], selected[i]], na.rm = TRUE))
            term4 <- c(term4, quantile(dataFrame[by1 ==
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[[1]])
            term5 <- c(term5, quantile(dataFrame[by1 ==
                                                   levels(by1)[j], selected[i]], na.rm = TRUE)[[5]])
          }
          if (total.column) {
            term1 <- c(term1, mean(dataFrame[, selected[i]],
                                   na.rm = TRUE))
            term2 <- c(term2, sd(dataFrame[, selected[i]],
                                 na.rm = TRUE))
            term3 <- c(term3, median(dataFrame[, selected[i]],
                                     na.rm = TRUE))
            term4 <- c(term4, quantile(dataFrame[, selected[i]],
                                       na.rm = TRUE)[[1]])
            term5 <- c(term5, quantile(dataFrame[, selected[i]],
                                       na.rm = TRUE)[[5]])
          }
          term.numeric <- paste(
            round(term1, 2),
            "(",
            signif(term2, digits = 2),
            ")   ",
            signif(term3,digits = 2),
            "[",
            signif(term4, digits = 2),
            "-",
            signif(term5, digits = 2),
            "]",
            sep = "")
          term.numeric <- t(term.numeric)
          rownames(term.numeric) <- "mean(sd)  median [min-max]"
        }
        table0 <- term.numeric
        if (test) {
          if (any(as.integer(table(by1[!is.na(dataFrame[,
                                                        selected[i]])])) < 3) | length(table(by1)) >
              length(table(by1[!is.na(dataFrame[, selected[i]])]))) {
            test.method <- paste("Sample too small: group",
                                 paste(which(as.integer(table(factor(by)[!is.na(dataFrame[,
                                                                                          selected[i]])])) < 3), collapse = " "))
            p.value <- NA
          }
          else {
            if (any(selected.iqr == selected[i])) {
              if (length(levels(by1)) > 2) {
                test.method <- "Kruskal-Wallis test"
                p.value <- kruskal.test(dataFrame[, selected[i]] ~
                                          by1)$p.value
              }
              else {
                test.method <- "Ranksum test"
                p.value <- wilcox.test(dataFrame[, selected[i]] ~
                                         by1, exact = FALSE)$p.value
              }
            }
            else {
              if (length(levels(by1)) > 2) {
                test.method <- paste("ANOVA F-test (",
                                     anova(lm(dataFrame[, selected[i]] ~
                                                by1))[1, 1], ", ", anova(lm(dataFrame[,
                                                                                      selected[i]] ~ by1))[2, 1], " df) = ",
                                     round(anova(lm(dataFrame[, selected[i]] ~
                                                      by1))[1, 4], decimal + 1), sep = "")
                p.value <- anova(lm(dataFrame[, selected[i]] ~
                                      by1))[1, 5]
              }
              else {
                test.method <- paste("t-test", paste(" (",
                                                     t.test(dataFrame[, selected[i]] ~ by1,
                                                            var.equal = TRUE)$parameter, " df)",
                                                     sep = ""), "=", round(abs(t.test(dataFrame[,
                                                                                                selected[i]] ~ by1, var.equal = TRUE)$statistic),
                                                                           decimal + 1))
                p.value <- t.test(dataFrame[, selected[i]] ~
                                    by1, var.equal = TRUE)$p.value
              }
            }
          }
        }
      }
      if (test) {
        if (name.test) {
          label.row <- c(rep("", length(levels(by1)) +
                               total.column), test.method, ifelse(p.value <
                                                                    0.001, "< 0.001", round(p.value, decimal +
                                                                                              2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total",
                                     "Test stat.", "P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "Test stat.",
                                     "P value")
          }
          table0 <- cbind(table0, "", "")
          blank.row <- rep("", length(levels(by1)) +
                             total.column + 2)
        }
        else {
          label.row <- c(rep("", length(levels(by1)) +
                               total.column), ifelse(p.value < 0.001, "< 0.001",
                                                     round(p.value, decimal + 2)))
          label.row <- t(label.row)
          if (total.column) {
            colnames(label.row) <- c(levels(by1), "Total",
                                     "P value")
          }
          else {
            colnames(label.row) <- c(levels(by1), "P value")
          }
          table0 <- cbind(table0, "")
          blank.row <- rep("", length(levels(by1)) +
                             total.column + 1)
        }
      }
      else {
        label.row <- c(rep("", length(levels(by1)) +
                             total.column))
        label.row <- t(label.row)
        if (total.column) {
          colnames(label.row) <- c(levels(by1), "Total")
        }
        else {
          colnames(label.row) <- c(levels(by1))
        }
        blank.row <- rep("", length(levels(by1)) + total.column)
      }
      if (var.labels) {
        rownames(label.row) <- ifelse(!is.null(attributes(dataFrame)$var.labels[selected][i]),
                                      attributes(dataFrame)$var.labels[selected[i]],
                                      names(dataFrame)[selected][i])
        rownames(label.row) <- ifelse(rownames(label.row) ==
                                        "", names(dataFrame[selected[i]]), rownames(label.row))
      }
      else {
        rownames(label.row) <- paste(selected[i], ":",
                                     names(dataFrame[selected[i]]))
      }
      if (!is.logical(dataFrame[, selected[i]])) {
        if (prevalence & length(levels(dataFrame[, selected[i]])) ==
            2) {
          rownames(label.row) <- paste(rownames(label.row),
                                       "=", levels(dataFrame[, selected[i]])[2])
        }
      }
      blank.row <- t(blank.row)
      rownames(blank.row) <- ""
      table2 <- rbind(table2, label.row, table0, blank.row)
    }
    if (sample.size) {
      rownames(table2)[1:2] <- c("Total", "")
    }
    class(table2) <- c("tableStack", "table")
    table2b<-table2
    table2<-matrix(data=table2,nr=nrow(table2),nc=(ncol(table2)))
    colnames(table2)<-colnames(table2b)
    rownames(table2)<-rownames(table2b)
    table2<-cbind(rownames(table2b), table2) 
    colnames(table2)[[1]]<-colnames(dataFrame)[by.var]   
  }
  table2=as.data.frame(table2)
  if(na.col==TRUE){
    table2[,"Vide"]=""
    table2[,1]=as.character(table2[,1])
    vars=table2[,1][which(table2[,1]%in% colnames(dataFrame)==T)]
    for (i in vars){
      na_number=sum(is.na(dataFrame[,i]))
      phrase=paste0(na_number," (",round(na_number/nrow(dataFrame)*100,2),"%)")
      table2[which(table2[,1]==i),"Vide"]=phrase
    }
  }
  return(table2)
}



tableStack_moy_med_ordered<-function (vars,by,dataFrame) 
{
  tt=as.data.frame(tableStack_moy_med(vars=vars, by=by, var.labels=T, dataFrame=dataFrame,percent = c("row"),test = T))
  
  tt2=tt[order(tt[,length(colnames(tt))]),]
  var_ordered=c()
  for(i in 1:nrow(tt2)){
    if (tt2[i,length(colnames(tt2))]!=""){
      var_ordered=c(var_ordered,numcol(tt2[i,1],dataFrame))
    }
  }
  tt3=as.data.frame(tableStack_moy_med(vars=var_ordered, by=by, var.labels=T, dataFrame=dataFrame,percent = c("row"),test = T))


  #
  # # Envoyer le tableau dans MARKDOWN
  # # ft <- flextable(as.data.frame(tt3))
  # # ft= fontsize(ft,size = 8, part = "all")
  # # ft <- bold(ft, bold = TRUE, part = "header")
  # # ft <- bold(ft, j=1, bold = TRUE, part = "body")
  # # ft <- align(ft, align = "left", part = "all" )
  # # ft <- autofit(ft,add_w=0.05,add_h=0.05)
  # # ft=FitFlextableToPage(ft) ## à utiliser si le tableau dépasse des marges
  # #####
  return(tt3)
}



