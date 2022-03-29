#!/usr/bin/env python
# coding: utf-8

# # 1 Pré-analyse

# In[1]:


#Chemin d'accès ou seront stocké les fichiers
path='C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap'


# In[2]:


#Essentiels 
import pandas as pd 
import numpy as np

#Graphes 
import matplotlib.pyplot as plt
# %matplotlib inline
import seaborn as sns 
import plotly as ply
import plotly.graph_objects as go
import plotly.io as pio
from plotly.offline import plot
import plotly.express as px

#Mapping
import folium 
from folium import plugins

import geopandas

#Gestion d'images
import imageio
from PIL import Image,ImageDraw


#gestion fichier 
import fileinput
import pathlib as path

#Gestion web
from selenium import webdriver
import time 
import os

#dépendances 
import kaleido

import json

from sklearn.metrics import r2_score


# In[3]:


DEPARTMENTS={'01':'Ain','02':'Aisne','03':'Allier','04':'Alpes-de-Haute-Provence',
             '05':'Hautes-Alpes','06':'Alpes-Maritimes','07':'Ardèche','08':'Ardennes','09':'Ariège',
             '10':'Aube','11':'Aude','12':'Aveyron','13':'Bouches-du-Rhône','14':'Calvados','15':'Cantal',
             '16':'Charente','17':'Charente-Maritime','18':'Cher','19':'Corrèze','2A':'Corse-du-Sud',
             '2B':'Haute-Corse','21':"Côte-d'Or",'22':"Côtes-d'Armor",'23':'Creuse','24':'Dordogne',
             '25':'Doubs','26':'Drôme','27':'Eure','28':'Eure-et-Loir','29':'Finistère','30':'Gard',
             '31':'Haute-Garonne','32':'Gers','33':'Gironde','34':'Hérault','35':'Ille-et-Vilaine',
             '36':'Indre','37':'Indre-et-Loire','38':'Isère','39':'Jura','40':'Landes',
             '41':'Loir-et-Cher','42':'Loire','43':'Haute-Loire','44':'Loire-Atlantique','45':'Loiret',
             '46':'Lot',
             '47':'Lot-et-Garonne','48':'Lozère','49':'Maine-et-Loire','50':'Manche','51':'Marne',
             '52':'Haute-Marne','53':'Mayenne','54':'Meurthe-et-Moselle','55':'Meuse','56':'Morbihan',
             '57':'Moselle','58':'Nièvre','59':'Nord','60':'Oise','61':'Orne','62':'Pas-de-Calais',
             '63':'Puy-de-Dôme','64':'Pyrénées-Atlantiques','65':'Hautes-Pyrénées',
             '66':'Pyrénées-Orientales','67':'Bas-Rhin','68':'Haut-Rhin','69':'Rhône','70':'Haute-Saône',
             '71':'Saône-et-Loire','72':'Sarthe','73':'Savoie','74':'Haute-Savoie','75':'Paris',
             '76':'Seine-Maritime','77':'Seine-et-Marne','78':'Yvelines','79':'Deux-Sèvres',
             '80':'Somme','81':'Tarn','82':'Tarn-et-Garonne','83':'Var','84':'Vaucluse','85':'Vendée',
             '86':'Vienne','87':'Haute-Vienne','88':'Vosges','89':'Yonne','90':'Territoire de Belfort',
             '91':'Essonne','92':'Hauts-de-Seine','93':'Seine-Saint-Denis','94':'Val-de-Marne',
             '95':"Val-d'Oise",'971':'Guadeloupe','972':'Martinique','973':'Guyane','974':'La Réunion',
             '976':'Mayotte','978':'Saint-Martin'}


# # 2 Import de la base de donnée de travail

# In[4]:


df=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_incidence.csv",
               sep=";",
               decimal=",")
df_date=df.copy()
df_date['jour'] = pd.to_datetime(df_date['jour'])#Considéré date comme date
Ser=df_date.groupby(df_date['jour'].dt.strftime('%Y-%m-%d'))['incid_hosp'].sum() #somme pur chaque date de la valeur de hosp
df2=pd.DataFrame(Ser)
df2=df2.sort_index(ascending=True)
df2.head()


# # 3 Pré-visualisation

# ## 3.1 Lissages des data

# In[5]:


hosp_m=[]
liste=list(df2["incid_hosp"])

for i in range(len(liste)):
    if i>len(liste)-15 : 
        hosp_m.append((liste[i]+sum(liste[i:]))/len(liste[i:]))
    else : 
        hosp_m.append((liste[i]+sum(liste[i+1:i+15]))/16)


# ## 3.2 Data cumulée du nb de hosp

# In[6]:


cumul_hosp=[]
for i in range(1,len(liste)): 
    if len(cumul_hosp)>1:
        cumul_hosp.append(liste[i]+cumul_hosp[-1])
    else : 
        cumul_hosp.append(liste[i])


# # 4 Visaualisation des données

# ## 4.1 Visualisation des data sous forme de courbes

# In[7]:


fig=go.Figure()
fig.add_trace(go.Scatter(y = hosp_m,
                         x = df2.index,
                         name = "Nb nv hosp / jours",
                         line_shape='spline'))
fig.update_layout(title="Nb nv hosp / jours",
                  xaxis_title="jours",
                  yaxis_title="nb hosp")
fig.show()


# In[8]:


fig=px.bar(y = hosp_m,
           x = df2.index)
fig.update_layout(title="Nb nv hosp / jours",
                  xaxis_title="jours",
                  yaxis_title="nb hosp")
fig.show()


# In[9]:


cumul_hosp
fig=go.Figure()
fig.add_trace(go.Scatter(y = cumul_hosp,
                         x = df2.index,
                         name = "Nb cumulée de personne hospitalisée",
                         line_shape='spline',
                         line=dict(color="red", dash="dot")))
fig.update_layout(title="Nb cumulée de personne hospitalisée",
                  xaxis_title="jours",
                  yaxis_title="cumul hosp")
fig.show()


# ## 4.2 Visualisation des data sous forme de cartes Française

# ### 4.2.1 Carto en ISO-3

# In[10]:


df_dep=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_incidence.csv",
               sep=";",
               decimal=",")
r,c=df_dep.shape
print('row:',r)


# In[11]:


#for i in range(59568): 
    #df_dep['dep'][i]=DEPARTMENTS[df_dep['dep'][i]]


# In[12]:


#print(df_dep.head(59568))


# In[13]:


#df_dep=df_dep.groupby(df_reg['dep'])['incid_hosp']

#pd.DataFrame(df_dep)
#df_reg=df_reg.groupby(df_reg['dep'])['jour']
#print(df_dep)


# trop grosse data                                        
# def plot_map(df, col, pal):
#     df=int(df[df[col]])
#     df = df[df[col]>0]
#     fig = px.choropleth(df, locations="France", locationmode='Regions', 
#                         color=col, hover_name="Country/Region", 
#                         title=col, hover_data=[col], color_continuous_scale=pal)
#     fig.show()
# 
# plot_map(df_dep,'Country','green')

# Premier essai                                                                                               
# df_dep['jour'] = pd.to_datetime(df_dep['jour'])
# fig = px.choropleth(df_dep, locations="dep", 
#                     color=np.log(df_dep["incid_hosp"].cumsum()),
#                     locationmode='country names', hover_name="dep", 
#                     animation_frame=df_dep["jour"].dt.strftime('%Y-%m-%d'),
#                     title='Cases over time', color_continuous_scale=px.colors.sequential.matter)
# fig.update(layout_coloraxis_showscale=False)
# fig.show()

# In[14]:


df_dep2=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_incidence.csv",
               sep=";",
               decimal=",")
print(df_dep2.head())


# In[15]:


df_dep2['jour'] = pd.to_datetime(df_dep2['jour'])
Serie=df_dep2.groupby([df_dep2['jour'].dt.strftime('%Y-%m-%d')],as_index=False)['incid_hosp'].sum()
df3=pd.DataFrame(Serie)
df3=df3.sort_index(ascending=True)
df3.insert(1,'jour',df_dep2['jour'])
df3.insert(2,'Country','France')

df3

1 er test 
fig = px.choropleth(df3, locations="Country", 
                    color=np.log(df3["incid_hosp"]),
                    locationmode='country names', 
                    animation_frame=df3['jour'].dt.strftime('%Y-%m-%d'),
                    title='Cases over time', color_continuous_scale=px.colors.sequential.matter,
                    center={"lat":46.00,"lon":2.00},
                    )
fig.update_layout( width=700, height=600)
fig.update(layout_coloraxis_showscale=True)
fig.show()
# #### 4.2.1.1 Carto Fr totale 

# In[16]:


#Tout les cas en france
fig = px.choropleth(df3, locations="Country", 
                    color=(df3["incid_hosp"]),
                    range_color=(min(df3["incid_hosp"]),max(df3["incid_hosp"])),
                    color_continuous_midpoint= df3['incid_hosp'].mean() ,
                    locationmode='country names', 
                    animation_frame=df3['jour'].dt.strftime('%Y-%m-%d'),
                    title='Cases over time', 
                    color_continuous_scale=px.colors.sequential.matter,
                    center={"lat":46.00,"lon":2.00},
                    )
fig.update_layout( width=700, height=600,
                  coloraxis_colorbar=dict(title="Population hosp",ticktext=[str(min(df3["incid_hosp"])),
                                                                            str(max(df3["incid_hosp"]))]))
#Mettre la date sur la carte 
fig.update(layout_coloraxis_showscale=True)
fig.show()


# ### 4.2.2 Carto avec OpenStreetMap(md folium)

# #### 4.2.2.1 Premier essai

# In[17]:


Nice = folium.Map(location=[43.583537,7.127527])
plugins.ScrollZoomToggler().add_to(Nice)
Nice


# In[18]:


df_dep3=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_incidence.csv",
               sep=";",
               decimal=",")
#toto=df_dep3.loc(df_dep3['incid_hosp'] == '404')
#type(df_dep3['dep'][1])
#df_dep3.loc[(df_dep3['incid_hosp'] >200) & (df_dep3['dep'].notin['75','77','78','91','92','93','94','95'])]

df_test=df4
print(df_test)
indexNames = df4[ df4['dep'] == '75' ].index
df_test.drop(indexNames,inplace=True)
indexNames = df4[ df4['dep'] == '77' ].index
df_test.drop(indexNames,inplace=True)
indexNames = df4[ df4['dep'] == '78' ].index
df_test.drop(indexNames,inplace=True)
indexNames = df4[ df4['dep'] == '91' ].index
df_test.drop(indexNames,inplace=True)
indexNames = df4[ df4['dep'] == '92' ].index
df_test.drop(indexNames,inplace=True)
indexNames = df4[ df4['dep'] == '93' ].index
df_test.drop(indexNames,inplace=True)
indexNames = df4[ df4['dep'] == '94' ].index
df_test.drop(indexNames,inplace=True)
indexNames = df4[ df4['dep'] == '95' ].index
df_test.drop(indexNames,inplace=True)

max(df_test['incid_hosp'])
# In[19]:


df_dep3['jour'] = pd.to_datetime(df_dep3['jour'])
Serie2=df_dep3.groupby([df_dep3['jour'].dt.strftime('%Y-%m-%d'),df_dep3['dep']],as_index=True)['incid_hosp'].sum()

#Serie2=df_dep3.groupby([df_dep3['jour'].dt.strftime('%Y-%m-%d')],as_index=False)['incid_hosp'].sum()
df4=pd.DataFrame(Serie2)
#df4.insert(1,'jour', pd.to_datetime(df_dep3['jour']))
df4.insert(1,'Country','France')
#df4[df4['jour'] == '2020-03-31']


# In[20]:


#for i in range(59568): 
#    df4['dep'][i]=DEPARTMENTS[df4['dep'][i]]


# In[21]:


df4


# #### 4.2.2.2 Fonctionne que pour la première date

# In[22]:


departement='https://france-geojson.gregoiredavid.fr/repo/departements.geojson'
Fr = folium.Map(location=[46.00,3.00], zoom_start=5.4)


# In[23]:


df4=df4.reset_index()
max(df4['incid_hosp'])
#df4.head(60)


# In[24]:


#help(folium.Choropleth)


# In[25]:


folium.Choropleth(
    geo_data = departement,                  #json
    name ='choropleth',                  
    data = df4,                     
    columns = ['dep', 'incid_hosp'], #columns to work on
    key_on ='feature.properties.code',
    fill_color ='YlOrRd',
    fill_opacity = 0.9,
    line_opacity = 0.2,
    bins=[0,5,30,60,100],
    legend_name = "incidence en fonction hosp").add_to(Fr)
plugins.ScrollZoomToggler().add_to(Fr)
minimap = plugins.MiniMap()
Fr.add_child(minimap)
Fr


# #### 4.2.2.2 Création d'un GIF avec plusieurs carto de différents jours

# In[26]:


dates=[]
for date in df4['jour'].unique():
    dates.append(date)
dates_red=[]
for indice in range(0,len(dates),3):#on divise le nombre de données par 3 => sinon 500 fichier html crée 
    dates_red.append(dates[indice])


# In[27]:


selected_date= dates[8]
df_dt = df4[df4['jour']=='2020-05-25']
df_dt


# ###### Petit test
# Date = 2020-03-27

# In[28]:


Fr_test = folium.Map(location=[47.00,3.00], zoom_start=5.4)
folium.Choropleth(
    geo_data = departement,                  #json
    name ='choropleth',                  
    data = df_dt,                     
    columns = ['dep', 'incid_hosp'], #columns to work on
    key_on ='feature.properties.code',
    fill_color ='YlOrRd',
    fill_opacity = 0.9,
    line_opacity = 0.2,
    legend_name = "incidence en fonction hosp").add_to(Fr_test)
plugins.ScrollZoomToggler().add_to(Fr_test)

Fr_test


# #### On crée un objet map pour toutes les dates
for i in dates_red :
        
        Fr_i = folium.Map(location=[47.00,3.00], zoom_start=5)
        
        
        df_dt = df4[df4['jour']==i]
        
    
        Fr_i=folium.Choropleth(
            geo_data = departement,                  #json
            name ='choropleth',                  
            data = df_dt,                     
            columns = ['dep', 'incid_hosp'], #columns to work on
            key_on ='feature.properties.code',
            fill_color ='YlOrRd',
            fill_opacity = 0.9,
            line_opacity = 0.2,
            bins=[0,50,100,200,410],#utiliser describe et prendre quartiles
            legend_name = "incidence en fonction hosp").add_to(Fr_i)
    #plugins.ScrollZoomToggler().add_to(Fr_i)
        Fr_i.save('C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap/Fr_Total_' + str(i) + '.html')
# ###### Ajouter le path

# #### Suppression du zoom
for i in dates_red:
    with fileinput.FileInput('C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap/Fr_Total_' + str(i) + '.html', inplace=True) as file:
        for line in file:
            print(line.replace('zoomControl: true', 'zoomControl: false'), end='')
# #### Transformation en fichier jpg
path='C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap' 
delay=1
for i in dates_red:
    fn='Fr_Total_' + str(i) + '.html'
    tmpurl='file:///{}/{mapfile}'.format(path,mapfile=fn)

    browser = webdriver.Chrome('C:/Users/Tom/Desktop/Projet/Python/Driver/chromedriver.exe')
    browser.get(tmpurl)

    #Give the map tiles some time to load
    time.sleep(2)
    browser.save_screenshot(path+'/'+'Fr_Total_' + str(i) + '.png')
    browser.quit()
    
    #remove html files
    os.remove(path+'/'+'Fr_Total_' + str(i) + '.html')
# In[29]:


#for i in dates_red:
#    image = Image.open(path+'/'+'Fr_Total_' + str(i) + '.png')
#    box = (0, 0, 800, 800)
#    cropped_image = image.crop(box)
#    cropped_image.save(path+'/'+'Fr_Total_' + str(i) + '.png')

help(imageio.mimwrite)Img=[]
width = 500
center = width // 2
max_radius = int(center * 1.5)
step = 8

for i in range(0, max_radius, step):
    im = Image.new('RGB', (width, width), color_1)
    draw = ImageDraw.Draw(im)
    draw.ellipse((center - i, center - i, center + i, center + i), fill=color_2)
    images.append(im)# liste avec tout les path de toutes les images dans l'ordre. 
images_path=[]
for i in dates_red:
    name='C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap'+'/'+'Fr_Total_' + str(i) + '.png'
    images_path.append(name)image_list = []
for file_name in images_path:
    image_list.append(imageio.imread(file_name))
    #os.remove(file_name)
imageio.mimwrite('C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap.gif', image_list, fps=2)#C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/
# #### 4.2.2.-1 Essai d'ajouter une échelle linéaire

# In[30]:


Fr_linear = folium.Map(location=[46.00,3.00], zoom_start=5.4)


# In[31]:


import branca.colormap as cm

linear = cm.LinearColormap(["#fefb9a",'g','y',"b",'purple',"m",'orange','red','black'],
    #['green','red'],
    #['red', 'orange', 'yellow', 'green', 'blue' , 'purple'],
    #['yellow', 'orange', 'red'],
    vmin=0, vmax=410,
    caption='Color Scale for Map').to_step(21*2)
linear.add_to(Fr_linear)
#linear.to_step(21*2).add_to(Fr_linear)


# In[32]:


#création d'un dico => dep : incidence 
df_dt = df4[df4['jour']=='2020-05-25']
dep_dict = df_dt.set_index('dep')['incid_hosp'].to_dict()
dep_dict['59']


# In[33]:


#Corse=['2A','2B']
def linear_color(Id_dep) : 
    return linear(int(dep_dict[Id_dep]))


# In[34]:


folium.GeoJson(
    departement,
    style_function = lambda  feature:  {
        'fillColor' :  linear_color ( feature['properties']['code']),
        'color'  :  'white' , 
        'weight'  :  0 , 
        'dashArray'  :  '0'    
    }
).add_to(Fr_linear)
Fr_linear


# In[37]:


import branca.colormap as cm

def mapping_step_GIF_1() : 
    departement='https://france-geojson.gregoiredavid.fr/repo/departements.geojson'
    Paris=['75','77','78','91','92','93','94','95']
    
    dates=[]
    for date in df4['jour'].unique():
        dates.append(date)
    
    dates_red=[]
    for indice in range(0,len(dates),3):#on divise le nombre de données par 3 => sinon 500 fichier html crée 
        #formule math pour calculer le décallage en fct du nombre de fichier => arguments 
        dates_red.append(dates[indice])
    min_df=min(df4['incid_hosp'])
    max_df=max(df4['incid_hosp'])
    linear = cm.LinearColormap(["#fdfc64",'g','y',"b",'purple',"m",'orange','red','black'],
                               vmin=min_df, vmax=250,
                               caption='Color Scale for Map')
        
    ##Echelle spé pour paris 
    linear_spé_paris=cm.LinearColormap(["#fdfc64",'g','y',"b",'purple',"m",'orange','red','black'],
                               vmin=min_df, vmax=max_df,
                               caption='Color Scale for Paris')
    
    def linear_color(Id_dep) : 
        if Id_dep not in Paris:
            return linear(int(dep_dict[Id_dep]))
        else : 
            return linear_spé_paris(int(dep_dict[Id_dep]))
    
    for i in dates_red :
        
        Fr_i = folium.Map(location=[47.00,3.00], zoom_start=5)
        
        df_dt = df4[df4['jour']==i]
        
        dep_dict = df_dt.set_index('dep')['incid_hosp'].to_dict()
        

        folium.GeoJson(
            departement,
            style_function = lambda  feature:  {
                'fillColor' :  linear_color ( feature['properties']['code']),
                'color'  :  'black' , 
                'weight'  :  0.1 , 
                'dashArray'  :  '0'
            }
        ).add_to(Fr_i)
        linear.to_step(21*2).add_to(Fr_i)# comment le mettre en argument?
        linear_spé_paris.to_step(21*2).add_to(Fr_i)

    #plugins.ScrollZoomToggler().add_to(Fr_i)
        Fr_i.save('C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap/Viz/Fr_Total_' + str(i) + '.html')
        

    for i in dates_red:
        with fileinput.FileInput('C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap/Viz/Fr_Total_' + str(i) + '.html', inplace=True) as file:
            for line in file:
                print(line.replace('zoomControl: true', 'zoomControl: false'), end='')
        
        
    path='C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap/Viz' 
    delay=1
    for i in dates_red:
        fn='Fr_Total_' + str(i) + '.html'
        tmpurl='file:///{}/{mapfile}'.format(path,mapfile=fn)
        
        browser = webdriver.Chrome('C:/Users/Tom/Desktop/Projet/Python/Driver/chromedriver.exe')
        browser.get(tmpurl)

        #Give the map tiles some time to load
        time.sleep(delay)
        browser.save_screenshot(path+'/'+'Fr_Total_' + str(i) + '.png')
        browser.quit()

        #remove html files
        os.remove(path+'/'+'Fr_Total_' + str(i) + '.html')
        
        
        
    images_path=[]
    for i in dates_red:
        name='C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap/Viz/Fr_Total_' + str(i) + '.png'
        images_path.append(name)
    image_list = []
    
    
    for file_name in images_path:
        image_list.append(imageio.imread(file_name))
        #os.remove(file_name)
    imageio.mimwrite('C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap.gif', image_list, fps=7)


# In[38]:


mapping_step_GIF_1()#df=df4, name_temporal_var='jour', map_variable='incid_hosp',palette_couleur=["#fdfc64",'g','y',"b",'purple',"m",'orange','red','black'],name_variable_dep_region_in_df='dep')

folium.Choropleth(
    geo_data = departement,                  #json
    name ='choropleth',                  
    data = df_dt,                     
    columns = ['dep', 'incid_hosp'], #columns to work on
    key_on ='feature.properties.code',
    fill_color = linear(int(feature['properties']['code'])) if feature['properties']['code']!='2A' or feature['properties']['code']!='2B'else '#00ff00',
    fill_opacity = 0.9,
    line_opacity = 0.2,
    #bins=[0,5,30,60,100],
    legend_name = "incidence en fonction hosp").add_to(Fr_linear)
linear.add_to(Fr_linear)
Fr_linear
# # Fonction toale 
for i in dates_red :
    Fr_i = folium.Map(location=[47.00,3.00], zoom_start=6)
        
        
    df_dt = df4[df4['jour']==i]
        
    
    Fr_i=folium.Choropleth(
        geo_data = departement,                  #json
        name ='choropleth',                  
        data = df_dt,                     
        columns = ['dep', 'incid_hosp'], #columns to work on
        key_on ='feature.properties.code',
        fill_color ='YlOrRd',
        fill_opacity = 0.9,
        line_opacity = 0.2,
        bins=[0,50,100,200,410],#utiliser describe et prendre quartiles
        legend_name = "incidence en fonction hosp").add_to(Fr_i)
    #plugins.ScrollZoomToggler().add_to(Fr_i)
    Fr_i.save('C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap/Fr_Total_' + str(i) + '.html')
# In[ ]:


import branca.colormap as cm

def mapping_step_GIF() : 
    departement='https://france-geojson.gregoiredavid.fr/repo/departements.geojson'
    
    dates=[]
    for date in df4['jour'].unique():
        dates.append(date)
    
    dates_red=[]
    for indice in range(0,len(dates),3):#on divise le nombre de données par 3 => sinon 500 fichier html crée 
        dates_red.append(dates[indice])
    
    
    linear = cm.LinearColormap(["#fefb9a",'g','y',"b",'purple',"m",'orange','red','black'],
                               vmin=0, vmax=410,
                               caption='Color Scale for Map')
    linear.to_step(21*2).add_to(Fr_linear)
    
    
    dep_dict = df4.set_index('dep')['incid_hosp'].to_dict()
    
    def linear_color(Id_dep) : 
        return linear(int(dep_dict[Id_dep]))
    
    
    for i in dates_red :
        
        Fr_i = folium.Map(location=[47.00,3.00], zoom_start=5)
        linear.to_step(21*2).add_to(Fr_linear)
        
        df_dt = df4[df4['jour']==i]
        
        dep_dict = df_dt.set_index('dep')['incid_hosp'].to_dict()
        

        folium.GeoJson(
            departement,
            style_function = lambda  feature:  {
                'fillColor' :  linear_color ( feature['properties']['code']),
                'color'  :  'black' , 
                'weight'  :  0.1 , 
                'dashArray'  :  '0'
            }
        ).add_to(Fr_i)
    #plugins.ScrollZoomToggler().add_to(Fr_i)
        Fr_i.save('C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap/Fr_Total_' + str(i) + '.html')
    print("maps generating done")

    for i in dates_red:
        with fileinput.FileInput('C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap/Fr_Total_' + str(i) + '.html', inplace=True) as file:
            for line in file:
                print(line.replace('zoomControl: true', 'zoomControl: false'), end='')
    print("zoom control = false done")
        
        
    path='C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap' 
    delay=1
    for i in dates_red:
        fn='Fr_Total_' + str(i) + '.html'
        tmpurl='file:///{}/{mapfile}'.format(path,mapfile=fn)
        
        browser = webdriver.Chrome('C:/Users/Tom/Desktop/Projet/Python/Driver/chromedriver.exe')
        browser.get(tmpurl)

        #Give the map tiles some time to load
        time.sleep(delay)
        browser.save_screenshot(path+'/'+'Fr_Total_' + str(i) + '.png')
        browser.quit()

        #remove html files
        os.remove(path+'/'+'Fr_Total_' + str(i) + '.html')
    print("html->png done")
        
        
    images_path=[]
    for i in dates_red:
        name='C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap'+'/'+'Fr_Total_' + str(i) + '.png'
        images_path.append(name)
    image_list = []
    
    
    for file_name in images_path:
        image_list.append(imageio.imread(file_name))
        #os.remove(file_name)
    imageio.mimwrite('C:/Users/Tom/Desktop/Projet/Python/COVID/VIZ/GifMap.gif', image_list, fps=2)
    print("finish")


# In[ ]:


#mapping_step_GIF()

