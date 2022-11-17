# Ex 3 Regression tree with cos data set
import numpy as np
from sklearn.tree import DecisionTreeRegressor
import matplotlib.pyplot as plt

## Create the data set
rng = np.random.RandomState(1)
X = np.sort(5 * rng.rand(200, 1), axis=0)
y = np.sin(X).ravel()
y[::1] += 0.2 * (0.5 - rng.rand(200))

## Create the model 
max_prof = 3 
reg = DecisionTreeRegressor(max_depth=max_prof)

## Fit the model
reg.fit(X, y)

## Predict values with the model
X_test = np.arange(0.0, 5.0, 0.01)[:, np.newaxis]
y_test = reg.predict(X_test)

## Plot the results
plt.figure()
plt.scatter(X, y, s=20, c="darkorange", label="data")
plt.plot(X_test, y_test, color="cornflowerblue", label=f"max_depth={max_prof}", linewidth=2)
plt.xlabel("data")
plt.ylabel("target")
plt.title("Decision Tree Regression")
plt.legend()
plt.show()

## Random forest regression 
### Import libraries
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score 

### Create the forest model 
max_depth = 3
forest = RandomForestRegressor(max_depth=max_depth)

### Split the data to train and test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=42)

### Fit the model
forest = forest.fit(X_train, y_train)

### Predict values with the model
y_pred_test = forest.predict(X_test)
y_pred_train = forest.predict(X_train)

print(f"The r2 score for the training data with the RandomForestRegressor model : {round(r2_score(y_train,y_pred_train),3)}")
print(f"The r2 score for the test data with the RandomForestRegressor model {round(r2_score(y_test,y_pred_test),3)}")

## Bonus: test with XGBoost Regressor
### Import libraries
import xgboost as xgb
import warnings 
warnings.filterwarnings('ignore') # to avoid warnings message caused by deprecated utilisation of pandas in xgboost function

### Create the model
xgb_reg = xgb.XGBRegressor(
    objective ='reg:squarederror', 
    colsample_bytree = 0.4, learning_rate = 0.2,
    max_depth = 20, alpha = 1,
    n_estimators = 1000,eta=0.1
    )

### Fit the model
xgb_reg.fit(X_train,y_train)

### Predict values with the model
preds_train = xgb_reg.predict(X_train)
preds_test = xgb_reg.predict(X_test)

print(f"The r2 score for the training data with the XGBoost Regressor model : {round(r2_score(y_train,preds_train),3)}")
print(f"The r2 score for the test data with the XGBoost Regressor model : {round(r2_score(y_test,preds_test),3)}")