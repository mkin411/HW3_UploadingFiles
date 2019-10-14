# 7 de Octobre
# Next exam- review day wednesday, exam on monday, importing, summarizing, merging, reshaping
#class: reshape
load("fish_data (10).Rdata")
f<-fish; rm(fish)
fs<- f[ ,c ("transect.id", "area_fac", "depth_fac", "parcel.id", "parcel.density.m3", "parcel.length.m")]
head(fs)
#how to rename a field (or colmn)
library(tidyverse)
fs <-rename(.data = fs, tid = transect.id)
names(fs)
fs.a<- rename(.data = fs, area = area_fac)
fs.d<- rename (.data = fs, depth = depth_fac)
fs.par <-rename(.data = fs, parcel = parcel.id)
fs.pd <-rename(.data = fs, parden = parcel.density.m3)
fs.l<-rename(.data = fs, parlen = parcel.length.m)
#problems with R not reassigning the colns
#another way to rename
names(fs) [1]= c("transect")
names(fs) [1:3] =c("transect", "a", "z")

#reshaping your data ----
library(reshape2)
#using the melt (reshape2) to change your data
#data frame from wide to long
#?melt----categorical 
head(fs)
fs.melt <-melt(data = fs, id.vars = c("tid", "parcel.id", "area_fac", "depth_fac"), measure.vars = c("parcel.length.m", "parcel.length.m"), value.name = c("numbers"))
head(fs.melt)
fs.m$variable <-as.character(fs.m$variable)
?dcast
#using dcast function to transform your data from long to wide 
fs.cast <- dcast(data = fs.melt, formula = tid~variable, value.var = c("numbers"), fun.aggregate = mean)
#keep transect, keep variable, return to me the mean of each transect
fs.cast
head(fs.cast)
names(fs.melt)
library(dbplyr)
# spread and gather
#gather is like melt, one with the key and one with the values
head(fs)
#key is the name of the column that has the pd or pl
fs.gather = fs %>% group_by(tid, area_fac, depth_fac, parcel.length.m, parcel.density.m3) %>% gather(key = 'variable', value = 'value', parcel.density.m3, parcel.length.m )
head(fs.gather)
#spread----anotherway to group
fs.spread <- fs.gather %>% spread(variable, value)
head(fs.spread)
#to be worked on- not complete in terms of spread function
#working on the melt function again
#id.vars are the colmns we want to keep wide
fs.m <- melt(data = fs, id.vars = c("tid", "area_fac", "depth_fac"), measure.vars = c("parcel.length.m", "parcel.density.m3"))
fs.m <- melt(data = fs, id.vars = c("tid", "area_fac", "depth_fac"), measure.vars = c("parcel.length.m", "parcel.density.m3"), value.name = c("data"), factorsAsStrings = T)             
str(fs.m)
#remving duplicates ----
head(fs)
o1 <- fs[1,]
o2 <-fs [1,]
o3 <- fs[1,]
o4 <- fs[2:10,]
o <- rbind(o1, o2, o3, o4)
o
head(o)
#there are duplicates needed to get rid of 
#now the first 3 rows are duplicates
no.dups <- o [!duplicated(o),]
o
dups <- o[duplicated(o),]
dups
no.dups <- o [!duplicated(o$parcel.density.m3), (o$parcel.length.m)]
#interested in taking two out
?complete.cases
#CTD some sensors work and others do not
#complete cases that return lines where nothing is missing, NA's allowed
head(fs)
#data with NAs
fs[2,]$parcel.density.m3 <-NA
fs[4,]$parcel.length.m <-NA
fs.complete <-fs[complete.cases(fs),]
head(fs.complete)
#deleting the data of that coln versus the row
#sorting
attach(mtcars)
#sort by mpg, order and range
nd <- mtcars [order(mpg), ]
nd
#largest to smallest in mpg
#uaing the arrange function
nd.arrange <-arrange(.data = mtcars, mpg)
nd.arrange
#creates the same
nd.arrange.desc<-arrange(.data = mtcars, desc(mpg))
nd.arrange.desc
nd.m.c<-arrange(.data = mtcars, mpg, cyl)
nd.m.c.desc<-arrange(.data = mtcars, mpg, desc(cyl))
nd.m.c.desc
#descending for cyl




