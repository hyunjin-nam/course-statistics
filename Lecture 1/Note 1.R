
print("Hello, world!")

2 + 2
1:10

x <- 2 + 2
x

y <- 3 * 6
y

x / y

vec1 <- c(1,2,3)
vec1
vec1 + 1

vec2<- c("How", "are","you","?")
vec2

vec3 <-c("How", "are","you","?", 3)
vec3
vec3 + 1

list1 <- list(vec1, vec2)
list1


matrix1 <- matrix(1:12 , nrow =2, ncol = 6) 
matrix1

matrix2 <- matrix(1:12 , nrow =2, ncol = 6, byrow = TRUE) 
matrix2

vec <- c(1,2,3)
cbind(vec,vec)
rbind(vec,vec)

df1 <- data.frame(item = c('pencil', 'pen', 'eraser'),
                  stock = c(T,T,F),
                  price = c(1000,1300,500))
df1[1,]
df1[,1]
df1$stock

df2 <- as.data.frame(matrix2)
df2
matrix2
str(df2)
str(df1)
str(matrix2)




set.seed(1)
x <- sample(1:1000, 100, replace = TRUE)
x

mean(x)
sd(x)^2
var(x)
