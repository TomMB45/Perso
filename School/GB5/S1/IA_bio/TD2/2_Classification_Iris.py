# Iris classification with Decision Tree
from sklearn.datasets import load_iris
from sklearn import tree
from sklearn.metrics import accuracy_score
import sklearn.model_selection as ms
import sklearn.metrics as sklm

iris = load_iris()

## 1. change the param value 
clf1 = tree.DecisionTreeClassifier(max_depth=50,min_samples_leaf=20)
clf1 = clf1.fit(iris.data, iris.target)
print("Question 1 : \n")
print(f"Prediction on the iris data : \n{clf1.predict(iris.data[:1, :])}")
print(f"Predict class probability on the iris data : \n{clf1.predict_proba(iris.data[:1, :])}")

## 2. Create the evaluation function
def validation(max_depth,min_samples_leaf,X_train, y_train, X_test, y_test):
    clf = tree.DecisionTreeClassifier(max_depth=max_depth,min_samples_leaf=min_samples_leaf)
    clf = clf.fit(X_train, y_train)
    y_pred = clf.predict(X_test)
    return accuracy_score(y_test,y_pred)

## 3. Usage of function 
### with the train data 
print("Question 3 : \n")
print(f"Accuracy score on the train data : {validation(50,20,iris.data,iris.target,iris.data,iris.target)}")

### With modification of parameters
max_depth, min_samples_leaf = 200, 100
print(f"Accuracy score on the train data with max_depth={max_depth} and min_samples_leaf={min_samples_leaf} : {validation(max_depth,min_samples_leaf,iris.data,iris.target,iris.data,iris.target)}")

max_depth, min_samples_leaf = 1, 1
print(f"Accuracy score on the train data with max_depth={max_depth} and min_samples_leaf={min_samples_leaf} : {validation(max_depth,min_samples_leaf,iris.data,iris.target,iris.data,iris.target)}")

## 4. external validation
print("Question 4 : \n")
max_depth=20
min_samples_leaf=10

X_train, X_test, y_train, y_test = ms.train_test_split(iris.data, iris.target, test_size=0.3, random_state=0)
clf1 = tree.DecisionTreeClassifier(max_depth=max_depth,min_samples_leaf=min_samples_leaf)
clf1 = clf1.fit(X_train, y_train)
print(f"The confusion matrix for the test values is : \n{sklm.confusion_matrix(y_test, clf1.predict(X_test))}")
print(f"\nThe prediction on the test data set is  : {clf1.predict(X_test)}")

y_pred_train = clf1.predict(X_train)
y_pred_test = clf1.predict(X_test)

print(f"\nAccuracy for the training data : {round(accuracy_score(y_train,y_pred_train),3)}")
print(f"\nAccuracy for the test data : {round(accuracy_score(y_test,y_pred_test),3)}")

print("\n\nTest model parameters : \n")
print("With a very high high min_sample_leaf value \n")
max_depth=None
min_samples_leaf=50

X_train_param, X_test_param, y_train_param, y_test_param = ms.train_test_split(iris.data, iris.target, test_size=0.3, random_state=0)
clf1 = tree.DecisionTreeClassifier(max_depth=max_depth,min_samples_leaf=min_samples_leaf)
clf1 = clf1.fit(X_train_param, y_train_param)
print(f"The confusion matrix for the test values is : \n{sklm.confusion_matrix(y_test_param, clf1.predict(X_test_param))}")
print(f"\nThe prediction on the test data set is  : {clf1.predict(X_test_param)}")

y_pred_train = clf1.predict(X_train)
y_pred_test = clf1.predict(X_test)

print(f"\nAccuracy for the training data : {round(accuracy_score(y_train,y_pred_train),3)}")
print(f"\nAccuracy for the test data : {round(accuracy_score(y_test,y_pred_test),3)}")

print("Here we observe that the accuracy of the model on the train and on the test sets are very low. \nIndeed, the dataset having only 150 observations, a min_samples_leaf equal to 50 leads to classification problems. We observe that the predictions are either 0 or 2. We also notice that in the confusion matrix all the values 1 have been predicted as being both. \nThis is explained by the fact that the min_samples_leaf is too low and does not allow the creation of graphs of high enough depth to make a good classification.") 