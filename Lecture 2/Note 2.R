
x <- 1:5
x

x + 1 
x + x

y <- c( 2,5,4,3 )

x + y

x < 3

x == c(8,7,3,5,5)
x != c(8,7,3,5,5)


x %in% c(1,4)
x %in% c(1,8)

x
sum(x)
mean(x)
median(x)

x <- c(1:10, NA)
x
is.na(x)

sum(x, na.rm = TRUE)
mean(x, na.rm = TRUE)
median(x, na.rm = TRUE)

9 / 2
9 %/% 2
9 %% 2

2^10

x <- 30
if(x >= 10){
  print('x is over 10 ')} else {
    print('x is not over 10')
  }

x <- 1:5
ifelse( x %% 2 == 0, 'even', 'odd' )


for( i in 1:5 ){
  print(i*3)
}


x <- 1
while( x < 5 ){
  x <- x + 1
  print(x)
}

x <- 10
x^2

x <- 4
square <- function( x ){
  return(x * x)
}

square(45)



install.packages('dplyr')
library('dplyr')

install.packages('ISLR')
library('ISLR')

Wage
head(Wage, 3)
tail(Wage, 4)

str(Wage)

Wage$education

unique(Wage$education)

summary(Wage)

table(Wage$education)
table(Wage$race)
table(Wage$education, Wage$race)


colnames(Wage)

wage1 <- Wage %>%
  select(year, wage)

colnames(wage1)
str(wage1)

wage2 <- Wage %>%
  filter(age == 18)

wage3 <- Wage %>%
  filter(age == 18 & education == '1. < HS Grad')

nrow(wage3)
dim(wage3)

wage4 <- Wage %>%
  select(education, jobclass) %>%
  mutate(new_variable = 1:nrow(Wage)) 

wage5 <- wage4 %>%
  select(education, jobclass) %>%
  mutate(new_variable = rep(3,3000)) 


head(wage4)
dim(wage4)
wage4

wage5 <- Wage %>%
  summarise( median_wage = median(wage), mean_wage = mean(wage), min_wage = min(wage))
wage5

wage6 <- Wage %>%
  group_by(education) %>%
  summarise(median_wage = median(wage))
wage6


wage7 <- Wage %>%
  group_by(education) %>%
  summarise(median_wage = median(wage), mean_wage = mean(wage))
wage7



table1 <- data.frame(ID = c('A', 'B', 'C', 'D', 'F'),
                     y = c(5,5,8,0,9))
table2 <- data.frame(ID = c('A', 'B', 'C', 'D', 'E'),
                     z = c(30,21,22,25,29))

table1
table2

left_table <- table1 %>%
  left_join(table2, by = 'ID' )
left_table

right_table <- table1 %>%
  right_join(table2, by = 'ID')
right_table

full_table <- table1 %>%
  full_join(table2, by = 'ID')
full_table

inner_table <- table1 %>%
  inner_join(table2, by = 'ID')
inner_table




set.seed(1)
x <- sample(1:100, 5)
x

sum(x)
length(x)
sum(x) / length(x)


my.mean <- function(x){
  return(sum(x) / length(x))
}

my.mean(x)
mean(x)


step1 <- x - mean(x)
step2 <- step1^2
step3 <- mean(step2)
step4 <- step3 * length(x) / (length(x)-1)

step4
var(x)

my.var <- function(x){
  step1 <- x - mean(x)
  step2 <- step1^2
  step3 <- mean(step2)
  step4 <- step3 * length(x) / (length(x)-1)
  return(step4)
}

my.var(x)

my.var <- function(x){
  return( mean((x-mean(x))^2)*length(x)/(length(x)-1)   )
}
my.var(x)

