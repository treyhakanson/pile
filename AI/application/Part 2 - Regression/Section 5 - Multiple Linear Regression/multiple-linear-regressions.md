# Multiple Linear Regressions

## Overview

A regression based on multiple variables having a linear effect on the dependent variable:

```
y = m_1 * x_1 + m_2 * x_2 + ... + m_n * x_n + b
```

Multiple linear regression, as with linear regression, comes with a few assumptions:

1. Linearity
2. Homoscedasticity
    - This assumption means that the variance around the regression line is the same for all values of the predictor variable
3. Multivariate Normality
    - The data needs to have an approximately Guassian distribution
4. Independence of Errors
5. Lack of Multicollinearity (Collinearity)
    - Occurs when the linear model of one regression in a multiple regression can be accurately predicted from the other models
    - A multiple regression model with collinear predictors can indicate how well the entire bundle of predictors predicts the outcome variable, but it may not give valid results about any individual predictor, or about which predictors are redundant with respect to others

Keep in mind that for categorical data, only n - 1 of the dummy variable columns need to be used in the model, due to Collinearity. Since each column is essentially boolean, the final column can be assumed exactly from all of the previous columns.

## Building a Model

When constructing a model, the first step is to determine what data actually needs to be configured. There are a few reasons its not always a good idea to include all available data:

1. Garbage in, garbage out: if too many things are included in the model, it can be unpredictable and unreliable
2. One must know how or why the different variables affect each other in order to explain and justify the results. A complex model is not always superior to a simple model.

Method of building a model:

1. "All-in"
    - Throw in all variables
    - Use when prior knowledge is known of the variables, and each one is known to have a clear impact
    - In preparation for backward elimination
2. Backward Elimination (Fastest method)
    1. Select a significance level to stay in the model (eg. SL = 5%)
    2. Fit the full model with all possible predictors
    3. Consider the predictor with the highest P-value, if it's greater than the chosen SL, go to 4, otherwise end (model is complete)
    4. Remove the predictor
    5. Fit the model without this variable and repeat starting at 3
3. Forward Elimination
    1. Select a significance level to enter in the model (eg. SL = 5%)
    2. Fit all simple regression models y ~ x_n, select the one with the lowest P-value
    3. Keep this variable and fit all possible models with one extra predictors added the one(s) you already have
    4. Consider the variable with the lowest P-value; if its less than SL go to 3, otherwise end (model is complete)
4. Bidirectional Elimination
    1. Select a significance level to enter and stay in the model (eg. SL_ENTER = 5%, SL_STAY = 5%). If a variable is not added, end (model is complete)
    2. Perform the next step of the forward selection process (new variable must have P < SL_ENTER)
    3. Perform all steps of backward elimination (variable must have P < SL_STAY to stay)
5. Score Comparison
    1. Select a criterion for goodness of fit
    2. Construct all possible regression models (2^n - 1 total combinations)
    3. Select the model with the best criterion

"Stepwise Regression" is a term commonly used to refer to methods 2-4, and sometimes used just to refer to 4.
