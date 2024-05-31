# Importing the libraries
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

# Importing the dataset
dataset = pd.read_csv('framingham.csv')

print(dataset.head())
print(dataset.shape)
print()
print(dataset.dtypes)
print()

# Missing data per category
total = dataset.isnull().sum()
null = pd.concat([total], axis=1, keys=["Total Null Values"])
missing_data = null[null['Total Null Values']>0]
print(missing_data)
print()

# Total percentage of missing data
total_percentage = (total.sum()/dataset.shape[0]) * 100
print(f'The total percentage of missing data is {round(total_percentage,2)}%')
print()

# Deleting the education column and changing the original dataset object as inplace is set to True
dataset.drop(['education'], axis=1, inplace=True)

# Deleting all rows that contain null values
dataset.dropna(axis=0, how='any', inplace=True)

print(dataset.head(30))
print(dataset.shape)
print()

# Data distribution histogram
fig = plt.figure(figsize=(15, 20))
ax = fig.gca()
dataset.hist(ax=ax)
plt.savefig("plots/analysis/dataDistribution.png")

# Heatmap
plt.figure(figsize=(15,8))
sns.heatmap(dataset.corr(), annot = True)
plt.savefig("plots/analysis/Heatmap.png")

# Comparison between the people the number of people that are CHD positive and CHD negatinve
plt.figure(figsize=(15, 8))
sns.countplot(x='TenYearCHD', data=dataset, palette="flare")
plt.savefig("plots/analysis/CHD_comparison.png")

cases = dataset.TenYearCHD.value_counts()
print("Number of negative cases : ", cases[0])
print("Number of positive cases : ", cases[1])
print()
