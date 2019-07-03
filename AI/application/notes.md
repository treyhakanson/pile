# Data Preprocessing

## Filling in Missing Data

A common strategy for filling in missing data is to replace empty values with the mean of the column; it is a dangerous strategy to remove rows due to missing data.

## Feature Scaling

Many machine learning algorithms use Euclidean distance somewhere in their computations. The formula for Euclidean distance is as follows:

```
sqrt((x1 - x2)^2 + (y1 - y2)^2)
```

Even if Euclidean distance is not used, feature scaling is still very useful because it garners faster convergence for learning algorithms.

If the two vectors x and y do not have the same scale, then this algorithm will weight heavily toward the larger. Thus, it is important to scale accordingly; However, sometimes it makes sense to weight variables differently, which is an important concept to keep in mind.

There are two main options for feature scaling:

```
// standardization
x_s = (x - mean(x)) / (std_dev(x))

// normalization
x_n = (x - min(x)) / (max(x) - min(x))
```
