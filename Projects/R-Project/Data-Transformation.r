library(nycflights13)

## 5 questions ask about flights dataset
# Q1 : Which are the top five companies in terms of aircraft production and the number of aircraft they have produced?
planes %>%
  group_by(manufacturer) %>%
  count(manufacturer) %>%
  arrange(-n) %>%
  head(5)

# Q2 : Which destination airport has the highest number of landings for the month of January?
flights %>%
  filter(month == 1) %>%
  count(dest) %>%
  arrange(-n) %>%
  head(5) %>%
  rename(faa = dest) %>%
  left_join(airports) %>%
  select(faa,name,n) 

# Q3 : Which destination airport does ExpressJet Airlines predominantly arrive at during the month of October?
flights %>%
  group_by(dest) %>%
  filter(month == 10) %>%
  count(carrier = "EV") %>%
  left_join(airlines) %>%
  arrange(-n) %>%
  head(1) %>%
  select(dest,carrier,name,n)

# Q4 : Which carrier had the highest total airtime?
flights %>%
  group_by(carrier) %>%
  summarise(total_airtime_hour = sum(air_time, na.rm = T)/60) %>%
  arrange(desc(total_airtime_hour)) %>%
  head(1)

#Q5 : Which airline has the highest total travel distance and the highest average distance per flight?

flights %>%
  left_join(airlines) %>%
  select(carrier,name,distance) %>%
  group_by(carrier,name) %>%
  summarise(total_dis = sum(distance,na.rm = T),
            count=n(),
            total_avg = sprintf("%.4f", mean(distance)))%>%
  arrange(desc(total_dis)) %>%
  head(5)

