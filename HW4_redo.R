#Hw4 Redo
f.s<-load("fish_data (10).Rdata")
f<-fish; rm(fish)
head(f.s)
f.s<- f[ ,c ("transect.id", "area_fac", "depth_fac", "parcel.id", "parcel.density.m3", "parcel.length.m")]
#seperating them into columns?
#1. Using the tapply function, find the mean of ‘parcel.density.m3’ for each transect and assign the outcome
#to an object.
fs<-tapply(X= f.s$parcel.density.m3, INDEX = list(f.s$transect.id), FUN = mean)
fs$rownames<- 1:39
#2. Convert the object to a data frame
fs.df<-as.data.frame(fs)
fs.df$rownames<-1:39
colnames(fs.df)<-"mean.parcel.density"
colnames(fs.df)
