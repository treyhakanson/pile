# sklearn

## Data Preprocessing

`sklearn` can be used to preprocess data, such as filling out empty columns:

```py
from sklearn.preprocessing import Imputer

'''
`missing_values`: values to replace, which here is `NaN`.

`strategy`: strategy for replacement, which here is the mean. mean is the default; adding here for clarity. Other options are median and most_frequent (mode).

`axis`: what axis to implement the strategy across; here it is 0, which represents the column. 1 would be the rows, which is typically not sensible.
'''
imp = Imputer(missing_values='NaN', strategy='mean', axis=0)

x = [
    ['val1', 2, 'NaN', 4],
    ['val1', 2, 3, 'NaN']
]
imp = imp.fit(x[:, 2:4]) # fit values is columns 3 and 4. (2 - 4 because the upper bound is excluded, and indexing starts at 0)
x[:, 2:4] = imp.transform(x[:, 2:4])

# This seems horribly ugly; is this correct? Yep, non of these methods mutate in-place
```

Categorical data is data that is classified into categories; if these categories are represented by strings, then they need to be encoded so that they can be handled mathematically:

```py
from sklearn.preprocessing import LabelEncoder

labelencoder_x = LabelEncoder()
x[:, 0] = labelencoder_x.fit_transform(x[:, 0]) # encoder first columns, all rows of matrix x
```

After encoding categorical data in this most basic manner, the strings will be represented by integers. Must be careful with this method though, because machine learning algorithms will take a higher value as having a higher weight, where in actuality this is very infrequently the case with categorical values. For example, if the data was a gender, it would be wrong to assign a higher weight to female than male or vice versa because it is irrelevant. However, this does work in some cases, such as if the value was something like small, medium, large, etc. To prevent this, can use "Dummy Encoding", which means that each category will be broken into its on column and a binary value will be used:

**Original Data**
| Country |
|:-------:|
| France  |
| Germany |
|  Spain  |
| Germany |

**Integer Encoded Data**
| Country |
|:-------:|
|    0    |
|    1    |
|    2    |
|    1    |

**Dummy Encoded Data**
| France | Germany | Spain |
|:------:|:-------:|:-----:|
|   1    |    0    |   0   |
|   0    |    1    |   0   |
|   0    |    0    |   1   |
|   0    |    1    |   0   |

To implement dummy encoding:

```py
from sklearn.preprocessing import LabelEncoder, OneHotEncoder

# Label encode first, because OneHotEncoder only works with numerical values
le_x = LabelEncoder()
x[:, 0] = le_x.fit_transform(x[:, 0])

# "Hot Encode" the categorical column to spread it into multiple "Dummy Encoded" columns
ohe = OneHotEncoder(categorical_features = [0]) # the first column is the categorical feature
x = ohe.fit_transform(x).toarray()
```

Data that is binary does not need to be dummy encoded (ex: yes, no)

It is required to separate training and test sets of data to prevent overfitting to the training data, which can be done via the `cross_validation` library of `sklearn`:

**IMPORTANT: `cross_validation` will be deprecated in favor of `model_selection`, which will contain all of the same features**

```py
from sklearn.cross_validation import train_test_split

# `test_size`: the fraction of the total set to be used as test data
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size = 0.2)
```

Feature scaling can also be done by `sklearn`:

```py
from sklearn.preprocessing import StandardScalar

ss_x = StandardScalar()

'''
Notice the test and training sets are handled differently; the scalar is fit
transformed to the training data so that when the test data is transformed, it
will receive the same scaling, or "fit". Basically, calling fit transform
gives the `StandardScalar` object a scale to work with based on the input data,
and this scale will be applied to any other data that is transformed using the
`StandardScalar`. Keep in mind that invoking `fit_transform` again will reset
the scale.
'''
x_train = ss_x.fit_transform(x_train)
x_test = ss_x.transform(x_test)
```

It is up for debate whether or not dummy values should be scaled. It shouldn't make or break the model either way.

Dependent features do not need to be feature scaled when they are categorical. For a regression problem, the feature will need to be scaled.
