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
#semi_join?


#Subsetting
#filter??
#aggregate problems

#what is aggregate generally?
#using mtcars data to demonstrate mean in aggregating, similar to tapply, but
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



#different file types-I understand, ned to load xlsx for xcl, cvs its all read_filetype
#time questions



#melt and cast




#gather and spread???- PLEASE DONT BE ON THE EXAM too much material
#ote


