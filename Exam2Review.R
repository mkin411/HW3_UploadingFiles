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





#Subsetting
#filter??







#renaming
#always old first then new
#names(dataframe)[location]<-c("new name") need the "quotations"






#what is aggregate generally?
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







#Sunday Review (10-8pm)
#different file types-I understand, ned to library (read xl) for xcl, cvs its all read_filetype
#only need to use the load function when the document is already in .Rdata
#time questions







#melt and cast
#under library(reshape2)
#melt goes from wide to long
#dcast goes from long to wide (1)
#dcast can also find the average




#cbind and rbind
#rbind will combine those with the same amount of rows 
#cbind will combine those with the same amount of cols







#duplicate and removing duplicates()



#assec and descend(1)
#arrange function



#


#gather and spread???- PLEASE DONT BE ON THE EXAM too much material


smiths
mtcars
library(nutshell)
load()

