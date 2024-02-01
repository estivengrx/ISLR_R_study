# Literal 8 of applied exercises, linear regression chapter 3
## Importing libraries
library(ISLR2)
library(ggplot2)
install.packages('ggpubr')
library(ggpubr)
library(dplyr)

## Data overview
data <- Auto
head(data)

## Trying a dataset filter in R
data_filtered = filter(data, year == 80)
unique(data$year)
head(data_filtered, 2)

## Linear regression model
## mpg is the response variable, while horsepower is the predictor
fit <- lm(mpg ~ horsepower, data=data)
summary(fit)

## Plot of data and linear model
## a) 
## i. Is there a relationship between the predictor and the response?

### Yes, there is an inverse proportional relationship between mpg, 
### (miles per gallon) and horsepower, as shown in the following graph.

ggplot(data, aes(x = horsepower, y = mpg)) +
  geom_point(color = "black", aes(shape = 'Data points')) +
  geom_smooth(method='lm', se=FALSE, color='orange', aes(fill = 'Linear Model')) +
  labs(fill = "Model", shape = 'Data') +
  ggtitle('Linear model in the Auto data') +
  stat_regline_equation(label.x.npc = 'center')

## ii. How strong is the relationship between the predictor and the response?

### The coefficient estimated for horsepower tells us that for a unit increment in
### horsepower, there is an associated 0.15 decrease in the mpg
plot(data[, c('mpg', 'horsepower', 'weight')])
summary(fit)

## iii.  Is the relationship between the predictor and the response positive or negative?

### It is a negative relationship.

## iv. What is the predicted mpg associated with a horsepower of 98? 
## What are the associated 95 % confidence and prediction intervals?

### The predicted mpg for a horsepower of 98 is 24.5
filter(data, horsepower == 98)
mpg_for_98_horsepower <- predict(fit, data.frame(horsepower = 98))

confidence_intervals <- predict(fit, data.frame(horsepower = 98), interval = 'confidence', level = 0.95)
prediction_intervals <- predict(fit, data.frame(horsepower = 98), interval = 'prediction', level = 0.95)

### Associated 95 % confidence and prediction intervals
print('Confidence intervals for 98 horsepowers:')
print(confidence_intervals)

print('Prediction intervals for 98 horsepowers:')
print(prediction_intervals)

## b) Plot the response and the predictor. Use the abline() function
## to display the least squares regression line.

plot(data$horsepower, data$mpg, col = 'darkgrey',
     main = 'Relationship between horsepower and mpg',
     xlab = 'Horsepower', ylab = 'Miles per gallon')  # Note the order of variables in the plot
abline(reg = fit, col= 'blue')

## c)  Use the plot() function to produce diagnostic plots of the least
#squares regression fit. Comment on any problems you see with #the fit.

par(mfrow = c(2, 2))
plot(fit)

