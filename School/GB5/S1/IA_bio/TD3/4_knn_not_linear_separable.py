import numpy as np 
import matplotlib.pyplot as plt
import seaborn as sns
from math import sqrt
from sklearn.neighbors import KNeighborsClassifier
import warnings
warnings.filterwarnings("ignore") ## Ignore warnings from seaborn _decorators.py

## Set a seed for reproducibility
np.random.seed(42)

print("Model without noise")

## Generate non linearly separable data
def non_linearly_separable (a:int,row:int,col:int) : 
    """
    Function to generate non linearly separable data

    Parameters
    ----------
    a : int
        Range of values.
    row : int
        Number of rows.
    col : int
        Number of columns.
    
    Returns
    -------
    X : np.ndarray
        Array of shape (row,col) with uniform values between -a and a.
    y : np.ndarray
        Array of shape (row,1) with values 0 or 1.
        That array correspond to the class of each row from X.
    
    """
    df = np.random.uniform(-a,a,(row,col))
    y = []
    for i in df : 
        dist = sqrt((i[0] - 0)**2 + (i[1] - 0)**2) ## Calcul distance euclidienne entre deux points 
        if dist > 1 and dist < 2 :
            y.append(1)
        else : 
            y.append(2)
    return df, y 

data,y = non_linearly_separable(4,5000,2)

## Plot the data (Check if the function generates non-linearly separable values)
sns.scatterplot(data[:,0],data[:,1],hue=y,palette="Set1")
plt.xlabel("x")
plt.ylabel("y")
plt.title("Data non linearly separable")
plt.show()

## Create the knn classifier (n_neighbors = 8 because it's one of the best value cf. figure "n_neighbors value and accuracy")
model = KNeighborsClassifier(n_neighbors=8)

## Fit the model 
model.fit(data,y)

## Create test data
X_test,Y_test = non_linearly_separable(4,2000,2)

## Predict the class of the test data
y_pred = model.predict(X_test)

## Check the accuracy of the model
def validation(y_pred,Y_test) :
    """
    Function to calculate the accuracy of the model

    Parameters
    ----------
    y_pred : np.ndarray
        Array of shape (row,1) with values 0 or 1.
        That array correspond to the class predicted by the model.
    Y_test : np.ndarray
        Array of shape (row,1) with values 0 or 1.
        That array correspond to the class of each row from X_test.
    
    Returns
    -------
    accuracy : float
        Accuracy of the model.

    """ 
    correct = 0
    for i in range(len(y_pred)) : 
        if y_pred[i] == Y_test[i] : 
            correct += 1
    return correct / len(y_pred)

print(f"Accuracy for test data {validation(y_pred,Y_test)}")

## Get the best value for n_neighbors
def eval_knn(k):
    X_train, y_train = non_linearly_separable(4, 5000, 2)
    X_test, y_test = non_linearly_separable(4, 2000, 2)
    accu = []
    k_value = []
    for i in range(1,k) : 
        neigh = KNeighborsClassifier(n_neighbors=i)
        neigh.fit(X_train,y_train)
        y_pred = neigh.predict(X_test)
        k_value.append(i)
        accu.append(validation(y_pred,y_test))
    plt.plot(k_value, accu, color = 'red')
    plt.xlabel('k')
    plt.ylabel('accuracy')
    plt.title('n_neighbors value and accuracy')
    plt.show()
eval_knn(25)

## Plot the results obtain by the model
sns.scatterplot(X_test[:,0],X_test[:,1],hue=y_pred,palette="Set1")
plt.xlabel("x")
plt.ylabel("y_predict")
plt.title("Prediction of the model")
plt.show()

## Noise 
print("Model with noise")

def noise(a,row,col,noise) : 
    """
    Function to generate non linearly separable data with noise
    
    Parameters
    ----------
    a : int
        Range of values.
    row : int
        Number of rows.
    col : int
        Number of columns.
    noise : float
        Percentage data with noise.
    
    Returns
    -------
    X : np.ndarray
        Array of shape (row,col) with uniform values between -a and a.
    y : np.ndarray
        Array of shape (row,1) with values 0 or 1.
        That array correspond to the class of each row
    """
    df,y = non_linearly_separable(a,row,col)
    for i in range(len(y)) : 
        if np.random.random() < noise : 
            y[i] = np.random.randint(1,3)
    return df, y 

noise_value = 0.1

### Create data with noise
X_train_noise,y_train_noise = noise(4,5000,2,noise_value)

### Create the knn classifier
model = KNeighborsClassifier(n_neighbors=8)

### Fit the model
model.fit(X_train_noise,y_train_noise)

### Create test data
X_test_noise,y_test_noise = non_linearly_separable(4,2000,2)

### Predict the class of the test data
y_pred = model.predict(X_test_noise)

fig,ax = plt.subplots(1,2,figsize=(10,5))
t = sns.scatterplot(X_train_noise[:,0],X_train_noise[:,1],hue=y_train_noise,palette="Set1",ax=ax[0])
p = sns.scatterplot(X_test_noise[:,0],X_test_noise[:,1],hue=y_pred,palette="Set1",ax=ax[1])
t.set_title("Data with noise")
p.set_title(f"Prediction of the model with noised training data (accuracy: {validation(y_pred,y_test_noise)})")
fig.suptitle("KNN with noise")
plt.show()

### Check the accuracy of the model
print(f"Accuracy for test data {validation(y_pred,y_test_noise)}")
print("The value of the accuracy is very close to the accuracy of the model without noise.\nThe KNN classifier seems to be robust to the noise.")
