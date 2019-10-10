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
#explain why you do notneed to isolate f.s$transect.id, the importance of the pipe function
mean.pd.df<-as.data.frame(mean.pd)
head(mean.pd.df)
nrow(mean.pd.df)
#11. Rename the column with the density values to something more descriptive.
colnames(mean.pd.df)<- c("transect.id", "mean.density")
head(mean.pd.df)
mean.pd.df$seq<-1:39

#12. Assign the row names of the data frame to be the values in a new field “transect”.
transect2.1<-mean.pd.df[,1]
head(mean.pd.df)
transect2.2<-as.data.frame(transect2.1)
head(transect2.2)
transect2.2$seq<-1:39
head(transect2.2)
tra
#finish tonight and study
