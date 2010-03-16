#Only run this if you downloaded the original wvs 2000 and 2005
#stata data files! http://www.wvsevsdb.com/wvs/WVSData.jsp?Idioma=I
library(foreign)

#################################################################
#2000
#################################################################
#WORLD VALUES SURVEY 2000 OFFICIAL DATA FILE v.20090914 World Values Survey Association (www.worldvaluessurvey.org)

#WVS 2000 official file compressed in ZIP format (SPSS=6.3Mb, SAS=7.1Mb, STATA=7.1Mb)
wvs <- read.dta("data/wvs2000_v20090914.dta")
#"year","country","childs","sex","age"
write.csv(wvs[ ,c("v1", "v2", "v107", "v223", "v225")],
          "num-child2000.csv")
rm(wvs)

#################################################################
#2005
#################################################################
#WORLD VALUES SURVEY 2005 OFFICIAL DATA FILE v.20090901, 2009. World Values Survey Association (www.worldvaluessurvey.org).

#WVS2005-List A official file v.20090901 compressed in ZIP format (SPSS=8.6Mb, SAS=14.6Mb, STATA=7.6Mb)
wvs <- read.dta("data/wvs2005_v20090901a.dta")
write.csv(wvs[ ,c("v1", "v2", "v56", "v235", "v237")],
          "num-child2005.csv")
rm(wvs)

#WVS2005-List B official file v.20090901 compressed in ZIP format (SPSS=1.8Mb, SAS=2.8Mb, STATA=1.5Mb)
wvs <- read.dta("data/wvs2005_v20090901b.dta")
write.csv(wvs[ ,c("v1", "v2", "v56", "v235", "v237")],
          "num-child2005b.csv")
rm(wvs)

########################################################
#1981 - 2005
########################################################
#WORLD VALUES SURVEY 1981-2008 OFFICIAL AGGREGATE v.20090901, 2009. World Values Survey Association (www.worldvaluessurvey.org)

#WVS official 5 wave aggregate 1981-2008 v.20090914 compressed in ZIP format (SPSS=45Mb, SAS=87Mb, STATA=39Mb) 	SPSS  SAS  STATA
#wvs <- read.dta("data/wvs1981_2008_v20090914.dta")
#write.csv(wvs[ ,c("v1", "v2", "v56", "v235", "v237")],
#          "num-child1981_2008.csv")
#rm(wvs)
