library(tidyverse)
library(wordcloud2)
library(wordcloud)


#Import Dataset
testData <- read.csv("CaseCompetitionData2021Copy.csv")

#Remove NA
testData[testData=="?"]<- NA

#Create DF with words and counts
cd1 <- count(testData, purchase_make)

#Create Wordcloud
wordcloud(words=cd1$purchase_make, freq = cd1$n, min.freq = 3)







