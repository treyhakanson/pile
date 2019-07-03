"""Support Vector Regression (SVR) Model."""
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from sklearn.svm import SVR
from sklearn.preprocessing import StandardScaler

data = pd.read_csv('Position_Salaries.csv')
x = data.iloc[:, 1:2].values
y = data.iloc[:, -1:].values

# SVR does not scale features automatically, must do manually
ss_x = StandardScaler()
ss_y = StandardScaler()
x = ss_x.fit_transform(x)
y = ss_y.fit_transform(y)

# Using a guassian kernel (rbf)
regressor = SVR(kernel='rbf')
regressor.fit(x, y)

x_grid = np.arange(min(x), max(x), 0.1)
x_grid = x_grid.reshape((len(x_grid), 1))
plt.scatter(x, y, color='red')
plt.plot(x_grid, regressor.predict(x_grid), color='blue')
plt.title('Position vs Salaries (SVR)')
plt.xlabel('Position')
plt.ylabel('Salary (USD)')
plt.show()

x_test = ss_x.transform([[6.5]])
y_pred_scaled = regressor.predict(x_test)
y_pred = ss_y.inverse_transform(y_pred_scaled)
print('Projected salary at level 6.5: $%.2f' % (y_pred))
