#IMPORTING LIBRARIES
import pickle
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from numpy import mean
from numpy import std
from sklearn.metrics import accuracy_score, confusion_matrix
from sklearn.model_selection import RepeatedStratifiedKFold
from sklearn.ensemble import RandomForestClassifier
import sklearn
import sklearn.metrics as metrics
from sklearn.preprocessing import StandardScaler, MinMaxScaler

# IMPORTING DATASET
dataset = pd.read_csv('../../data/resampled_framingham.csv')
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, -1].values

# Variables to store best and worst models and their details
best_acc = 0
worst_acc = 100
bestModel_data = {}
worstModel_data = {}
bestModel = None
worstModel = None

# List to store the accuracies of the trained models
scores = []

# Defining RepeatedStratifiedKFold
cv = RepeatedStratifiedKFold(n_splits=5, n_repeats=10, random_state=1)

# Separating train and test sets using StratifiedKFold
for train_index, test_index in cv.split(X, y):
    X_train, X_test = X[train_index], X[test_index]
    y_train, y_test = y[train_index], y[test_index]

    # FEATURE SCALING
    sc = MinMaxScaler()
    X_train = sc.fit_transform(X_train)
    X_test = sc.transform(X_test)

    # Training the model using the selected classifier
    classifier = RandomForestClassifier(criterion='entropy', random_state=0)
    classifier.fit(X_train, y_train)
    prediction = classifier.predict(X_test)

    # Accuracy of the trained model
    accuracy = accuracy_score(y_test, prediction)
    scores.append(accuracy)

    # If the accuracy of the trained model is greater than the current highest accuracy
    if accuracy > best_acc:
        best_acc = accuracy
        bestModel = classifier
        bestModel_data["X_train"] = X_train
        bestModel_data["X_test"] = X_test
        bestModel_data["y_train"] = y_train
        bestModel_data["y_test"] = y_test
        bestModel_data["scaler"] = sc
        bestModel_data["prediction"] = prediction

    # Else # If the accuracy of the trained model is less than the current lowest accuracy
    elif accuracy < worst_acc:
        worst_acc = accuracy
        worstModel = classifier
        worstModel_data["X_train"] = X_train
        worstModel_data["X_test"] = X_test
        worstModel_data["y_train"] = y_train
        worstModel_data["y_test"] = y_test
        worstModel_data["scaler"] = sc
        worstModel_data["prediction"] = prediction

# Performance of the model
print('Accuracy : %.3f (%.3f)' % (mean(scores), std(scores)))
print('Highest accuracy : %.3f ' % (best_acc))
print('Lowest accuracy : %.3f ' % (worst_acc))

# Classification report of the beat and the worst models achieved
file = open("report.txt", "w")

file.write("Best Model\n")
file.write(sklearn.metrics.classification_report(bestModel_data["y_test"], bestModel_data["prediction"]))

file.write("\nWorst Model\n")
file.write(sklearn.metrics.classification_report(worstModel_data["y_test"], worstModel_data["prediction"]))

file.close()

# Confusion matrix for the best model achieved
cm = confusion_matrix(bestModel_data['y_test'], bestModel_data['prediction'])
conf_matrix=pd.DataFrame(data=cm,columns=['Predicted:0','Predicted:1'],index=['Actual:0','Actual:1'])
plt.figure(figsize = (8,5))
sns.heatmap(conf_matrix, annot=True,fmt='d',cmap="Blues")
plt.savefig("plots/confusion-matrix.png")

# ROC-curve for the best model achieved
metrics.plot_roc_curve(bestModel, bestModel_data['X_test'], bestModel_data['y_test'])
plt.plot([0, 1], [0, 1], color='darkorange', lw=2, linestyle='--')
plt.savefig("plots/roc-curve.png")

# Saving the best model achieved as a pickle file
with open('randomForest.pickle', 'wb') as handle:
    pickle.dump(bestModel, handle, protocol=pickle.HIGHEST_PROTOCOL)
    print('Model train success')

# Storing the scalar relevant to the best model as a pickle file
with open('scaler.pickle', 'wb') as f:
    pickle.dump(bestModel_data["scaler"], f, protocol=pickle.HIGHEST_PROTOCOL)
    print('scaler save success')