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
fd6<- filter(.data = f, depth_fac == "Deep")
#Which
fd7<- ff[which(ff$depth_fac == 'Deep' & ff$area_fac == "East"), ]
#fd6 <- ff[which(ff$depth_fac == 'Deep' & ff$area_fac == "East", ff$yr_fac == "2014")
 #subsetting and then combine using rowbinf (rbind function)
d1<- ff[which(ff$depth_fac == 'Deep' & ff$area_fac == "East"),]
d2<- ff[which(ff$depth_fac == 'Shallow' & ff$area_fac == "West"), ]
#combine d1 and d2
d3<- rbind(d1, d2)
d3
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

