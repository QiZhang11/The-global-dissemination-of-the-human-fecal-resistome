wd<- "C:/Users/plant/Desktop"
setwd(wd)
mydata<-read.table("map.csv",header=TRUE,sep=",") 

visit.x<-mydata$Longitude
visit.y<-mydata$Latitude

library(ggplot2)
library(ggmap)
library(sp)
library(maptools)
library(maps)
library(mapdata)
library(RColorBrewer)
mp<-NULL 
mapworld<-borders("world",colour = "gray50",fill="white")
mp<-ggplot()+mapworld+ylim(-60,90)

mp2<-mp+
  geom_point(aes(x=visit.x,y=visit.y,color=class,alpha=0.6,size=mydata$number))+ scale_size(range=c(5,15))
scale_color_brewer(palette = "Set1")

mp2
mp3<-mp2+theme_light()
mp3
