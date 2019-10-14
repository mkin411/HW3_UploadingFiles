#Exam2Review 
mtcars
mca<-mtcars
library(nutshell)
b<-data("batting.2008")
b<-batting.2008;rm(batting.2008)
head(b)
bt<-b
f.s.<-load("fish_data (10).Rdata")
f.s1<-fish;rm(fish)
f.s.2<-f.s1[,c("transect.id", "parcel.id", "parcel.density.m3", "parcel.length.m", "area_fac", "depth_fac")]
head(f.s.2)


#hw 4 questions 8-9:50 go over some questions, general id, 
#1. Using the tapply function, find the mean of 'parcel.density.m3' for each transect and assign the outcome
#to an object.create a dataframe, label colmns and rows something more specific 
mean.p.m3<-tapply(f.s.2$parcel.density.m3, INDEX = (f.s.2$transect.id), FUN = mean)
head(mean.p.m3)
nrow(mean.p.m3)
mean.p.m3.df<-as.data.frame(mean.p.m3)
head(mean.p.m3.df)
colnames(mean.p.m3.df)<-c("mean parcel density")
head(mean.p.m3.df)
mean.p.m3.df$rows<-1:39
#rows can be transect too

#2 Repeat the above steps, but this time using the tapply function to find the standard deviation of
#'parcel.density.m3'.
sd.p.d<-tapply(f.s.2$parcel.density.m3, INDEX = (f.s.2$transect.id), FUN = sd)
head(sd.p.d)
sd.p.d.df<-as.data.frame(sd.p.d)
head(sd.p.d.df)
colnames(sd.p.d.df)<-c("parcel density sd")
head(sd.p.d.df)
nrow(sd.p.d.df)
sd.p.d.df$rows<-1:39


#3. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, transect)
me.st.pd<-merge(sd.p.d.df, mean.p.m3.df, by= "rows")
head(me.st.pd)
me.st.pd.df<-as.data.frame(me.st.pd)
colnames(me.st.pd.df)<-c("transect.id", "sd parcel", "mean parcel")
head(me.st.pd.df)
me.st.pd.df$rows<-1:39


#4. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for 'parcel.density.m3''.
p.length<-tapply(f.s.2$parcel.density.m3, INDEX = f.s.2$transect.id, FUN = length)
head(p.length)
p.length.df<-as.data.frame(p.length)
head(p.length.df)
colnames(p.length.df)<-c("parcel length")
head(p.length.df)
p.length.df$rows<-1:39
head(p.length.df)

#5. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, count, and transect).
merge.2.1<-merge(me.st.pd.df, p.length.df, by = "rows")
head(merge.2.1)
merge.2.1["rows"]<-NULL
head(merge.2.1)

#6. Using the group_by and summarise functions (tidyverse package), find the mean of 'parcel.density.m3'
#for each transect and assign the outcome to an object. name rows and cols
library(tidyverse)
groupby1<-f.s.2%>%group_by(transect.id)%>%summarise(pdmean = mean(parcel.density.m3))
head(groupby1)
colnames(groupby1)<- "mean parcel density"
groupby1.df<-as.data.frame(groupby1)
head(groupby1.df)
colnames(groupby1.df)<-c("transect.id", "mean parcel density")
head(groupby1.df)
groupby1.df$rows<-1:39
#7. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#'parcel.density.m3'.
t.a2<-tapply(f.s.2$parcel.density.m3, INDEX = f.s.2$transect.id, FUN = sd)
head(t.a2)
t.a2.df<-as.data.frame(t.a2)
head(t.a2.df)
colnames(t.a2.df)<-"sd parcel"
head(t.a2.df)
t.a2.df$rows<-1:39


#8. Using the join function (tidyverse package), combine the data frames with the mean and standard
#deviation to create one, new data frame that has three columns (mean density, sd
#density, transect)
merges<-right_join(groupby1.df, t.a2.df, by = "rows")
head(merges)
merges["rows"]<-NULL
head(merges)
merges.df<-as.data.frame(merges)
merges.df$rows<-1:39
#9. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for 'parcel.density.m3''
length.c<-tapply(f.s.2$parcel.density.m3, INDEX = f.s.2$transect.id, FUN = length)
lenght.c.df<-as.data.frame(length.c)
nrow(lenght.c.df)
head(lenght.c.df)
colnames(lenght.c.df)<-"parcel density obs"
lenght.c.df$rows<-1:39


#10 Using the join function, combine the data frames with the mean and standard deviation to create one,
#new data frame that has three columns (mean density, sd density, count, and transect)
join.tp<-right_join(merges.df, lenght.c.df, by ="rows")
head(join.tp)
join.tp["rows"]<-NULL
head(join.tp)


#easier way
groupby4<-f.s.2%>%group_by(transect.id)%>%summarise(count= length(parcel.density.m3), sd = sd(parcel.density.m3), mean = mean(parcel.density.m3))
head(groupby4)
#all 4 easily


#aggregate function 
#creates a data frame
#one example
#1. Using the agg function, find the mean of 'parcel.density.m3' for each transect and assign the outcome
#to an object.create a dataframe, label colmns and rows something more specific 
ag.1<-aggregate(f.s.2$parcel.density.m3, by= list(f.s.2$transect.id), FUN = mean)
head(ag.1)
colnames(ag.1)<-c("transect.id", "meanpd")
head(ag.1)
ag.1$rows<-1:39

#making by std and merge
ag.2<-aggregate(f.s.2$parcel.density.m3, by = list(f.s.2$transect.id), FUN = sd)
head(ag.2)
colnames(ag.2)<-c("transect.id", "sdparcel")
head(ag.2)
ag.2$rows<-1:39



join.merge1<-right_join(ag.1, ag.2, by= "rows")
head(join.merge1)
join.merge1[,c("rows", "transect.id.y")]<-NULL
head(join.merge1)
merge.agg1<-merge(ag.1, ag.2, by= "rows")
head(merge.agg1)
merge.agg1["rows"]<-NULL
head(merge.agg1)




#11. Select an 2 fields (e.g. area, depth, year, transect) in the fish_data.Rdata to group by. Find the minimum,
#lower 95%, median, mean, upper 95%, and maximum values for parcel.length.m.
five.num.pd<-f.s.2%>%group_by(transect.id, parcel.id)%>%summarise(min = min(parcel.density.m3), low95 =quantile(parcel.density.m3, 0.025), median = median(parcel.density.m3), up95 = quantile(parcel.density.m3, 0.975), max = max(parcel.density.m3))
head(five.num.pd)


#melt and dcat
#subset and filter (dpylr)
#time
#ascend and descend
#duplicates and rbind, cbind


