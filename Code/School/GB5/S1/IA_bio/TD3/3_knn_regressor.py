## Import libraries
import numpy as np 
from random import uniform
from math import pi
from sklearn.neighbors import KNeighborsRegressor
import matplotlib.pyplot as plt

## Generate data
sample = 5000 
X = sorted([uniform(0,6*pi) for i in range(sample)])
Y = [np.sin(x)+uniform(-0.3,0.3) for x in X]

## Create the knn regressor
neigh = KNeighborsRegressor(n_neighbors=5)

## Fit the model
neigh.fit(np.array(sorted(X)).reshape(-1,1), np.array(Y).reshape(-1,1)) # reshape(-1,1) is used to convert the array to a column vector

## Create test data (number of point = 1/4 of the training data)
X_test = sorted([uniform(0,6*pi) for i in range(int(sample/4))])

## Plot the results 
plt.figure(figsize=(10,5))
plt.plot(X,Y)
plt.plot(X_test, neigh.predict(np.array(X_test).reshape(-1,1)))
plt.legend(['Data', 'Prediction'])
plt.xlabel('x')
plt.ylabel('y')
plt.title('Prediction of the sin function with a KNN regressor and training set with uniform noise')
plt.show()

## Bonus 
### The following code is used to plot the prediction for different values of k
### Here we used MSE as a metric to evaluate the performance of the model
def eval_knn(k):
    X = sorted([uniform(0,6*pi) for i in range(5000)])
    Y = [np.sin(x)+uniform(-0.3,0.3) for x in X]
    MSE = []
    k_value = []
    for i in range(1,k) : 
        neigh = KNeighborsRegressor(n_neighbors=i)
        neigh.fit(np.array(sorted(X)).reshape(-1,1), np.array(Y).reshape(-1,1))
        y_pred = neigh.predict(np.array(X).reshape(-1,1))
        k_value.append(i)
        MSE.append(np.mean((y_pred - Y)**2))
    plt.plot(k_value, MSE, color = 'red')
    plt.xlabel('k')
    plt.ylabel('MSE')
    plt.title('MSE in function of k neibors used in KNN')
    plt.show()

eval_knn(15)