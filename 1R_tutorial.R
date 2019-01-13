# Data manipulation:
library(dplyr)
# 1R algorithm:
library(OneR)
# Visualizations:
library(ggplot2)

# Import data, remove 1st column with duplicate rownames
mushrooms <- read.csv("mushroom_data.csv")

# Check the structure of the data frame and observe the variables
str(mushrooms)

mushrooms <- mushrooms %>% select(-veil_type)

# Transform and visualize class balance:
mushrooms %>%
  group_by(poisonous) %>%
  summarise(percentage_each = ((n() / nrow(mushrooms))*100)) %>% 
  ggplot(aes(x = poisonous, y = percentage_each, fill = poisonous)) + 
    geom_bar(stat = "identity", alpha = 0.85) +
    theme_minimal() +
    ggtitle("Current and Former Employee Reviews") +
    theme(legend.position="none") +
    ggtitle("Balance of classes in dataset")

# Inspect a variable:
table(mushrooms$stalk_root, mushrooms$poisonous)

# Split data into training and testing
train_index <- sample(nrow(mushrooms), nrow(mushrooms) * .8, replace = FALSE)
train <- mushrooms[train_index,]
test <- mushrooms[-train_index,]

test_labels <- test %>% select(poisonous)
test <- test %>% select(-poisonous)

# Using OneR algorithm, predict the dependent variable 'poisonous' from 
# all independent variables in the 'train' dataset and display model 
# rules using verbose = T
model <- OneR(poisonous ~., data = train, verbose = T)

# View model summary
summary(model)

# predict 'test' dataset values using trained model
prediction <- predict(model, test)

# View confusion matrix to evaluate model accuracy and error types
eval_model(prediction, test_labels)

# TODO: Use other classification algorithms from the 'caret' package
# to improve model accuracy / decrease number of Type II errors



#####################################################
# OPTIONAL ##########################################
# View all rows containing erroneous predictions ####
#####################################################
# prediction_vs_actual <- cbind(test_labels, prediction)
# colnames(prediction_vs_actual) <- c("actual", "predicted")
# prediction_vs_actual %>% filter(actual != predicted)
#####################################################
#####################################################


