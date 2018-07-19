### Case Study 2: Reported Heights
library(dplyr)
library(tidyr)
library(dslabs)
library(tidyverse)
library(ggrepel)
library(data.table)
library(rvest)
library(stringr)

not_inches <- function(x, smallest = 50, tallest = 84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest 
  ind
}


class(reported_heights$height)
temp_x <- as.numeric(reported_heights$height)
sum(is.na(temp_x))

# Filter incorrect enteries
reported_heights %>% mutate(new_height = as.numeric((height))) %>% filter(is.na(new_height)) %>% head(n=10)

not_inches <- function(x, smallest = 50, tallest = 84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest 
  ind
}

problems <- reported_heights %>% filter(not_inches(height)) %>% .$height
length(problems)

## Filers

# x'y" examples
pattern <- "^\\d\\s*'\\s*\\d{1,2}\\.*\\d*'*\"*$"
str_subset(problems, pattern) %>% head(n=10) %>% cat

# x.y examples
pattern <- "^[4-6]\\s*[\\.|,]\\s*([0-9]|10|11)$"
str_subset(problems, pattern) %>% head(n=10) %>% cat

# cm examples
ind <- which(between(suppressWarnings(as.numeric(problems))/2.54, 54, 81))
ind <- ind[!is.na(ind)]
problems[ind] %>% head(n=10) %>% cat

# Regex Examples
yes <- c("5", "6", "180 cm","70 inches", "5\'4\"")
no <- c("180", "70'", "five", "six")
s <- c(yes, no)

pattern <- "\\d"
str_detect(s, pattern)
str_view(s, pattern) # view first str match
str_view_all(s, pattern) # view all str match

# Character Classes, Anchors, and Qualifiers
str_view(s,"[56]")
str_view(s,"[4-7]")
str_view_all(s,"[a-zA-Z]")
str_view_all(s,"^\\d$")
str_view_all(s,"^\\d{1,3}$")
str_view_all(s,"^[4-7]'\\d{1,2}\"$")

pattern_1 = "^[4-7]'\\d{1,2}\"$"
pattern_2 = "^[4-7]'\\s*\\d{1,2}\"$"

sum(str_detect(problems,"^[4-7]'\\s\\d{1,2}\"$"))

problems %>% str_replace("feet|ft|foot", "'") %>% str_replace("inches|in|''|\"","")

pattern_without_groups <- "^[4-7],\\d*$"
pattern_with_groups <- "(^[4-7]),(\\d*$)"

str_match(s, pattern_with_groups)

## Example
#problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
#pattern_with_groups <- "^([4-7])[,\\.](\\d*)$"
#str_replace(problems, pattern_with_groups, "\\1'\\2")

## Example
#problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
#pattern_with_groups <- "^([4-7])[,\\.\\s](\\d*)$"
#str_replace(problems, pattern_with_groups, "\\1'\\2")

## Example
yes <- c("5 feet 7inches")
no <- c("5ft 9 inches", "5 ft 9 inches")
s <- c(yes, no)

#converted <- s %>% 
#  str_replace("feet|foot|ft", "'") %>% 
#  str_replace("inches|in|''|\"", "") %>% 
#  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

converted <- s %>% 
  str_replace("\\s+feet|foot|ft\\s+", "'") %>% 
              str_replace("\\s+inches|in|''|\"\\s+", "") %>% 
              str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)



