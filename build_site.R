#!/usr/bin/env Rscript
if (!require("quarto")) install.packages("quarto")
library(quarto)

if (!quarto::quarto_binary_sitrep()) {
  stop("Something is wrong with your Quarto installation.")
}

# Build the site into docs/
quarto::quarto_render(".")

# Stage the generated files
system('git add docs/*')

# If this is running outside RStudio, quit without saving workspace
if (!any(grepl("rstudio", search()))) q("no")
