#HW4
#tapply & merge
#1. Using the tapply function, find the mean of ‘parcel.density.m3’ for each transect and assign the outcome
#to an object.
#2. Convert the object to a data frame
#3. Rename the column with the density values to something more descriptive.
#4. Assign the row names of the data frame to be the values in a new field “transect”.
#5. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#‘parcel.density.m3’.
#6. Using the merge function, combine the data frames with the mean and standard deviation to create
one, new data frame that has three columns (mean density, sd density, transect)
#7. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for ‘parcel.density.m3’’.
#8. Using the merge function, combine the data frames with the mean and standard deviation to create
#one, new data frame that has three columns (mean density, sd density, count, and transect).
#summarise & join
#9. Using the group_by and summarise functions (tidyverse package), find the mean of ‘parcel.density.m3’
#for each transect and assign the outcome to an object.
#10. Convert the object to a data frame
#11. Rename the column with the density values to something more descriptive.
#12. Assign the row names of the data frame to be the values in a new field “transect”.
#13. Repeat the above steps, but this time using the tapply function to find the standard deviation of
#‘parcel.density.m3’.
#14. Using the join function (tidyverse package), combine the data frames with the mean and standard
#deviation to create one, new data frame that has three columns (mean density, sd density, transect)
#15. Repeat the above steps, but this time using the tapply function to find the count of observations for
#each transect for ‘parcel.density.m3’’.
#16. Using the join function, combine the data frames with the mean and standard deviation to create one,
#new data frame that has three columns (mean density, sd density, count, and transect).
#Free style
#17. Select an 2 fields (e.g. area, depth, year, transect) in the fish_data.Rdata to group by. Find the minimum,
#lower 95%, median, mean, upper 95%, and maximum values for parcel.length.m.