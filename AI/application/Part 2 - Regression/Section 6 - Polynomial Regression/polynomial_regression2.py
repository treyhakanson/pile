"""Simple implementation of polynomial regression."""
import pandas as pd
import numpy as np
from matplotlib import pyplot as plt
import warnings
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression

warnings.filterwarnings(action="ignore", module="scipy",
                        message="^internal gelsd")

data = pd.read_csv('Position_Salaries.csv')

# does this so that x is a matrix; upper bound is non-inclusive so this matrix
# will only contain column 1
x = data.iloc[:, 1:2].values
y = data.iloc[:, -1].values

# No need to split set into training and test set because the dataset is very
# small
poly_reg = PolynomialFeatures(degree=4)
x_poly = poly_reg.fit_transform(x)
poly_reg.fit(x_poly, y)
x_grid = np.arange(min(x), max(x), 0.1)
x_grid = x_grid.reshape((len(x_grid), 1))
lin_reg = LinearRegression()
lin_reg.fit(x_poly, y)
y_pred = lin_reg.predict(poly_reg.fit_transform(x_grid))

plt.scatter(x, y, color='red')
plt.plot(x_grid, y_pred, color='blue')
plt.title('Salary vs Position')
plt.xlabel('Position')
plt.ylabel('Salary')

salary = lin_reg.predict(poly_reg.fit_transform(6.5))[0]
print('Projected salary for position 6.5: %0.2f' % (salary))

plt.show()
