# Importing the libraries
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.feature_selection import SelectKBest, f_classif

# Importing the dataset
dataset = pd.read_csv('framingham.csv')
print(dataset.shape)
print()

# Deleting the education column and changing the original dataset object as inplace is set to True
dataset.drop(['education'], axis=1, inplace=True)
# Deleting null values
dataset.dropna(axis=0, how='any', inplace=True)

print(dataset.head())
print(dataset.shape)
print()

# Separating independent and target columns
X = dataset.iloc[:, :-1]
y = dataset.iloc[:, -1]

# Feature Selection using SelectKBest class
features = SelectKBest(score_func=f_classif, k=14)
fit = features.fit(X, y)
dfscores = pd.DataFrame(fit.scores_)
dfcolumns = pd.DataFrame(X.columns)

# Printing the 10 most important features
featureScores = pd.concat([dfcolumns, dfscores], axis=1)
featureScores.columns = ['Specs', 'Score']
print(featureScores.nlargest(14, 'Score'))
print()

# Plotting feature importance in descending order
plt.figure(figsize=(20, 10))
sns.barplot(x='Specs', y='Score', data=featureScores, palette="rocket",order=featureScores.sort_values('Score', ascending=False).Specs)
plt.box(False)
plt.title('Feature importance', fontsize=16)
plt.xlabel('\n Features', fontsize=14)
plt.ylabel('Importance \n', fontsize=14)
plt.xticks(fontsize=12)
plt.yticks(fontsize=12)
plt.savefig("plots/featureSelection/feature_importance.png")

# Choosing only top eight features to be sued moving forward
top_features = featureScores.sort_values(by='Score', ascending=False)["Specs"].tolist()[:11]
print(top_features)
print()

# creating new dataframe with only the selected features
dataset = dataset[['age',
                   'sysBP',
                   'prevalentHyp',
                   'diaBP',
                   'glucose',
                   'male',
                   'diabetes',
                   'totChol',
                   'BPMeds',
                   'BMI',
                   'TenYearCHD']]

# Print new dataset
print(dataset.head(10))
print(dataset.shape)
print()

# New heatmap
plt.figure(figsize=(15, 8))
sns.heatmap(dataset.corr(), annot=True)
plt.savefig("plots/featureSelection/dataset-correlation.png")
