# caTools

Splitting datasets (useful for training vs test sets):

```R
library(caTools)

set.seed(123) # an arbitrary seed value
split = sample.split(data$Col, SplitRatio = 0.8) # returns an array of `TRUE` and `FALSE`, where a `SplitRatio` fraction of the total set is `True`
training_set = subset(data, split == TRUE)
test_set = subset(data, split == FALSE)
```
