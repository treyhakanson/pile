# R Basics

## General

To set the working directory:

```R
setwd('/path/to/dir')
```

Control flow:

```R
# will return `tr` if condition is true, and `fl` if false
ifelse(condition, tr, fl)
```

Selections from a dataset:

```R
data$colName # Selects `colName` from the dataset
```

Basics:

```R
# an vector
c('val1', 'val2', 'val3')

# outputs an overview of `var`
summary(var)
```

**R indexes start at 1 not zero!**

## Importing Data

To import data (relative to working directory):

```R
data = read.csv('data.csv')
```

To fill missing data:

```R
data = read.csv('data.csv')

# replaces `na` columns with the average of the column
data$col = ifelse(is.na(data$col),
                  ave(data$col, FUN = function(x) mean(x, na.rm = TRUE)),
                  data$col)

# Figure out what the hell the above syntax is; what is ave? What is na.rm?
```

## Scaling Data

To scale data uniformly:

```R
training_set = scale(training_set)
test_set = scale(test_set)
```

`scale` requires the features to be numerical. Keep in mind that factored categorical string features are not numerical even if the input labels where numerical. These must be ignored when scaling.

## Packages

Run this function from within a script or the R console to install a package:

```R
install.packages('<package name>')
```

To include a package:

```R
library(packageName)
```
