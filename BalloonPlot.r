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
  arrange(customer_age) %>%
  mutate(purchase_price = fct_relevel(purchase_price, c("5001 - 10000",  "10001 - 15000", "15001 - 20000", "20001 - 25000", "25001 - 30000", "30001 - 35000", "35001 - 40000", "40001 - 45000", "45001 - 50000", "50001 - 55000", "55001 - 60000", "60001 - 65000", "65001 - 70000", "70001 - 75000", "75001 - 80000", "80001 - 85000", "85001 - 90000", "90001 - 95000")))


#Customer Age and Income
#Create contingency table
contingencyTable <- table(testData$customer_age, testData$customer_income)

contingencyTable <- as.data.frame(contingencyTable)

ageIncomeBalloon <- ggballoonplot(contingencyTable, fill = "value")+
  scale_fill_viridis_c(option = "C")
ageIncomeBalloon


#Vehicle Make and Income Balloon Plot
#Would be ideal to scale each make variable, so that the size of the bubble
#showed the difference relative to the other bins, as opposed to showing total count.
makeIncomeTable2 <- table(testData$purchase_make,testData$customer_income)

makeIncomeTable2 <- as.data.frame(makeIncomeTable2)

makeIncomeBalloon2 <- ggballoonplot(makeIncomeTable2, fill = "value")+
  scale_fill_viridis_c(option = "C")
makeIncomeBalloon2


#Gender Income Balloon Plot
genderIncome <- table(testData$customer_gender, testData$customer_income)
genderIncome <- as.data.frame(genderIncome)

genderIncomeBalloon <- ggballoonplot(genderIncome, fill = "value")+
  scale_fill_viridis_c(option = "C")
genderIncomeBalloon


#Income and Purchase Price
#Gender Income Balloon Plot
priceIncome <- table(testData$purchase_price, testData$customer_income)
priceIncome <- as.data.frame(priceIncome)

priceIncomeBalloon <- ggballoonplot(priceIncome, fill = "value")+
  scale_fill_viridis_c(option = "C")
priceIncomeBalloon









