library(tidyverse)
library(wordcloud2)
library(wordcloud)
library(ggplot2)
library(ggpubr)


#Import Dataset
testData <- read.csv("CaseCompetitionData2021Copy.csv")


#Drop post purchase because of excessive NA 
testData <- select(testData, -post_purchase_satisfaction)


#Remove NA
testData[testData=="?"]<- NA
testData <- na.omit(testData)


#Baloon Plot -----

#Rearrange data as factor data
testData <- testData %>%
  mutate(customer_income = fct_relevel(customer_income, c("0 - 20000", "20001 - 40000", "40001 - 60000", "60001 - 80000", "80001 - 100000", "100001 - 120000", "120001 - 140000", "140001 - 160000", "160001 - 180000", "180001 - 200000",  "200001+"))) %>%
  mutate(customer_income = fct_rev(customer_income)) %>%
  arrange(customer_income) %>%
  mutate(customer_age = fct_relevel(customer_age, c("0 - 20", "21 - 30", "31 - 40", "41 - 50", "51 - 60", "61 - 70", "71 - 80", "81 - 90", "91 - 100", "101+"))) %>%
  arrange(customer_age)


#Create contingency table
contingencyTable <- table(testData$customer_age, testData$customer_income)

contingencyTable <- as.data.frame(contingencyTable)

ggballoonplot(contingencyTable, fill = "value")+
  scale_fill_viridis_c(option = "C")