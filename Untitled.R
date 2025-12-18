if(!dir.exists(file.path("data", "mp01"))){
  dir.create(file.path("data", "mp01"), showWarnings=FALSE, recursive=TRUE)
}

library(dplyr)
library(readr)

global_top10  <- read_tsv(GLOBAL_TOP_10_FILENAME, show_col_types = FALSE)
country_top10 <- read_tsv(COUNTRY_TOP_10_FILENAME, show_col_types = FALSE)

# Peek at schema and first rows
names(global_top10)
head(global_top10, 3)
