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


#melt and dcast
library(reshape2)
f.s.2<-f.s1[,c("transect.id", "parcel.id", "parcel.density.m3", "parcel.length.m", "area_fac", "depth_fac")]
#melt(data= df , id.vars =c("transect.id", "parcel.id", "parcel.density.m3", "area_fac"), measure.vars=c("parcel.density.length", "parcel.density.length"), value.names = c("numbers"))

melt.f.s<-melt(data = f.s.2, id.vars = c("transect.id", "parcel.id", "parcel.density.m3", "area_fac"), measure.vars = c("parcel.length.m", "parcel.length.m"), value.name = c("numbers"))
head(melt.f.s)

#long to wide-dcast
dcastf.s<-dcast(data = melt.f.s, formula = transect.id~variable, value.var = c("numbers"), fun.aggregate = mean)
#need to make sure you use the object assigned to the melt question
head(dcastf.s)

#melt and cast again
#under reshape2
#object<-melt(data=dataframe, id.vars= c("","","",""keeping), measure.vars= c("things melting"), value.vars= c("new namefor melted data"))
#dcast- long to wide
#object name<-dcast(data=melt dataframe, formula = transect.id~variable- created this in melt, value.var= c("new name created"), fun.aggregate= function parameter)


#subset and filter (dpylr)
f.s.2<-f.s1[,c("transect.id", "parcel.id", "parcel.density.m3", "parcel.length.m", "area_fac", "depth_fac")]
head(f.s.2)
#finding the data where depth fac is equal to Deep, area fac is equal to West and parcel is is equal to 1
d1<-f.s.2[which(f.s.2$depth_fac == "Deep" & f.s.2$area_fac == "West" & f.s.2$parcel.id ==1 ),]
head(d1)
#subset data where depth is shallow, area is east, and parcel id is 2
d2<-f.s.2[which(f.s.2$depth_fac == "Shallow" & f.s.2$area_fac == "East" & f.s.2$parcel.id == 2),]
d3<-rbind(d1, d2)
head(d3)

#subsetting
m5<-subset(x=f.s.2, depth_fac =="Deep", select = c("transect.id", "area_fac"))
head(m5)
m6<-subset(x=f.s.2, depth_fac == "Deep", select = c("parcel.id", "depth_fac", "parcel.length.m"))
m7<-cbind(m5, m6)
head(m7)
#found

#filter
library(dplyr)
#filtering of the depth_fac colm is deep
filter1<-filter(.data = f.s.2, depth_fac == "Deep")
head(filter1)
filter2<-filter(.data = f.s.2, area_fac == "West")
head(filter2)
mergef<-merge(filter1, filter2)
head(mergef)

#time
vf<-read.table(file='ISIIS201405281124.txt', sep="\t", skip=10, header = TRUE, fileEncoding = "ISO-8859-1", stringsAsFactors = FALSE, quote = "\"", check.names = FALSE, encoding = "UTF-8", na.strings = "9999.99")
#"\t" tab deliminated #string as factors are false dont want it to be factor data 
date<-scan(file = 'ISIIS201405281124.txt', what = "character",skip = 1, nlines = 1, quiet = TRUE)
date4<-date[2]
date4
library(stringr)
#str_sub isolates them by location in a string
day<-str_sub(string = date4, start = 4, end = 5)
day
month<-str_sub(string = date4, start = 1, end = 2)
month
year<-str_sub(string = date4, start = 7, end = 8)
year

#dateTime
vf$Time<-as.numeric(str_sub(vf$Time, 1, 2))
vf$Time
vf<-read.table(file='ISIIS201405281124.txt', sep="\t", skip=10, header = TRUE, fileEncoding = "ISO-8859-1", stringsAsFactors = FALSE, quote = "\"", check.names = FALSE, encoding = "UTF-8", na.strings = "9999.99")
head(vf)
library(stringr)
vf$hour<-as.numeric(str_sub(vf$Time, start = 1, end = 2))
vf$mins<-as.numeric(str_sub(vf$Time, start = 4, end = 5))
head(vf$mins)
vf$seconds<-as.numeric(str_sub(vf$Time, start=7, end = 11))
head(vf$seconds)
vf$time<-str_c(vf$hour, vf$mins,vf$seconds, sep=":")
vf$date<-str_c(vf$month, vf$day, vf$year, sep = "/")


#ascend and descend
attach(mtcars)
#need to attach
order.c<- mtcars[order(mpg),]
head(order.c)
#order said data
#arrange data
arr.cars<-arrange(.data = order.c, desc(cyl))
head(arr.cars)

fish.order<-f.s.2[order(f.s.2$parcel.length.m),]
fish.arrange<-arrange(.data = f.s.2, desc(f.s.2$parcel.length.m))
head(fish.arrange)
#need to isolate that 


#duplicates and rbind
#already subsetting
p1<-f.s.2[1,]
p2<-f.s.2[1,]
p3<-f.s.2[1,]
p4<-f.s.2[2:6,]
p5<-rbind(p1, p2, p3, p4)
head(p5)

no.dups.p5<-p5[!duplicated(p5),]
head(no.dups.p5)
#gets rid of the dupliates



