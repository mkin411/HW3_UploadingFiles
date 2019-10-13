#Review for Exam besides grouping, summarizing 

#understanding group_by and summarise
#using the pipe function, always have the data frame first, then the pipe fun, then the group by the column you want to group by
#then the pipe function again then summarise the specific name of what you are trying to obtain, then the function and then
#the isolated colmn, the mtcars data is already apart of the base R, so you do not need to use the $ function to isolate the colmns values
head(mtcars)
mc<-mtcars
mc
library(tidyverse)
#group mtcars by cylinders and return some averages
head(mc)
cyl.gb<-mc %>%group_by(cyl)%>% summarise(mpg= mean(mpg), hp=mean(hp), carb=mean(carb)) 
head(cyl.gb)
head(mc)


#Three ways to merge dataframes
#merge, join, and aggregate
#mergeformat
#merge(df1, df2, by= unique identifier)
#join format
#depends on right join, left join, or full join
#right join=
#left join =Return all rows from x, and all columns from x and y. 
#If there are multiple matches between x and y, all combination of the matches are returned. This is a mutating join.
#inner_join?
#semi_join?:
#anti-join: finds areas that do not match

#renaming
#always old first then new
#names(dataframe)[location]<-c("new name") need the "quotations"
#dataframe<-rename(.data = data frame, new name = old name)
#names function=> names(datafram)[location]-> c("new name")

#what is aggregate generally? creates a datafram already, cleaner
#using mtcars data to demonstrate mean in aggregating, similar to tapply, but
#tapply(vector, grouping, f): output is a matrix/array, where an element in the matrix/array is the value of f at a grouping g of the vector, and g gets pushed to the row/col names
#aggregate(matrix, grouping, f): similar to by, but instead of pretty printing the output, aggregate sticks everything into a dataframe.

head(mc)
attach(mc)
#attach allows to call the dataframe by there names only, already a dataframe, do not need to create a df
#why do I need to attach here?
cars<-aggregate(mc, by =list(cyl, gear), FUN=mean, na.rm=TRUE)
head(cars)
cars[c("cyl", "gear")]<-NULL
head(cars)
#I got rid of the other duplicated columns
#go over aggregate in HW4? 


#Sunday Review (10-8pm) beginning sunday review Saturday at 1800
#different file types-I understand, ned to library (read xl) for xcl, cvs its all read_filetype
#go over filtering and dcast, need to work on Time, ascend, descend, duplicate review, 
#review subsetting, melt, cbind and rbind
#redo HW4 if time
read_csv("Aurelia_SEAMAP_2012-2018_30minCell.csv")
library(readxl)
read_xlsx("Aurelia_SEAMAP_2012-2018_30minCell.xlsx")
#yeiled he same out come

#only need to use the load function when the document is already in .Rdata
#time questions (9-11)
vf<-read.table(file='ISIIS201405291242.txt', sep="\t", skip=10, header = TRUE, fileEncoding = "ISO-8859-1", stringsAsFactors = FALSE, quote = "\"", check.names = FALSE, encoding = "UTF-8", na.strings = "9999.99")
date<-scan(file = 'ISIIS201405291242.txt', what = "character",skip = 1, nlines = 1, quiet = TRUE)
#need to load file onto Hw2











#melt and cast (11-1)
#under library(reshape2)
#melt goes from wide to long
#dcast goes from long to wide (1)
#review
head(fs)
fs.melt <-melt(data = fs, id.vars = c("tid", "parcel.id", "area_fac", "depth_fac"), measure.vars = c("parcel.length.m", "parcel.length.m"), value.name = c("numbers"))
#melt(data= data frame, id.vars= c("isolate qualitative data"), measure.vars = c("qualitative data"), value.name= name the column that you want to associate with that
head(fs.melt)
fs.m$variable <-as.character(fs.m$variable)
?dcast
#using dcast function to transform your data from long to wide 
fs.cast <- dcast(data = fs.melt, formula = tid~variable, value.var = c("numbers"), fun.aggregate = mean)
#keep transect, keep variable, return to me the mean of each transect
fs.cast
head(fs.cast)
names(fs.melt)
#dcast can find the function of the variable that you isolate, it finds the function 
#using fun.aggregate and then puts the format back into wide rather than long
#like melt does


#duplicate and removing duplicates() (2-3?)





#assec and descend(1) (3-4)
#arrange function



#


#subsetting and filtering questions (4-6 review)
#The two simplest of the five verbs are filter() and select(), which allow you to return
#only a subset of the rows or columns of a data frame, respectively

#subsetting
#subsetting, merging, cbind covered, rbind review, filter next 19:46 Saturday
#subsetting and then combine using rowbinf (rbind function)
d1<- ff[which(ff$depth_fac == 'Deep' & ff$area_fac == "East"),]
#Isolated depth fac and area fac in data set to create new values, does the 
#which create the rows in this case? which depth_fac is Shallow and which area_fac is West
d2<- ff[which(ff$depth_fac == 'Shallow' & ff$area_fac == "West"), ]
#combine d1 and d2
d3<- rbind(d1, d2)
head(d3)
nrow(d3)
?which
#combine data frames with seperate columns into a singl data frame
c1<-subset(x = ff, depth_fac == "Deep", select = c("transect.id", "area_fac"))
c2<- subset (x = ff, depth_fac == "Deep", select = c("depth_fac", "parcel.length.m", "group"))
c3<-cbind(c1, c2)
head(c3)

#merging two data frames, ensuring that observations from one data frame are connected with 
#observation in the second data frame correctly
m1<- subset (x = ff, depth_fac == "Deep", select = c("transect.id", "area_fac"))
m2<- subset (x = ff, depth_fac == "Deep", select = c("depth_fac", "parcel.length.m", "group", "transect.id"))
mergem1.2<-merge(x=m1, y=m2, by = "transect.id", no.dups = T)
head(mergem1.2)

#could you also do a cbind here?
cbind.m<-cbind(m1, m2)
head(cbind.m)
#creates the same outcome so yes, I presume

head(fi)
#subset fi area_fac=WEST, create two df to merge with different data
f1<-subset(x = fi, area_fac == "West", select = c("transect.id", "parcel.length.m"))
head(f1)
head(fi)
f2<-subset(x =fi, area_fac == "West", select = c("depth_fac", "area_fac", "parcel.id", "transect.id"))
head(f2)
merge.f.2<-merge(x=f1, y=f2, by= "transect.id", no.dups = T)
head(merge.f.2)
#cbind and rbind (1-2?)
#rbind will combine those with the same amount of rows 
#cbind will combine those with the same amount of cols






#filter; also only returns a subset of rows or colms from the dataset
#fd6.1<-filter(.data = fi, depth_fac == "Deep", preserve == T)
#?filter

              
              
#6-9 review all data above, and redo the HW4 if time? otherwise finish on Monday


