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
#aggregate problems
#what is aggregate generally?







#different file types
#time questions
#melt and cast
#gather and sprea
#ote
