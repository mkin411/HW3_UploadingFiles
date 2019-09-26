#Write a Code to upload for all files
#loading the aurelia_15minCell_statareas.Rdata
ty<-load("aurelia_15minCell_statareas.Rdata")
head(ty)
#loading the aurelia_15minCelstatareas.txt
d7<-read.csv(file = "aurelia_15minCell_statareas.txt", header = T, sep = ",", stringsAsFactors = F)
head(d7)
library(tidyverse)
#loading the Aurelia_SEAMAP_2012-2018_30minCell.csv file
d8<-read.csv("Aurelia_")



#loading IIS201405281105.text 
s1 <- read_csv(file = "ISIIS201405281105.txt")
s1
s2<-read_csv(file = "ISIIS201405281609.txt")
s2
s3<-read_csv(file = "ISIIS201405281124.txt")
s3
s4<-read_csv(file = "ISIIS201405281215.txt")
s4

#Aureliafiles
library(readxl)
s5<-read_xlsx("Aurelia_SEAMAP_2012-2018_30minCell.xlsx")
s5
s6<-load("aurelia_15minCell_statareas.Rdata")
s6
head(a)

