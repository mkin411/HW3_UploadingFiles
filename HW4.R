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
#1. Using the tapply function, find the mean of ‘parcel.density.m3’ for each transect and assign the outcome
#to an object.
ts.1<- tapply(X = fs$parcel.density.m3, INDEX = list(fs$transect.id), FUN = mean)
ts.1
head(ts.1)
str(ts.1)
nrow(ts.1)
#2. Convert the object to a data frame
ts.1.df<-as.data.frame(ts.1)
ts.1.df
ts.1.df$rownames <- 1:39
names(ts.1.df)
unlist(ts.1)
fd<- data.frame(transect.id = names(ts.1), parcel.density.mean=ts.1)
head(fd)
str(fd)
fd[,1]<-NULL
str(fd)
head(fd)
fs.d.f<-aggregate(x = list(mean.parcel=fs$parcel.density.m3), by= list(tid=fs$transect.id), FUN = mean)
head(fs.d.f)
library(tidyverse)
rename(fs.d.f,transect.id=tid)
#another way of creating 
#re-did based on aggregate
#tapply makes a matrix; organized differently as data frames
#output colm

#3. Rename the column with the density values to something more descriptive.
colnames(ts.1.df)<-c("parcel.density.mean", "rownames")
colnames(ts.1.df)
str(ts.1.df)
#4. Assign the row names of the data frame to be the values in a new field “transect”.
nrow(ts.1.df)
ncol(ts.1.df)
rownames(ts.1.df) -> values
transect<-values
transect
transect.2 <-rownames(ts.1.df)
transect.2
transect.2$rownames <- 1:39
#all data frames need to be assigned to 1:39 in order to merge
#5. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#‘parcel.density.m3’.
ts.2<- tapply(X = fs$parcel.density.m3, INDEX = list(fs$transect.id), FUN = sd)
head (ts.2)
#need to re-create dataframe
fs.d.f.2<-aggregate(x = list(std.parcel=fs$parcel.density.m3), by= list(tid=fs$transect.id), FUN = sd)
fs.d.f.2
fs.d.f.2$rownames <-1:39
nrow(fs.d.f.2)
colnames(ts.2.df)<-c("parcel.density.sd", "rownames")
transect.3 <-rownames(fs.d.f.2)
transect.3
#6. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, transect)
new.df.frame<-merge(transect.2, c(fs.d.f, fs.d.f.2), by = "rownames")
head(new.df.frame)
nrow(new.df.frame)
transect.id.name<- rename(.data = new.df.frame, transect.id = x)
head(transect.id.name)
#7. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for ‘parcel.density.m3’’.
library(tidyverse)
ts.c<- tapply(X = fs$parcel.density.m3, INDEX = list(fs$transect.id), FUN = length)
ts.c
fs.d.f.3<-aggregate(x = list(std.parcel=fs$parcel.density.m3), by= list(tid=fs$transect.id), FUN = length)
fs.d.f.3$rownames<-1:39
#length of is the # of o
#8. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, count, and transect).
new.df.frame.2<-merge(c(transect.2, fs.d.f.3), c(fs.d.f, fs.d.f.2), by = "rownames")
head(new.df.frame.2)
transect.id.name.2<-rename(.data = new.df.frame.2, transect.id = x)
head(transect.id.name.2)
nrow(new.df.frame.2)

#summarise & join
#9. Using the group_by and summarise functions (tidyverse package), find the mean of ‘parcel.density.m3’
#for each transect and assign the outcome to an object.
library(tidyverse)
library(dplyr)
mean.parcel = fs %>% group_by(transect.id)%>% summarise(pdmean = mean(parcel.density.m3))
head(mean.parcel)
#10. Convert the object to a data frame
mean.parcel.df<-as.data.frame(mean.parcel)
mean.parcel.df
head(mean.parcel.df)
#11. Rename the column with the density values to something more descriptive.
colnames(mean.parcel.df)<-c("transect.id", "parcel.density.mean")
colnames(mean.parcel.df)
head(mean.parcel.df)
#12. Assign the row names of the data frame to be the values in a new field “transect”.
head(mean.parcel.df[,1])
transect7 <- mean.parcel.df[,1]
head(transect7)
transect.7$rownames <-1:39
#need to have the second column to be named properly because otherwise it assigns to the numbers
#13. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#‘parcel.density.m3’.
#how is this different than #5??
ts.3<- tapply(X = fs$parcel.density.m3, INDEX = list(fs$transect.id), FUN = sd)
head (ts.3)
ts.3.df<-as.data.frame(ts.3)
fs.d.f.3<-aggregate(x = list(.parcel=fs$parcel.density.m3), by= list(tid=fs$transect.id), FUN = sd)
ts.3.df
ts.3.df$rownames <-1:39
nrow(ts.3.df)
colnames(ts.3.df)<-"parcel.density.sd"
colnames(ts.3.df)
transect.5 <-rownames(ts.3.df)
transect.5
transect.5$rownames<-1:39
transect5.1<-as.data.frame(transect.5)
#14. Using the join function (tidyverse package), combine the data frames with the mean and standard
#deviation to create one, new data frame that has three columns (mean density, sd
#density, transect)
library(tidyverse)
join.df<-merge(ts.1.df,ts.2.df, by = "rownames")
join.fs <- left_join(x= transect.5.1, y= join.df, by = "rownames")
nrow(join.fs)

#15. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for ‘parcel.density.m3’’.
ts.4<- tapply(X = fs$parcel.density.m3, INDEX =(fs$transect.id), FUN = length)
head(ts.4)
ts.4.df<-as.data.frame(ts.4)
fs.d.f.4<-aggregate(x = list(.parcel=fs$parcel.density.m3), by= list(tid=fs$transect.id), FUN = length)
fs.d.f.4$rownames <- 1:39
transect.7 <- rownames(ts.4.df)
head(transect.7)
transect0.7 <- as.data.frame(transect.7)
transect0.7$rownames <- 1:39
head(transect0.7)
head(ts.4.df)
nrow(ts.4.df)
colnames(ts.4.df)<-c("parcel.density.count", "rownames")
head(ts.4.df)

#16. Using the join function, combine the data frames with the mean and standard deviation to create one,
#new data frame that has three columns (mean density, sd density, count, and transect).
join.df.2<-merge(fs.d.f, fs.d.f.2, by="rownames")
join.df.3 <-merge(transect0.7, fs.d.f.3, by ="rownames")
join.fs <-left_join(x=join.df.3, y= join.df.2, by = "rownames")
nrow(join.fs)
head(join.fs)

#Free style
#17. Select an 2 fields (e.g. area, depth, year, transect) in the fish_data.Rdata to group by. Find the minimum,
#lower 95%, median, mean, upper 95%, and maximum values for parcel.length.m.
f.length<-tapply(X = fs$parcel.length.m, INDEX =list(fs$transect.id), FUN = fivenum)
f.length




