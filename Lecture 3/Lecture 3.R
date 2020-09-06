library(dplyr)
library(tidyr)
library(forecast)
library(ggplot2)
library(git2r)
library(RCurl)

setwd('/Users/hyunjinnam/')
url <- 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'
link <- getURL(url)
data <- read.csv(text = link)

data <- data %>%
  select(-Province.State,-Lat, -Long) %>%
  group_by(Country.Region) %>%
  summarise_all(sum, na.rm = TRUE) 

country.list <- unique(data$Country.Region)
data.final <- data.frame()
forecast.final <- data.frame()


for(i in 1:length(country.list)){
  country <- country.list[i]
  country.data <- data %>%
    filter( Country.Region == country) %>%
    select(-Country.Region)
  
  first_day <- min(which(country.data > 0))
  last_day <-  ncol(country.data)
  N <- country.data[,first_day:last_day] %>% t() %>% as.vector()
  day <- seq(from = 1, to = last_day - first_day + 1, by = 1)
  country.data <- data.frame( Country = rep(country,last_day - first_day + 1 ) ,Day = day, N = N)
  data.final <- rbind(data.final, country.data)
  
  ## plot it
  forecast.plot <- ggplot(country.data, aes(x = Day, y = N)) + geom_line(colour=1) +
    geom_point(size = 1) +
    labs(y = 'Number of confirmed patients',
         x="Time since first case", 
         title="Prediction of the number of COVID-19 cases",
         subtitle = country)+ theme_linedraw()
  

  ggsave(forecast.plot,filename =paste0(country,".png"))
  print(forecast.plot)
  dev.off()
}

write.csv(data.final, 'forecast.csv')



'%ni%' <- Negate('%in%')
maxn <- data.final %>%
  group_by(Country) %>%
  summarize(N = max(N), Day = max(Day))
topn <- 10
topn.country <- maxn$Country[which(maxn$N %in% tail(sort(maxn$N),topn))]
maxn.topn <- maxn %>% filter(Country %in% topn.country)
maxn.rest <- maxn %>% filter(Country %ni% topn.country)


country_rest <- data.final %>%
  filter(Country %ni% topn.country) %>%
  ggplot(aes(x = Day, y = N, group = Country)) +
  geom_line(colour=1) + 
  annotate("text",x = maxn.rest$Day, y = maxn.rest$N ,label = maxn.rest$Country, size = 3)

country_top10 <- data.final %>%
  filter(Country %in% topn.country) %>%
  ggplot(aes(x = Day, y = N, group = Country)) +
  geom_line(colour=1) + 
  annotate("text",x = maxn.topn$Day, y = maxn.topn$N + 2000,label = maxn.topn$Country, size = 3)

setwd('/Users/hyunjinnam/covid-19/img')
ggsave(country_rest,filename ="country_rest.png")
print(country_rest)
dev.off()

ggsave(country_top10,filename ="country_top10.png")
print(country_top10)
dev.off()

print(format(Sys.time(), "%b %d %X %Y"))
