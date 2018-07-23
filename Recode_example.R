### Recode Example

library(dslabs)
data("gapminder")

# Recode countries longer than 12 letters in the region “Middle Africa” to their abbreviations in a new column, “country_short”
dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country_short = recode(country, 
                                "Central African Republic" = "CAR", 
                                "Congo, Dem. Rep." = "DRC",
                                "Equatorial Guinea" = "Eq. Guinea"))
