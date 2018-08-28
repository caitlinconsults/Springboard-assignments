## Install Packages

library("dplyr")
library("tidyr")
library("stringr")

## Import Data into RStudio

refine_original <- read.csv("refine_original.csv", header = TRUE, stringsAsFactors = FALSE)

refine_clean <- refine_original

## Clean Up Brand Names

refine_clean$company <- sapply(refine_clean$company, tolower)

refine_clean$company <- str_replace(refine_clean$company, "phl", "phil")
refine_clean$company <- str_replace(refine_clean$company, "lps", "lips")
refine_clean$company <- str_replace(refine_clean$company, "fil", "phil")
refine_clean$company <- str_replace(refine_clean$company, "illi", "ili")

refine_clean$company <- str_replace(refine_clean$company, "0", "o")
refine_clean$company <- str_replace(refine_clean$company, "ak ", "ak")

refine_clean$company <- str_replace(refine_clean$company, "lver", "lever")

refine_clean <- refine_clean[order(refine_clean$company),]

## Separate Product Code and Number

refine_clean <- refine_clean %>%
  separate(Product.code...number, c("product_code", "product_number"), "-")

## Add Product Categories

index <- c("p", "v", "x", "q")
Product_Categories <- c("Smartphone", "TV", "Laptop", "Tablet")

refine_clean$product_categories <- Product_Categories[match(refine_clean$product_code, index)]

rm(index)
rm(Product_Categories)

## Add Full Address for Geocoding

refine_clean <- unite(refine_clean, "full_address", address, city, country, sep = ",", remove = FALSE)

## Create Dummy Variables for Company

refine_clean$company_philips <- as.numeric(refine_clean$company == "philips")
refine_clean$company_akzo <- as.numeric(refine_clean$company == "akzo")
refine_clean$company_van_houten <- as.numeric(refine_clean$company == "van houten")
refine_clean$company_unilever <- as.numeric(refine_clean$company == "unilever")

## Create Dummy Variables for Product Category

refine_clean$product_smartphone <- as.numeric(refine_clean$product_categories == "Smartphone")
refine_clean$product_tv <- as.numeric(refine_clean$product_categories == "TV")
refine_clean$product_laptop <- as.numeric(refine_clean$product_categories == "Laptop")
refine_clean$product_tablet <- as.numeric(refine_clean$product_categories == "Tablet")

## Export Data from RStudio

write.csv(refine_clean, "~/Springboard/Springboard-Capstone/refine_clean.csv")
