#Population stats for 1978-2022

#Packages
install.packages('ggplot2')
library(ggplot2)

#Read in the data
data <- read.csv("~/R projects/population-stats-in-r/productivity-statistics-1978-2022.csv", header=TRUE)

#Renaming of the data columns
new_data_col_names <- c("Series_reference","Period","Data_value","STATUS","UNITS","MAGNTUDE",
                        "Subject","Group","Type","Industry","Measure")
names(data) <- new_data_col_names

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

#Quick check of mean productivity by industry
#Remove rows where industry is blank
non_blank_industries <- data[data$Industry != "",]
prod_by_industry <-  aggregate(Data_value ~ Industry, data = non_blank_industries, FUN = mean)

#Quick plot of the results
barplot(prod_by_industry$Data_value, names.arg = prod_by_industry$Industry, las = 2)

#Checking the unique values in variables
unique(data$Industry)
unique(data$Measure)
#One value for each year despite the .03 in each period
unique(data$Period)

#Examining the productivity from each year
aggregate(Data_value ~ Period, data, FUN = mean)
#Quick plot of the results
plot(aggregate(Data_value ~ Period, data, FUN = mean))

#Investigate why productivity in 1978 was so high
period_1978 <- data[data$Period == 1978.03,]
#As this was the first year it is the baseline
#It shall be excluded from plotting and analysis where applicable

#Analyse the Measure column to see different types of measurement
unique(data$Measure)

#Isolate the index and Percentage change measurement types
index_data <- data[data$Measure == "Index",]
percent_change_data <- data[data$Measure == "Percentage Change",]

#Graphing a specific industry
#Industry of choice is Education and training
edu_and_train_data <- index_data[index_data$Industry == "Education and Training",]
ggplot(data=edu_and_train_data, aes(x=Period, y=Data_value, colour=Type)) +
  geom_point()

#Graphing all industries
#Need to find a way to include industries
total_info <- index_data[index_data$Type == "Total",]
ggplot(data=total_info, aes(x=Period, y=Data_value)) +
  geom_point()

