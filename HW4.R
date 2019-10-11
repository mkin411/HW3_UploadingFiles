#HW4.R
#tapply & merge using fish data
load("fish_data (10).Rdata")
fs<-fish; rm(fish)
f<- fs[ ,c ("transect.id", "area_fac", "depth_fac", "parcel.id", "parcel.density.m3", "parcel.length.m")]
head(fs)
load("fish_data (10).Rdata")
library(tidyverse)
#1. Using the tapply function, find the mean of ‘parcel.density.m3’ for each transect and assign the outcome
#to an object.
parceldensity.m <- tapply(X = f$parcel.density.m3, INDEX = (f$transect.id), FUN=mean)
head(parceldensity.m)
#2. Convert the object to a data frame
parceldensity.m.d <- as.data.frame(parceldensity.m)
head(parceldensity.m.d)
nrow(parceldensity.m.d)
parceldensity.m.d$seq <- 1:39
#another way of creating 
#re-did based on aggregate
#tapply makes a matrix; organized differently as data frames
#output colm

#3. Rename the column with the density values to something more descriptive.
colnames(parceldensity.m.d) <-  c("density.mean", "seq")
head(parceldensity.m.d)
#4. Assign the row names of the data frame to be the values in a new field “transect”.
transect <- rownames(parceldensity.m.d)
head(transect)
transect <- as.data.frame(transect)
head(transect)
transect$seq <- 1:39
#all data frames need to be assigned to 1:39 in order to merge
#5. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#‘parcel.density.m3’.
parceldensity.sd <- tapply(X = f$parcel.density.m3, INDEX =(f$transect.id), FUN=sd)
parceldensity.sd.d <-as.data.frame(parceldensity.sd)
colnames(parceldensity.sd.d) <-  "density.st.dev"
transect <- rownames(parceldensity.sd.d)
nrow(parceldensity.sd.d)
parceldensity.sd.d$seq <-1:39
#6. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, transect)
head(parceldensity.sd.d)
head(parceldensity.m.d)
parcel.density <- merge(transect, c(parceldensity.sd.d,parceldensity.m.d), by="seq")
head(parcel.density)
parcel.density[,c("seq","seq.1")] <- NULL
head(parcel.density)
head(parcel.density)
colnames(parcel.density) <- c("transect", "standard.dev", "mean")
head(parcel.density)
#7. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for ‘parcel.density.m3’’.
parceldensity.c <- tapply(X = f$parcel.density.m3, INDEX = list(f$transect.id), FUN=length)
head(parceldensity.c)
parceldensity.c.d <- as.data.frame(parceldensity.c)
head(parceldensity.c.d)
colnames(parceldensity.c.d) <- "count"
head(parceldensity.c.d)
nrow(parceldensity.c.d)
parceldensity.c.d$seq <- 1:39
head(parceldensity.c.d)
#length of is the # of o
#8. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, count, and transect).
parcel.density$seq <- 1:39
newdataframe1 <- merge(parcel.density, parceldensity.c.d, by="seq")
head(newdataframe1)
nrow(newdataframe1)
newdataframe1[,"seq"] <- NULL
head(newdataframe1)
colnames(newdataframe1) <- c("transect.id","density.stdv", "density.mean", "obs.count")
head(newdataframe1)

#summarise & join
#9. Using the group_by and summarise functions (tidyverse package), find the mean of ‘parcel.density.m3’
#for each transect and assign the outcome to an object.
parceldensity.m.2 <- f %>% group_by(transect.id) %>% summarise(density = mean(parcel.density.m3))
head(parceldensity.m.2)
#10. Convert the object to a data frame
parceldensity.m.2.d <- as.data.frame(parceldensity.m.2)
head(parceldensity.m.2.d)
#11. Rename the column with the density values to something more descriptive.
colnames(parceldensity.m.2.d) <- c("transect","mean")
head(parceldensity.m.2.d)
nrow(parceldensity.m.2.d)
parceldensity.m.2.d$seq <- 1:39
#12. Assign the row names of the data frame to be the values in a new field “transect”.
transect2 <- parceldensity.m.2.d[,1]
head(transect2)
transect2.0 <- as.data.frame(transect2)
head(transect2.0)
transect2.0$seq <- 1:39
head(transect2.0)
#need to have the second column to be named properly because otherwise it assigns to the numbers
#13. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#‘parcel.density.m3’.
#how is this different than #5??
parceldensity.sd.2 <- tapply(X=f$parcel.density.m3, INDEX = f$transect.id, FUN =sd)
head(parceldensity.sd.2)
parceldensity.sd.d.2 <- as.data.frame(parceldensity.sd.2)
head(parceldensity.sd.d.2)
ncol(parceldensity.sd.d.2)
parceldensity.sd.d.2$seq <- 1:39
head(parceldensity.sd.d.2)
colnames(parceldensity.sd.d.2) <- c("st.dev", "seq")
head(parceldensity.sd.d.2)
transect3 <- rownames(parceldensity.sd.d.2)
head(transect3)
#14. Using the join function (tidyverse package), combine the data frames with the mean and standard
#deviation to create one, new data frame that has three columns (mean density, sd
#density, transect)
dataframe3 <- merge(parceldensity.m.2.d,parceldensity.sd.d.2, by="seq")
head(dataframe3)
dataframe4 <- right_join(x=transect2.0, y=dataframe3, by = "seq")
head(dataframe4)
dataframe4[,"seq"] <- NULL
head(dataframe4)

#15. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for ‘parcel.density.m3’’.
parceldensity.c.2<- tapply(X=f$parcel.density.m3, INDEX = f$transect.id, FUN = length)
head(parceldensity.c.2)
parceldensity.c.2.d <- as.data.frame(parceldensity.c.2)
head(parceldensity.c.2.d)
parceldensity.c.2.d$seq <- 1:39
head(parceldensity.c.2.d)
colnames(parceldensity.c.2.d) <- c("count", "seq")
head(parceldensity.c.2.d)

#16. Using the join function, combine the data frames with the mean and standard deviation to create one,
#new data frame that has three columns (mean density, sd density, count, and transect).
wow <- right_join(dataframe4,parceldensity.c.2.d, by="seq")
head(wow)
wow[,c("transect2","seq")] <- NULL
head(wow)
nrow(wow)

#Free style
#17. Select an 2 fields (e.g. area, depth, year, transect) in the fish_data.Rdata to group by. Find the minimum,
#lower 95%, median, mean, upper 95%, and maximum values for parcel.length.m.
length6.1 <- f %>% group_by(f$transect.id, f$parcel.id) %>% summarise(min = min(f$parcel.length.m),low95 = quantile(f$parcel.length.m,0.95),median =median(f$parcel.length.m), up95 = (quantile(f$parcel.length.m,1)-quantile(f$parcel.length.m,0.95)),max = max(f$parcel.length.m))

head(length6.1)


#done


