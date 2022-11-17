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
#import kaleido
import pandas as pd 
import plotly.express as px
from plotly.offline import plot
pio.renderers.default='browser'
#%%
df=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_incidence.csv",
               sep=";",
               decimal=",")
df_date=df.copy()
df_date['jour'] = pd.to_datetime(df_date['jour'])#Considéré date comme date
Ser=df_date.groupby(df_date['jour'].dt.strftime('%Y-%m-%d'))['incid_hosp'].sum() #somme pur chaque date de la valeur de hosp
df2=pd.DataFrame(Ser)
df2=df2.sort_index(ascending=True)
#%%
#Moyenne glissante descendante
hosp=[]

for i in list(df2["incid_hosp"]):
    if len(hosp)<7 : 
        hosp.append(df2[df2["incid_hosp"]==i]["incid_hosp"].iloc[-1])
    else : 
        hosp.append((df2[df2["incid_hosp"]==i]["incid_hosp"].iloc[-1]+sum(hosp[-7:])/8))


#print(df[df["incid_hosp"]==i]["incid_hosp"].iloc[-1])
#%%
#Moyenne glissante montante
hosp_m=[]
liste=list(df2["incid_hosp"])

for i in range(len(liste)):
    if i>len(liste)-15 : 
        hosp_m.append((liste[i]+sum(liste[i:]))/len(liste[i:]))
    else : 
        hosp_m.append((liste[i]+sum(liste[i+1:i+15]))/16)
#%% 
#Nombre cumulé hosp
cumul_hosp=[]
for i in range(1,len(liste)): 
    if len(cumul_hosp)>1:
        cumul_hosp.append(liste[i]+cumul_hosp[-1])
    else : 
        cumul_hosp.append(liste[i])

#%%
plt.figure(figsize=(14,6))
plt.title("Nb nv décès / jours")
sns.lineplot(y=df["incid_hosp"],
             x=df2.index,
             label="Nb quotidien décès")
sns.lineplot()
plt.xlabel("jour")
plt.show()
#%%
fig=go.Figure()
fig.add_trace(go.Scatter(y = hosp_m,
                         x = df2.index,
                         name = "Nb nv hosp / jours",
                         line_shape='spline'))
fig.update_layout(title="Nb nv hosp / jours",
                  xaxis_title="jours",
                  yaxis_title="nb hosp")
#fig.write_image("figure.svg", engine="kaleido")
fig.show()
#%%
fig=px.bar(y = hosp_m,
           x = df2.index)
fig.show()

#%%
from sklearn.model_selection import train_test_split
cols_to_use = ["incid_rea"]
X = df[cols_to_use]

#Sélection de la variable à expliquer 
y = df.incid_hosp

# Séparation en train en valid 
X_train, X_valid, y_train, y_valid = train_test_split(X, y,random_state=42)
print("Split done")
input_shape = [X_train.shape[1]]
#%%
from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras import callbacks

model = keras.Sequential([
    layers.Dense(128, activation='relu', input_shape=input_shape),
    layers.Dense(64, activation='relu'),
    layers.Dense(1) 
    ])
model.compile(
    optimizer='adam',
    loss='mae',
    )
early_stopping = callbacks.EarlyStopping(min_delta=0.001,
                                        patience=5,
                                        restore_best_weights=True)

history = model.fit(
    X_train, y_train,
    validation_data=(X_valid, y_valid),
    batch_size=512,
    epochs=50,
    callbacks=[early_stopping]
    )
# history_df = pd.DataFrame(history.history)
# history_df.loc[:, ['loss', 'val_loss']].plot()
# plt.title("loss et val_loss pour le modèle DL 5 avec early stop")
# print("Minimum Validation Loss: {:0.4f}".format(history_df['val_loss'].min()));
# print("finish model DL 5.2")
pred=model.predict(X_valid)
acc=r2_score(y_valid,pred)
print(acc*100)
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

#%%
prediction_mdl=model.predict(np.array(df.incid_rea))#.reshape(-1,1))
predictionXGB=my_model.predict(np.array(df.incid_rea).reshape(-1,1))
#%% 
fig=go.Figure()
fig.add_trace(go.Scatter(y = hosp_m,
                         x = df2.index,
                         name = "Nb nv hosp / jours",
                         line_shape='spline',
                         line=dict(color="red", dash="dot")))
fig.add_trace(go.Scatter(y = predictionXGB,
                         x = df2.index,
                         name = "Nb nv hosp / jours prédiction XGB",
                         mode="lines",
                         line_shape='spline',
                         line=dict(color='green', dash='dot')))
fig.add_trace(go.Scatter(y = prediction_mdl,
                         x = df2.index,
                         name = "Nb nv hosp / jours prédiction DL",
                         mode="lines",
                         line_shape='spline',
                         line=dict(color='blue', dash='dot')))
fig.update_layout(title="Nb nv hosp / jours",
                  xaxis_title="jours",
                  yaxis_title="nb hosp")
fig.show()
#%% 
#Cumul hosp
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
#%%
df_reg=df.copy()
print(df_reg)
df_reg=df_reg.groupby(df['reg'].dt.strftime('%Y-%m-%d'))['incid_hosp']["jour"]

def plot_map(df, col, pal):
    df=int(df[df[col]])
    df = df[df[col]>0]
    fig = px.choropleth(df, locations="Region", locationmode='Regions', 
                        color=col, hover_name="Country/Region", 
                        title=col, hover_data=[col], color_continuous_scale=pal)
#     fig.update_layout(coloraxis_showscale=False)
    fig.show()

plot_map(df,'dep','green')



