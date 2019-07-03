"""Simple linear regression over salary data."""
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from matplotlib import pyplot as plt

data = pd.read_csv('math.csv')
x = data.iloc[:, :-1].values
y = data.iloc[:, 1].values

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2,
                                                    random_state=0)

"""
The simple linear regression model will take care of feature scaling for you,
so it is not necessary to scale the x and y vectors
"""
regressor = LinearRegression()
regressor.fit(x_train, y_train)

# Predicted and actual results
y_pred_train = regressor.predict(x_train)
y_pred_test = regressor.predict(x_train)

# Training
plt.title('Years Experience vs Salary (Training)')
plt.xlabel('Experience (Years)')
plt.ylabel('Salary (USD)')
plt.scatter(x_train, y_train, color='red')
plt.plot(x_train, y_pred_train, color='blue')
plt.show()

# Test
plt.title('Years Experience vs Salary (Test)')
plt.xlabel('Experience (years)')
plt.ylabel('Salary (USD)')
plt.scatter(x_test, y_test, color='red')
plt.plot(x_test, y_pred_train, color='blue')  # Line doesn't change from prev
plt.show()
