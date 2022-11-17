# TD2 
## Ex 2: 
Here the program enables the classification of 3 types of plants according to their characteristics.
First of all, we test a modification of the model parameters to test it.
Then we create the validation function which allows us to evaluate the performance of the model by calculating its accuracy of the model. This function has been tested on several examples by changing the parameters. 
Then we perform an external validation. For that we split our dataset into train and test, then we compare the accuracy obtained by the model on the train and the test.

Bonus: 
Test with a too-high min_sample_leaf, we observe that the accuracy of the model on the train and the test sets are very low. 
Indeed, the dataset having only 150 observations, a min_samples_leaf equal to 50 leads to classification problems. We observe that the predictions are either 0 or 2. 
We also notice that in the confusion matrix all the values 1 have been predicted as being both. \nThis is explained by the fact that the min_samples_leaf is too low and does not allow the creation of graphs of high enough depth to make a good classification.

## Ex 3:
Here, we try to predict a value from a modified sin function. To begin we create the data by applying for each value of X the calculations to obtain each value of y. 
Then we create the decision tree regressor model that we make with the data of X and y. Thanks to this, we obtain a model that allows us to predict the values of y according to the values of X. 
We then make a plot to compare the true values of y with the values predicted by the model.
We then repeat these steps but using a random forest regressor model, we obtain an R^2 on the test dataset of 0.966. 

Bonus: 
To improve this result we tested setting up an XGBoost Regressor model for which we maximized the squared error, set the learning rate to 0.2, the max depth to 20, and the number of estimators to 1000. We obtain an R^2 of 0.986 on the test dataset.