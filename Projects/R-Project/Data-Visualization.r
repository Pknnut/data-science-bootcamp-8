library(tidyverse)
library(ggthemes)

# 5 Question and Chart about Diamonds dataset.

#HW1 Percentage of Cut in Diamonds.

HW1_Chart <- diamonds %>%
  group_by(cut) %>%
  summarise(percentage = n() / nrow(diamonds) * 100) %>%
  ggplot(aes("", percentage, fill = cut)) +
  geom_bar(stat = "identity") +
  coord_polar(theta = "y") +
  geom_text(aes(label = paste0(round(percentage, 2), "%")), position = position_stack(vjust = 0.5)) +
  labs(title = "Percentage of Cut in Diamonds", 
       x = "cut") +
  theme_minimal()

HW1_Ans <- diamonds %>%
  group_by(cut) %>%
  summarise(percentage = paste(round(n() / nrow(diamonds) * 100,2),"%"))

#HW2 Median price of each Cut.

HW2_Chart <- diamonds %>%
  ggplot(aes(x = cut, y = price, fill = cut)) +
  geom_boxplot() +
  labs(title = "Boxplot of Price by Cut",
       x = "Cut",
       y = "Price") +
  scale_fill_manual(values = c("pink","red","gold","green","blue","purple","light blue")) +
  theme_minimal()

HW2_Ans <- diamonds %>%
  group_by(cut) %>%
  summarise(Median_price = round(median(price),2)) 

#HW3 Max price of each clarity in cut.

HW3_Chart <- diamonds %>%
  group_by(cut, clarity) %>%
  summarise(Max_price = max(price)) %>%
  ggplot(aes(cut, Max_price, fill = clarity)) +
  geom_col(position = "dodge") +
  facet_wrap(~cut , ncol = 2)
labs(title = "Maximum Price by Clarity",
     x = "Clarity",
     y = "Maximum Price") +
  theme_minimal()

HW3_Ans <- diamonds %>%
  group_by(cut,clarity) %>%
  summarise(Max_price = max(price)) 

#HW4 Percentage of Color in Cut of Diamonds.

HW4_Chart <- diamonds %>%
  group_by(cut,color) %>%
  summarise(percentage = n() / nrow(diamonds) * 100) %>%
  ggplot(aes("", percentage , fill = color)) +
  geom_bar(position = "dodge",stat = "identity") +
  facet_wrap(~cut, ncol = 3 ) +
  geom_text(aes(label = paste(round(percentage,2),"%")),
            position = position_dodge(width = 1),vjust = -0.5) +
  labs(title = "Percentage of Color in Cut of Diamonds",
       x = "Cut") +
  theme_minimal()

HW4 <- diamonds %>%
  group_by(cut,color) %>%
  summarise(percentage = paste(round(n() / nrow(diamonds) * 100,2),"%"))

total_percentage <- HW4 %>%
  summarise(total_percentage = 
            paste(sum(as.numeric(sub("%","",percentage))),"%"))

HW4_Ans <- list(HW4,total_percentage)

#HW5 Percentage of Colors in each Cut of Diamonds.

HW5_chart <- diamonds %>%
  group_by(cut,color) %>%
  summarise(count = n()) %>%
  group_by(cut) %>%
  mutate(percentage = round(count / sum(count) * 100,2 )) %>%
  ggplot(aes(cut , percentage , fill = color)) +
  geom_col(position = "dodge") +
  geom_text(aes(label = paste(round(percentage,2),"%")) ,
            position = position_dodge(width = 1) , vjust = -0.5) +
  facet_wrap(~color , ncol = 2) +
  labs(title = "Percentage of Colors in each Cut of Diamonds",
       x = "Cut",
       y = "Percentage") +
  theme_minimal()

HW5_Ans <- diamonds %>%
  group_by(cut,color) %>%
  summarise(count = n()) %>%
  mutate(percentage = paste(round(count / sum(count) * 100,2),"%" )) %>%
  print(n = 35)
