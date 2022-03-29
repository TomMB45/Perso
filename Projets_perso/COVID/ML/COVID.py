#%%
import matplotlib.pyplot as plt
# %matplotlib inline
import seaborn as sns
import numpy as np
import time 
from sklearn.metrics import r2_score
import plotly as ply
import plotly.graph_objects as go
import plotly.io as pio
from plotly.offline import plot


start=time.time()
#timeit

#%%
import pandas as pd 
pd.set_option("display.max_rows", 5)

df=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_Hosp.csv",
               sep=";",
               decimal=",",
              index_col="jour", 
              parse_dates=True)
#%%
print(df.index.values[115433])
print(df.head(76000))
r,c=df.shape
print(r,c)

somme=df["hosp"].cumsum()
print(somme) 


réa=df["rea"].cumsum()
df_fig=df.copy()
df_fig.insert(1, "Critique", 150, allow_duplicates=False)
print(df_fig.head())
#%%

############ Data viz
plt.figure(figsize=(14,6))
plt.title("Nb hospitalisation par jours")
sns.lineplot(data=df_fig["hosp"],label="Hospitalisation",color="red")
#sns.lineplot(data=df_fig["rea"],label="Réanimation")
sns.lineplot(data=df_fig["Critique"],label="Point de confinement")
plt.xlabel("jour")
plt.show()
print("done 1.1")
#%%

plt.figure(figsize=(14,6))
plt.title("Nb hospitalisation conventionelle et SSR(Soins de Suite et de Réadaptation) et hospitalisation longue durée par jours")
sns.lineplot(data=df_fig["HospConv"],label="Hospitalisation conventionnelle",color="cyan")
sns.lineplot(data=df_fig["SSR_USLD"],label="SSR ou USLD",color="red")
plt.xlabel("jour")
plt.show()
print("done 1.2")
#%%
plt.figure(figsize=(14,6))
plt.title("Nb cumulée de patients hospitalisée et qui sont décédé ou rentré a domicile")
sns.lineplot(data=df_fig["rad"],
             label="Nb cumulé patients ayant été hospitalisés pour COVID-19 et de retour à domicile",
             color="green")
sns.lineplot(data=df_fig["dc"],
             label="Nb cumulé patients décédées",
             color="black")
plt.xlabel("jour")
plt.show()
print("done 1.3")

#%%
plt.figure(figsize=(14,6))
plt.title("Distribution des hospitalisations en fonction des régions")
sns.barplot(x= df["reg"],
            y = df["hosp"],
            palette="Blues")
plt.xlabel("Régions")
plt.ylabel("Hospitalisations")
plt.show()
print("done 1.4")

#%%
plt.figure(figsize=(14,6))
plt.title("Distribution des réanimation en fonction des régions")
sns.barplot(x= df["reg"],
            y = df["rea"],
            palette="Blues")
plt.xlabel("Régions")
plt.ylabel("Réanimations")
plt.show()
print("done 1.5")
#%%
df_sans_0 =pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_Hosp.csv",
               sep=";",
               decimal=",")
indexNames = df_sans_0[ df_sans_0['cl_age90'] == 0 ].index
df_sans_0.drop(indexNames , inplace=True)
plt.figure(figsize=(14,6))
plt.title("Distribution des hospitalisations en fonction des régions avec un slice en fonction de l'age des patients")
sns.barplot(x= df_sans_0["reg"],
            y = df_sans_0["hosp"],
            hue=df_sans_0['cl_age90'],
            palette="Blues")
plt.xlabel("Régions")
plt.ylabel("Hospitalisations")
plt.show()
print("done 1.6")

#%% 
#######################################2eme base de données 
df2=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_incidence.csv",
               sep=";",
               decimal=",",
              index_col="jour", 
              parse_dates=True)
print(df2.head())
#%%
##########################################Data viz 
plt.figure(figsize=(14,6))
plt.title("Nb nouvelles hospitalisation, de réa, de décès et de retour à domicile")
sns.lineplot(data=df2["incid_hosp"],label="Nb quotidien hospitalisation")
sns.lineplot(data=df2["incid_rea"],label="Nb quotidien en réa")
sns.lineplot(data=df2["incid_dc"],label="Nb quotidien décès")
sns.lineplot(data=df2["incid_rad"],label="Nb quotidien retour a domicile")
plt.xlabel("jour")
plt.show()
print("done 2.1")
#%%
plt.figure(figsize=(14,6))
plt.title("Nb nv décès / jours")
sns.lineplot(data=df2["incid_dc"],label="Nb quotidien décès")
plt.xlabel("jour")
plt.show()
print("done 2.1")
#%%

#############################################ML 
from sklearn.model_selection import train_test_split

### 2.2.1 Séparation en apprentissage et validation
ml=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_incidence.csv",
               sep=";",
               decimal=",")
print(ml._get_numeric_data())

#sélection des variables expliquatives 
cols_to_use = ["incid_rea","incid_dc","incid_rad"]
X = ml[cols_to_use]

#Sélection de la variable à expliquer 
y = ml.incid_hosp

# Séparation en train en valid 
X_train, X_valid, y_train, y_valid = train_test_split(X, y,random_state=42)
print("Split done")
#%%

from sklearn.preprocessing import MinMaxScaler
scaler = MinMaxScaler()
scaler.fit(X_train)
X_train_transformed = scaler.transform(X_train)
X_test_transformed = scaler.transform(X_valid)

### 2.2.2 Création du modèle avec XGboost
from xgboost import XGBRegressor
my_model = XGBRegressor(n_estimators=500,learning_rate=0.05,n_jobs=4)
my_model.fit(X_train, y_train)

### 2.2.3 Evaluation du modèle 
from sklearn.metrics import mean_absolute_error
#from sklearn.metrics import accuracy_score
predictions = my_model.predict(X_valid)
print("Mean Absolute Error: " + str(mean_absolute_error(predictions, y_valid)))
print("finish model ML 1")
#%%

my_model.fit(X_train, y_train, 
             early_stopping_rounds=5, 
             eval_set=[(X_valid, y_valid)],
             verbose=False)
predictions = my_model.predict(X_valid)
print("Mean Absolute Error: " + str(mean_absolute_error(predictions, y_valid)))
#print(my_model)
print("finish model ML 2")



pred=my_model.predict(X_valid)
#print(pred)
acc=r2_score(y_valid,pred)
print(acc*100)
#%%
##################################DL 
accu={}
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers

### 2.3.2 Modèle
model2 = keras.Sequential([
    layers.Dense(32 ,input_shape=[3]),
    layers.Activation('swish'),
    layers.Dense(32),
    layers.Activation('swish'),
    layers.Dense(1),
])
model2.compile(
    optimizer='adam',
    loss='mae',
)
history = model2.fit(
    X_train, y_train,
    validation_data=(X_valid, y_valid),
    batch_size=40,
    epochs=10,
    verbose=0, # suppress output since we'll plot the curves
    #callbacks=[early_stopping]
)
history_df = pd.DataFrame(history.history)
history_df.loc[0:, ['loss', 'val_loss']].plot()
plt.title("loss et val_loss pour le modèle DL 2(Layer dense et Activation swish)")
print("Minimum Validation Loss: {:0.4f}".format(history_df['val_loss'].min()));
print("finish model DL 3.1")

pred=model2.predict(X_valid)
acc=r2_score(y_valid,pred)
print(acc*100)
accu["model2"]=acc*100

#%%
##COmprendre les types de layers d'activations 
# activation_layer = layers.Activation('swish')

# x = tf.linspace(-3.0, 3.0, 100)
# y = activation_layer(x)

# plt.figure(dpi=100)
# plt.plot(x, y)
# plt.xlim(-3, 3)
# plt.xlabel("Input")
# plt.ylabel("Output")
# plt.show()
#%%
input_shape = [X_train.shape[1]]
model3 = keras.Sequential([
    layers.Dense(1, input_shape=input_shape),
])
model3.compile(
    optimizer='adam',
    loss='mae',
)
from tensorflow.keras import callbacks

early_stopping = callbacks.EarlyStopping(min_delta=0.001,
                                        patience=5,
                                        restore_best_weights=True)
history = model3.fit(
    X_train, y_train,
    validation_data=(X_valid, y_valid),
    batch_size=450,
    epochs=50,
    verbose=0, # suppress output since we'll plot the curves
    #callbacks=[early_stopping]
)
history_df = pd.DataFrame(history.history)
history_df.loc[0:, ['loss', 'val_loss']].plot()
plt.title("loss et val_loss pour le modèle DL 3(1 seul layer dense)")
print("Minimum Validation Loss: {:0.4f}".format(history_df['val_loss'].min()));
print("finish model DL 3.1")

pred=model3.predict(X_valid)
acc=r2_score(y_valid,pred)
print(acc*100)
accu["model3"]=acc*100
#%%

#Commence le plot avec epoch 10
plt.title("loss et val_loss pour le modèle DL 3(1 seul layer dense) commence a epoch 10")
history_df.loc[10:, ['loss', 'val_loss']].plot()
print("Minimum Validation Loss: {:0.4f}".format(history_df['val_loss'].min()));
print("finish model DL 3.2")
#%%

model5_1 = keras.Sequential([
    layers.Dense(128, activation='relu', input_shape=input_shape),
    layers.Dense(64, activation='relu'),
    layers.Dense(1)
])
model5_1.compile(
    optimizer='adam',
    loss='mae',
)
history = model5_1.fit(
    X_train, y_train,
    validation_data=(X_valid, y_valid),
    batch_size=512,
    epochs=50,
    verbose=1
)
history_df = pd.DataFrame(history.history)
history_df.loc[:, ['loss', 'val_loss']].plot()
plt.title("loss et val_loss pour le modèle DL 5 sans early stop")
print("Minimum Validation Loss: {:0.4f}".format(history_df['val_loss'].min()));
print("finish model DL 5.1")

pred=model5_1.predict(X_valid)
acc=r2_score(y_valid,pred)
print(acc*100)
accu["model5.1"]=acc*100

#%%

from tensorflow.keras import callbacks

early_stopping = callbacks.EarlyStopping(min_delta=0.001,
                                        patience=5,
                                        restore_best_weights=True)

history = model5_1.fit(
    X_train, y_train,
    validation_data=(X_valid, y_valid),
    batch_size=512,
    epochs=50,
    callbacks=[early_stopping]
)
history_df = pd.DataFrame(history.history)
history_df.loc[:, ['loss', 'val_loss']].plot()
plt.title("loss et val_loss pour le modèle DL 5 avec early stop")
print("Minimum Validation Loss: {:0.4f}".format(history_df['val_loss'].min()));
print("finish model DL 5.2")
pred=model5_1.predict(X_valid)
acc=r2_score(y_valid,pred)
print(acc*100)

accu["model5.2"]=acc*100
#%%

### Ajout drop out
shape = [X_train.shape[1]]
print(input_shape)
model6 = keras.Sequential([
    layers.Dense(128, activation='relu', input_shape=shape),
    layers.Dropout(0.3), 
    layers.Dense(64, activation='relu'),
    layers.Dropout(0.3), 
    layers.Dense(1)
])

model6.compile(
    optimizer='adam',
    loss='mae',
)
history = model6.fit(
    X_train, y_train,
    validation_data=(X_valid, y_valid),
    batch_size=512,
    epochs=50,
    verbose=1,
)
history_df = pd.DataFrame(history.history)
history_df.loc[:, ['loss', 'val_loss']].plot()
plt.title("loss et val_loss pour le modèle DL 6(avec drop-out)")
print("Minimum Validation Loss: {:0.4f}".format(history_df['val_loss'].min()))
print("finish model DL 6")
pred=model6.predict(X_valid)
acc=r2_score(y_valid,pred)
print(acc*100)

accu["model6"]=acc*100

av7=time.time()-start
print(av7)

#%%
model7 = keras.Sequential([
    layers.BatchNormalization(input_shape=input_shape),
    layers.Dense(100, activation='relu'),
    layers.BatchNormalization(),
    layers.Dense(100, activation='relu'),
    layers.BatchNormalization(),
    layers.Dense(100, activation='relu'),
    layers.BatchNormalization(),
    layers.Dense(1),
])

print("DL7 compile")
model7.compile(
    optimizer='sgd',
    loss='mae',
    metrics=['mae'],
)
print("DL7 fit")
EPOCHS = 50
history = model7.fit(
    X_train, y_train,
    validation_data=(X_valid, y_valid),
    batch_size=30,
    epochs=EPOCHS,
    verbose=1,
    callbacks=[early_stopping]
)
print("DL7 history")
history_df = pd.DataFrame(history.history)
history_df.loc[0:, ['loss', 'val_loss']].plot()
plt.title("loss et val_loss pour le modèle DL 7(succession layer dense et layer de normalisation)")
print(("Minimum Validation Loss: {:0.4f}").format(history_df['val_loss'].min()))
print("finish model DL 7")
pred=model7.predict(X_valid)
acc=r2_score(y_valid,pred)
print(acc*100)

accu["model7"]=acc*100

#%%
print("Finish")
ap7=time.time()-start
only7=ap7-av7
print("temps execution modèle 7 : {:.0f} min et {:.0f} sec".format(only7 / 60, only7%60 ))
### Crée un dico avec toutes les valeurs de loss min pour choisir le meilleur 
print("Temps total d'exécution du fichier sans modèle 7 : {:.0f} min et {:.0f} sec".format( av7 / 60, av7%60 ) )  
print("Temps total d'exécution du fichier avec modèle 7: {:.0f} min et {:.0f} sec".format( ap7 / 60, ap7%60 ) )  
print(accu)
print(sum(accu.values())/len(accu.values()))
print(max(accu.values()))

#%%
Best_model=model5_1 

##QUand est ce que indice_dc == 0 
#%%
figure=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_incidence.csv",
               sep=";",
               decimal=",")

jours = []
hosp = []
rea=[]
#faire une liste 
for i in list(figure["jour"].unique()):
    jours.append(figure[figure["jour"]==i]["jour"].iloc[-1])
    
for i in list(figure["incid_hosp"].unique()):
    hosp.append(figure[figure["incid_hosp"]==i]["incid_hosp"].iloc[-1])

#%%
import plotly.express as px
from plotly.offline import plot
pio.renderers.default='browser'

fig=go.Figure()
fig.add_trace(go.Scatter(y = hosp,
                         x = jours,
                         mode = 'lines+markers',name = "Nb nv décès / jours"))
fig.update_layout(title="Nb nv hosp / jours",
                  xaxis_title="jours",
                  yaxis_title="nb hosp")
#fig.write_image("figure.svg", engine="kaleido")
fig.show()

# fig=px.scatter(x=jours, y=hosp)
# plot(figure)

# fig=go.Figure()
# fig.add_trace(go.Scatter(x = jours,
#                           y = hosp, 
#                           mode = 'lines+markers',
#                           name = "Nb nv décès / jours"))
# fig.update_layout(title="Nb nv hosp / jours",
#                   xaxis_title="jours",
#                   yaxis_title="nb hosp")
# # fig.write_image("figure.svg", engine="kaleido")
# fig.show()


#plot(fig, auto_open=True)
# plt.figure(figsize=(14,6))
# plt.title("Nb nv décès / jours")
# sns.lineplot(data=df2["incid_dc"].cumsum(),label="Nb quotidien décès")
# plt.xlabel("jour")
# plt.show()
print("done fig plotly")
#%%
figure=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_incidence.csv",
               sep=";",
               decimal=",")
x,y = figure.shape
print(x,y)
print(figure.head(59568))

#%%
hosp_normal=[]
jours_2=[]

for i in list(figure["jour"].unique()):
    jours_2.append(figure[figure["jour"]==i]["jour"].iloc[-1])

#%%

for i in list(figure["incid_hosp"]):
    if len(hosp_normal)<=7 : 
        hosp_normal.append(figure[figure["incid_hosp"]==i]["incid_hosp"].iloc[-1])
    else :
        hosp_normal.append((figure[figure["incid_hosp"]==i]["incid_hosp"].iloc[-1]+hosp_normal[-10]+hosp_normal[-9]+hosp_normal[-8]+hosp_normal[-7]+hosp_normal[-6]+hosp_normal[-5]+hosp_normal[-4]+hosp_normal[-3]+hosp_normal[-2]+hosp_normal[-1])//11    )

#%%
fig=go.Figure()
fig.add_trace(go.Scatter(y = hosp_normal,
                         x = jours,
                         mode = 'lines+markers',name = "Nb nv hosp / jours"))
fig.update_layout(title="Nb nv hosp / jours",
                  xaxis_title="jours",
                  yaxis_title="nb hosp")
#fig.write_image("figure.svg", engine="kaleido")
fig.show()

#%%
