library(tidyverse)
library(wordcloud2)
library(wordcloud)
library(ggplot2)
library(ggpubr)


#Import Dataset
testData <- read.csv("CaseCompetitionData2021Copy.csv")

#Drop post-purchase because of excessive NA
testData <- select(testData, -post_purchase_satisfaction)

#Remove NA
testData[testData=="?"]<- NA
testData <- na.omit(testData)

#Create DF with words and counts
cd1 <- count(testData, purchase_make)

#Create Wordcloud
wordcloud(words=cd1$purchase_make, freq = cd1$n, min.freq = 10)
