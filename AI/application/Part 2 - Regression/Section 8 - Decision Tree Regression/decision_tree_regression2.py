"""Decision Tree Regression (SVR) Model."""
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from sklearn.tree import DecisionTreeRegressor

data = pd.read_csv('Position_Salaries.csv')
x = data.iloc[:, 1:2].values
y = data.iloc[:, -1:].values

regressor = DecisionTreeRegressor()
regressor.fit(x, y)

x_grid = np.arange(min(x), max(x), 0.01)
x_grid = x_grid.reshape((len(x_grid), 1))
plt.scatter(x, y, color='red')
plt.plot(x_grid, regressor.predict(x_grid), color='blue')
plt.title('Position vs Salaries (Decision Tree)')
plt.xlabel('Position')
plt.ylabel('Salary (USD)')
plt.show()

y_pred = regressor.predict(6.5)
print('Projected salary at level 6.5: $%.2f' % (y_pred))
