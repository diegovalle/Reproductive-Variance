########################################################
#####       Author: Diego Valle Jones
#####       Website: www.diegovalle.net
#####       Date Created: Thu Mar 11 10:25:34 2010
########################################################
#Pretty map of the ratio of male / female variance in number of
#children.

library(ggplot2)
library(maps)
library(maptools)
library(plotrix)
library(RColorBrewer)

cleanFile <- function(name) {
  wvs <- read.csv(name)
  names(wvs) <- c("row","year","country","childs","sex","age")
  wvs <- subset(wvs, sex != "na" & country != "israel")
  wvs <- na.omit(wvs)
  wvs$numchilds <- as.numeric(gsub("[a-z ]", "", wvs$childs))
  wvs$sex <- gsub("male ", "male", wvs$sex)
  wvs[is.na(wvs)] <- 0
  wvs$sex <- factor(wvs$sex)
  wvs
}

file2000 <- "data/num-child2000.csv"
file2005a <- "data/num-child2005.csv"
file2005b <- "data/num-child2005b.csv"

#Make sure you downloaded the data files from the world values survey
#read readme.md
if(!file.exists(file2000) |
   !file.exists(file2005a) |
   !file.exists(file2005b)) {
     source("convert-wvs.r")
}


wvs2000 <- cleanFile(file2000)
wvs2005 <- cleanFile(file2005a)
wvs2005b <- cleanFile(file2005b)
wvs <- rbind(wvs2000, wvs2005, wvs2005b)
rm(wvs2000, wvs2005, wvs2005b)

#The upperbound for the number of kids is 8, it seems to me
#reasonable to assume men on average have more kids because of
#biological constraints
#Now if I only knew where to get data to estimate the difference
#wvs[wvs$sex == "male" & wvs$numchilds == 8,]$numchilds <- 8.2


qplot(data = wvs, y = age, x = factor(numchilds), geom = "boxplot")
summary(lm(numchilds ~ age , data = wvs))

meanVar <- function(df, old = 0){
  createData <- function(df) {
      m <- subset(df, sex == "male")
      f <- subset(df, sex == "female")
      data.frame(var.ratio = var(m$numchilds) / var(f$numchilds),
                 meanchld.dif = mean(m$numchilds) - mean(f$numchilds),
                 meanage.dif = mean(m$age) - mean(f$age),
                 n = nrow(df))
  }
  ddply(subset(df, age > old), .(country), createData)
}

#You must be this old to enter the chart
old <- 33
alpha <- meanVar(wvs, old)
#Check to see if the average of the country and the differences in number of children between men and women are significant
summary(lm(var.ratio ~  meanage.dif + meanchld.dif , data = alpha))

plot(alpha$var.ratio ~ alpha$meanage.dif)
plot(alpha$var.ratio ~ alpha$meanchld.dif)
plot(sort(alpha$var.ratio))

densityChilds <- function(df, name) {
  ggplot(df, aes(numchilds, group = sex, fill = sex)) +
     geom_density(alpha = .5, adjust = 3) + xlab("Number of Children")+
     opts(title = name)
}

#the mean ratio doesn't take into account population, but it doesn't
#significantly affect the result
wvs.old <- subset(wvs, age > old)
worldvar <- ddply(wvs.old, .(sex), function(df) var(df$numchilds))
worldvar$V1[2] / worldvar$V1[1]
densityChilds(wvs.old, "World")

densityChilds(subset(wvs.old, country == "usa"), "USA")
dev.print(png, file="output/usa.png", height=300, width=400)
densityChilds(subset(wvs.old, country =="canada"), "Canada")
dev.print(png, file="output/canada.png", height=300, width=400)


map <- readShapeSpatial("map/TM_WORLD_BORDERS_SIMPL-0.2.shp")
map <- fortify(map, region = "ISO2")



abbrv <- read.csv("data/abbrv.csv")
matches <- pmatch(tolower(alpha$country), tolower(abbrv$Country.names))
alpha$abbrv <- as.character(abbrv[matches,2])
#Some countries have to be matched manually
alpha[which(alpha$country=="usa"), "abbrv"] <- "US"
alpha[which(alpha$country=="s africa"), "abbrv"] <- "ZA"
alpha[which(alpha$country=="vietnam"), "abbrv"] <- "VN"
alpha[which(alpha$country=="s korea"), "abbrv"] <- "KR"
alpha[which(alpha$country=="britain"), "abbrv"] <- "GB"

mergeMapRepVar <- function(df, map) {
  df <- subset(df, country != "ethiopia")
  p.map <- merge(map, df,
                 by.x = "id",
                 by.y ="abbrv",
                 all.x = TRUE)
  p.map <- p.map[order(p.map$order), ]
  p.map
}

world.map <- mergeMapRepVar(alpha, map)
world.map <- subset(world.map, id != "AQ")

ggplot(world.map, aes(long, lat)) +
         geom_polygon(aes(group = group), fill = "gray70",
                      color = "gray70", size = .2) +
         geom_polygon(aes(group = group, fill = var.ratio),
                      color = "#C4C4C4", size = .2) +
         scale_y_continuous(breaks = NA) +
         scale_x_continuous(breaks = NA) + xlab("") + ylab("") +
         scale_fill_gradient2(low = "red",
                              mid = "white",
                              high = "blue",
                              midpoint = 1) +
         opts(panel.background = theme_rect(fill = "#e0f2ff",
                                            colour = "white")) +
         opts(title = "Male / Female reproductive variance (alpha females = red, alpha males = blue, white = equal)")
dev.print(png, file="output/rep-var-map.png", height=550, width=960)

#What are the errors? Bootstraping to the rescue!
samplevar <- function(D, d) {
  E=D[d,]
  m <- subset(E, sex == "male")
  f <- subset(E, sex == "female")
  var(m$numchilds) / var(f$numchilds)
}

bootvar <- function(df) {
  int <- boot(df[,c(5,7)], samplevar, R=500)
  bci <- boot.ci(int)
  data.frame(#mean = mean(df$numchilds),
             #var = var(df$numchilds),
             lower = bci[4]$normal[2],
             upper = bci[4]$normal[3])
}

library(boot)
int <- bootvar(subset(wvs.old, country=="ethiopia"))
int
#bt <- ddply(wvs.old, .(country, sex), bootvar)
