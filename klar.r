#Categorical Variable Clustering using klaR

library(klaR)
library(tidyverse)
library(wordcloud2)
install.packages("wordcloud")
library(wordcloud)

testData <- read.csv("CaseCompetitionData2021Copy.csv")


#Prep Data
testData <- testData %>%
  sample_frac(.1)

testData <- testData[c("customer_age", "customer_income")]

testData[testData=="?"]<- NA

testData <- na.omit(testData)

testData$customer_age <- as.factor(testData$customer_age)
testData$customer_income <- as.factor(testData$customer_income)

#Run K modes
cl <- kmodes(testData, 2)
plot(testData$customer_age, testData$customer_income, col = cl$cluster)



#WordCloud
cd2 <- count(testData, purchase_make)
wordcloud(words=cd2$purchase_make, freq = cd2$n, min.freq = 3)



