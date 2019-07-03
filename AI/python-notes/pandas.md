# Pandas

## Loading Data

Pandas are used to load and manipulate sets of data. The main structure for this is a `Dataframe`:

```py
import pandas as pd

dict = {
    'col1': ['val1', 'val2', 'val3'],
    'col2': ['val4', 'val5', 'val6'],
    'col3': ['val7', 'val8', 'val9']
}

data = pd.DataFrame(dict)
print data

'''
Example Output:
------------------------
    col1    col2    col3
0   val1    val2    val3
1   val4    val5    val6
3   val7    val8    val9
'''
```

Pandas by default will set the indexes of a `DataFrame` to integers. This can be changed if desired.

Pandas can also import `csv` files, which are automatically loaded into a `DataFrame`:

```py
import pandas as pd

data = pd.read_csv('data.csv')
```

## Retrieving Data

Columns can be retrieved by name from a `DataFrame` using square notation, and rows can be retrieved using a similar notation, but with indexes:

```py
import pandas as pd

data = pd.read_csv('data.csv')

# Retrieving Columns
data['col1']           # loads `col1` into a Pandas Series
data[['col1']]         # loads `col1` into a Pandas DataFrame
data[['col1', 'col2']] # loads `col1` and `col2` into a Pandas DataFrame

# Retrieving Rows
data[1:2] # loads the 2 and third rows into a Pandas DataFrame

# Chaining Operations
data[0][['col1']] # loads only `col1` of the first row into a Pandas DataFrame
```

`loc` and `iloc` can be used to make simple to complex data selection operations. `loc` is label based, meaning that it specifies selections based on row and column labels. `iloc` is integer index based, so rows and columns must be specified by integer indexes. Both are still used via square brackets:

```py
import pandas as pd

data = pd.read_csv('data.csv')

data.loc[0]            # the first row of data
data.iloc['col1']      # the values of `col1`
data.iloc[1:3, :-1]    # rows 1-3, all columns except for the last
data.iloc[:, 3].values # all rows, just the third column, only the values (a list)
```

**Are iloc and loc any different from just using normal square bracket notation?**
