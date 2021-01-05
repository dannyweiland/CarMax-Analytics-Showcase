treemap_df <- df1 %>%
  count(purchase_make, purchase_model)

MakeModelTreemap <- treemap(treemap_df,
                            index=c("purchase_make", "purchase_model"),
                            vSize="n",
                            type="index",
                            title="Vehicle Models by Purchase Quantity")
ggsave("MakeModelTreemap.png")
