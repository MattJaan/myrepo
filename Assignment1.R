# Goal is to calculate the average slope of each well in 2 well plates
# p commonly stands for plate
# r commonly stands for replicate

# Read in csv files
df_p1r1<-read.csv("HHP001R1.csv")
df_p1r2<-read.csv("HHP001R2.csv")
df_p2r1<-read.csv("HHP002R1.csv")
df_p2r2<-read.csv("HHP002R2.csv")

# For plate 1 replicate 1
# Create an open list
regress_p1r1 <-list()

# For each of the wells in the plate (columns beginning at column 3) do a
# linear regression against time and fill the list 

for(wells in names(df_p1r1)[2:ncol(df_p1r1)]){
    regress_p1r1[[wells]]<-lm(get(wells)~df_p1r1$Time..sec., data=df_p1r1)
}

# Create an open list  
slope_p1r1 <-list()

# For all the same wells in the now filled list take the slope coefficient
# and fill the open list with the well and the slope
for(wells in names(regress_p1r1)[2:ncol(df_p1r1)]){
    slope_p1r1[[wells]]<-coef(regress_p1r1[[wells]])[[2]]
}

# Save the list containing the well and slope in a dataframe
df_slope_p1r1 <- as.data.frame(slope_p1r1)

# For plate 1 replicate 2
regress_p1r2 <-list()
for(wells in names(df_p1r2)[2:ncol(df_p1r2)]){
  regress_p1r2[[wells]]<-lm(get(wells)~df_p1r2$Time..sec., data=df_p1r2)
}
slope_p1r2 <-list()
for(wells in names(regress_p1r2)[2:ncol(df_p1r2)]){
  slope_p1r2[[wells]]<-coef(regress_p1r2[[wells]])[[2]]
}

df_slope_p1r2 <- as.data.frame(slope_p1r2)

#For plate 2 replicate 1

regress_p2r1 <-list()
for(wells in names(df_p2r1)[2:ncol(df_p2r1)]){
  regress_p2r1[[wells]]<-lm(get(wells)~df_p2r1$Time..sec., data=df_p2r1)
}
slope_p2r1 <-list()
for(wells in names(regress_p2r1)[2:ncol(df_p2r1)]){
  slope_p2r1[[wells]]<-coef(regress_p2r1[[wells]])[[2]]
}

df_slope_p2r1 <- as.data.frame(slope_p2r1)


#For plate 2 replicate 2

regress_p2r2 <-list()
for(wells in names(df_p2r2)[2:ncol(df_p2r2)]){
  regress_p2r2[[wells]]<-lm(get(wells)~df_p2r2$Time..sec., data=df_p2r2)
}
slope_p2r2 <-list()
for(wells in names(regress_p2r2)[2:ncol(df_p2r2)]){
  slope_p2r2[[wells]]<-coef(regress_p2r2[[wells]])[[2]]
}

df_slope_p2r2 <- as.data.frame(slope_p2r2)

# Combine Dataframes
df_combined <- rbind(df_slope_p1r1,df_slope_p1r2,df_slope_p2r1,df_slope_p2r2)


#Calculate mean slope for plate 1 from combined dataframe
plate1_avg <- sapply(df_combined, function(x) mean(x[1:2]))

#calculate mean slope for plate 2 from combined dataframe
plate2_avg <- sapply(df_combined, function(x) mean(x[3:4]))

# combine the calculate averages into a single dataframe
df_averages <- rbind(plate1_avg, plate2_avg)

# Write a csv as an output using the combined average dataframe, with row 
# labels to decipher rows for each plate
write.csv(x=df_averages, file="Slope_averages.csv", row.names = TRUE)
