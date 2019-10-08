#HW4
#tapply & merge using fish data
load("fish_data (10).Rdata")
f<-fish; rm(fish)
load("fish_data (10).Rdata")
fs<- f[ ,c ("transect.id", "area_fac", "depth_fac", "parcel.id", "parcel.density.m3", "parcel.length.m")]
head(fs)
fs$transect.id
str(fs$transect.id)
(fs$transect.id)
#there are 2026 transects, but are repeats of 5 of the same types, only 5 transects present
#1. Using the tapply function, find the mean of ‘parcel.density.m3’ for each transect and assign the outcome
#to an object.
ts.1<- tapply(X = fs$parcel.density.m3, INDEX = list(fs$transect.id), FUN = mean)
ts.1
#2. Convert the object to a data frame
ts.1.df<-as.data.frame(ts.1)
ts.1.df
#3. Rename the column with the density values to something more descriptive.
colnames(ts.1.df)<-"parcel.density.mean"
#why is it that when I do the head of what I assigned it shows the change, but it doesn't change when I do the whole str of fs?

#4. Assign the row names of the data frame to be the values in a new field “transect”.
nrow(ts.1.df)
ncol(ts.1.df)
rownames(ts.1.df) -> values
transect<-values
transect
transect.2 <-rownames(ts.1.df)
transect.2
#5. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#‘parcel.density.m3’.
ts.2<- tapply(X = fs$parcel.density.m3, INDEX = list(fs$transect.id), FUN = sd)
head (ts.2)
ts.2.df<-as.data.frame(ts.2)
ts.2.df
nrow(ts.2.df)
colnames(ts.2.df)<-"parcel.density.sd"
transect.3 <-rownames(ts.2.df)
transect.3
#6. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, transect)
new.df.frame<-merge(transect, c(ts.2.df, ts.1.df))
head(new.df.frame)
nrow(new.df.frame)
#why are there 1521 rows not 39 like the original data? 39 * 39
transect.id.name<- rename(.data = new.df.frame, transect.id = x)
head(transect.id.name)
#7. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for ‘parcel.density.m3’’.
library(tidyverse)
ts.c<- tapply(X = fs$parcel.density.m3, INDEX = list(fs$transect.id), FUN = length)
ts.c
#length of is the # of obs
#8. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, count, and transect).
new.df.frame.2<-merge(c(transect, ts.c), c(ts.2.df, ts.1.df))
head(new.df.frame.2)
transect.id.name.2<- rename(.data = new.df.frame.2, transect.id = x)
head(transect.id.name.2)

#summarise & join
#9. Using the group_by and summarise functions (tidyverse package), find the mean of ‘parcel.density.m3’
#for each transect and assign the outcome to an object.
library(tidyverse)
library(dplyr)
mean.parcel = fs %>% group_by(parcel.density.m3) %>% summarise(n(mean))
head(mean.parcel)
#10. Convert the object to a data frame


#11. Rename the column with the density values to something more descriptive.


#12. Assign the row names of the data frame to be the values in a new field “transect”.


#13. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#‘parcel.density.m3’.


#14. Using the join function (tidyverse package), combine the data frames with the mean and standard
#deviation to create one, new data frame that has three columns (mean density, sd
#density, transect)


#15. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for ‘parcel.density.m3’’.


#16. Using the join function, combine the data frames with the mean and standard deviation to create one,
#new data frame that has three columns (mean density, sd density, count, and transect).


#Free style
#17. Select an 2 fields (e.g. area, depth, year, transect) in the fish_data.Rdata to group by. Find the minimum,
#lower 95%, median, mean, upper 95%, and maximum values for parcel.length.m.

