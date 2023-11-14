
test_data <- read.csv(file = "example.csv")

# Pivot the data longer based on the weight column
long_data <- test_data %>%
  slice(rep(1:n(), test_data$weight)) %>%
  select(-weight)  # Remove the weight column as it's no longer needed

# Convert the tibble to a data frame
long_data_df <- as.data.frame(long_data)

ggplot(long_data_df,
       aes(axis1 = Intervention, axis2 = scale, axis3 = outcome)) +
  geom_alluvium(aes(fill = Intervention)) +
  geom_stratum(aes(fill = outcome)) +
  geom_text(stat = "stratum", aes(label = outcome), size = 3) +
  geom_text(stat = "alluvium", aes(label = outcome), size = 3, angle = 90) +
  theme_minimal() + 
  theme(legend.position = "none") +
  ggtitle("The expected impacts of agroforestry interventions")

