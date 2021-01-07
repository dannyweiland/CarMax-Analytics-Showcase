#This is the code for the treemap visualization.  It relies on df1 from the main CarMax.rmd file 

#Import treemap library
library(treemap)

#Make a dataframe with the count of the purchase make and purchase model
treemap_df <- df1 %>%
  count(purchase_make, purchase_model)

#Create the Treemap showing the makeup of the makes and models in the dataset
MakeModelTreemap <- treemap(treemap_df,
                            index=c("purchase_make", "purchase_model"),
                            vSize="n",
                            type="index",
                            title="Proportion of Manufacturer Sales by Quantity")

