
getwd()
setwd('/Users/hyunjinnam/course-statistics/Lecture 7')
data <- read.csv('data.csv')

str(data)
summary(data)


plot(data)


set.seed(123)
sample <- sample(c(T,F), nrow(data), replace = T, prob = c(0.6, 0.4))
train <- data[sample,]
test <- data[!sample,]


library(ggplot2)
plot(test)

ggplot(data = train, aes(TV, Sales)) +
  geom_point()


library(broom)
library(modelr)


model1 <- lm(Sales ~ TV, data = train)
model1_results <- augment(model1, train)

summary(model1)


ggplot(data = train, aes(TV, Sales)) +
  geom_point() +
  geom_smooth(method = 'lm')



model1_plot1 <- ggplot(model1_results, aes(.fitted, .resid)) +
  geom_ref_line(h = 0) +
  geom_point() +
  geom_smooth(se = F) 
model1_plot1


model1_plot2 <- ggplot(model1_results, aes( sample = .resid)) +
  stat_qq() +
  stat_qq_line() 
model1_plot2

pred1 <- predict(model1, test)
test$Pred1 <- pred1
test

mse1 <- mean((test$Sales -  test$Pred1)^2)
mse1



model2 <- lm(Sales ~ . , data = train)
model2 <- lm(Sales ~ TV + Radio + Newspaper , data = train)

summary(model2)

model3 <- lm(Sales ~ TV + Radio  , data = train)
model3_results <- augment(model3, train)

summary(model3)


model3_plot1 <- ggplot(model3_results, aes(.fitted, .resid)) +
  geom_ref_line(h = 0) +
  geom_point() +
  geom_smooth(se = F) 
model3_plot1



model3_plot2 <- ggplot(model3_results, aes( sample = .resid)) +
  stat_qq() +
  stat_qq_line() 
model3_plot2


pred3 <- predict(model3, test)
test$Pred3 <- pred3

mse3 <- mean((test$Sales - test$Pred3)^2)
mse1
mse3

