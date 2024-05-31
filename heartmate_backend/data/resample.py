# Importing the libraries
import csv
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from imblearn.pipeline import Pipeline
from imblearn.over_sampling import SMOTENC
from imblearn.under_sampling import RandomUnderSampler

# Importing the dataset
dataset = pd.read_csv('framingham.csv')
print(dataset.shape)
print()

# Deleting the education column and changing the original dataset object as inplace is set to True
dataset.drop(['education'], axis=1, inplace=True)

# Deleting null values
dataset.dropna(axis=0, how='any', inplace=True)
print(dataset.shape)
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
print(dataset.head(10))
print(dataset.shape)
print()

# Checking balance of target variable
plt.figure(figsize=(15, 8))
sns.countplot(x='TenYearCHD', data=dataset, palette="flare")
plt.savefig("plots/resample/balance-before.png")

cases = dataset.TenYearCHD.value_counts()
print("Number of negative cases before resampling : " + str(cases[0]))
print("Number of positive cases before resampling : " + str(cases[1]))
print()

# Separating independent and target columns
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, -1].values

# Manually combining SMOTENC and Random underSampling to balance the dataset
over = SMOTENC(categorical_features=[2, 5, 6, 8], sampling_strategy=0.26)
under = RandomUnderSampler(sampling_strategy=0.9)
pipeline = Pipeline(steps=[('o', over), ('u', under)])
X_resampled, y_resampled = pipeline.fit_resample(X, y)

print(X_resampled)
print(y_resampled)
print()

num_zeros = 0
num_ones = 0

# Counting the number of positive and negative cases after resampling
for i in range(len(y_resampled)):
    if y_resampled[i] == 0:
        num_zeros += 1
    else:
        num_ones += 1
print("Number of negative cases after resampling : ", num_zeros)
print("Number of positive cases after resampling : ", num_ones)
print()

# writing resampled data to CSV

# field names
fields = ['age', 'sysBP', 'prevalentHyp', 'diaBP', 'glucose', 'male', 'diabetes', 'totChol', 'BPMeds', 'BMI', 'TenYearCHD']

row = []
rows = []

for i in range(len(X_resampled)):
    row = list(X_resampled[i])
    row.append(int(y_resampled[i]))
    rows.append(row)

# name of csv file
filename = "resampled_framingham.csv"

# writing to csv file
with open(filename, 'w', newline='') as csvfile:
    # creating a csv writer object
    csvwriter = csv.writer(csvfile)

    # writing the fields
    csvwriter.writerow(fields)

    # writing the data rows
    csvwriter.writerows(rows)

resampled_dataset = pd.read_csv('resampled_framingham.csv')
print(resampled_dataset.head())
print(resampled_dataset.shape)

# Checking balance of target variable
plt.figure(figsize=(15, 8))
sns.countplot(x='TenYearCHD', data=resampled_dataset, palette="flare")
plt.savefig("plots/resample/balance-after.png")
