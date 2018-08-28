## Import data into RStudio

titanic_original <- read.csv("titanic_original.csv", header = TRUE, stringsAsFactors = FALSE)

titanic_clean <- titanic_original

## Clean Port of Embarkation

titanic_clean$embarked <- sub("^$", "S", titanic_clean$embarked)

titanic_clean$embarked <- as.factor(titanic_clean$embarked)

## Clean Age

titanic_clean$age[which(is.na(titanic_clean$age))] <- mean(titanic_clean$age, na.rm = TRUE)

## Clean Lifeboat

titanic_clean$boat <- sub("^$", "NA", titanic_clean$boat)

titanic_clean$boat <- as.factor(titanic_clean$boat)

## Clean Cabin

titanic_clean$has_cabin_number <- ifelse(grepl(".", titanic_clean$cabin), 1, 0)

## Export data from RStudio

write.csv(titanic_clean, "~/Springboard/Springboard-Capstone/titanic_clean.csv")