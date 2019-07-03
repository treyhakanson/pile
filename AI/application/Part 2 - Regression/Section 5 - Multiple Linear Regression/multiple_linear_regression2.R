library(caTools)

data = read.csv('50_Startups.csv')

data$State = factor(data$State,
                    levels = c('New York', 'California', 'Florida'),
                    labels = c(1, 2, 3))

set.seed(123)
split = sample.split(data$Profit, SplitRatio = 0.8)
training_set = subset(data, split == TRUE)
test_set = subset(data, split == FALSE)

# The `.` following the `~` refers to all other columns; this is a shortcut for the
# following:
# Profit ~ R.D.Spend + Administration + Marketing.Spend + State
regressor = lm(formula = Profit ~ .,
               data = training_set)

y_pred = predict(regressor, newdata = test_set)
