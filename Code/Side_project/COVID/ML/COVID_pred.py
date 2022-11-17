#%%
import matplotlib.pyplot as plt
# %matplotlib inline
import numpy as np
from sklearn.metrics import mean_squared_error
import plotly.graph_objects as go
import plotly.io as pio
import pandas as pd 
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression

pio.renderers.default='browser'
#%%
df=pd.read_csv("C:/Users/Tom/Desktop/Projet/Python/COVID/Data_incidence.csv",
               sep=";",
               decimal=",")
df_cum=df.copy() 
df['jour'] = pd.to_datetime(df['jour'])#Considéré date comme date
Ser=df.groupby(df['jour'].dt.strftime('%Y%m%d'))['incid_hosp'].sum() #somme pur chaque date de la valeur de hosp
df2=pd.DataFrame(Ser)
df2=df2.sort_index(ascending=True)
#%% 
#Nombre cumulé hosp
liste=list(df2["incid_hosp"])
cumul_hosp=[]
for i in range(1,len(liste)): 
    if len(cumul_hosp)>1:
        cumul_hosp.append(liste[i]+cumul_hosp[-1])
    else : 
        cumul_hosp.append(liste[i])
#%%
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
#Setup
df_cum["incid_hosp"]=df_cum["incid_hosp"].cumsum()

#df2["incid_hosp"]=df2["incid_hosp"].cumsum()
#df2.index=df2.index.values.astype('datetime64[s]')
#%%
# Prédiction linéaire
train_ml=df_cum.iloc[:int(df_cum.shape[0]*0.95)]
valid_ml=df_cum.iloc[int(df_cum.shape[0]*0.95):]
model_scores=[]
print(train_ml["incid_hosp"])
lin_reg=LinearRegression(normalize=True)
lin_reg.fit(np.array(train_ml.index).reshape(-1,1),np.array(train_ml["incid_hosp"]).reshape(-1,1))

prediction_valid_linreg=lin_reg.predict(np.array(valid_ml.index).reshape(-1,1))

model_scores.append(np.sqrt(mean_squared_error(valid_ml["incid_hosp"],prediction_valid_linreg)))
print("Root Mean Square Error for Linear Regression: ",np.sqrt(mean_squared_error(valid_ml["incid_hosp"],prediction_valid_linreg)))

#%%
# prédiction polynomiale 
poly = PolynomialFeatures(degree = 8)
train_poly=poly.fit_transform(np.array(train_ml.index).reshape(-1,1))
valid_poly=poly.fit_transform(np.array(valid_ml.index).reshape(-1,1))
y=train_ml["incid_hosp"]

linreg=LinearRegression(normalize=True)
linreg.fit(train_poly,y)

prediction_poly=linreg.predict(valid_poly)
rmse_poly=np.sqrt(mean_squared_error(valid_ml["incid_hosp"],prediction_poly))
model_scores.append(rmse_poly)
print("Root Mean Squared Error for Polynomial Regression: ",rmse_poly)

comp_data=poly.fit_transform(np.array(df_cum.index).reshape(-1,1))
plt.figure(figsize=(11,6))
predictions_poly=linreg.predict(comp_data)

#%%
plt.figure(figsize=(11,6))
prediction_linreg=lin_reg.predict(np.array(df_cum.index).reshape(-1,1))
linreg_output=[]
for i in range(prediction_linreg.shape[0]):
    linreg_output.append(prediction_linreg[i][0])

fig=go.Figure()
fig.add_trace(go.Scatter(x=df_cum.index, y=df_cum["incid_hosp"],
                    mode='lines+markers',name="Train Data for Confirmed Cases"))
fig.add_trace(go.Scatter(x=df_cum.index, y=linreg_output,
                    mode='lines',name="Linear Regression Best Fit Line",
                    line=dict(color='red', dash='dot')))
fig.add_trace(go.Scatter(x=df_cum.index, y=predictions_poly,
                    mode='lines',name="Polynomial Regression Best Fit",
                    line=dict(color='green', dash='dot')))
fig.update_layout(title="Confirmed Cases Linear Regression Prediction",
                 xaxis_title="Date",yaxis_title="Confirmed Cases",legend=dict(x=0,y=1,traceorder="normal"))
fig.show()
#%%

