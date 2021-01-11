library(tidyverse)
library(wordcloud2)
library(wordcloud)
library(ggplot2)
library(ggpubr)
library(webshot)
webshot::install_phantomjs()
library("htmlwidgets")




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
#This will create an image of your wordcloud
wordcloud(words=cd1$purchase_make, freq = cd1$n, min.freq = 10)

#Create another using Wordcloud2
#Wordcloud2 creates an html widget
myWordCloud2 <- wordcloud2(data = cd1, size=.5, color = 'random-dark', backgroundColor = "white")
myWordCloud2

#The following code is used to save as html widget
saveWidget(myWordCloud2, "tmp.html",selfcontained = F)

#This code can be used to save as png or pdf
webshot("tmp.html", "fig_1.png", delay =5, vwidth = 480, vheight = 480)



