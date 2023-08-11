## connect to SQL server (postgreSQL)
library(RPostgreSQL)
library(tidyverse)

## Create database on PostgreSQL => Create a few tables about pizza restaurants.

con <- dbConnect(PostgreSQL(),
                 host = "arjuna.db.elephantsql.com",
                 port = 5432,
                 user = "bofwigvg",
                 password = "--------------------------",
                 dbname = "bofwigvg")


pizza_menu <- tibble(id_pizza = 1:5, 
                     name = c("hawaiian","anchovy and olives",
                              "pepperoni","meat feast","margherita"),
                     price = as.numeric(c(199,229,249,269,309)))


drink_menu <- tibble(id_drink = 1:5,
                      name = c("wine","beer","coke","lemon soda","water"),
                      price = as.numeric(c(500,100,30,60,20)))


transactions <- tibble(cus_id = 1:3,
                       name = c("John","Max","Cara"),
                       id_pizza = c(3,5,4),
                       pizza_name = c("pepperoni","margherita",
                                      "meat feast"),
                       pizza_amount = c(2,4,3),
                       id_drink = c(1,3,2),
                       drink_name = c("wine","coke","beer"),
                       drink_amount = c(2,4,3))


dbWriteTable(con,"pizza_menu",pizza_menu)
dbWriteTable(con,"drink_menu",drink_menu)
dbWriteTable(con,"transactions",transactions)


dbGetQuery(con,"select tran.name,
                       tran.pizza_name ,
                       tran.pizza_amount,
                       tran.pizza_amount * pizza.price as total_pizza,
                       tran.drink_name ,
                       tran.drink_amount,
                       tran.drink_amount * drink.price as total_drink
                from transactions as tran,
                     pizza_menu as pizza,
                     drink_menu as drink
                where tran.id_pizza = pizza.id_pizza
                  AND tran.id_drink = drink.id_drink")


dbDisconnect(con)




















