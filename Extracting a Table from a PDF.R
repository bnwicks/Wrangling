### Case Study: Extracting a Table from a PDF

library(dslabs)
data("research_funding_rates")
research_funding_rates 

## Download data
library("pdftools")
temp_file <- tempfile()
url <- "http://www.pnas.org/content/suppl/2015/09/16/1510159112.DCSupplemental/pnas.201510159SI.pdf"
download.file(url, temp_file)
txt <- pdf_text(temp_file)
file.remove(temp_file)
# raw_data_research_funding_rates <- txt[2]
# raw_data_research_funding_rates <- data("raw_data_research_funding_rates")

data("raw_data_research_funding_rates")
raw_data_research_funding_rates %>% head
tab <- str_split(raw_data_research_funding_rates, "\n") # split newlines
tab <- tab[[1]]
tab %>% head
the_names_1 <- tab[3]
the_names_2 <- tab[4]

# remove space and following comma
the_names_1 <- the_names_1 %>%
  str_trim() %>%
  str_replace_all(",\\s.", "") %>%
  str_split("\\s{2,}", simplify = TRUE)
the_names_1

# remove leading space then split
the_names_2 <- the_names_2 %>%
  str_trim() %>%
  str_split("\\s+", simplify = TRUE)
the_names_2

# Join names 1 + 2
tmp_names <- str_c(rep(the_names_1, each = 3), the_names_2[-1], sep = "_")
the_names <- c(the_names_2[1], tmp_names) %>%
  str_to_lower() %>%
  str_replace_all("\\s", "_")
the_names

#actual data
new_research_funding_rates <- tab[6:14] %>%
  str_trim %>%
  str_split("\\s{2,}", simplify = TRUE) %>%
  data.frame(stringsAsFactors = FALSE) %>%
  setNames(the_names) %>%
  mutate_at(-1, parse_number)
new_research_funding_rates %>% head()

# identical?
identical(research_funding_rates, new_research_funding_rates)



