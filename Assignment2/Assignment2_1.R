library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)

## JD: I don't have a sense of what's going on here. What are we seeing? Where is the information about “combinations” in the different wells? Why are we turning the data.frame sideways?

# Reads RDS file into a data frame 
df_avg <- read_rds("Slope_averages.rds")

# Transposes the data frame but needs to made into a data frame again because 
# transposing turns it into a matrix
df_t <- as.data.frame(t(df_avg))

# Stores all the number component of the well plate label, the label, 
# and plate number into lists
numbers <- as.numeric(rep(1:24,32))
labels<- rep(rownames(df_t),2)
plate <- as.numeric(c(rep(1,384),rep(2,384)))

# Makes a data frame called slope using the columns of the transposed data frame
df_form <- data.frame(slope=c(df_t[,"plate1_avg"],df_t[,"plate2_avg"]))

## JD: Don't comment just to comment. The comment above and below don't really add anything
## Also, you're not making a data frame “called slope”
# Adds columns to the data frame using the lists above
df_form$well<- labels
df_form$number<- numbers
df_form$plate<- plate

# Using mutate to make a column "assay" when the value in the number column is
# in one of the lists, each list results in corresponding assay types
## JD: Recommend writing this as a human-readable table, either as a separate file or in the code.
df_form2 <- df_form |> mutate(assay=case_when(
  number %in% c(1,12,13,24)~"positive",
  number %in% c(2,14)~"negative",
  number %in% c(3,4,5,15,16,17)~"NADPH",
  number %in% c(6,7,8,18,19,20)~"No protein",
  number %in% c(9,10,11,21,22,23)~"Reductase"
))

summary(df_form2)

# Using mutate to make a column called protein for when the number column value 
# is in a list and plate column equals either 1 or 2
df_fin <- df_form2 |> mutate(protein=case_when(
  number %in% c(1:12) & plate ==1 ~"CYP 1A",
  number %in% c(13:24) & plate ==1 ~"CYP 1B1",
  number %in% c(1:12) & plate ==2 ~"CYP 1C1",
  number %in% c(13:24) & plate ==2 ~"CYP 1D1"
))

# Printing to show the number of trails in each well plate, all the proteins,
# assays and number of wells for each assay per protein
print(df_fin |> count(plate, name="count"))
print(df_fin |> count(protein, name="count"))
print(df_fin |> count(assay, name="count"))
print(df_fin |> count(plate, protein, assay, name="count"))

# Class checking
class(df_fin$slope)
class(df_fin$well)
class(df_fin$number)
class(df_fin$plate)
class(df_fin$assay)
class(df_fin$protein)

# Storing characters as factors
df_fin$protein <- as.factor(df_fin$protein)
df_fin$assay <- as.factor(df_fin$assay)
df_fin$well <- as.factor(df_fin$well)

summary(df_fin)

# Saves data frame in easily readable RDS file
saveRDS(df_fin, "Formatted_Data.rds")

## JD: Could be good to stop here and do all the plots in the second file?

# Creates data frame grouping by protein to calculate the plate and total wells per protein
df_fin_sum <- df_fin |> group_by(protein)|> summarise(avg_plate=mean(plate))

# Makes a column graph for the plate number per protein
ggplot(data=df_fin_sum, mapping=aes(x=protein,y= avg_plate)) + geom_col()
