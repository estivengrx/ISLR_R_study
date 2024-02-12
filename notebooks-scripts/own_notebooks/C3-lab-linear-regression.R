# Importing libraries
library('MASS')
library('ISLR2')
library('ggplot2')

# Overview of the Boston dataset and plotting the lstat and medv columns
head(Boston)
#plot(Boston)

# Making a simple linear regression

## lstat <- lower status of the population (percent).
## medv <- median value of owner-occupied homes in $1000s.

lm.fit <- lm(medv ~ lstat, data = Boston) # lm stands for Linear Model
summary(lm.fit) # Descriptive summary of the simple linear model
confint(lm.fit) # Confidence intervals of the model

## SIMPLE GRAPH:  
plot (Boston$lstat , Boston$medv)
abline (lm.fit)

## MORE COMPLEX GRAPH:
ggplot(Boston, aes(x = lstat, y = medv)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +  # Adding linear regression line
  labs(title = "Relationship between Lower Status and Median Home Value",
       x = "Lower Status of the Population (%)",
       y = "Median Home Value ($1000s)")

# Predictions from the model
predict (lm.fit , data.frame(lstat = (c(5, 10, 15))),
         interval = "confidence")
