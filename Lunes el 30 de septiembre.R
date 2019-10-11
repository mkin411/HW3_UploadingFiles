#Lunes el 30 de Septiembre
#Functions working with datasets, finding columns finding rows and columns, pull, summarize and reshape data
f<-load("fish_data (10).Rdata")
ff<- fish
#subsetting
fd<-ff[ff$depth_fac == "Deep", ]
fd2<- subset (x = ff, depth_fac == "Deep")
fd2

#subset shallow tows
fd2<- subset (x = ff, depth_fac == "shallow tows")
fd22<-f[ff$tow.depth == "shallow tows"]
fd22
#east
#fd3 <-subse (x = ff, depth_fac == "east")
fd33<-fd22<-f[ff$parcel.end.lat == "east"]
#patches
fd4<-subset(x = ff, depth_fac == "patches")
#selecting area
fd5<- subset(x =ff, depth_fac =="Deep", select = c("transect.id", "area_fac"))
fd5
##filter
library(dplyr)
fd6<- filter(.data = f, depth_fac == "Deep", perserve = FALSE)
#Which
fd7<- ff[which(ff$depth_fac == 'Deep' & ff$area_fac == "East"), ]
#fd6 <- ff[which(ff$depth_fac == 'Deep' & ff$area_fac == "East", ff$yr_fac == "2014")
 #subsetting and then combine using rowbinf (rbind function)
d1<- ff[which(ff$depth_fac == 'Deep' & ff$area_fac == "East"),]
d2<- ff[which(ff$depth_fac == 'Shallow' & ff$area_fac == "West"), ]
#combine d1 and d2
d3<- rbind(d1, d2)
head(d3)
nrow(d3)
#combine data frames with seperate columns into a singl data frame
c1<-subset(x = ff, depth_fac == "Deep", select = c("transect.id", "area_fac"))
#que es la problema?
c2<- subset (x = ff, depth_fac == "Deep", select = c("depth_fac", "parcel.length.m", "group"))
#c3<-cbind(c1, c2)
#merging two data frames, ensuring that observations from one data frame are connected with 
#observation in the second data frame correctly
m1<- subset (x = ff, depth_fac == "Deep", select = c("transect.id", "area_fac"))
m2<- subset (x = ff, depth_fac == "Deep", select = c("depth_fac", "parcel.length.m", "group", "transect.id"))
#head(m1) and head (m2)
#merge I
#mt <- merge( x = m1, y = m2, by = c("transect.id"), all.x = T)
#only going to merge the shorter x to the longer, y, and visa verse, all.y; rid all the other vaules of x that dont match
#all matches all the the dataframes that match, sometimes all and all.x may return the same thing
#choose all.x or all. y 
mt <- merge(x=m1, y=m2, by= c("transect.id"), all.x = T, no.dups = T)
my<- merge( x = m1, y = m2, by = c("transect.id"), all.x = T, no.dups = T)
head(m1)
head(m2)
nrow(m1) + nrow(m2)
nrow(mt)
#join
library(dplyr)
mj <- dplyr::right_join(x = m1, y = m2, by = c('transect.id'))
nrow(mj)
#antijoin finds anything that does not match
#right match all match and then they are gotten rid if x is more, left condition would NAs
m1$seq<-seq(1, nrow(m1),1)
m2$seq <- seq(1, nrow(m2), 1)
head(m2)
mt <- merge(x=m1, y=m2, by= c("transect.id", "seq"), all.x = T, no.dups = T)
nrow(mt)
#need to add "seq" so that the rows make sense
#can not put rows to assign to how many rows you are expected, just using transect.id was repeated so many times, need a unique value to help
#seq helps align the number to what is should be- specific placement
m2$seq<-seq(from= 1, to =nrow(m2), by=1)
v<-seq(5, 20, 0.5)
vc<- cut(x=v, breaks =seq(5, 20, 1), include.lowest = T)
vc
#created a seq started at 5 then went to 20,, first to b ones and second be twos in hours, assign that hour identifier to that data
#cut takes the vector with the breaks, .5-1 as one at a time and include the lowest, and seperate intervals
#repeating less because of shift in range
#subsetting, merging, cut 

#2 october 2019
#review of subsetting
#summarize data
library(tidyverse)
install.packages("nutshell")
library(nutshell)
data("batting.2008")
d <- batting.2008
head(d)
#tapply -- (tidyverse function)
#how do you want to summarize your data?
str(d)
#number of home runs per team, HR
hr<-tapply(X = d$HR, INDEX = list(d$teamID), FUN = sum)
#needs to be uppercase X
hr
#interested in variance
## find quantile values for home runs
#five num gives you min, lower hinge, median, upper-hinge, and max value
fhr<-tapply(X = d$HR, INDEX = list(d$teamID), FUN = fivenum)
fhr
#lower hinde and upper hinge 17th and 20th percentiles
lq.q<-tapply(X = d$H/d$AB, INDEX = list(d$lgID), FUN = fivenum)
lq.q
#proportion of hits for at bat
head(d$lgID)
summary(d[d$lgID== "AL",] $H/d[d$lgID=="AL",]$AB)
#review al functions
#summarize over multiple categories
bats<-tapply(X= d$HR, INDEX = list(d$lgID, d$bats), FUN = mean)
unique(d$bats)
bats.team<-tapply(X= d$HR, INDEX = list(d$lgID, d$teamID), FUN = mean)
bats.team
#three categories
bats.team2<-tapply(X= d$HR, INDEX = list(d$lgID, d$teamID,d$bats), FUN = mean)
bats.team2
#aggregate ---- 
team.stats.sum<-aggregate(x=d[,c("AB", "H", "BB", "2B", "HR")], by=list(d$teamID), FUN=sum)
#tidyverse summarise
#passes the output for whatevers on the left to to the function group
#group by assigns groups by indicators you want to give
team.sum = d %>% group_by(teamID) %>% summarise(ABsum = sum(AB), ABmean= mean(AB), Absd= sd(AB), ABcount= n())
head(team.sum)
#AB count is number of observations
#summarise, can do them all at the same time versus aggregate, summarise is more flexible
team.sum2 = d %>% group_by(lgID, teamID) %>% summarise(ABsum = sum(AB), ABmean= mean(AB), Absd= sd(AB), ABcount= n())
team.sum2
#league, team and your data, added another field 
#aggregatevs summarise, use of summarise more intuitive
#rowsum ----
#when you just want to add up the values in each row
rs<-rowsum(d[c("AB", "H", "HR", "2B", "3B")],group =d$teamID)
head(d[c("AB", "H", "HR", "2B", "3B")])
#use the function tabulate
HR.cnts<-tabulate(d$HR)
names(HR.cnts) <-0:length(HR.cnts-1)
#sequence, 0 to the number of valuesl started at 0 then subtracted it, assigned it each value for each team
#number of times that number , one player hit 47 hr
#name function do not need to be a vector
HR.cnts
#table ----
table(d$bats)
table(d[,c("bats", "throws")])
#giving us different categories
length(d$team)
#aside about the name function ----
m<- matrix(nrow=4, ncol=3)
m
colnames(m)<-c("one", "two", "three")
rownames(m)<-c("apple", "pear", "orange", "berry")
#reshaping your data ----
n<-matrix(1:10, nrow=5)
n
t(n)
#cols have become the rows
v <-1:10
t(v)
str(t(v))
#reshape data, using stack and unstack ----
names(d)
s<-d[,c("lgID", "teamID", "AB", "HR", "throws")]
s.un<-unstack(x =s, form = teamID ~ AB)
s.un
head(s.un)
#melt and cast
library(reshape2)
#cast function to change data frame from the long to the wide format
s.wide<-dcast(data= s, value.var = "HR",formula = "lgID" ~"teamID" ,fun.aggregate = mean)
str(s.wide)


