library(dplyr)
library(tidyr)
library(dslabs)
library(tidyverse)
library(ggrepel)
library(data.table)

path <- system.file("extdata", package = "dslabs")
filename <- file.path(path, "life-expectancy-and-fertility-two-countries-example.csv")

raw_dat <- read.csv(filename)

select(raw_dat, 1:5)

dat <- raw_dat %>% gather(key, value, -country)

dat_tidy <- dat %>% separate(key, c("year", "variable_name"),sep = "_", extra = "merge") %>% spread(variable_name, value)

###

tab <- left_join(murders, results_us_election_2016, by="state")
tab %>% ggplot(aes(population/10^6, electoral_votes, label = abb)) +
  geom_point() +
  geom_text_repel() +
  scale_x_continuous(trans = "log2") +
  scale_y_continuous(trans = "log2") +
  geom_smooth(method = "lm", se = FALSE)

###

tab1 <- data.table(state = c("Alabama", "Alaska", "Arizona", "Delaware", "District of Columbia"), population = c(4779736, 710231, 6392017, 897934, 601723))
tab2 <- data.table(state = c("Alabama", "Alaska", "Arizona", "California", "Colorado", "Connecticut"), electoral_votes = c(9, 3, 11, 55, 9, 7))

dat <- left_join(tab1, tab2, by = "state")
dat <- inner_join(tab1, tab2, by = "state")
dat <- semi_join(tab1, tab2, by = "state")

##

tab1 <- tab[1:5,]
tab2 <- tab[3:7,]
intersect(tab1,tab2)
union(tab1, tab2)
setequal(tab1, tab2)

##

df1 <- data.table(x = c("a", "b"), y = c("a", "a"))
df2 <- data.table(x = c("a", "a"), y = c("a", "b"))
final <- union(df1, df2)
final <- setdiff(df1, df2)
final <- setdiff(df2, df1)
final <- intersect(df1, df2)

## Printing out Wikipedia page data [html] -> [dataframe]

library(rvest)
url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
tab <- h %>% html_nodes("table")
tab <- tab[[2]]
tab <- tab %>% html_table()
tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))

# Fix Commas, data






