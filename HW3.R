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
s7<-read_csv(file ="aurelia_15minCell_statareas.txt")
s7
s8<-read_csv(file = "ENVREC (1).csv")
s8

#OtherFiles
s9<-read_csv(file = "STAREC_rev20190402.csv")
s9
s10<-read_csv("INGEST_DATA.csv")
s10
s11<-read_csv("NEWBIOCODESBIG.csv")
s11
s12<-read_csv("SHRREC.csv")
s12
s13<-read_csv("CTDCASTREC.csv")
s13
s14<-read_csv("INVREC.csv")
s14
s15<-read_csv("ISTREC.csv")
s15
s16<-read_csv("VESSELS.csv")
s16
s17<-read_csv("CTDREC.csv")
s17
s18<-read_csv("BGSREC(1).csv")
s18
s19<-read_csv("CRUISES.csv")
s19

