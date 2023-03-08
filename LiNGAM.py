import numpy as np
import pandas as pd
import lingam
import networkx as nx
import matplotlib.pyplot as plt
import statsmodels.api as sm
from scipy import stats
from sklearn.preprocessing import MinMaxScaler

pip install lingam

#Load data
data = pd.read_csv('E:/Lectures/Computational Statistics/Assignments/a1_data.csv')

#To normalize the data
# Create an instance of MinMaxScaler
scaler = MinMaxScaler()
# Fit and transform the data
normalized_data = scaler.fit_transform(data)
data_f = pd.DataFrame(normalized_data)

# Create a Q-Q plot against the normal distribution
sm.qqplot(data_f, line='s')
plt.title('Q-Q Plot of Data against Normal Distribution')
plt.show()

# calculate Pearson correlation coefficients between all pairs of variables
corr_matrix = data_f.corr()
# display the correlation matrix
print(corr_matrix)

#To check whether a given distribution is non-Gaussian in Python we can use Shapiro-Wilk test
statistic, pvalue = stats.shapiro(data_f)
alpha = 0.05
if pvalue > alpha:
    print("The data is Gaussian (fail to reject H0)")
else:
    print("The data is not Gaussian (reject H0)")

# run LiNGAM procedure
model = lingam.DirectLiNGAM()

# Create an instance of MinMaxScaler
scaler = MinMaxScaler()

# Fit and transform the data
normalized_data = scaler.fit_transform(data_f)

# normalized_data is now a numpy array with the normalized data

model.fit(data_f)

print(model.causal_order_)
print(model.adjacency_matrix_)


# plot DAG
graph = nx.DiGraph(model.adjacency_matrix_)
nx.draw_shell(graph, with_labels=True)