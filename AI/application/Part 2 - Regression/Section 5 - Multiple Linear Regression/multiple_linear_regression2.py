"""Multiple linear regression for venture capital data."""
import pandas as pd
import numpy as np
import statsmodels.formula.api as sm
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

data = pd.read_csv('50_Startups.csv')

x = data.iloc[:, :-1].values
y = data.iloc[:, 4].values

le = LabelEncoder()
x[:, -1] = le.fit_transform(x[:, -1])

ohe = OneHotEncoder(categorical_features=[-1])
x = ohe.fit_transform(x).toarray()

"""
Important to ensure the dummy variable trap is avoided by removing one of the
dummy columns; most libraries will do this for you. For example,
`LinearRegression` will handle it, but the OLS regressor will not. To be
safe, its always fine to just drop it manually.
"""
x = x[:, 1:]

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2,
                                                    random_state=0)

regressor = LinearRegression()
regressor.fit(x_train, y_train)

y_pred = regressor.predict(x_test)

"""
Using Backward Elimination to Determine What Variables are Needed
------------------------------------------------------------------------------

The statsmodels library requires an extra column of 1s to be added to the data
in this case because since this in a linear regression, there needs to be a
constant b0. The model will not know this unless the column is added. Strange,
just a quirk of the library.
"""
x = np.append(arr=np.ones((len(x), 1)).astype(int), values=x, axis=1)

# The set of optimal features (only those that have statistical significance)
x_opt = x[:, :-1]
# exog does not include the intercept by default, which is why we need the
# column of 1s
regressor_ols = sm.OLS(endog=y, exog=x_opt).fit()


def trim_columns(x, y):
    """Remove the least statistically significant column from x.

    Calculates the statistical significance of all columns in x as they
    correlate to y, and removes the least significant column. Outputs the new
    data with the column removed.

    """
    max_pval = 0.05
    max_idx = -1
    regressor_ols = sm.OLS(endog=y, exog=x).fit()
    for (i, pval) in enumerate(regressor_ols.pvalues):
        if pval > max_pval:
            max_pval = pval
            max_idx = i
    if max_idx != -1:
        x = np.delete(x, max_idx, 1)
    return x


prev_len = -1
while len(x_opt[0]) != prev_len:
    prev_len = len(x_opt[0])
    x_opt = trim_columns(x_opt, y)

regressor_ols = sm.OLS(endog=y, exog=x_opt).fit()
print(regressor_ols.summary())
