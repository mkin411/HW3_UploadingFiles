#Hw4 Redo
load("fish_data (10).Rdata")
library(tidyverse)
cf<-load("fish_data (10).Rdata")
fs<-fish; rm(fish)
f.s<- fs[ ,c ("transect.id", "area_fac", "depth_fac", "parcel.id", "parcel.density.m3", "parcel.length.m")]

#1. Using the tapply function, find the mean of ‘parcel.density.m3’ for each transect and assign the outcome
#to an object.
mf<-tapply(X= f.s$parcel.density.m, INDEX = list(f.s$transect.id), FUN = mean)
head(mf)           
#2. Convert the object to a data frame
mf.df<-as.data.frame(mf)
nrow(mf.df)
mf.df$seq<-1:39

#3. Rename the column with the density values to something more descriptive.
colnames(mf.df)<-c("mean.parcel.density", "seq")
colnames(mf.df)


#4. Assign the row names of the data frame to be the values in a new field “transect”.
transect1<-rownames(mf.df)
head(transect1)
transect1<-as.data.frame(transect1)
transect1$seq<-1:39

#5. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#‘parcel.density.m3
std<-tapply(X=f.s$parcel.density.m3, INDEX = list(f.s$transect.id), FUN = sd)
std.df<-as.data.frame(std)
nrow(std.df)
colnames(std.df)<-"std.parcel.density"
colnames(std.df)
rownames(std.df)<-transect1
#why am I having issues here?
nrow(std.df)
std.df$seq<-1:39

#6. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, transect)
head(std.df)
head(mf.df)
merge.df<-merge(transect1, c(mf.df, std.df), by = "seq")
head(merge.df)
merge.df[,c("seq", "seq.1")]<-NULL
head(merge.df)
colnames(merge.df)<-c("transect", "mean", "std")
head(merge.df)
merge.df$seq<-1:39
#7. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for ‘parcel.density.m3’’.
c.df<-tapply(X=f.s$parcel.density.m3, INDEX= list(f.s$transect.id), FUN = length)
cd.df.df<-as.data.frame(c.df)
head(cd.df.df)
colnames(cd.df.df)<-"count"
head(cd.df.df)
nrow(cd.df.df)
cd.df.df$seq<-1:39
head(cd.df.df)

#8. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, count, and transect)
new.d.f.1<-merge(merge.df, mf.df, by = "seq") 
head(new.d.f.1)
nrow(new.d.f.1)
new.d.f.1["seq"]<-NULL
head(new.d.f.1)
colnames(new.d.f.1) <- c("transect.id","density.stdv", "density.mean", "obs.count")
head(new.d.f.1)


#summarise & join
#9. Using the group_by and summarise functions (tidyverse package), find the mean of ‘parcel.density.m3’
#for each transect and assign the outcome to an object.
library(tidyverse)
mean.pd<-f.s%>%group_by(transect.id) %>% summarise(density= mean(parcel.density.m3))
#explain why you do notneed to isolate f.s$transect.id (tidyverse function?), the importance of the pipe function
mean.pd.df<-as.data.frame(mean.pd)
head(mean.pd.df)
nrow(mean.pd.df)
#11. Rename the column with the density values to something more descriptive.
colnames(mean.pd.df)<- c("transect.id", "mean.density")
head(mean.pd.df)
mean.pd.df$seq<-1:39
head(mean.pd.df)


#12. Assign the row names of the data frame to be the values in a new field “transect”.
transect2.1<-mean.pd.df[,1]
head(mean.pd.df)
transect2.2<-as.data.frame(transect2.1)
head(transect2.2)
transect2.2$seq<-1:39
head(transect2.2)


#13. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#‘parcel.density.m3’.
#why do you need to mean parcel density first in a tapply function?
pd.std<-tapply(X= f.s$parcel.density.m3, INDEX = f.s$transect.id, FUN = sd)
head(pd.std)
pd.std.df<-as.data.frame(pd.std)
head(pd.std.df)
nrow(pd.std.df)
pd.std.df$seq<-1:39
colnames(pd.std.df)<- c("std.dev", "seq")
colnames(pd.std.df)
transect <-rownames(pd.std.df)
head(transect)

#14. Using the join function (tidyverse package), combine the data frames with the mean and standard
#deviation to create one, new data frame that has three columns (mean density, sd
#density, transect)
new.df.four<-merge(mean.pd.df, pd.std.df, by = "seq")
join.14<-right_join(x=transect2.2, y = new.df.four, by = "seq" )
#its a right join because the join is merging from the right to the left of the dataframes
join.14[,"seq"]<-NULL
join.14[, "transect2.1" ]<-NULL
head(join.14)
new.df.four$seq<-1:39
#had to get rid of duplicate rows

#15. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for ‘parcel.density.m3’
new.df.five<-tapply(f.s$parcel.density.m3, INDEX = f.s$transect.id, FUN = length)
head(new.df.five)
#why for this are you putting parcel.densityfirst and then the transect.id second?
new.df.five.df<-as.data.frame(new.df.five)
head(new.df.five.df)
new.df.five.df$seq<-1:39
colnames(new.df.five.df)<- c("parcel den count", "seq")
head(new.df.five.df)

#16. Using the join function, combine the data frames with the mean and standard deviation to create one,
#new data frame that has three columns (mean density, sd density, count, and transect).
dr<-merge(new.df.five.df, transect2.2, by = "seq")
dr.join<-right_join(new.df.four, dr, by ="seq")
head(dr.join)
dr.join[, c("seq", "transect2.1")]<- NULL
#need to have the c and brackets as well as the , in order to seperate those changes
head(dr.join)
nrow(dr.join)


17. Select an 2 fields (e.g. area, depth, year, transect) in the fish_data.Rdata to group by. Find the minimum,
#lower 95%, median, mean, upper 95%, and maximum values for parcel.length.m.
#review this question
#one way below
five.num<-group_by(.data = f.s$transect.id, f.s$parcel.id) %>% summarise()
five.num <- f.s%>% group_by(f.s$transect.id, f.s$parcel.id) %>% summarise(min = min(f.s$parcel.length.m),low95 = quantile(f.s$parcel.length.m,0.95),median =median(f.s$parcel.length.m), up95 = (quantile(f.s$parcel.length.m,1)-quantile(f.s$parcel.length.m,0.95)),max = max(f.s$parcel.length.m))
five.num

#understanding group_by and summarise


#second way
summary(f.s)
summary(f.s$parcel.id, f.s$transect.id, by=f.s$parcel.length.m)
#is this way correct? Above? What is this actually doing?

