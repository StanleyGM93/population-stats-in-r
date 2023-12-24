#Population stats for 1978-2022

#Read in the data
data <- read.csv("~/R projects/population-stats-in-r/productivity-statistics-1978-2022.csv", header=TRUE)

#Gain some insight into the data
str(data)
summary(data)
head(data)
tail(data)

#Checking that the last 2 columns only contain NA values
all(is.na(data$Series_title_4))
all(is.na(data$Series_title_5))

#Removing the last 2 columns as they don't contain data
data <- data[, 1:11]

#Renaming of the data columns
new_data_col_names <- c("Series_reference","Period","Data_value","STATUS","UNITS","MAGNTUDE",
                        "Subject","Group","Type","Industry","Measure")
names(data) <- new_data_col_names

#Quick check of mean productivity by industry
#Remove rows where industry is blank
non_blank_industries <- data[data$Industry != "",]
prod_by_industry <-  aggregate(Data_value ~ Industry, data = non_blank_industries, FUN = mean)

#Quick plot of the results
barplot(prod_by_industry$Data_value, names.arg = prod_by_industry$Industry, las = 2)

