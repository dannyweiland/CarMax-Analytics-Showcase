---
title: "CarMax Analysis"
author: "Daniel Weiland"
date: "12/4/2020"
output:
  html_document:
    df_print: paged
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## CarMax Analytics Showcase

```{r Carmax Analytics Showcase Setup, message=FALSE, warning=FALSE, include=FALSE}

#Clear workspace
rm(list = ls())


#Set working directory
setwd("C:/Users/Danny/Desktop/CarMax-Analytics-Showcase")


#Import Libraries
library(dplyr)
library(ggplot2)
library(naniar)
library(corrplot)
library(cowplot)
library(randomForest)
library(readxl)
library(forcats)
library(treemap)
library(ggpubr)
library(tidyverse)
library(caret)


#Import Dataset
df1_raw <- read.csv("CaseCompetitionData2021Copy.csv")

```

```{r Data Cleaning, include=FALSE}

#New Dataset for Cleaning and Analysis
df1 <- df1_raw


#Replacing ? Values with NA
df1[df1=="?"]<- NA


#The post purchase satisfaction column only had a few thousand responses.  I excluded this variable from my main dataset, and created a separate dataframe later in the project to analyze this variable.  
df1 <- select(df1, -post_purchase_satisfaction)


#Omitting NA values only removed 14% of observations.     
#Omit NA values
df1 <- na.omit(df1)


#I changed the customer_income and customer_age variables from character to factor, and set the factor levels to #reflect the order of the values of the bins that they represent   
df1 <- df1 %>%
  mutate(customer_income = fct_relevel(customer_income, c("0 - 20000", "20001 - 40000", "40001 - 60000", "60001 - 80000", "80001 - 100000", "100001 - 120000", "120001 - 140000", "140001 - 160000", "160001 - 180000", "180001 - 200000",  "200001+"))) %>%
  arrange(customer_income) %>%
  mutate(customer_age = fct_relevel(customer_age, c("0 - 20", "21 - 30", "31 - 40", "41 - 50", "51 - 60", "61 - 70", "71 - 80", "81 - 90", "91 - 100", "101+"))) %>%
  arrange(customer_age) %>%
  mutate(purchase_price = fct_relevel(purchase_price, c("5001 - 10000",  "10001 - 15000", "15001 - 20000", "20001 - 25000", "25001 - 30000", "30001 - 35000", "35001 - 40000", "40001 - 45000", "45001 - 50000", "50001 - 55000", "55001 - 60000", "60001 - 65000", "65001 - 70000", "70001 - 75000", "75001 - 80000", "80001 - 85000", "85001 - 90000", "90001 - 95000")))

```

```{r Descriptive Statistics of Customer Population, echo=FALSE}

#Here I created a table of the count of each gender within my processed dataset.
gender_table <- table(df1$customer_gender)
gender_table_df <- as.data.frame(gender_table)
gender_table_df <- rename(gender_table_df, customer_gender = Var1)


#Gender PieChart
GenderPie <- ggplot(gender_table_df, aes(x="", y=Freq, fill = customer_gender)) +
  geom_bar(stat="identity", width = 1)+
  coord_polar("y", start=0)+
  theme_void()
ggsave("GenderPie1.png")  


#Barplot of Genders
genderPlot1 <- ggplot(df1, aes(customer_gender, fill = customer_gender))+
  geom_bar() +
  xlab("Gender")+
  theme_minimal()
genderPlot1
ggsave("GenderPlot1.png")


#Barplot of Customer Ages
agePlot1 <- ggplot(df1, aes(customer_age, fill = customer_age))+
  geom_bar()+
  theme_minimal()
agePlot1
ggsave("AgePlot1.png")


#Barplot of customer income
incomePlot1 <- ggplot(df1, aes(customer_income, fill = customer_income))+
  geom_bar() +
  theme_void()+
  xlab("Income Bracket")
incomePlot1
ggsave("IncomePlot1.png")


#Most Common Combination of Age, Income, Gender
#customer_combo_df <- df1 %>%
#  select(customer_age, customer_income, customer_gender)

#customer_combo_df_collapsed <- apply(customer_combo_df, 1, paste, collapse='')

#sort(table(customer_combo_df_collapsed), decreasing = T)

```